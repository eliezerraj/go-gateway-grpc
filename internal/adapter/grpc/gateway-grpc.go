package grpc

import (
	"fmt"
	"context"
	"encoding/json"

	"github.com/rs/zerolog/log"
	"github.com/go-gateway-grpc/internal/core/model"

	"google.golang.org/grpc/metadata"
	go_core_observ 		"github.com/eliezerraj/go-core/observability"
	go_grpc_client "github.com/eliezerraj/go-core/grpc"	
	proto "github.com/go-gateway-grpc/protogen/token"
	//proto "github.com/eliezerraj/go-grpc-proto/protogen/token"
)

var childLogger = log.With().Str("component","go-gateway-grpc").Str("package","internal.adapter.grpc").Logger()
var tracerProvider go_core_observ.TracerProvider
var tokenServiceClient	proto.TokenServiceClient

type AdapaterGrpc struct {
	grpcClientWorker	*go_grpc_client.GrpcClientWorker
	serviceClient		proto.TokenServiceClient
}

// About create a new worker service
func NewAdapaterGrpc( grpcClientWorker	*go_grpc_client.GrpcClientWorker ) *AdapaterGrpc{
	childLogger.Info().Str("func","NewAdapaterGrpc").Send()

	// Create a client
	serviceClient := proto.NewTokenServiceClient(grpcClientWorker.GrcpClient)

	return &AdapaterGrpc{
		grpcClientWorker: grpcClientWorker,
		serviceClient:	serviceClient,
	}
}

// About get gprc server information pod 
func (a *AdapaterGrpc) GetInfoPodGrpc(ctx context.Context) (*model.InfoPod, error){
	childLogger.Info().Str("func","GetInfoPodGrpc").Interface("trace-request-id", ctx.Value("trace-request-id")).Send()

	// Trace
	span := tracerProvider.Span(ctx, "adapter.GetInfoPodGrpc")
	defer span.End()
		
	// Prepare to receive proto data
	podInfoRequest := &proto.PodRequest{}

	// Set header for authorization
	header := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	ctx = metadata.NewOutgoingContext(ctx, header)

	// request the data from grpc
	res_podInfoResponse, err := a.serviceClient.GetPod(ctx, podInfoRequest)
	if err != nil {
		childLogger.Error().Err(err).Send()
	  	return nil, err
	}

	// convert proto to json
	response_str, err := a.grpcClientWorker.ProtoToJSON(res_podInfoResponse)
	if err != nil {
		return nil, err
  	}

	// convert json to struct
	var res_pod map[string]interface{}
	err = json.Unmarshal([]byte(response_str), &res_pod)
	if err != nil {
		return nil, err
	}

	result_filtered := res_pod["pod"].(map[string]interface{})
	
	var infoPod model.InfoPod
	jsonString, err := json.Marshal(result_filtered)
	if err != nil {
		return nil, err
	}
	json.Unmarshal(jsonString, &infoPod)
	
	return &infoPod, nil
}
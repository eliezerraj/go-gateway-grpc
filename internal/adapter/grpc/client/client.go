package client

import (
	"fmt"
	"context"
	"encoding/json"

	"github.com/rs/zerolog/log"
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/core/erro"

	"google.golang.org/grpc/metadata"
	go_core_observ 	"github.com/eliezerraj/go-core/observability"
	go_grpc_client "github.com/eliezerraj/go-core/grpc"	
	proto "github.com/go-gateway-grpc/protogen/token"

	"go.opentelemetry.io/otel"
)

var (
	childLogger = log.With().Str("component","go-gateway-grpc").Str("package","internal.adapter.grpc.client").Logger()
	tracerProvider go_core_observ.TracerProvider
	tokenServiceClient	proto.TokenServiceClient
)

type AdapaterGrpc struct {
	GrpcClientWorker	*go_grpc_client.GrpcClientWorker
	serviceClient		proto.TokenServiceClient
	StatusGrpcServer	bool
}

// About create a new worker service
func NewAdapaterGrpc(grpcClientWorker *go_grpc_client.GrpcClientWorker) *AdapaterGrpc{
	childLogger.Info().Str("func","NewAdapaterGrpc").Send()

	// Create a client
	serviceClient := proto.NewTokenServiceClient(grpcClientWorker.GrcpClient)
	
	statusGrpcServer := true
	if	grpcClientWorker == nil {	
		statusGrpcServer = false
	}

	return &AdapaterGrpc{
		GrpcClientWorker: grpcClientWorker,
		serviceClient:	serviceClient,
		StatusGrpcServer: statusGrpcServer,
	}
}

// About get gprc server information pod 
func (a *AdapaterGrpc) GetInfoPodGrpc(ctx context.Context) (*model.InfoPod, error){
	childLogger.Info().Str("func","GetInfoPodGrpc").Interface("trace-request-id", ctx.Value("trace-request-id")).Send()

	// Trace
	ctx, span := tracerProvider.SpanCtx(ctx, "adapter.grpc.client.GetInfoPodGrpc")
	defer span.End()
		
	// Prepare to receive proto data
	podInfoRequest := &proto.PodRequest{}

	// Set header for trace-id
	header_grpc := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	otel.GetTextMapPropagator().Inject(ctx, go_core_observ.MetadataCarrier{header_grpc})
	ctx = metadata.NewOutgoingContext(ctx, header_grpc)

	// request the data from grpc
	res_podInfoResponse, err := a.serviceClient.GetPod(ctx, podInfoRequest)
	if err != nil {
	  	return nil, err
	}

	// convert proto to json
	response_str, err := a.GrpcClientWorker.ProtoToJSON(res_podInfoResponse)
	if err != nil {
		return nil, err
  	}

	// convert json to struct
	var res_protoJson map[string]interface{}
	err = json.Unmarshal([]byte(response_str), &res_protoJson)
	if err != nil {
		return nil, err
	}

	result_filtered := res_protoJson["pod"].(map[string]interface{})
	
	var infoPod model.InfoPod
	jsonString, err := json.Marshal(result_filtered)
	if err != nil {
		return nil, err
	}
	json.Unmarshal(jsonString, &infoPod)
	
	return &infoPod, nil
}

// About get gprc server information pod 
func (a *AdapaterGrpc) AddPaymentTokenGrpc(ctx context.Context, payment model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","AddPaymentTokenGrpc").Interface("trace-request-id", ctx.Value("trace-request-id")).Interface("payment",payment).Send()

	// Trace
	ctx, span := tracerProvider.SpanCtx(ctx, "adapter.grpc.client.AddPaymentTokenGrpc")
	defer span.End()

	// Set header for observability
	header_grpc := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	otel.GetTextMapPropagator().Inject(ctx, go_core_observ.MetadataCarrier{header_grpc})
	ctx = metadata.NewOutgoingContext(ctx, header_grpc)

	// Prepare to paymento proto
	paymentProto := proto.Payment{  TokenData: payment.TokenData,
									Terminal: payment.Terminal,	
									Currency: payment.Currency,
									Amount: payment.Amount,
									CardType: payment.CardType,
									Mcc: payment.Mcc,
									TransactionId: *payment.TransactionId,}

	paymentTokenRequest := &proto.PaymentTokenRequest{Payment: &paymentProto}

	// request the data from grpc
	res_paymentTokenResponse, err := a.serviceClient.AddPaymentToken(ctx, paymentTokenRequest)
	if err != nil {
	  	return nil, err
	}

	// convert proto to json
	response_str, err := a.GrpcClientWorker.ProtoToJSON(res_paymentTokenResponse)
	if err != nil {
		return nil, err
  	}
		  
	// convert json to map
	var res_protoJson map[string]interface{}
	err = json.Unmarshal([]byte(response_str), &res_protoJson)
	if err != nil {
		return nil, err
	}
	childLogger.Info().Str("func","==res_protoJson=>").Interface("res_protoJson", res_protoJson).Send()

	// extract and convert payment
	result_filtered := res_protoJson["payment"].(map[string]interface{})
	var res_payment model.Payment
	jsonString, err := json.Marshal(result_filtered)
	if err != nil {
		return nil, err
	}
	json.Unmarshal(jsonString, &res_payment)

	// extract and convert []steps
	steps, ok := res_protoJson["steps"].([]interface{})
	if !ok {
		return nil, erro.ErroPayloadMalInformed
	}
	var res_list_step_process []model.StepProcess
	for _, item_step := range steps {
		jsonString, err = json.Marshal(item_step)
		if err != nil {
			return nil, err
		}
		stepProcess := model.StepProcess{}
		json.Unmarshal(jsonString, &stepProcess)
		res_list_step_process = append(res_list_step_process, stepProcess)
	}

	res_payment.StepProcess = &res_list_step_process
	return &res_payment, nil
}

// About test grpc connection
func (a *AdapaterGrpc) TestConnection(ctx context.Context) (error){
	childLogger.Info().Str("func","TestConnection").Interface("trace-request-id", ctx.Value("trace-request-id")).Send()

	// Trace
	ctx, span := tracerProvider.SpanCtx(ctx, "adapter.grpc.client.TestConnection")
	defer span.End()

	// Set header for trace-id
	header_grpc := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	otel.GetTextMapPropagator().Inject(ctx, go_core_observ.MetadataCarrier{header_grpc})
	ctx = metadata.NewOutgoingContext(ctx, header_grpc)

	if (a.GrpcClientWorker == nil){
		return erro.ErroGrpcServerNill
	}
	err := a.GrpcClientWorker.TestConnection(ctx)
	if err != nil {
		return err
	}
	return nil
}
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

	// Set header for trace-id
	header := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	ctx = metadata.NewOutgoingContext(ctx, header)

	// request the data from grpc
	res_podInfoResponse, err := a.serviceClient.GetPod(ctx, podInfoRequest)
	if err != nil {
	  	return nil, err
	}

	// convert proto to json
	response_str, err := a.grpcClientWorker.ProtoToJSON(res_podInfoResponse)
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

// About send the data to grpc server tokenization to create a card
func (a *AdapaterGrpc) CreateCardTokenGrpc(ctx context.Context, card model.Card) (*model.Card, error){
	childLogger.Info().Str("func","CreateCardTokenGrpc").Interface("trace-request-id", ctx.Value("trace-request-id")).Interface("card",card).Send()

	// Trace
	span := tracerProvider.Span(ctx, "adapter.CreateCardTokenGrpc")
	defer span.End()
		
	// Prepare to receive proto data
	cardProto := proto.Card{Id: uint32(card.ID),
							CardNumber: card.CardNumber}
	cardTokenRequest := &proto.CardTokenRequest{Card: &cardProto}

	// Set header for observability
	header := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	ctx = metadata.NewOutgoingContext(ctx, header)

	// request the data from grpc
	res_cardTokenResponse, err := a.serviceClient.CreateCardToken(ctx, cardTokenRequest)
	if err != nil {
	  	return nil, err
	}

	// convert proto to json
	response_str, err := a.grpcClientWorker.ProtoToJSON(res_cardTokenResponse)
	if err != nil {
		return nil, err
  	}
		  
	// convert json to struct
	var res_protoJson map[string]interface{}
	err = json.Unmarshal([]byte(response_str), &res_protoJson)
	if err != nil {
		return nil, err
	}

	result_filtered := res_protoJson["card"].(map[string]interface{})
	
	var res_card model.Card
	jsonString, err := json.Marshal(result_filtered)
	if err != nil {
		return nil, err
	}
	json.Unmarshal(jsonString, &res_card)
	
	return &res_card, nil
}

// About get gprc server information pod 
func (a *AdapaterGrpc) GetCardTokenGrpc(ctx context.Context, card model.Card) (*[]model.Card, error){
	childLogger.Info().Str("func","GetCardTokenGrpc").Interface("trace-request-id", ctx.Value("trace-request-id")).Interface("card",card).Send()

	// Trace
	span := tracerProvider.Span(ctx, "adapter.GetCardTokenGrpc")
	defer span.End()
		
	// Prepare to receive proto data
	cardProto := proto.Card{ TokenData: card.TokenData}
	cardTokenRequest := &proto.CardTokenRequest{Card: &cardProto}

	// Set header for observability
	header := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	ctx = metadata.NewOutgoingContext(ctx, header)

	// request the data from grpc
	res_cardTokenResponse, err := a.serviceClient.GetCardToken(ctx, cardTokenRequest)
	if err != nil {
	  	return nil, err
	}

	// convert proto to json
	response_str, err := a.grpcClientWorker.ProtoToJSON(res_cardTokenResponse)
	if err != nil {
		return nil, err
  	}
		  
	// convert json to struct
	var res_protoJson map[string]interface{}
	err = json.Unmarshal([]byte(response_str), &res_protoJson)
	if err != nil {
		return nil, err
	}

	var list_cards []model.Card
	if _, ok := res_protoJson["cards"].([]interface{}); ok {
		for _, v := range res_protoJson["cards"].([]interface{}) {
			res_card := model.Card{}
			jsonString, err := json.Marshal(v)
			if err != nil {
				return nil, err
			}
			json.Unmarshal(jsonString, &res_card)
			list_cards = append(list_cards, res_card)
		}
		
	} else {
		list_cards = append(list_cards, model.Card{})
	}
	return &list_cards, nil
}

// About get gprc server information pod 
func (a *AdapaterGrpc) AddPaymentToken(ctx context.Context, payment model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","AddPaymentToken").Interface("trace-request-id", ctx.Value("trace-request-id")).Interface("payment",payment).Send()

	// Trace
	span := tracerProvider.Span(ctx, "adapter.AddPaymentToken")
	defer span.End()

	// Set header for observability
	header := metadata.New(map[string]string{ "trace-request-id": fmt.Sprintf("%s",ctx.Value("trace-request-id")) })
	ctx = metadata.NewOutgoingContext(ctx, header)

	// Prepare to paymento proto
	paymentProto := proto.Payment{  TokenData: payment.TokenData,
									Terminal: payment.Terminal,	
									Currency: payment.Currency,
									Amount: payment.Amount,
									CardType: payment.CardType,
									Mcc: payment.Mcc,	
									}
	paymentTokenRequest := &proto.PaymentTokenRequest{Payment: &paymentProto}

	// request the data from grpc
	res_paymentTokenResponse, err := a.serviceClient.AddPaymentToken(ctx, paymentTokenRequest)
	if err != nil {
	  	return nil, err
	}

	// convert proto to json
	response_str, err := a.grpcClientWorker.ProtoToJSON(res_paymentTokenResponse)
	if err != nil {
		return nil, err
  	}
		  
	// convert json to struct
	var res_protoJson map[string]interface{}
	err = json.Unmarshal([]byte(response_str), &res_protoJson)
	if err != nil {
		return nil, err
	}

	result_filtered := res_protoJson["payment"].(map[string]interface{})
	
	var res_payment model.Payment
	jsonString, err := json.Marshal(result_filtered)
	if err != nil {
		return nil, err
	}
	json.Unmarshal(jsonString, &res_payment)

	return &res_payment, nil
}
package service

import(
	"fmt"
	"context"
	"errors"
	"net/http"	
	"encoding/json"

	"github.com/go-gateway-grpc/internal/core/erro"
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/adapter/database"
	"github.com/rs/zerolog/log"

	adapter_grpc 	"github.com/go-gateway-grpc/internal/adapter/grpc/client"
	go_core_observ 	"github.com/eliezerraj/go-core/observability"
	go_core_api "github.com/eliezerraj/go-core/api"
)

var childLogger = log.With().Str("component","go-gateway-grpc").Str("package","internal.core.service").Logger()
var tracerProvider go_core_observ.TracerProvider
var apiService go_core_api.ApiService

type WorkerService struct {
	workerRepository 	*database.WorkerRepository
	apiService			[]model.ApiService
	adapaterGrpc		*adapter_grpc.AdapaterGrpc
}

// About create a new worker service
func NewWorkerService(	workerRepository *database.WorkerRepository,
						apiService		[]model.ApiService,
						adapaterGrpc	*adapter_grpc.AdapaterGrpc ) *WorkerService{
	childLogger.Info().Str("func","NewWorkerService").Send()

	return &WorkerService{
		workerRepository: workerRepository,
		apiService: apiService,
		adapaterGrpc: adapaterGrpc,
	}
}

// About handle/convert http status code
func errorStatusCode(statusCode int, serviceName string) error{
	childLogger.Info().Str("func","errorStatusCode").Interface("serviceName", serviceName).Interface("statusCode", statusCode).Send()
	var err error
	switch statusCode {
		case http.StatusUnauthorized:
			err = erro.ErrUnauthorized
		case http.StatusForbidden:
			err = erro.ErrHTTPForbiden
		case http.StatusNotFound:
			err = erro.ErrNotFound
		default:
			err = errors.New(fmt.Sprintf("service %s in outage", serviceName))
		}
	return err
}

// About get gprc server information pod 
func (s *WorkerService) GetInfoPodGrpc(ctx context.Context) (*model.InfoPod, error){
	childLogger.Info().Str("func","GetInfoPodGrpc").Interface("trace-request-id", ctx.Value("trace-request-id")).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.GetInfoPodGrpc")
	defer span.End()

	// Send via grpc
	res_pod, err :=s.adapaterGrpc.GetInfoPodGrpc(ctx)
	if err != nil {
		return nil, err
	}

	return res_pod, nil
}

// About payment via token (GRPC)
func (s *WorkerService) AddPaymentToken(ctx context.Context, payment model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","AddPaymentToken").Interface("trace-request-id", ctx.Value("trace-request-id")).Interface("payment", payment).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.AddPaymentToken")
	span.End()

	// Get a transactio UUID
	res_uuid, err := s.workerRepository.GetTransactionUUID(ctx)
	if err != nil {
		return nil, err
	}
	payment.TransactionId = res_uuid

	// Send data via grpc
	res_payment_token, err := s.adapaterGrpc.AddPaymentTokenGrpc(ctx, payment)
	if err != nil {
		return nil, err
	}
	
	return res_payment_token, nil
}

// About payment via plain card (REST)
func (s *WorkerService) AddPayment(ctx context.Context, payment model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","AddPayment").Interface("trace-request-id", ctx.Value("trace-request-id")).Interface("payment", payment).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.AddPayment")
	trace_id := fmt.Sprintf("%v",ctx.Value("trace-request-id"))
	span.End()

	// Get a transactio UUID
	res_uuid, err := s.workerRepository.GetTransactionUUID(ctx)
	if err != nil {
		return nil, err
	}
	payment.TransactionId = res_uuid

	// Set headers
	headers := map[string]string{
		"Content-Type":  "application/json;charset=UTF-8",
		"X-Request-Id": trace_id,
		"x-apigw-api-id": s.apiService[1].XApigwApiId,
		"Host": s.apiService[1].HostName,
	}
	httpClient := go_core_api.HttpClient {
		Url: 	s.apiService[1].Url + "/addPayment",
		Method: s.apiService[1].Method,
		Timeout: 15,
		Headers: &headers,
	}

	// Send data via grpc
	res_payload, statusCode, err := apiService.CallRestApi(	ctx,
															httpClient, 
															payment)
	
	if err != nil {
		return nil, errorStatusCode(statusCode, s.apiService[1].Name)
	}
	jsonString, err  := json.Marshal(res_payload)
	if err != nil {
		return nil, errors.New(err.Error())
    }
	var payment_parsed model.Payment
	json.Unmarshal(jsonString, &payment_parsed)

	return &payment_parsed, nil
}

// About payment via plain card (REST)
func (s *WorkerService) PixTransaction(ctx context.Context, pixTransaction model.PixTransaction) (*model.PixTransaction, error){
	childLogger.Info().Str("func","PixTransaction").Interface("trace-request-id", ctx.Value("trace-request-id")).Interface("pixTransaction", pixTransaction).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.PixTransaction")
	trace_id := fmt.Sprintf("%v",ctx.Value("trace-request-id"))
	span.End()

	// Get a transactio UUID
	res_uuid, err := s.workerRepository.GetTransactionUUID(ctx)
	if err != nil {
		return nil, err
	}
	pixTransaction.TransactionId = *res_uuid

	// Set headers
	headers := map[string]string{
		"Content-Type":  "application/json;charset=UTF-8",
		"X-Request-Id": trace_id,
		"x-apigw-api-id": s.apiService[2].XApigwApiId,
		"Host": s.apiService[1].HostName,
	}
	httpClient := go_core_api.HttpClient {
		Url: 	s.apiService[1].Url + "/pixTransaction",
		Method: s.apiService[1].Method,
		Timeout: 15,
		Headers: &headers,
	}

	// Send data via grpc
	res_payload, statusCode, err := apiService.CallRestApi(	ctx,
															httpClient, 
															pixTransaction)
	
	if err != nil {
		return nil, errorStatusCode(statusCode, s.apiService[1].Name)
	}
	jsonString, err  := json.Marshal(res_payload)
	if err != nil {
		return nil, errors.New(err.Error())
    }
	var pix_transaction_parsed model.PixTransaction
	json.Unmarshal(jsonString, &pix_transaction_parsed)

	return &pix_transaction_parsed, nil
}
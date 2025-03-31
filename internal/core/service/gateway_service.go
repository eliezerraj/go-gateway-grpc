package service

import(
	"context"

	"github.com/go-gateway-grpc/internal/core/erro"
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/adapter/database"
	"github.com/rs/zerolog/log"

	adapter_grpc 	"github.com/go-gateway-grpc/internal/adapter/grpc"
	go_core_observ 	"github.com/eliezerraj/go-core/observability"
)

var childLogger = log.With().Str("component","go-gateway-grpc").Str("package","internal.core.service").Logger()
var tracerProvider go_core_observ.TracerProvider

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

// About get gprc server information pod 
func (s *WorkerService) GetInfoPodGrpc(ctx context.Context) (*model.InfoPod, error){
	childLogger.Info().Str("func","GetInfoPodGrpc").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Send()

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

// About create a card token
func (s *WorkerService) CreateCardToken(ctx context.Context, card model.Card) (*model.Card, error){
	childLogger.Info().Str("func","CreateCardToken").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Interface("card", card).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.CreateCardToken")
	span.End()
	
	// Businness rule
	if (card.Type != "CREDIT") && (card.Type != "DEBIT") {
		return nil, erro.ErrCardTypeInvalid
	}

	// Check id the card exists
	res_card, err := s.workerRepository.GetCard(ctx, card)
	if err != nil {
		return nil, err
	}

	// set the PK
	card.ID = res_card.ID

	// Send via grpc
	res_card_token, err := s.adapaterGrpc.CreateCardTokenGrpc(ctx, card)
	if err != nil {
		return nil, err
	}

	card.ID = res_card_token.ID
	card.TokenData = res_card_token.TokenData
	card.CreatedAt = res_card_token.CreatedAt
	card.ExpiredAt = res_card_token.ExpiredAt

	return &card, nil
}

// About get a card from token
func (s *WorkerService) GetCardToken(ctx context.Context, card model.Card) (*[]model.Card, error){
	childLogger.Info().Str("func","GetCardToken").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Interface("card", card).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.GetCardToken")
	span.End()
	
	// Send via grpc
	res_card_token, err := s.adapaterGrpc.GetCardTokenGrpc(ctx, card)
	if err != nil {
		return nil, err
	}

	return res_card_token, nil
}

// About create a card token
func (s *WorkerService) AddPaymentToken(ctx context.Context, payment model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","AddPaymentToken").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Interface("payment", payment).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.AddPaymentToken")
	span.End()

	// Get a transactio UUID
	res_uuid, err := s.workerRepository.GetTransactionUUID(ctx)
	if err != nil {
		return nil, err
	}
	payment.TransactionID = res_uuid

	// Send via grpc
	card := model.Card{TokenData: payment.TokenData}
	_, err = s.adapaterGrpc.GetCardTokenGrpc(ctx, card)
	if err != nil {
		return nil, err
	}

	// Send via grpc
	res_payment_token, err := s.adapaterGrpc.AddPaymentToken(ctx, payment)
	if err != nil {
		return nil, err
	}
	
	return res_payment_token, nil
}
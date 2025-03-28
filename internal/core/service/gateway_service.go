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

// About add a payment
func (s *WorkerService) AddPayment(ctx context.Context, payment *model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","AddPayment").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Interface("payment", payment).Send()

	// Trace
	span := tracerProvider.Span(ctx, "service.AddPayment")

	// get connection
	tx, conn, err := s.workerRepository.DatabasePGServer.StartTx(ctx)
	if err != nil {
		return nil, err
	}
	
	// handle tx
	defer func() {
		if err != nil {
			tx.Rollback(ctx)
		} else {
			tx.Commit(ctx)
		}
		s.workerRepository.DatabasePGServer.ReleaseTx(conn)
		span.End()
	}()

	// Businness rule
	if (payment.CardType != "CREDIT") && (payment.CardType != "DEBIT") {
		return nil, erro.ErrCardTypeInvalid
	}

	// add payment
	payment.Status = "PENDING"

	res, err := s.workerRepository.AddPayment(ctx, tx, payment)
	if err != nil {
		return nil, err
	}

	return res, nil
}

// About get a payment
func (s *WorkerService) GetPayment(ctx context.Context, payment *model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","GetPayment").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Interface("payment", payment).Send()

	span := tracerProvider.Span(ctx, "service.GetPayment")
	defer span.End()
	
	res, err := s.workerRepository.GetPayment(ctx, payment)
	if err != nil {
		return nil, err
	}
	return res, nil
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
package database

import (
	"context"
	"time"
	"errors"
	
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/core/erro"

	go_core_observ "github.com/eliezerraj/go-core/observability"
	go_core_pg "github.com/eliezerraj/go-core/database/pg"

	"github.com/jackc/pgx/v5"
	"github.com/rs/zerolog/log"
)

var childLogger = log.With().Str("component","go-gateway-grpc").Str("package","internal.adapter.database").Logger()

var tracerProvider go_core_observ.TracerProvider

type WorkerRepository struct {
	DatabasePGServer *go_core_pg.DatabasePGServer
}

func NewWorkerRepository(databasePGServer *go_core_pg.DatabasePGServer) *WorkerRepository{
	childLogger.Info().Str("func","NewWorkerRepository").Send()

	return &WorkerRepository{
		DatabasePGServer: databasePGServer,
	}
}

// About add payment
func (w WorkerRepository) AddPayment(ctx context.Context, tx pgx.Tx, payment *model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","AddPayment").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Send()

	// Trace
	span := tracerProvider.Span(ctx, "database.AddPayment")
	defer span.End()

	// Prepare
	payment.CreateAt = time.Now()
	if payment.PaymentAt.IsZero(){
		payment.PaymentAt = payment.CreateAt
	}

	// Query and execute
	query := `INSERT INTO payment (fk_card_id, 
									card_number, 
									fk_terminal_id, 
									terminal_name, 
									card_type, 
									card_model, 
									payment_at, 
									mcc, 
									status, 
									currency, 
									amount, 
									create_at,
									tenant_id)
				VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) RETURNING id`

	row := tx.QueryRow(ctx, query, payment.FkCardID,
									payment.CardNumber,
									payment.FkTerminalId,
									payment.TerminalName,
									payment.CardType,
									payment.CardMode,
									payment.PaymentAt,
									payment.MCC,
									payment.Status,
									payment.Currency,
									payment.Amount,
									payment.CreateAt ,
									payment.TenantID)

	var id int
	if err := row.Scan(&id); err != nil {
		childLogger.Error().Err(err).Msg("QueryRow INSERT")
		return nil, errors.New(err.Error())
	}

	// set PK
	payment.ID = id
	return payment , nil
}

// About get payment
func (w WorkerRepository) GetPayment(ctx context.Context, payment *model.Payment) (*model.Payment, error){
	childLogger.Info().Str("func","GetPayment").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Send()
	
	// Trace
	span := tracerProvider.Span(ctx, "database.GetPayment")
	defer span.End()

	// Get connection
	conn, err := w.DatabasePGServer.Acquire(ctx)
	if err != nil {
		return nil, errors.New(err.Error())
	}
	defer w.DatabasePGServer.Release(conn)

	// Prepare
	res_payment := model.Payment{}

	// query and execute
	query := `SELECT id, 
						fk_card_id, 
						card_number, 
						fk_terminal_id, 
						card_type, 
						card_model, 
						payment_at, 
						mcc, 
						status, 
						currency, 
						amount, 
						create_at, 
						update_at,
						tenant_id
				FROM payment
				WHERE id =$1`

	rows, err := conn.Query(ctx, query, payment.ID)
	if err != nil {
		return nil, errors.New(err.Error())
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan( 	&res_payment.ID, 
							&res_payment.FkCardID, 
							&res_payment.CardNumber, 
							&res_payment.FkTerminalId, 
							&res_payment.CardType, 
							&res_payment.CardMode,
							&res_payment.PaymentAt,
							&res_payment.MCC,
							&res_payment.Status,							
							&res_payment.Currency,
							&res_payment.Amount,
							&res_payment.CreateAt,
							&res_payment.UpdateAt,
							&res_payment.TenantID,
						)
		if err != nil {
			return nil, errors.New(err.Error())
        }
		return &res_payment, nil
	}
	
	return nil, erro.ErrNotFound
}
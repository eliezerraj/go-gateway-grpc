package database

import (
	"context"
	"errors"
	
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/core/erro"

	go_core_observ "github.com/eliezerraj/go-core/observability"
	go_core_pg "github.com/eliezerraj/go-core/database/pg"

	"github.com/rs/zerolog/log"
)

var childLogger = log.With().Str("component","go-gateway-grpc").Str("package","internal.adapter.database").Logger()

var tracerProvider go_core_observ.TracerProvider

type WorkerRepository struct {
	DatabasePGServer *go_core_pg.DatabasePGServer
}

// About create a worker
func NewWorkerRepository(databasePGServer *go_core_pg.DatabasePGServer) *WorkerRepository{
	childLogger.Info().Str("func","NewWorkerRepository").Send()

	return &WorkerRepository{
		DatabasePGServer: databasePGServer,
	}
}

// About get card
func (w *WorkerRepository) GetCard(ctx context.Context, card model.Card) (*model.Card, error){
	childLogger.Info().Str("func","GetCard").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Send()
	
	// Trace
	span := tracerProvider.Span(ctx, "database.GetCard")
	defer span.End()

	// Get connection
	conn, err := w.DatabasePGServer.Acquire(ctx)
	if err != nil {
		return nil, errors.New(err.Error())
	}
	defer w.DatabasePGServer.Release(conn)

	// prepare
	res_card := model.Card{}

	// query and execute
	query :=  `SELECT 	c.id, 
						c.fk_account_id,
						a.account_id, 
						c.card_number, 
						c.card_type, 
						c.card_model, 
						c.card_pin, 
						c.status, 
						c.tenant_id
				FROM card c,
					account a 
				WHERE c.card_number = $1
				and a.id = c.fk_account_id`

	rows, err := conn.Query(ctx, query, card.CardNumber)
	if err != nil {
		return nil, errors.New(err.Error())
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan( 	&res_card.ID, 
							&res_card.FkAccountID, 
							&res_card.AccountID,
							&res_card.CardNumber, 
							&res_card.Type, 
							&res_card.Model,
							&res_card.Pin,
							&res_card.Status,
							&res_card.TenantID,
		)
		if err != nil {
			return nil, errors.New(err.Error())
        }
		return &res_card, nil
	}
	
	return nil, erro.ErrNotFound
}

// About get a transacion UUID
func (w WorkerRepository) GetTransactionUUID(ctx context.Context) (*string, error){
	childLogger.Info().Str("func","GetTransactionUUID").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Send()
	
	// Trace
	span := tracerProvider.Span(ctx, "database.GetTransactionUUID")
	defer span.End()

	conn, err := w.DatabasePGServer.Acquire(ctx)
	if err != nil {
		return nil, errors.New(err.Error())
	}
	defer w.DatabasePGServer.Release(conn)

	// Prepare
	var uuid string

	// Query and Execute
	query := `SELECT uuid_generate_v4()`

	rows, err := conn.Query(ctx, query)
	if err != nil {
		return nil, errors.New(err.Error())
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&uuid) 
		if err != nil {
			return nil, errors.New(err.Error())
        }
		return &uuid, nil
	}
	
	return &uuid, nil
}
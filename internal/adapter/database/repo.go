package database

import (
	"context"
	"errors"
	
	go_core_observ "github.com/eliezerraj/go-core/observability"
	go_core_pg "github.com/eliezerraj/go-core/database/pg"

	"github.com/rs/zerolog/log"
)

var (
	childLogger = log.With().Str("component","go-gateway-grpc").Str("package","internal.adapter.database").Logger()
	tracerProvider go_core_observ.TracerProvider
)

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

// Above get stats from database
func (w WorkerRepository) Stat(ctx context.Context) (go_core_pg.PoolStats){
	childLogger.Info().Str("func","Stat").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Send()
	
	stats := w.DatabasePGServer.Stat()

	resPoolStats := go_core_pg.PoolStats{
		AcquireCount:         stats.AcquireCount(),
		AcquiredConns:        stats.AcquiredConns(),
		CanceledAcquireCount: stats.CanceledAcquireCount(),
		ConstructingConns:    stats.ConstructingConns(),
		EmptyAcquireCount:    stats.EmptyAcquireCount(),
		IdleConns:            stats.IdleConns(),
		MaxConns:             stats.MaxConns(),
		TotalConns:           stats.TotalConns(),
	}

	return resPoolStats
}


// About get a transacion UUID
func (w WorkerRepository) GetTransactionUUID(ctx context.Context) (*string, error){
	childLogger.Info().Str("func","GetTransactionUUID").Interface("trace-resquest-id", ctx.Value("trace-request-id")).Send()
	
	// Trace
	span := tracerProvider.Span(ctx, "database.GetTransactionUUID")
	defer span.End()

	conn, err := w.DatabasePGServer.Acquire(ctx)
	if err != nil {
		childLogger.Error().Err(err).Send()
		return nil, errors.New(err.Error())
	}
	defer w.DatabasePGServer.Release(conn)

	// Prepare
	var uuid string

	// Query and Execute
	query := `SELECT uuid_generate_v4()`

	rows, err := conn.Query(ctx, query)
	if err != nil {
		childLogger.Error().Err(err).Send()
		return nil, errors.New(err.Error())
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&uuid) 
		if err != nil {
			childLogger.Error().Err(err).Send()
			return nil, errors.New(err.Error())
        }
		return &uuid, nil
	}
	
	return &uuid, nil
}
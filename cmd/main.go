package main

import(
	"fmt"
	"time"
	"context"
	
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"

	"github.com/go-gateway-grpc/internal/adapter/api"
	"github.com/go-gateway-grpc/internal/infra/configuration"
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/core/service"
	"github.com/go-gateway-grpc/internal/infra/server"
	"github.com/go-gateway-grpc/internal/adapter/database"
	adapter_grpc "github.com/go-gateway-grpc/internal/adapter/grpc/client"

	go_core_pg "github.com/eliezerraj/go-core/database/pg"
	go_grpc_client_worker "github.com/eliezerraj/go-core/grpc"	
)

var(
	logLevel = 	zerolog.InfoLevel // zerolog.InfoLevel zerolog.DebugLevel
	appServer	model.AppServer
	databaseConfig go_core_pg.DatabaseConfig
	databasePGServer go_core_pg.DatabasePGServer
	goCoreGrpcClientWorker go_grpc_client_worker.GrpcClientWorker
	childLogger = log.With().Str("component","go-gateway-grpc").Str("package", "main").Logger()
)

// About initialize the enviroment var
func init(){
	childLogger.Info().Str("func","init").Send()

	zerolog.SetGlobalLevel(logLevel)

	infoPod, server := configuration.GetInfoPod()
	configOTEL 		:= configuration.GetOtelEnv()
	databaseConfig 	:= configuration.GetDatabaseEnv()
	apiService 	:= configuration.GetEndpointEnv() 

	appServer.InfoPod = &infoPod
	appServer.Server = &server
	appServer.DatabaseConfig = &databaseConfig
	appServer.ConfigOTEL = &configOTEL
	appServer.ApiService = apiService
}

func main()  {
	childLogger.Info().Str("func","main").Interface("appServer :",appServer).Send()

	ctx, cancel := context.WithTimeout(	context.Background(), 
										time.Duration( appServer.Server.ReadTimeout ) * time.Second)
	defer cancel()

	// Open Database
	count := 1
	var err error
	for {
		databasePGServer, err = databasePGServer.NewDatabasePGServer(ctx, *appServer.DatabaseConfig)
		if err != nil {
			if count < 3 {
				childLogger.Error().Err(err).Msg("error open database... trying again !!")
			} else {
				childLogger.Error().Err(err).Msg("fatal error open Database aborting")
				panic(err)
			}
			time.Sleep(3 * time.Second) //backoff
			count = count + 1
			continue
		}
		break
	}

	// Open client GRPC channel
	var adapaterGrpc adapter_grpc.AdapaterGrpc

	goCoreGrpcClientWorker, err  := goCoreGrpcClientWorker.StartGrpcClient(appServer.ApiService[0].Url)
	if err != nil {
		childLogger.Error().Err(err).Msg(fmt.Sprintf("erro connect to grpc server : %v %v",appServer.ApiService[0].Name, appServer.ApiService[0].Url ))
	} else {
		// test connection
		err = goCoreGrpcClientWorker.TestConnection(ctx)
		if err != nil {
			childLogger.Error().Err(err).Msg(fmt.Sprintf("erro connect to grpc server : %v %v",appServer.ApiService[0].Name, appServer.ApiService[0].Url ))
		} else {
			childLogger.Info().Msg("gprc channel openned sucessfull")
		}
		adapaterGrpc = *adapter_grpc.NewAdapaterGrpc(goCoreGrpcClientWorker)
	}

	// create and wire
	database := database.NewWorkerRepository(&databasePGServer)
	workerService := service.NewWorkerService(database, appServer.ApiService, &adapaterGrpc )

	httpRouters := api.NewHttpRouters(workerService)
	httpServer := server.NewHttpAppServer(appServer.Server)

	// start server
	httpServer.StartHttpAppServer(ctx, &httpRouters, &appServer)
}
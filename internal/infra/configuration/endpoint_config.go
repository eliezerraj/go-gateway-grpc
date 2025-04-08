package configuration

import(
	"os"
	"github.com/joho/godotenv"
	"github.com/go-gateway-grpc/internal/core/model"
)

// About get service´s endpoint env var
func GetEndpointEnv() []model.ApiService {
	childLogger.Info().Str("func","GetEndpointEnv").Send()

	err := godotenv.Load(".env")
	if err != nil {
		childLogger.Error().Err(err).Send()
	}
	
	var apiService []model.ApiService

	var apiService01 model.ApiService
	if os.Getenv("URL_SERVICE_01") !=  "" {
		apiService01.Url = os.Getenv("URL_SERVICE_01")
	}
	if os.Getenv("X_APIGW_API_ID_SERVICE_01") !=  "" {
		apiService01.Header_x_apigw_api_id = os.Getenv("X_APIGW_API_ID_SERVICE_01")
	}
	if os.Getenv("METHOD_SERVICE_01") !=  "" {
		apiService01.Method = os.Getenv("METHOD_SERVICE_01")
	}
	if os.Getenv("NAME_SERVICE_01") !=  "" {
		apiService01.Name = os.Getenv("NAME_SERVICE_01")
	}
	if os.Getenv("HOST_SERVICE_01") !=  "" {
		apiService01.HostName = os.Getenv("HOST_SERVICE_01")
	}
	apiService = append(apiService, apiService01)

	return apiService
}
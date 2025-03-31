package api

import (
	"encoding/json"
	"net/http"
	"github.com/rs/zerolog/log"

	"github.com/go-gateway-grpc/internal/core/service"
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/core/erro"

	"github.com/eliezerraj/go-core/coreJson"
	"github.com/gorilla/mux"

	go_core_observ "github.com/eliezerraj/go-core/observability"
)

var childLogger = log.With().Str("component", "go-gateway-grpc").Str("package", "internal.adapter.api").Logger()

var core_json coreJson.CoreJson
var core_apiError coreJson.APIError
var tracerProvider go_core_observ.TracerProvider

type HttpRouters struct {
	workerService 	*service.WorkerService
}

func NewHttpRouters(workerService *service.WorkerService) HttpRouters {
	childLogger.Info().Str("func","NewHttpRouters").Send()
	
	return HttpRouters{
		workerService: workerService,
	}
}

// About return a health
func (h *HttpRouters) Health(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Msg("Health")

	json.NewEncoder(rw).Encode(model.MessageRouter{Message: "true"})
}

// About return a live
func (h *HttpRouters) Live(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Str("func","Live").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	json.NewEncoder(rw).Encode(model.MessageRouter{Message: "true"})
}

// About show all header received
func (h *HttpRouters) Header(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Str("func","Header").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()
	
	json.NewEncoder(rw).Encode(req.Header)
}

// About create a token from card
func (h *HttpRouters) CreateCardToken(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","CreateCardToken").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	span := tracerProvider.Span(req.Context(), "adapter.api.CreateCardToken")
	defer span.End()

	card := model.Card{}
	err := json.NewDecoder(req.Body).Decode(&card)
    if err != nil {
		core_apiError = core_apiError.NewAPIError(err, http.StatusBadRequest)
		return &core_apiError
    }
	defer req.Body.Close()

	res, err := h.workerService.CreateCardToken(req.Context(), card)
	if err != nil {
		switch err {
		case erro.ErrNotFound:
			core_apiError = core_apiError.NewAPIError(err, http.StatusNotFound)
		default:
			core_apiError = core_apiError.NewAPIError(err, http.StatusInternalServerError)
		}
		return &core_apiError
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

// About get information from a grpc server (pod information)
func (h *HttpRouters) GetInfoPodGrpc(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","GetInfoPodGrpc").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	// Trace
	span := tracerProvider.Span(req.Context(), "adapter.api.GetInfoPodGrpc")
	defer span.End()

	// GetInfoPodGrpc service
	res, err := h.workerService.GetInfoPodGrpc(req.Context())
	if err != nil {
		switch err {
		case erro.ErrNotFound:
			core_apiError = core_apiError.NewAPIError(err, http.StatusNotFound)
		default:
			core_apiError = core_apiError.NewAPIError(err, http.StatusInternalServerError)
		}
		return &core_apiError
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

// About get a card info from token
func (h *HttpRouters) GetCardToken(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","GetCardToken").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	span := tracerProvider.Span(req.Context(), "adapter.api.GetCardToken")
	defer span.End()

	// Parameter
	vars := mux.Vars(req)
	card := model.Card{}
	card.TokenData = vars["id"]

	res, err := h.workerService.GetCardToken(req.Context(), card)
	if err != nil {
		switch err {
		case erro.ErrNotFound:
			core_apiError = core_apiError.NewAPIError(err, http.StatusNotFound)
		default:
			core_apiError = core_apiError.NewAPIError(err, http.StatusInternalServerError)
		}
		return &core_apiError
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

// About add payment via token
func (h *HttpRouters) AddPaymentToken(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","AddPayment").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	span := tracerProvider.Span(req.Context(), "adapter.api.AddPaymentToken")
	defer span.End()

	payment := model.Payment{}
	err := json.NewDecoder(req.Body).Decode(&payment)
    if err != nil {
		core_apiError = core_apiError.NewAPIError(err, http.StatusBadRequest)
		return &core_apiError
    }
	defer req.Body.Close()

	res, err := h.workerService.AddPaymentToken(req.Context(), payment)
	if err != nil {
		switch err {
		case erro.ErrNotFound:
			core_apiError = core_apiError.NewAPIError(err, http.StatusNotFound)
		default:
			core_apiError = core_apiError.NewAPIError(err, http.StatusInternalServerError)
		}
		return &core_apiError
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

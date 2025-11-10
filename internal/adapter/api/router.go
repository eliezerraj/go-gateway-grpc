package api

import (
	"fmt"
	"time"
	"context"
	"reflect"
	"encoding/json"
	"net/http"
	"strings"
	
	"github.com/rs/zerolog/log"

	"github.com/go-gateway-grpc/internal/core/service"
	"github.com/go-gateway-grpc/internal/core/model"
	"github.com/go-gateway-grpc/internal/core/erro"

	"github.com/eliezerraj/go-core/coreJson"

	go_core_observ "github.com/eliezerraj/go-core/observability"
)

var (
	childLogger = log.With().Str("component", "go-gateway-grpc").Str("package", "internal.adapter.api").Logger()
	core_json coreJson.CoreJson
	core_apiError coreJson.APIError
	tracerProvider go_core_observ.TracerProvider
)

type HttpRouters struct {
	workerService 	*service.WorkerService
	ctxTimeout		time.Duration
}

// About create a new instance of HttpRouters
func NewHttpRouters(workerService *service.WorkerService,
					ctxTimeout	time.Duration) HttpRouters {
	childLogger.Info().Str("func","NewHttpRouters").Send()
	
	return HttpRouters{
		workerService: workerService,
		ctxTimeout: ctxTimeout,
	}
}

// About return a health
func (h *HttpRouters) Health(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Str("func","Health").Send()

	json.NewEncoder(rw).Encode(model.MessageRouter{Message: "true"})
}

// About return a live
func (h *HttpRouters) Live(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Str("func","Live").Send()

	json.NewEncoder(rw).Encode(model.MessageRouter{Message: "true"})
}

// About show all header received
func (h *HttpRouters) Header(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Str("func","Header").Send()
	
	json.NewEncoder(rw).Encode(req.Header)
}

// About show all context values
func (h *HttpRouters) Context(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Str("func","Context").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()
	
	contextValues := reflect.ValueOf(req.Context()).Elem()
	json.NewEncoder(rw).Encode(fmt.Sprintf("%v",contextValues))
}


// About show pgx stats
func (h *HttpRouters) Stat(rw http.ResponseWriter, req *http.Request) {
	childLogger.Info().Str("func","Stat").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()
	
	res := h.workerService.Stat(req.Context())

	json.NewEncoder(rw).Encode(res)
}

// About handle error
func (h *HttpRouters) ErrorHandler(trace_id string, err error) *coreJson.APIError {
	if strings.Contains(err.Error(), "context deadline exceeded") {
    	err = erro.ErrTimeout
	} 
	switch err {
	case erro.ErrBadRequest:
		core_apiError = core_apiError.NewAPIError(err, trace_id, http.StatusBadRequest)
	case erro.ErrNotFound:
		core_apiError = core_apiError.NewAPIError(err, trace_id, http.StatusNotFound)
	case erro.ErrTimeout:
		core_apiError = core_apiError.NewAPIError(err, trace_id, http.StatusGatewayTimeout)
	default:
		core_apiError = core_apiError.NewAPIError(err, trace_id, http.StatusInternalServerError)
	}
	return &core_apiError
}

// About get information from a grpc server (pod information)
func (h *HttpRouters) GetInfoPodGrpc(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","GetInfoPodGrpc").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	ctx, cancel := context.WithTimeout(req.Context(), h.ctxTimeout * time.Second)
    defer cancel()

	// Trace
	ctx, span := tracerProvider.SpanCtx(ctx, "adapter.api.GetInfoPodGrpc")
	defer span.End()

	trace_id := fmt.Sprintf("%v", ctx.Value("trace-request-id"))

	// GetInfoPodGrpc service
	res, err := h.workerService.GetInfoPodGrpc(ctx)
	if err != nil {
		return h.ErrorHandler(trace_id, err)
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

// About add payment via token
func (h *HttpRouters) AddPaymentToken(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","AddPaymentToken").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	ctx, cancel := context.WithTimeout(req.Context(), h.ctxTimeout * time.Second)
    defer cancel()

	ctx, span := tracerProvider.SpanCtx(ctx, "adapter.api.AddPaymentToken")
	defer span.End()

	trace_id := fmt.Sprintf("%v", ctx.Value("trace-request-id"))

	payment := model.Payment{}
	err := json.NewDecoder(req.Body).Decode(&payment)
    if err != nil {
		return h.ErrorHandler(trace_id, erro.ErrBadRequest)
    }
	defer req.Body.Close()

	res, err := h.workerService.AddPaymentToken(ctx, payment)
	if err != nil {
		return h.ErrorHandler(trace_id, err)
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

// About add payment
func (h *HttpRouters) AddPayment(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","AddPayment").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	ctx, cancel := context.WithTimeout(req.Context(), h.ctxTimeout * time.Second)
    defer cancel()

	ctx, span := tracerProvider.SpanCtx(ctx, "adapter.api.AddPayment")
	defer span.End()

	trace_id := fmt.Sprintf("%v", ctx.Value("trace-request-id"))

	payment := model.Payment{}
	err := json.NewDecoder(req.Body).Decode(&payment)
    if err != nil {
		return h.ErrorHandler(trace_id, erro.ErrBadRequest)
    }
	defer req.Body.Close()

	res, err := h.workerService.AddPayment(ctx, payment)
	if err != nil {
		return h.ErrorHandler(trace_id, err)
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

// About pix transaction aysnc
func (h *HttpRouters) PixTransaction(rw http.ResponseWriter, req *http.Request) error {
	childLogger.Info().Str("func","PixTransaction").Interface("trace-resquest-id", req.Context().Value("trace-request-id")).Send()

	ctx, cancel := context.WithTimeout(req.Context(), h.ctxTimeout * time.Second)
    defer cancel()

	ctx, span := tracerProvider.SpanCtx(ctx, "adapter.api.PixTransaction")
	defer span.End()

	trace_id := fmt.Sprintf("%v", ctx.Value("trace-request-id"))

	pixTransaction := model.PixTransaction{}
	err := json.NewDecoder(req.Body).Decode(&pixTransaction)
    if err != nil {
		return h.ErrorHandler(trace_id, erro.ErrBadRequest)
    }

	// use the transaction_id if it was informed - this scenario is used to test the idepontent key (valkey go-ledger-worker)
	if len(req.Header.Values("transaction-id")) > 0 {
		pixTransaction.TransactionId = req.Header.Values("transaction-id")[0]
	}

	defer req.Body.Close()

	res, err := h.workerService.PixTransaction(ctx, pixTransaction)
	if err != nil {
		return h.ErrorHandler(trace_id, err)
	}
	
	return core_json.WriteJSON(rw, http.StatusOK, res)
}

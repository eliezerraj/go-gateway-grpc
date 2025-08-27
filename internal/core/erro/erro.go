package erro

import (
	"errors"
)

var (
	ErrNotFound 		= errors.New("item not found")
	ErrBadRequest 		= errors.New("bad request ! check parameters")
	ErroPayloadMalInformed	= errors.New("paylod mal informed")
	ErroGrpcServer			= errors.New("gprc server is outage or break (circuit breaker is going to OPEN)")
	ErroGrpcServerNill		= errors.New("gprc server is not initialized - nil (circuit breaker is going to OPEN)")
	ErrHTTPForbiden		= errors.New("forbiden request")
	ErrUnauthorized 	= errors.New("not authorized")
	ErrServer		 	= errors.New("server identified error")
	ErrTimeout			= errors.New("timeout: context deadline exceeded.")	
)
package erro

import (
	"errors"
)

var (
	ErrNotFound 			= errors.New("item not found")
	ErroPayloadMalInformed	= errors.New("paylod mal informed")
	ErroGrpcServer			= errors.New("gprc server is outage (circuit breaker OPEN)")

	ErrHTTPForbiden		= errors.New("forbiden request")
	ErrUnauthorized 	= errors.New("not authorized")
	ErrServer		 	= errors.New("server identified error")
)
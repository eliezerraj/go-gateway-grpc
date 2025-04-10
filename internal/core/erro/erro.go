package erro

import (
	"errors"
)

var (
	ErrNotFound 			= errors.New("item not found")
	ErroPayloadMalInformed	= errors.New("paylod mal informed")

	ErrHTTPForbiden		= errors.New("forbiden request")
	ErrUnauthorized 	= errors.New("not authorized")
	ErrServer		 	= errors.New("server identified error")
)
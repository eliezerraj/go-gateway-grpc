package erro

import (
	"errors"
)

var (
	ErrNotFound 			= errors.New("item not found")
	ErroPayloadMalInformed	= errors.New("paylod mal informed")
)
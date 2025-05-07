#!/bin/bash

# variabels
#AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6Ijc4NDE3YWI2LTg4YzktNDRkZi1iZjIxLTVhYzI1NTZlNzU1NCIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDYzNjcxMDh9.K-eWRVfTQXBJ-UA0sbTknbGF6qXBxD9eFbm3r5Q0TxE-uq-c9L-omVyMJ3gUQDAqM_1JDpRa2EiED6uYsOIU0_c4qj6xNm7fU_IkCyDuf0mxghWPfbBpkegj2NhXdQEfNLGC8bSK6037FxGWTWteT_UFtEQR0OKMLaYrI0nbTnIKCNudExeJqcv2yMIYubfLweTe_m40-qZPdganHFKuQn1qZ0kHNDk1jcfIF7nb2zNdNmEZJsmIeqYMCx9kE8hcDSoAcIxklT8Xj0396OloSbNO7H-AqDhCCnYZUeuN15G0n2KhIUvxXKuqDuD96lxdKLo0LOnUaT2YY-Yv4u765tlc1j_AGicbuIs5gbOXjYO2go7ngDxDa050tKR6kEl9ZcpNWF3Nx1UGxeW69KbOOQS00C3STdgRvr8lhjRExrrvd1b00IUuMxGGJ1qcudZDxSkhJv7onXrB387EyBAD2iIn8U-xNUIJK8y3VGRUw7ZeD3NsTxV2jy7bXZk6v4Cs3SOcmigRTAOwe_XcZrRlonhhxZDhjezuM4j20V6Uy3EJAghhI0pOZYwIO3C4aSafjS6A1KpSl_KO2UqPyXqHYTIVA5VOUxOMpvdrtBwZ205qNGYMiCzv9A6DIr1TlUPzvwI3qWbS43eR-KikuE7vzWnO1hmtlRT8XAgtf3_4_RU

URL_POST=https://go-global.architecture.caradhras.io/gateway-grpc/paymentToken

RANDOM_PRICE=$((RANDOM % 130 + 20))

FINAL_PAN=644f7143d2d49de4f202d686a6be4e5b51486a62bab6edf5d4ff12c1a067ba1c

echo '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}'

# POST request
curl -i -s -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}' | grep "^HTTP\/"
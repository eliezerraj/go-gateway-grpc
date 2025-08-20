SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMi4wIiwiand0X2lkIjoiZTk4ZmFkZWQtNTlhNi00ZjgxLWIyMWItM2E2OWU3ZjE2MjcwIiwidXNlcm5hbWUiOiJ1c2VyLTAxIiwidGllciI6InRpZXIxIiwic2NvcGUiOlsidGVzdC5yZWFkIiwidGVzdC53cml0ZSIsImFkbWluIl0sImV4cCI6MTc1NTc5NzY1OX0.lHeZyj5tV3fB61mQLI8t6XF4Y1yCMK63N6CK1HneLeVSagGPmKX95mv0hMahnDX_ARukHMIH7doXxWQJeyv5oO9rz8bUHWzI5859_sy3Nbmjrnrf1UFOknekJliHJxWbgWio8lLcgkdkPps4bGCVe2HqmCowE6jGIOsdc7-1-c9srquTo0qJHPyBrYZPKdp379rGp1DKsd8zTzT5ryjBKyFCYZbaDjY4YBd0JWK3i-KnizmCwimOi8p3ScHb2aM00-f8_FGWShpE_KcqzAhzqGSd8YNH2kKiWCkswxLXe0ZYAw6aRCD6lTMqdcBgMch1cu53yaHWrDXVUs7IYIreblq8klcUbrClGrvGiLSUrihib1iGRdUOSw_Pds4eVEcNWSbyURVR7lpoVheADDxUE0qjm8D95_cMrByAHKB0lMZykTqaT0mlJpeeKVmiq4tVbE456t4Jl4CPFXqHBwOLHI96o8d9K-1YzCzezrKl2szSK8iPJk-oAQEA0_aI8H9_Oxdva3togS6NuyWzAzXSauYZTGGfmmNxP0KaqLQpzCuaQxlHnW9ThgiZIYcMGPFv47kF4BT3NyuNoSkXDbheJVm_hoSBObxB0iNksPHAA8K2NJmOmCjkVt9LegcayYM1hYOctT-Lu9nLcZ5LQEgSCDddFQWz1nwITlKY1Beel20

#export URL_POST_PIX=https://go-global.architecture.caradhras.io/gateway-grpc/pixTransaction
#export URL_POST_PAYMENT=https://go-global.architecture.caradhras.io/gateway-grpc/payment
#export URL_POST_TOKEN=https://go-global.architecture.caradhras.io/gateway-grpc/paymentToken

# Default target
all: env

# Show environment variables # echo "$$(echo "obase=2; $$a" | bc)"; \
env:
	@echo "Current Environment Variables:"
	@echo "AUTH_TOKEN=$(AUTH_TOKEN)"
	@echo "---------------------------------------------------------"

load_all:
	@echo "Run load all ..."

	@for ((i=0; i<=1000000; i++)); do \
		echo "--- LEDGER (ledger/movimentStatement) ---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/ledger_dynamic_v2.sh"; \
		echo "--- PIX (gateway-grpc/pixTransaction) ---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/pix_dynamic_v2.sh"; \
		echo "--- PAYMENT (gateway-grpc/payment) ---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/payment_dynamic_v2.sh"; \
		echo "--- TOKEN (gateway-grpc/paymentToken) ---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/token_dynamic_v2.sh"; \
		echo "--- CARD (card/cardToken) ---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/card_dynamic_v2.sh"; \
	done

load_pix:
	@echo "Run load pixTransaction ..."

	@for ((i=0; i<=10000; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/pix_dynamic.sh"; \
	done

load_payment:
	@echo "Run load payment_dynamic.sh ..."

	@for ((i=0; i<=10000; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/payment_dynamic.sh"; \
	done

load_token:
	@echo "Run load token_dynamic.sh ..."

	@for ((i=0; i<=10000; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/token_dynamic.sh"; \
	done

siege_pix:
	@echo "Run siege pixTransaction ..."

	@siege -c120 -t2m -d1 -v --content-type "application/json" --header="Authorization: $(AUTH_TOKEN)" '$(URL_POST_PIX) POST {"account_from":{"account_id":"ACC-900"},"account_to":{"account_id":"ACC-901"},"currency":"BRL","amount":1.50}'

siege_payment:
	@echo "Run siege payment ..."

	@siege -c5 -t2m -d1 -v --content-type "application/json" --header="Authorization: $(AUTH_TOKEN)" '$(URL_POST_PAYMENT) POST {"card_number": "111.111.000.216","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": 52}'

siege_token:
	@echo "Run siege payment ..."

	@siege -c120 -t2m -v --content-type "application/json" --header="Authorization: $(AUTH_TOKEN)" '$(URL_POST_TOKEN) POST {"token_data": "644f7143d2d49de4f202d686a6be4e5b51486a62bab6edf5d4ff12c1a067ba1c","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": 105}'


.PHONY: all env
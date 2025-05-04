SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6IjZjOGNkYjBlLWZkYzctNDBiNy1iYTg5LTk1NDY1MzFhZGVhZSIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDYyNzUxMjF9.EwN2XWT4BrjqMK2xAJCHtbCGAEi-E40MCyyVKtO20LC1lMRlmktlqC3wZtYRSdpbGARpBwA5RboAfLTzdLRg50MuMxx9gCoubaghErp3zOnvdvgE-zSEgH8HLzJiQEEmj43YoSpAW1H_ZpAP1-QQ8rS_DWNCyrXCu7axXAXmJWli16_n0iIzXaA43066eIdpowoSn7Ho8kb5b0MncY_q0m0IkaTwHnNesMlRXYV5bw472IabMGCQXOPlsw1_zxHDdOys8sDkRlkt52g6R0nqaNg4Q3z7MZ-gZEMu2ENVZwdbkUWE3wf_Yv9PJPRtEdq1e9U8iZyi3NQ-QuSeVhUSwwK_mqn6gxhT2amMUd6cKpSK3O5qiB8qU_erElj-io5EWoHLUh5BSYELR_yjk-cxwuY3kBDJLLF2cke61JWpLb0dFLXxcqJeLjU4tGfLbsfVYYavEMtzblrIxub1C7iR2RdPA48XyISmXGcJrClJAgUGpPBq0JF65isVAjXd2PVEFxx2IMbSDWRtkndRHvUMYasZKeL4xhlWDrh7o7Dd5yfy5Ko29k0GWTQsGR_zTUprpZmerTWA9Aj6md-G8jmqy3k7M_Ac_AGzPFIJTkCvJUX5UA21txrcGs-6tghQv0mASbJ-BY8k3vmhS7SH4pDGHEtUoOpTQMz-CGyZy-spmQg
export URL_POST_PIX=https://go-global.architecture.caradhras.io/gateway-grpc/pixTransaction
export URL_POST_PAYMENT=https://go-global.architecture.caradhras.io/gateway-grpc/payment
export URL_POST_TOKEN=https://go-global.architecture.caradhras.io/gateway-grpc/paymentToken

# Default target
all: env

# Show environment variables # echo "$$(echo "obase=2; $$a" | bc)"; \
env:
	@echo "Current Environment Variables:"
	@echo "AUTH_TOKEN=$(AUTH_TOKEN)"
	@echo "---------------------------------------------------------"

load_all:
	@echo "Run load pixTransaction ..."

	@for ((i=0; i<=1000; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/pix_dynamic.sh"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/payment_dynamic.sh"; \
	done

load_pix:
	@echo "Run load pixTransaction ..."

	@for ((i=0; i<=1000; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/pix_dynamic.sh"; \
	done

load_payment:
	@echo "Run load payment_dynamic.sh ..."

	@for ((i=0; i<=1000; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/payment_dynamic.sh"; \
	done

load_token:
	@echo "Run load token_dynamic.sh ..."

	@for ((i=0; i<=1000; i++)); do \
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
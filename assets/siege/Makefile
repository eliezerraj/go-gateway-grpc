SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6IjgxZTI0NDliLTMyYjktNGZjMS1hYWFlLTk3MDQxYjNlMDRiZCIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDc0ODEwODd9.Wp_sad7c_aASENYjC3zaZhnLL4Nsnip1phVAfRQ3aXCFPB7VN34gMzHikBzUFhL7MfjwYfsXVDXYqmQA5XZOPxsDNirskIV73nsI5EELlkfyCAY0Yel3ot1X_fN0tGmjXeyvbyLQhKMqq2ck5BS2SPlXQvk-guf2qZg2lgDCKoQB7FELOhxwc-zFD7nu7MkIXrdWeLTRj6JhNIwaGlsFj1FY-0_PC20FxaoTDhN252FZwZbznTWWi49gt9zk2KybZEIgVD-pG6sGDe1H7sCV-fRfT7467ybslkaGYGlyI9fuJU_QDEh5JtkXeW8Qn-N7DmcDoYR2kc3U9575qd9OJAoP1ozwaEj2C85plPYGO288JP3LvDAdP__uQXosMEqahHcT4-gubitU0n9fLyhdYtxg7w3KnzTUHsOmAWPOwLoy3_TlhwGTr7BTzGtjLMvAK_lFYAfKFz7-SkAdFtiL8CwGpFCmwsH5656qvKXFP99KL6lXbnYmpTkmPX8eHR84a4KF0FMMFdHFHzZemGuxJ_XkZo_PgQf1Uy866AnYZfaG4x0zwnrhN1IWBEMpQa6KV593b9B5LL5BqZnCWA7omiFKbp_-F8STOmR7zlUU6FjHMDPjAHrcBbjogr0_njFN43imROKCymdMhpAGEa3J_vW9hu2bhEqUcibtSE6MET8

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

	@for ((i=0; i<=100000; i++)); do \
		echo "------ LEDGER ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/ledger_dynamic.sh"; \
		echo "------ PIX ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/pix_dynamic.sh"; \
		echo "------ PAYMENT ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/payment_dynamic.sh"; \
		echo "------ TOKEN ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/token_dynamic.sh"; \
		echo "------ CARD ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/card_dynamic.sh"; \
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
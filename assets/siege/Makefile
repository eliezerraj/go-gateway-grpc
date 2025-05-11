SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6ImUzYWQ2ZWI3LWUwM2EtNGM4Yi1hNDU5LTkwOGU1ZDc5Y2I1NyIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDcwNDIzNDl9.Ycg0ZEyMe8pMGfStFLGWscZKaNm-n4zMZ0sP_qEw3kb0aBTcepE58mf5a2dMcxNTorpceuZcKGamjt0JpZxhonifxpChCSxSC90_0dHwqGh0awwJfh3yAW_WvOQjwbQi-FbHtf3jcrMysHMgnW3VY4tok-rycqKTv6111DJKa7qINmsjljJv6M9pV8hGIxtt9FawS4rKxtNxo-xyYhoahtMxJgK2jKAum834-6Y3oBoxVmJw28dJq-ZjbAN7dkhZSmIPtl8Xk-0DZBGXX2HlkTsS3tzCYNLeU3CE3WOhQKS5W6ZvRphO_zYcBh-8yNRyb-Ai7bnMtyfHE6nhlCPFvZpg4EL49VVh9RJrP2tMLKnB27pMu2LyIc980AKabO-JBiYqR47pGS1_lclBPnA94GJ3_MqSrmVvkHOiKz5W6e5nQEVkDpjuVpDpgJfcxy-k5R7ywJXMzEN6YTLdg-hAiMpLEf6M_fg-6X1fTs2rMOJINpi9vGfsEbzSt_oIvzQhRsFp4MEn_mAvpEt_kPGwfZmQiJjtIl5Keiimla_hSg0oqBgVWXUxTklavvrvhCS3O9xkheblX6aVXUX9Gwp2nk9ai_Fi30y1BNuKHiESXhbwQjwuMZXPt2Kij_f2krH9pf9PKJMd3wgjTo3FWlXsUuRuhNfd_bLEkXVJR_gKn4M

export URL_POST_PIX=https://go-global2.architecture.caradhras.io/gateway-grpc/pixTransaction
export URL_POST_PAYMENT=https://go-global2.architecture.caradhras.io/gateway-grpc/payment
export URL_POST_TOKEN=https://go-global2.architecture.caradhras.io/gateway-grpc/paymentToken

# Default target
all: env

# Show environment variables # echo "$$(echo "obase=2; $$a" | bc)"; \
env:
	@echo "Current Environment Variables:"
	@echo "AUTH_TOKEN=$(AUTH_TOKEN)"
	@echo "---------------------------------------------------------"

load_all:
	@echo "Run load all ..."

	@for ((i=0; i<=1000; i++)); do \
		echo "------ PIX ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/pix_dynamic.sh"; \
		echo "------ PAYMENT ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/payment_dynamic.sh"; \
		echo "------ TOKEN ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/token_dynamic.sh"; \
		echo "------ LEDGER ------------"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/ledger_dynamic.sh"; \
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
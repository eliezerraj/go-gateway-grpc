SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMi4xIiwiand0X2lkIjoiZGRkZmM4NjItZTU0Yy00OWZkLWI4MWYtMWY1NjUxYzY3NzI5IiwidXNlcm5hbWUiOiJ1c2VyLTAzIiwidGllciI6InRpZXItMDMiLCJhcGlfYWNjZXNzX2tleSI6IkFQSV9BQ0NFU1NfS0VZX1VTRVJfMDMiLCJzY29wZSI6WyJ0ZXN0LnJlYWQiLCJ0ZXN0LndyaXRlIiwiYWRtaW4iXSwiZXhwIjoxNzU2MDQ1MTYyfQ.lbrD72ol19q57KQO6lTUjo3AUvX2Lz8Rs8ki3zfItduaSbeUzPxrLtLKP61KXRuKwDLy8yT0-amJiI6dgZzLWX72BsLNDnNAQgKTAS4O7BCvCro7w7jjZKRBIKaGewf0Txx_ojbcNsC_ThvxshlBAEafmJLBlBin5z3AGPUhDgaTQdN30fB9JnZVU7fn7ySQQAw6Po5pUokwIMZSI1AhCyaSLzRcmRw43TOXLrDj86pQSi-2CUePBaSjr4Gv2X2gzEX4XkXYmaGbCu--S41KlA-Pcr4mjbDuSzq-qA4-GPzGlrMWK3Gtn75sq7G_5PNL_mxnehFTbKkqbaL0TeKJkCbzVIJ-Mjf8QcKvavJ5-8gw4JbELPl-949LL7gait8p-YVXICbvTrQSxfMqPjxQiYEcKwmh1HO3-cX5Pxm0C5sGjGNgH0gCi8Ou7hunz9LscWjCdC-Gy2u7aTPW2igZCsPOogkRAkNgSpwhrUI_SWroeQQZnFB8SczK7VIia-ie63nWWuYlexH98x-nKvQMTN2jab6YXYb6gwAabb9eB2z8czD1PdUK_bl-jX_3FWtod7fOPKlU3dV1jGAnSAT9zNi6ogdkO6Eg09Gt5LxALZhmcSmyT2RZ4nmlpsv9vgMulrUqP48fhq4c2dluN5W8GKMecQNhBbVZ3pYFoYorGP0

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
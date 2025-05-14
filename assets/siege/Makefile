SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6IjVmODMwNjc0LWIzNjEtNDljZS1hMmMzLTc5MzkyYTE1OTQ5NSIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDcyMDEzMDZ9.mEtRr2BPkuQZEK5VNj_SmVUFom2h4GovFlmGH5xGDz5Ne8ehOfQHEYmuQzejY_vgtwYnyej17UXZ0ev8ohg5wfu9uPwxwyMfbAOlYmCIPudqVfgmlgCuli10kjHsqsTb073nz6lzbeYZETX6WQKJB3Rh9r16_bpPju1NB1fqnxKCpJ-Auzgps_MKUqPDWOkvlQ3biMjWwsYOf7KY0bePF4_OXkOW88lK6GuSYU9KKDB1IOvRzUyCWOU2Olp7dksWsZE4ykHozuL_SEKQOaH89YxoR7JyyKDPq7bVv95HlHQtzoRWTL239KwXRYbDY85LjVyt6bdxE5PrLWMvT4qVu1pybGYM2t0e_SPLgaSL4-cXdJq7L5zSr0NZtrcaasF16NnP50hA-_lQALPuJ8O4RhWB_kwBMgcdgocu1XPvWrIQaknIeE8E-L6Y0NCPzOBD7KJCMO_ZUkQKbkILitjLQ2X01st5A-uWSWUoVOmKBJSo1C0O3urx36OSGepzuwAPvx1cq0aQCj_o_-7a_3E5mI7E3aBeqSkmriyrQ6W79r7ex1hNn3eU9R_PK2Wu7Ujn-bzApcLHjHK7AA23D5C0pwgV2RdgQyh3UWa5NPQJWM805hqqgylAk-clYe4bmXu5oLdvbsNeP-qVXlGamxjp1ENtrjMjyahU8_zO509ky9Q

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

	@for ((i=0; i<=1000; i++)); do \
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
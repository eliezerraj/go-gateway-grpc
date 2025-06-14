SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6ImIxYWQwM2JjLTVkNmUtNDM2Ni1hYTYxLTZkMTczMDRlMDUzNSIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDkyNzM0NDJ9.JB4JbXf2yUMS0E-vZQY5KNXwOTPzequvXl7_Aj2eglOWkPsfb8jaThLSvI6dal2MJKFjKLFtgEGN5zyI6W0rpNelGgdKVelArYAL8EM9EBDqvMU5heo8j8BOgB5w3cGweun-Y6pBWu9Sn4gGwoPV6A3P9rjb_-nDbndj-eOlfA5B7GKVqnmlxXakz9IsmySpkWzZY_qiRXAnWSJd1FnPQnaSLdm6XoI_01d9U1FxSgBJWmrQjpeGfmcxrDQ2iJPs87GtuLvuc2IfCP_o6nKTJKRxdZoXFZ8-0XlSNfQ_y9E832PJ3X1P12prG5ogHSecV7ZRrG8d-lk3qjEbzGI4uFEoj1PSs8PUM6MTIdH30vL-h3MC2X69ofVXpxWrlll_xoBFB8F_GvN_ekMt8W6qYEAQFYIGm-vS5pqjaFVvpT9riouJ0zCI7JbS-Kt1F9FSAp8XO2ryLsfT5FkKThVT6bcoj6fHEF4VwA1ZzrBnNiElAPxCkf_O_y14H1Uxn_kJz1FSPH8HmfwGawgtm1oE226M0AffA_4jvK_TkGw6RqxJORdgrg9K4fLxGvw9WP7k9YtGCgAlao0l4YOPGFnTGp3alwxJxi1hwtIvekJ6GaCWcFsgPNB_PpfvX_xizvp5ZgMdW49z-yb_RfpDv9az4cq1t0yqNHU9WO9cyBosVuY

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
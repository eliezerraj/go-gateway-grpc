SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6IjMxZTJkNDFmLTkwZmUtNGVjMy1hNzk4LWQxM2E2MmJmOTcxNCIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDY0NDUxOTB9.jDizRiRDA9fralRMaNLP7Cik4An_zLAr0w7FPweRPkLtbrZ9QzmrjTuWOVylP55X66tGAS8wXjln3vieg3iTRk-CHB0Xwez7MJZghsXjhbZHDX2oZty99FtbnnGKlEwfgY0_zPEB1XKM63iNoU_y_TQ8vBS_WA5H4OXHEjEDIYqlorQ-ZifpfLTCYfPmi6pE1_z-7qoFbaKbMnL_2cIGQI3efSRGMr73qqmwdt2JxLuHn4eTJHqd5f0QWymf3kWaQ-uhHD_Vif7d0L1pa_wvPzRgOp-budYpGRCbR6kKyHamK6RErr0qjB1yx3QTd7NeBq8DMg5PUIiTI6j47k9jF3q6eGjcMdL_VPk6fWBOq4IcCHAxBBegNNvO6fGlwb27qe_iFUABO8cq_m4jpoy4SaM6yYoUGpuTcbX6AJd7k-68PJfwqDo73XdMnqMd3gO3OGYVo7vEpUuvIkAOiEWesg2aWJEr7sN0IdQcMozyr_Lbgv1BrN-FGn5zGlQSdOeha5DPg5bhC4JBnj4bRLjoPWtwpBLJyZs7PIHxozsocCXCq91FSBmRYsoX0hNvzCZ0WpWxaa2dOzjMT7Vw5bdjUWb2NRp8d22_WIzpt2SZIjykQWcFzpGvY0AiwykFzYGp34Z4c8k4afDIKDApGF0y0X1LfxtwfdvORqrGL5p3DpQ
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
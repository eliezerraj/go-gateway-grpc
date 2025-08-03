SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMi4wIiwiand0X2lkIjoiYWJjMmRiYzctNjZlMC00MDZmLWJmNWUtNzYxOTNkYTc2OTc1IiwidXNlcm5hbWUiOiJ1c2VyLTAxIiwidGllciI6InRpZXIxIiwic2NvcGUiOlsidGVzdC5yZWFkIiwidGVzdC53cml0ZSIsImFkbWluIl0sImV4cCI6MTc1NDA4OTUyN30.a3_0bshmfLJWxUKW4U-23NL3vmiaSB2GpJpK2y4of5bWo7a7oxxn8NfNdGIOZQQJP9fiYAm8KxWLYvPDXJxBZKwUopd7FSOl5Y3yWejNFgNLLbsCSdbH2dls_h6Te4DMNmtNVcCIPuTbppy1dzfeIDDXo3vFxkb7UQ5F9Xf-ISM3-hYSY7jpIa3OwT88khSnQp76QUnVAVZ9Wu4zgUUh-JalmJghwhBwbo8h8ZxmmO2erYDj0fQDUg8P0iOcJYfA_x-Bn_BxT4_BtHHGIVSxF9jpW4qN0CZZRNDOY2y2JPkOLCJDuFm08ebXqTPOd9s0VKsP8GOsRibxl_l07iFwW-LYnru0D7P5hg0m_1UAZP-3fVJT74-Et385dsj2zHmlH7OGVxKcQjGohONe7LRZnXpweb_g-HkqhFncTMt8H1D3JKovkRIQhs5G7G4MAg8-krY42ImF_C1XmnZYotVx2B6EsNtBSpSNQsNn7luM3d54ICHOGDeF451S45PO7gVswxghZznPDg5vNpeuUOMIohgOM1IBETwocEzSmo5_uSaarWd2ZRBisB7X4D-vvoWrhhFHWrCKhGOLIE5SXQNwpb-NNqTWGTcwARXISj_kFkIhWglDDqqy6Ze0a8nWe2Jqr0CLfYkoLKa4G7tTCSFurnCXC2ohHhLh8dp_H7c2BZc

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
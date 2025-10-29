SHELL=/bin/bash

# Define environment variables

export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMi4yIiwiand0X2lkIjoiNDE5NjUzZTUtNzUwMC00YTZmLWJmNmItOGQwZmJlZjI3ZjhjIiwidXNlcm5hbWUiOiJ1c2VyLTAzIiwidGllciI6InRpZXItMDMiLCJhcGlfYWNjZXNzX2tleSI6IkFQSV9BQ0NFU1NfS0VZX1VTRVJfMDMiLCJzY29wZSI6WyJ0ZXN0LnJlYWQiLCJ0ZXN0LndyaXRlIiwiYWRtaW4iXSwiZXhwIjoxNzYxODY3NjA0fQ.X5UgVGcx0-_ZtjBRPRN24q5cWbVf-rybIQUQR7rn6KIzuOmDk0r4uM_yDqdh7Yz8bUg7mnTZ4DHKqx7QWdNHlmVn0I1uj2NFrLgNrnpvJv1PD98T8HIxqUEf0ZYsMvi_R1V8MUQgxlnxT5YQi8GH3-ZanxOG9RpSJZgso1r-VW9Fdx4XVQGrWkcOjKFkrr0ceubRaVWLzX3hSU8XVU2DXkFRQylOKx2PjPIZN5sILGlfi6ASz7wf8Llvg3MJMJ90AE-8kV3A841MUCBrvDxF91lYRjIBzvo5DTuSejwqsEREh5iwf1PSbnYakyNfy8QEQWnCFEOBj0uybU8SesAOnF9FFDNLhksB-cE0NbvDJ1zUGhnGbhWG8opySJ05QmKEwSarGkksAn_omvM4Cqt3FpujX6o-SlUoICD3oGxLO8O_FT2YCdgl4A5d_A3M45ad7efOM-9HIojEtfqBAwi2uP9SiAsEFZrCigGz13eX9dClRm7CN3loGmXZA6g0bHKTx1bj4eymyFwRB1EURfzyHzoouKi6qqlFTEgC9SB8CmK_fZKROqoK4PUcTCSnJahZZ5YTxFMQY0zZL3_t8nvzyX88BEcoPBowdbLVcKhwclYj0DF3JS1vAOWExabdwr0b2ORFrFx-oxl9qknFXM_z6AhpWr7wcVmns7xh3fgmyiM

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
		echo "--- 01 LEDGER (arch) ---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/01_ledger_v1.sh"; \
		echo "--- 02 ACCOUNT (arch) ---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/02_account_v1.sh"; \
		echo "--- 03 CARD (arch-02)---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/03_card_v1.sh"; \
		echo "--- 04 PAYMENT (arch)---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/04_payment_v1.sh"; \
		echo "--- 05 GATEWAY (arch)---"; \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/05_gateway_grpc_v1.sh"; \
	done

	echo "****** FIM DO PROCESSO ******"; \

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
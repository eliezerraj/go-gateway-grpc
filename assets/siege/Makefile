SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6ImNhZjg5ZDE5LTg2NzAtNDFmNy04YmU2LTM2ODU3MGVlYWIyZiIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDU5OTcwODF9.GMVXXMEoHC-7JX_mUhnvnGCum-aYHQRa_Cf96ZTVE0ryiDr6ZAf0ljHzn6o5reZXM2istqMHboSrnxt-Zt4x8Q5gXZsB7DWB5A7a2YfHck9RIH3YO1GQ6ch5UuPmubGmqCx9DCdvriXoMgae4VSyBCUJtQvOpbPpWYphrcmtUuncttRx06HkOmmM3xLI_mEHY9eX10-Tv0FNVSTnY-2H6OlWTM4Gk9ruiqBx7JFh187yg79drDUZ62CPCjbF8JgHvVRTEMdYEt3VuPzyjLlT2lfEuOeWKquxhcFbYU9uIjj2ue4MzE7UEsdBHlfO3tioE5D7jcwyBGX5ebJlUm9MQffrg3PCQ8k9iZ7OwjJv-i7-A8vFskDJJruRP2v893lLnDaKFAeT4Ffg4HqR0T2Rr43w1NmPSmiK7MxORgo8CK86Qm9AKRrG-NiQ1WvZBAx8lVIrQERbr0fgL3elEG0FwHgcSz7g-7SLNlmNne6YsKjxla_vO5sMm3x89L81PPM3ZTDOt-i-gprUVP3NUiF1pn9r5nPZnhJJlcrDtR6C5KmBqMF8ayZwMbLZ715Fpjz7E_4QdAft7hKfzB6MQso4NDRO2EBrrKll_srmLyqAwPDV735j7FPJBUwibjXQ93mZj9ihe7IWASF1wyvMKVvz4v_XEry59YWkh6wcSn0aUz4
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

load_pix:
	@echo "Run load pixTransaction ..."

	@for ((i=0; i<=10; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/pix_dynamic.sh"; \
	done

load_payment:
	@echo "Run load payment_dynamic.sh ..."

	@for ((i=0; i<=10; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/payment_dynamic.sh"; \
	done

load_token:
	@echo "Run load token_dynamic.sh ..."

	@for ((i=0; i<=10; i++)); do \
		"/mnt/c/Eliezer/workspace/github.com/go-gateway-grpc/assets/siege/token_dynamic.sh"; \
	done

siege_pix:
	@echo "Run siege pixTransaction ..."

	@siege -c120 -t2m -d1 -v --content-type "application/json" --header="Authorization: $(AUTH_TOKEN)" '$(URL_POST_PIX) POST {"account_from":{"account_id":"ACC-900"},"account_to":{"account_id":"ACC-901"},"currency":"BRL","amount":1.50}'

siege_payment:
	@echo "Run siege payment ..."

	@siege -c120 -t2m -v --content-type "application/json" --header="Authorization: $(AUTH_TOKEN)" '$(URL_POST_PAYMENT) POST {"card_number": "111.111.000.216","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": 52}'

siege_token:
	@echo "Run siege payment ..."

	@siege -c120 -t2m -v --content-type "application/json" --header="Authorization: $(AUTH_TOKEN)" '$(URL_POST_TOKEN) POST {"token_data": "644f7143d2d49de4f202d686a6be4e5b51486a62bab6edf5d4ff12c1a067ba1c","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": 105}'


.PHONY: all env
SHELL=/bin/bash

# Define environment variables
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMi4wIiwiand0X2lkIjoiNjgyM2VkODgtZDY3Ny00ZGEzLWI4NWUtNmNhOTQ3ODIxYjMwIiwidXNlcm5hbWUiOiJ1c2VyLTAxIiwidGllciI6InRpZXIxIiwic2NvcGUiOlsidGVzdC5yZWFkIiwidGVzdC53cml0ZSIsImFkbWluIl0sImV4cCI6MTc1NDY3OTg3MH0.Wgxn2rKv5ldKjvwuLWMSFtn7s1OrdUE-eKzMBnApoSAbSBAmeOuP1Yc4QqVQqfT0d2gwfss4RGk5XaUfWUOfVybL0l-r6IYFbARmNOXq7PaSmBHzPhXVNhHIpyElUa9psuKGE3DcRwChaH-mX_2UpwtYQi4xf1IzWJmUQQS--jN6i_7iI2Kp5LH5hdfNXtUROhWuP3BlvjLBhBnk64N91TShl-7Xe7XjGggQ9IRlWrDtQKITnEDrZwOrB0MQlISnrjSd1tSkwYbtr9rQb9CRYXfycV-Dj6hvF3--jjq_HzYoayIrhjXoI7kUMI7lGtFyZeVeCUCIzUR0ZJyVrJZgH9AzHfbY4PMLeEzZ4d7lYaWbzmU6MxWmkCjhhL16mXP2ENN87yZNi0CjgO81X6aWfp8d2pGTWTh6bBkE9dtpZ4IFE-xc_hT47JfNLa8R2J3zfpag2RhnC-86PGFqMr9eBx7QK4c7i4L03-RV91WFkaAeB6aWTOhhXFEGns6d4S2jju4_FSwce2hLvmoj64qg3IwHWF7d1XzDZjPq0v332gnNp6Wm_ykwnCGQfKwkQ5mhek63Vuw9bxZv-MgFDonKKgrlxf2UDec3gCjUkOKueXyB9b5qCGeX9NUiUGqcUXpOpsJfKcLTOej-tHEvzM9bk0kqg7wpaLugjWyX_HOynS4

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
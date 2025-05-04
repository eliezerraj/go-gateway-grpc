#!/bin/bash

# variabels
AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6IjZjOGNkYjBlLWZkYzctNDBiNy1iYTg5LTk1NDY1MzFhZGVhZSIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDYyNzUxMjF9.EwN2XWT4BrjqMK2xAJCHtbCGAEi-E40MCyyVKtO20LC1lMRlmktlqC3wZtYRSdpbGARpBwA5RboAfLTzdLRg50MuMxx9gCoubaghErp3zOnvdvgE-zSEgH8HLzJiQEEmj43YoSpAW1H_ZpAP1-QQ8rS_DWNCyrXCu7axXAXmJWli16_n0iIzXaA43066eIdpowoSn7Ho8kb5b0MncY_q0m0IkaTwHnNesMlRXYV5bw472IabMGCQXOPlsw1_zxHDdOys8sDkRlkt52g6R0nqaNg4Q3z7MZ-gZEMu2ENVZwdbkUWE3wf_Yv9PJPRtEdq1e9U8iZyi3NQ-QuSeVhUSwwK_mqn6gxhT2amMUd6cKpSK3O5qiB8qU_erElj-io5EWoHLUh5BSYELR_yjk-cxwuY3kBDJLLF2cke61JWpLb0dFLXxcqJeLjU4tGfLbsfVYYavEMtzblrIxub1C7iR2RdPA48XyISmXGcJrClJAgUGpPBq0JF65isVAjXd2PVEFxx2IMbSDWRtkndRHvUMYasZKeL4xhlWDrh7o7Dd5yfy5Ko29k0GWTQsGR_zTUprpZmerTWA9Aj6md-G8jmqy3k7M_Ac_AGzPFIJTkCvJUX5UA21txrcGs-6tghQv0mASbJ-BY8k3vmhS7SH4pDGHEtUoOpTQMz-CGyZy-spmQg

URL_POST_PIX=https://go-global.architecture.caradhras.io/gateway-grpc/pixTransaction

RANDOM_FROM=$((RANDOM % 100 + 1))
RANDOM_TO=$((RANDOM % 100 + 1))
RANDOM_PRICE=$((RANDOM % 300 + 100))

echo '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}'

# POST request
curl -s -X POST "$URL_POST_PIX" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}'

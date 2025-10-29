#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_HOST=https://go-global-apex.architecture.caradhras.io

#-----------------------------------------------------
URL_GET="${URL_HOST}/payment-gateway/info"

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /info"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /info\e[0m"
fi

#------------------------------------------
RANDOM_PAN=$((RANDOM % 900 + 100))
PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
CARD_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

URL_GET="${URL_HOST}/payment-gateway/payment?card=${CARD_PAN}&after=2025-09-21"
#echo $URL_GET

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  	echo "HTTP:200 /payment-gateway/payment?card=${CARD_PAN}&after=2025-09-21"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /payment-gateway/payment?card=${CARD_PAN}&after=2025-09-21\e[0m"
fi
#-----------------------------------------
RANDOM_FROM=$((RANDOM % 999 + 1))
RANDOM_TO=$((RANDOM % 999 + 1))
RANDOM_PRICE=$((RANDOM % 300 + 100))

URL_POST="${URL_HOST}/payment-gateway/pixTransaction"
PAYLOAD='{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}'
#echo $URL_POST
#echo $PAYLOAD

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data "$PAYLOAD")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  	echo "HTTP:200 /payment-gateway/pixTransaction"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /payment-gateway/pixTransaction\e[0m"
fi

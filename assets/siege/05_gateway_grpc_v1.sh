#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_HOST=https://go-global-apex.architecture.caradhras.io

#-----------------------------------------------------
URL_GET="${URL_HOST}/gateway-grpc/info"

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /info"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /info\e[0m"
fi

#-----------------------------------------
RANDOM_PAN=$((RANDOM % 900 + 100))
RANDOM_PRICE=$((RANDOM % 130 + 20))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
CARD_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

URL_POST="${URL_HOST}/gateway-grpc/payment"
PAYLOAD='{"card_number":"'$CARD_PAN'","card_type":"CREDIT","terminal":"TERM-1","mcc":"FOOD","currency":"BRL","amount":'$RANDOM_PRICE'}'
#echo $URL_POST
#echo $PAYLOAD

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data "$PAYLOAD")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200 /gateway-grpc/payment"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /gateway-grpc/payment\e[0m"
fi

#-------------------------
RANDOM_FROM=$((RANDOM % 999 + 1))
RANDOM_TO=$((RANDOM % 999 + 1))
RANDOM_PRICE=$((RANDOM % 300 + 100))

URL_POST="${URL_HOST}/gateway-grpc/pixTransaction"
PAYLOAD='{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}'
#echo $URL_POST
#echo $PAYLOAD

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data "$PAYLOAD")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  	echo "HTTP:200 /gateway-grpc/pixTransaction"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /gateway-grpc/pixTransaction\e[0m"
fi
#---------------------------------------
RANDOM_PRICE=$((RANDOM % 300 + 120))
TOKEN_PAN=16b2541dd83c005fa377f673d2865c11fd96dc4c01c9db9b321f197da5139b1d

URL_POST="${URL_HOST}/gateway-grpc/paymentToken"
PAYLOAD='{"token_data": "'$TOKEN_PAN'","card_type": "CREDIT","terminal":"TERM-1","mcc":"GAS","currency":"BRL","amount": '$RANDOM_PRICE'}'
#echo $URL_POST
#echo $PAYLOAD

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data "$PAYLOAD")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  	echo "HTTP:200 /gateway-grpc/paymentToken"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /gateway-grpc/paymentToken\e[0m"
fi

#!/bin/bash

# variabels
#export AUTH_TOKEN=

export URL_POST=https://go-global-apex.architecture.caradhras.io/gateway-grpc/payment

RANDOM_PAN=$((RANDOM % 900 + 100))
RANDOM_PRICE=$((RANDOM % 130 + 20))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

#echo '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}'

# POST request
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_PAN=$((RANDOM % 900 + 100))
RANDOM_PRICE=$((RANDOM % 130 + 20))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-2","mcc": "GAS","currency": "BRL","amount": '$RANDOM_PRICE'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_PAN=$((RANDOM % 900 + 100))
RANDOM_PRICE=$((RANDOM % 130 + 20))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-3","mcc": "BOOK_STORE","currency": "BRL","amount": '$RANDOM_PRICE'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_PAN=$((RANDOM % 900 + 100))
RANDOM_PRICE=$((RANDOM % 130 + 20))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-4","mcc": "GAS","currency": "BRL","amount": '$RANDOM_PRICE'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_PAN=$((RANDOM % 900 + 100))
RANDOM_PRICE=$((RANDOM % 130 + 20))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-5","mcc": "COMPUTE","currency": "BRL","amount": '$RANDOM_PRICE'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

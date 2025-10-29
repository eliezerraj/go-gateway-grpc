#!/bin/bash

# variabels
#AUTH_TOKEN=

URL_POST=https://go-global-apex.architecture.caradhras.io/gateway-grpc/paymentToken

RANDOM_PRICE=$((RANDOM % 130 + 20))

FINAL_PAN=644f7143d2d49de4f202d686a6be4e5b51486a62bab6edf5d4ff12c1a067ba1c

#echo '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}'

# POST request
STATUS_CODE=$(curl -i -s -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"token_data": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi
#!/bin/bash

# variabels
#AUTH_TOKEN=
URL_POST_PIX=https://go-global-apex.architecture.caradhras.io/gateway-grpc/pixTransaction

RANDOM_FROM=$((RANDOM % 999 + 1))
RANDOM_TO=$((RANDOM % 999 + 1))
RANDOM_PRICE=$((RANDOM % 300 + 100))

#echo '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}'

# POST request
STATUS_CODE=$(curl -i -s -X POST "$URL_POST_PIX" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST_PIX" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST_PIX" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST_PIX" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -i -s -X POST "$URL_POST_PIX" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from":{"account_id":"ACC-'$RANDOM_FROM'"},"account_to":{"account_id":"ACC-'$RANDOM_TO'"},"currency":"BRL","amount":'$RANDOM_PRICE'}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi
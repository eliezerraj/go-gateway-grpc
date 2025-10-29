#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_HOST=https://go-global.architecture.caradhras.io/ledger/movimentTransaction

RANDOM_ACC=$((RANDOM % 999 + 1))
RANDOM_AMOUNT=$((RANDOM % 100 + 10))

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_HOST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from": {"account_id":"ACC-'$RANDOM_ACC'"},"type":"DEPOSIT","currency":"BRL", "amount": '$RANDOM_AMOUNT'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_ACC=$((RANDOM % 999 + 1))
RANDOM_AMOUNT=$((RANDOM % 100 + 10))

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_HOST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from": {"account_id":"ACC-'$RANDOM_ACC'"},"type":"DEPOSIT","currency":"BRL", "amount": '$RANDOM_AMOUNT'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_ACC=$((RANDOM % 999 + 1))
RANDOM_AMOUNT=$((RANDOM % 100 + 10))

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_HOST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from": {"account_id":"ACC-'$RANDOM_ACC'"},"type":"DEPOSIT","currency":"BRL", "amount": '$RANDOM_AMOUNT'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_ACC=$((RANDOM % 999 + 1))
RANDOM_AMOUNT=$((RANDOM % 100 + 10))

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_HOST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from": {"account_id":"ACC-'$RANDOM_ACC'"},"type":"DEPOSIT","currency":"BRL", "amount": '$RANDOM_AMOUNT'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_ACC=$((RANDOM % 999 + 1))
RANDOM_AMOUNT=$((RANDOM % 100 + 10))

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_HOST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"account_from": {"account_id":"ACC-'$RANDOM_ACC'"},"type":"DEPOSIT","currency":"BRL", "amount": '$RANDOM_AMOUNT'}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

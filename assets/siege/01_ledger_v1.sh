#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_HOST=https://go-global-apex.architecture.caradhras.io/ledger

#-----------------------------------------------------
URL_GET="${URL_HOST}/info"

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /info"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /info\e[0m"
fi
# ---------------------------------------------------
RANDOM_ACC=$((RANDOM % 999 + 1))
URL_GET="${URL_HOST}/movimentStatement/ACC-${RANDOM_ACC}"
#echo $URL_GET

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  	echo "HTTP:200 /movimentStatement/ACC-${RANDOM_ACC}"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /movimentStatement/ACC-${RANDOM_ACC}\e[0m"
fi
#------------------------------------------
RANDOM_ACC=$((RANDOM % 999 + 1))
URL_GET="${URL_HOST}/movimentStatementPerDate?account-id=ACC-${RANDOM_ACC}&date_start=2025-04-07"
#echo $URL_GET

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  	echo "HTTP:200 /movimentStatementPerDate?account-id=ACC-${RANDOM_ACC}"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /movimentStatementPerDate?account-id=ACC-${RANDOM_ACC}\e[0m"
fi
#-------------------------------------------------
RANDOM_ACC=$((RANDOM % 999 + 1))
RANDOM_AMOUNT=$((RANDOM % 100 + 10))

URL_POST="${URL_HOST}/movimentTransaction"
PAYLOAD='{"account_from": {"account_id":"ACC-'$RANDOM_ACC'"},"type":"DEPOSIT","currency":"BRL", "amount": '$RANDOM_AMOUNT'}'
#echo $URL_POST
#echo $PAYLOAD

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data "$PAYLOAD")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  	echo "HTTP:200 /movimentTransaction"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /movimentTransaction\e[0m"
fi

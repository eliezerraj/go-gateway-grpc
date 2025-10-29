#!/bin/bash

# variabels
#export AUTH_TOKEN=

export URL_HOST=https://go-global-apex.architecture.caradhras.io/payment-gateway/payment

RANDOM_PAN=$((RANDOM % 900 + 100))
PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"
URL_GET="${URL_HOST}?card=${FINAL_PAN}&after=2025-09-21"

# GET request
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_PAN=$((RANDOM % 900 + 100))
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"
URL_GET="${URL_HOST}?card=${FINAL_PAN}&after=2025-09-21"

# GET request
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

RANDOM_PAN=$((RANDOM % 900 + 100))
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"
URL_GET="${URL_HOST}?card=${FINAL_PAN}&after=2025-09-21"

# GET request
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi
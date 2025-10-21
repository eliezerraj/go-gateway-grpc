#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_HOST=https://go-global-apex.architecture.caradhras.io/ledger/movimentStatementPerDate
export URL_HOST_2=https://go-global.architecture.caradhras.io/ledger/movimentTransaction

RANDOM_ACC=$((RANDOM % 999 + 1))
RANDOM_AMOUNT=$((RANDOM % 100 + 10))

# GET request
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_HOST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_HOST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_HOST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_HOST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_HOST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_POST=https://go-global-apex.architecture.caradhras.io/ledger/movimentStatementPerDate
export URL_POST2=https://go-global-apex.architecture.caradhras.io/ledger/movimentStatement

RANDOM_ACC=$((RANDOM % 999 + 1))

#echo "'$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07"

# POST request
STATUS_CODE=$(curl -s -i -X GET ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN" | grep "^HTTP\/"\
          )

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X GET ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN" | grep "^HTTP\/"\
          )

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X GET ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN" | grep "^HTTP\/"\
          )

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X GET ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN" | grep "^HTTP\/"\
          )

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X GET ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN" | grep "^HTTP\/"\
          )

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi
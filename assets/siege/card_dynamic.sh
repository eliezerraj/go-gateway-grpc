#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_POST=https://go-global-apex.architecture.caradhras.io/card/cardToken

RANDOM_PAN=$((RANDOM % 900 + 100))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

#echo '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}'

# POST request
STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====> $STATUS_CODE  "
fi

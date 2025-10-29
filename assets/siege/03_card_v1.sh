#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_HOST=https://go-global-apex.architecture.caradhras.io

#-----------------------------------------------------
URL_GET="${URL_HOST}/card/info"

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /info"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /info\e[0m"
fi

# ---------------------------------------------------
RANDOM_PAN=$((RANDOM % 900 + 100))
PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
CARD_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

URL_GET="${URL_HOST}/card/card/${CARD_PAN}"
#echo $URL_GET

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /card/card/${CARD_PAN}"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /card/card/${CARD_PAN}\e[0m"
fi
#------------------------------------------
RANDOM_PAN=$((RANDOM % 900 + 100))
PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
CARD_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

URL_POST="${URL_HOST}/card/cardToken"
PAYLOAD='{"card_number":"'$CARD_PAN'","card_type":"CREDIT"}'
#echo $URL_POST
#echo $PAYLOAD

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data "$PAYLOAD")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /card/cardToken"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /card/cardToken\e[0m"
fi

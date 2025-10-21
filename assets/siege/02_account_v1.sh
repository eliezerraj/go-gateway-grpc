#!/bin/bash

# variabels
#export AUTH_TOKEN=
export URL_HOST=https://go-global-apex.architecture.caradhras.io

#-----------------------------------------------------
URL_GET="${URL_HOST}/account/info"

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
URL_GET="${URL_HOST}/account/get/ACC-${RANDOM_ACC}"
#echo $URL_GET

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /account/get/ACC-${RANDOM_ACC}"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /account/get/ACC-${RANDOM_ACC}\e[0m"
fi
#------------------------------------------
RANDOM_PERSON=$((RANDOM % 999 + 1))
URL_GET="${URL_HOST}/account/list/P-${RANDOM_PERSON}"
#echo $URL_GET

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_GET" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN ")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /account/list/P-${RANDOM_PERSON}"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /account/list/P-${RANDOM_PERSON}\e[0m"
fi
#-------------------------------------------------
RANDOM_TENANT=$((RANDOM % 999 + 1))

URL_POST="${URL_HOST}/account/update/ACC-${RANDOM_ACC}"
PAYLOAD='{"tenant_id": "TENANT-SIEGE-'$RANDOM_TENANT'"}'
#echo $URL_POST
#echo $PAYLOAD

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data "$PAYLOAD")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
	echo "HTTP:200 /account/update/ACC-${RANDOM_ACC}"
else
	echo -e "\e[31m** ERROR $STATUS_CODE ==> /account/update/ACC-${RANDOM_ACC}\e[0m"
fi

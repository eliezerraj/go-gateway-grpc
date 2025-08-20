#!/bin/bash

# variabels
#export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6IjkyNWFjMDk2LTc3Y2UtNDYyZC1hMDFiLWZkYjQ5NzZjZGVlNSIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDY0NTA1MTN9.U2mF4BGg_B87182DTnibBS8GBcmUd-Os0uvJ6JA-R9unIHOkq4sT_er14w9AP1mGo541yg5viFQAPqPdQCSUUHwI5d_mmry6xRqG2bSMDpeEDx8ylFQR7wsSofZNjb5IHaoMty1Rii88fpdFMOZEGtPPNvQiy_E51h_4RfFkH0vQa_oVo9VxIuMYaYfAGUuKnTJdjIe0bvJRaCcTQf8ZkTYezHa7RJr2Vq6fJZytY74CMFJhG02Ru_4tXL88M8S54di84dzls57HGJXEjidu1o0GXezdo81vz8z7XR7OZfwAk02GDYwuC0WLmWerNkdTUKRh8wugUTTbD9-IEnWkIcBzirrLBlu3zSf5ssOlcMOaSFn0WAunCZSUHP45qCmwn0kmniCJF7aBfjzpI5edrPxV_YN1pVBz6DkhW5mD2SS5h8sgpS_f24ayMK-gkT5apQa_8KaQyodZqyMDnBljrX2_mDoRp4zgIqkrfjebnsqyuT6mN_k6xRdsfEOMzQY7d3FVLkCDg2XGGoKf8ZpQ_A8OSE-0zXHho2K0PcNdgkWDEg4ylU10RZNSRHXGMuSNcklBXRsg_CoH8jpcdBxBAvSvljQU5oBrU8NkWscNZBOEQBnl3XnnmbC-QcW6NVnmsEsge2EWAVKw_if4mBeTXET3PTjuZ0yLVB0Xs36FKOY
export URL_POST=https://go-global-apex.architecture.caradhras.io/ledger/movimentStatementPerDate
export URL_POST2=https://go-global-apex.architecture.caradhras.io/ledger/movimentStatement

RANDOM_ACC=$((RANDOM % 999 + 1))

#echo "'$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07"

# POST request
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" ''$URL_POST'?account-id=ACC-'$RANDOM_ACC'&date_start=2025-04-07' \
          --header "Content-Type: application/json" \
          --header "Authorization: $AUTH_TOKEN")

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

#!/bin/bash

# variabels
#export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6IjMxZTJkNDFmLTkwZmUtNGVjMy1hNzk4LWQxM2E2MmJmOTcxNCIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDY0NDUxOTB9.jDizRiRDA9fralRMaNLP7Cik4An_zLAr0w7FPweRPkLtbrZ9QzmrjTuWOVylP55X66tGAS8wXjln3vieg3iTRk-CHB0Xwez7MJZghsXjhbZHDX2oZty99FtbnnGKlEwfgY0_zPEB1XKM63iNoU_y_TQ8vBS_WA5H4OXHEjEDIYqlorQ-ZifpfLTCYfPmi6pE1_z-7qoFbaKbMnL_2cIGQI3efSRGMr73qqmwdt2JxLuHn4eTJHqd5f0QWymf3kWaQ-uhHD_Vif7d0L1pa_wvPzRgOp-budYpGRCbR6kKyHamK6RErr0qjB1yx3QTd7NeBq8DMg5PUIiTI6j47k9jF3q6eGjcMdL_VPk6fWBOq4IcCHAxBBegNNvO6fGlwb27qe_iFUABO8cq_m4jpoy4SaM6yYoUGpuTcbX6AJd7k-68PJfwqDo73XdMnqMd3gO3OGYVo7vEpUuvIkAOiEWesg2aWJEr7sN0IdQcMozyr_Lbgv1BrN-FGn5zGlQSdOeha5DPg5bhC4JBnj4bRLjoPWtwpBLJyZs7PIHxozsocCXCq91FSBmRYsoX0hNvzCZ0WpWxaa2dOzjMT7Vw5bdjUWb2NRp8d22_WIzpt2SZIjykQWcFzpGvY0AiwykFzYGp34Z4c8k4afDIKDApGF0y0X1LfxtwfdvORqrGL5p3DpQ
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
  echo "  ERROR =====================> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====================> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====================> $STATUS_CODE  "
fi

STATUS_CODE=$(curl -s -i -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}' | grep "^HTTP\/")

if echo "$STATUS_CODE" | grep -q "200"; then
  echo "$STATUS_CODE"
else
  echo "  ERROR =====================> $STATUS_CODE  "
fi

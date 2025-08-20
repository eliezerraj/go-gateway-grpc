#!/bin/bash

# variabels
#export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMi4wIiwiand0X2lkIjoiOWI2NTM4NmYtZDRkMS00ZjVmLThmMzMtMjcxZjVkMzkzMmZiIiwidXNlcm5hbWUiOiJ1c2VyLTAxIiwidGllciI6InRpZXIxIiwic2NvcGUiOlsidGVzdC5yZWFkIiwidGVzdC53cml0ZSIsImFkbWluIl0sImV4cCI6MTc1NTg5NzM4NX0.ZWW3tDpYNwdmrhtsknrVeuVfTp9qd-LUY48qR_-2PVjQ-C9mbUWfyY0YSwF8LZli9J1vL1UsZhbEGfATv7Q091bzBOI1iU0aSX4TYmevK6jN50CPQiLbYOzX76r4E3K_ZxeR88v5QEq1iees0QmixbVN1D-LYQ8LXrBGF49MDoDvCPiS28TvWPuE3S5wnHXin2q70wqhjQUB7y-pW6nj8sYH5ev3T0rPxZoqa0vrfJ5WGOhhet-u_z5jtjkPdm9YD9Bg4BUrJuJ_doR7YQKl8OboSphpzEMS0iF7IY2Lj76rYQ8PzYU4UVUR1jk2KMe7JaSzfoeJhycjXTPiGhamvfd-iNInqHtTm4Lk_8161tKCJJPmUiwGtkorG9H1vDmQJ79f_vfmTK6et4jW8hSV7NY7vrApiGwfLhNa8SnI_wGakLrvQ93omqE4Tu3tvdhwQr_U8ZN2Wd0XsRkQ_XfRAoF1h4oqubvC9XHNiMDmGNnTKGdC-XWnhsBBQbDE09IBwsPy9pG2i_BBzEfgeIy9VDtAFRlpL5OYz2ttuKuelESU8iXUTcb_8bdZBcd_8eWhxyg9QRsr1E9A9EatH818IhunkFK2AJ5fP_-swiyQVUIR2Uq1CMwVLCR2SyrgUESexyqhRu5kCrD4-KN3OHcFhh5tyQINMEm7ifhyxYJoxIM
export URL_POST=https://go-global-apex.architecture.caradhras.io/card/cardToken

RANDOM_PAN=$((RANDOM % 900 + 100))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

#echo '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}'

# POST request
STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

STATUS_CODE=$(curl -s -w " HTTP:%{http_code}" "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT"}')

if echo "$STATUS_CODE" | grep -q "HTTP:200"; then
  echo "HTTP:200"
else
  echo "ERROR ====> $STATUS_CODE"
fi

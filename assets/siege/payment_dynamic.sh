#!/bin/bash

# variabels
export AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJpc3MiOiJnby1vYXV0aC1sYW1iZGEiLCJ2ZXJzaW9uIjoiMyIsImp3dF9pZCI6ImNhZjg5ZDE5LTg2NzAtNDFmNy04YmU2LTM2ODU3MGVlYWIyZiIsInVzZXJuYW1lIjoiYWRtaW4iLCJzY29wZSI6WyJhZG1pbiJdLCJleHAiOjE3NDU5OTcwODF9.GMVXXMEoHC-7JX_mUhnvnGCum-aYHQRa_Cf96ZTVE0ryiDr6ZAf0ljHzn6o5reZXM2istqMHboSrnxt-Zt4x8Q5gXZsB7DWB5A7a2YfHck9RIH3YO1GQ6ch5UuPmubGmqCx9DCdvriXoMgae4VSyBCUJtQvOpbPpWYphrcmtUuncttRx06HkOmmM3xLI_mEHY9eX10-Tv0FNVSTnY-2H6OlWTM4Gk9ruiqBx7JFh187yg79drDUZ62CPCjbF8JgHvVRTEMdYEt3VuPzyjLlT2lfEuOeWKquxhcFbYU9uIjj2ue4MzE7UEsdBHlfO3tioE5D7jcwyBGX5ebJlUm9MQffrg3PCQ8k9iZ7OwjJv-i7-A8vFskDJJruRP2v893lLnDaKFAeT4Ffg4HqR0T2Rr43w1NmPSmiK7MxORgo8CK86Qm9AKRrG-NiQ1WvZBAx8lVIrQERbr0fgL3elEG0FwHgcSz7g-7SLNlmNne6YsKjxla_vO5sMm3x89L81PPM3ZTDOt-i-gprUVP3NUiF1pn9r5nPZnhJJlcrDtR6C5KmBqMF8ayZwMbLZ715Fpjz7E_4QdAft7hKfzB6MQso4NDRO2EBrrKll_srmLyqAwPDV735j7FPJBUwibjXQ93mZj9ihe7IWASF1wyvMKVvz4v_XEry59YWkh6wcSn0aUz4
export URL_POST=https://go-global.architecture.caradhras.io/gateway-grpc/payment

RANDOM_PAN=$((RANDOM % 200 + 100))
RANDOM_PRICE=$((RANDOM % 130 + 20))

PAN=111111000001
PAN_TMP=$(($PAN+$RANDOM_PAN))
FINAL_PAN="${PAN_TMP:0:3}"."${PAN_TMP:3:3}"."${PAN_TMP:6:3}"."${PAN_TMP:9:3}"

echo '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}'

# POST request
curl -s -X POST "$URL_POST" \
	--header "Content-Type: application/json" \
	--header "Authorization: $AUTH_TOKEN" \
	--data '{"card_number": "'$FINAL_PAN'","card_type": "CREDIT","terminal": "TERM-1","mcc": "FOOD","currency": "BRL","amount": '$RANDOM_PRICE'}'
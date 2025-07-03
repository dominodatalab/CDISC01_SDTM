#!/bin/bash

# 1) Grab user JWT token 
TOKEN=$(curl -s "$DOMINO_API_PROXY/access-token")

# 2) Take snapshot of CDISC01_SDTMBLIND NetApp Volume
curl -X POST "https://lsdemo.domino-eval.com/remotefs/v1/snapshots" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     -d '{
       "volumeId": "7ad74260-7182-4c9e-9784-83e54eb44f94"
     }'

# 3) Take snapshot of CDISC01_SDTMUNBLIND NetApp Volume
curl -X POST "https://lsdemo.domino-eval.com/remotefs/v1/snapshots" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     -d '{
       "volumeId": "6423cdf9-3b6b-48d4-a948-cea816bdac40"
     }'

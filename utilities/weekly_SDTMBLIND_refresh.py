import os
import requests

# 1) Grab user JWT token
DOMINO_API_PROXY = os.environ.get("DOMINO_API_PROXY")

token_url = f"{DOMINO_API_PROXY}/access-token"
response = requests.get(token_url)
response.raise_for_status()
token = response.text.strip()

# 2) Take snapshot of CDISC01_SDTMBLIND NetApp Volume
snapshot_url = "https://life-sciences-demo.domino-eval.com/remotefs/v1/snapshots"
headers = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {token}"
}
payload = {
    "volumeId": "7ad74260-7182-4c9e-9784-83e54eb44f94"
}

response = requests.post(snapshot_url, headers=headers, json=payload)
response.raise_for_status()

print("Snapshot created successfully!")
print("Response:", response.json())
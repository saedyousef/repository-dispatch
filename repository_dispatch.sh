#!/bin/bash

TOKEN="$1"
OWNER="$2"
REPO="$3"
EVENT_TYPE="$4"
PAYLOAD="$5"

echo "📡 Dispatching event '$EVENT_TYPE' to $OWNER/$REPO..."

response=$(curl -s -X POST "https://api.github.com/repos/${OWNER}/${REPO}/dispatches" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  -d "{\"event_type\": \"${EVENT_TYPE}\", \"client_payload\": ${PAYLOAD} }")

if [ -z "$response" ]; then
  echo "✅ Dispatch triggered successfully."
else
  echo "❌ Failed to trigger dispatch:"
  echo "$response"
  exit 1
fi

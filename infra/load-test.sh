#!/usr/bin/bash

for i in {1..1000}; do
  curl --location "localhost:8080/posts" \
  --header "Content-Type: application/json" \
  --data "{
      \"title\": \"Teste ${i} - $(date)\",
      \"text\": \"Teste ${i} - $(date)\"
  }"
done

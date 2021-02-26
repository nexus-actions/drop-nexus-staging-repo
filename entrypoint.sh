#!/bin/sh -l
# inspired by https://gist.github.com/romainbsl/c60987c4852f9e56e3b0ebc51ee2b7c9

response=$(curl -s --request POST -u "$INPUT_USERNAME:$INPUT_PASSWORD" \
  --url ${INPUT_BASE_URL}staging/bulk/drop \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{ "data" : {"stagedRepositoryIds":["'"$INPUT_STAGED_REPOSITORY_ID"'"], "description":"Drop '"$INPUT_STAGED_REPOSITORY_ID"'." } }')

if [ ! -z "$response" ]; then
    echo "Error while dropping staged repository $INPUT_STAGED_REPOSITORY_ID : $response."
    exit 1
fi
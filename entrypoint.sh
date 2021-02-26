#!/bin/sh -l
# inspired by https://gist.github.com/romainbsl/c60987c4852f9e56e3b0ebc51ee2b7c9

username=$INPUT_USERNAME
password=$INPUT_PASSWORD
stagedRepositoryId=$INPUT_STAGED_REPOSITORY_ID

if test -z "$username" || test -z "$password" || test -z "$stagedRepositoryId"
then
      echo "Missing parameter(s) for sonatype 'username' | 'password' | 'stagedRepositoryId'."
      exit 1
fi

if [ -z $INPUT_BASE_URL ]
then
  INPUT_BASE_URL="https://oss.sonatype.org/service/local/"
fi

response=$(curl -s --request POST -u "$username:$password" \
  --url ${INPUT_BASE_URL}staging/bulk/drop \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{ "data" : {"stagedRepositoryIds":["'"$stagedRepositoryId"'"], "description":"Drop '"$stagedRepositoryId"'." } }')

if [ ! -z "$response" ]; then
    echo "Error while dropping staged repository $stagedRepositoryId : $response."
    exit 1
fi
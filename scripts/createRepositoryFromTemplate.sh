#!/bin/bash
ORG="$1"
REPO="$2"
API_SPEC_FILE=api-spec-file-name
TMPL_REPO=antonior0409/openapi-template

set -e

mkdir "$REPO"
gh repo clone "${TMPL_REPO}" "${REPO}" -- --depth 1
git config --global user.email "no-reply@github.com"
git config --global user.name "GitHub Actions"
cd "$REPO" 
rm -rf .git
git init -b main
echo $ORG > $API_SPEC_FILE.txt
git add .
git commit -am "Initial commit"
gh repo create ${VISIBILITY} "${ORG}/${REPO}" --source=. --remote=origin --push

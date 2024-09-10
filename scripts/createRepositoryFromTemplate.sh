#!/bin/bash
VISIBILITY="$1"
ORG="$2"
REPO="$3"
API_SPEC_FILE="$4"
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
gh repo create ${VISIBILITY} "antonior0409/${REPO}" --source=. --remote=origin --push

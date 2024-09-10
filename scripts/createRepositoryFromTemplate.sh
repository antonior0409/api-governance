#!/bin/bash

SCRIPT=$(basename "$0")

function usage
{
    >&2 echo "Usage: $SCRIPT [--private|--internal|--public] organization repository api-spec-file-name"
    exit 2
}

case $# in
    2)
        if [[ $1 == -* ]]; then
            usage
        fi
        VISIBILITY="--internal" # default
        ;;
    3)
        if [[ $1 == "--private" || $1 == "--internal" || $1 == "--public" ]]; then
            VISIBILITY="$1"
            shift
        else
            usage
        fi
        ;;
    *)
        usage
esac

ORG="$1"
REPO="$2"
API_SPEC_FILE=api-spec-file-name
TMPL_REPO=antonior0409/openapi-template

set -e

mkdir "$REPO"
gh repo clone "${TMPL_REPO}" "${REPO}" -- --depth 1
cd "$REPO" 
rm -rf .git
git init -b main
echo $ORG > $API_SPEC_FILE.txt
git add .
git commit -am "Initial commit"
gh repo create ${VISIBILITY} "${ORG}/${REPO}" --source=. --remote=origin --push

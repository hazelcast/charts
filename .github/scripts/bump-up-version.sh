#!/bin/bash

# $ ./bump-up-version.sh 4.1.1 app
# 4.2-SNAPSHOT
# $ ./bump-up-version.sh 3.5.2 chart
# 3.5.3-latest-snapshot

version=$1
type=$2

IFS=. read -r major minor patch <<<"$version"

if [ $type = app ]; then
    ((minor++))
    printf -v version '%d.%d-SNAPSHOT' "$major" "$((minor))"
elif [ $type = chart ]; then
    ((patch++))
    printf -v version '%d.%d.%d-latest-snapshot' "$major" "$minor" "$((patch))"
fi

echo $version
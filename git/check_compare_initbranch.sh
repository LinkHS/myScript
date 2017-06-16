#!/bin/bash
ls > __check.txt

destDir=$(dirname $(readlink -f "$0"))"/CheckBeforeCheckIn_$(date +%Y-%m-%d_%H-%M-%S)"
origin="$(git rev-parse --abbrev-ref HEAD)"
echo "current branch is $origin"

mkdir $destDir $destDir/new $destDir/old

git branch new
git branch old

git checkout new
git add .
git commit -m "[G42-0000]: check before checkin"
#git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT new old | xargs tar -rf old.tar
git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT old new | xargs -I {} cp {} --parents $destDir/new

git checkout old
#git diff --name-only old new | xargs tar -rf new.tar
git diff --name-only old new | xargs -I {} cp {} --parents $destDir/old

git checkout new
git reset HEAD~

git checkout $origin
git branch -d old
git branch -d new

rm $destDir/new/__check.txt
rm __check.txt

#newName=$destDir"_$(date +%Y-%m-%d_%H-%M-%S)"
#mv $destDir $newName
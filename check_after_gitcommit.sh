#!/bin/bash
ls > __rubbish__.txt

##################################### Create dest folders #####################################
destDir=$(dirname $(readlink -f "$0"))"/CheckIn_$(date +%Y-%m-%d_%H-%M-%S)"
origin="$(git rev-parse --abbrev-ref HEAD)"
echo "current branch is $new"
mkdir $destDir $destDir/new $destDir/old

##################################### Create temp branches #####################################
git branch new
git branch old

git checkout new
git add .
git commit -m "[G42-0000]: rubbish, will be delete later"

##################################### Copy diff files from initial branch #####################################
git checkout old
git reset HEAD~ --hard
#git diff --name-only old new | xargs tar -rf new.tar
git diff --name-only old $origin | xargs -I {} cp {} --parents $destDir/old

##################################### Copy diff files from local branch #####################################
git checkout new
#git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT new old | xargs tar -rf old.tar
git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT old $origin | xargs -I {} cp {} --parents $destDir/new

##################################### Recover local branch #####################################
git reset HEAD~

git checkout $origin
git branch -d old
git branch -d new

rm __rubbish__.txt

#newName=$destDir"_$(date +%Y-%m-%d_%H-%M-%S)"
#mv $destDir $newName
#!/bin/bash
ls > __rubbish__.txt

# !!!!!!!!!!! Please modify J6000275 to your work number !!!!!!!!!!!#
MY_NUMBER=J6000275
MY_GIT_ADDR=ssh://$MY_NUMBER@10.71.254.26:29418/MTK/platform/vendor/mediatek
MY_BRANCH=dev/MT6753/MT6753_ALPS.L1.MP3.V2_C2K_MTK

echo "Is J6000275 your work number?"

##################################### Get master branch name #####################################
destDir=$(dirname $(readlink -f "$0"))"/CheckCompareServer_$(date +%Y-%m-%d_%H-%M-%S)"
origin="$(git rev-parse --abbrev-ref HEAD)"
echo "current branch is $origin"

##################################### Create dest folders #####################################
mkdir $destDir $destDir/server $destDir/current

##################################### Create temp branches #####################################
git branch server
git branch current

##################################### Synchronize with server #####################################
git checkout server
git pull $MY_GIT_ADDR $MY_BRANCH

##################################### Copy diff files from server branch #####################################
git checkout current
git add .
git commit -m "[G42-0000]: rubbish, will be delete later"
git diff --name-only current server | xargs -I {} cp {} --parents $destDir/current

##################################### Copy diff files from local branch #####################################
git checkout server
git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT current server | xargs -I {} cp {} --parents $destDir/server

##################################### Recover local branch #####################################
git checkout current
git reset HEAD~

git checkout $origin
git branch -d current
git branch -D server

rm $destDir/current/__rubbish__.txt
rm __rubbish__.txt

#newName=$destDir"_$(date +%Y-%m-%d_%H-%M-%S)"
#mv $destDir $newName
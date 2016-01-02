#!/bin/bash


account=$1
BRANCH=$2
TAGFLAG=$3
CLEANFLAG=1

VERSION="V1.0"
CHIPSET="MTK6752"
ANDROID_VERSION="JB4.2"
FOLDER="LINUX"

IP=10.71.254.26
PORT=29418
Server_IP=${IP}:${PORT}
Project_path=MTK/manifest.git

function fn_help () { 
    echo "********************************************************"
    echo "usage: $0 <account> <branch> [option].... [tag] [clean=1]"
    echo "version         : $VERSION"
    echo "chipset         : $CHIPSET"
    echo "android version : $ANDROID_VERSION"
    echo "********************************************************"
    exit 1
}

if [ "$1" == "help" ] || [ "$1" == "--help" ]; then
fn_help
fi

FOLD=$(echo $3 | grep folder=)
if [ "$FOLD" ]; then
   FOLDER=$(echo $FOLD | cut -d '=' -f 2)
   TAGFLAG=""
else
   FOLD=$(echo $4 | grep folder=)
   if [ "$FOLD" ]; then
      FOLDER=$(echo $FOLD | cut -d '=' -f 2)
   else
      FOLD=$(echo $5 | grep folder=)
      if [ "$FOLD" ]; then  
          FOLDER=$(echo $FOLD | cut -d '=' -f 2)
      fi
   fi
fi

function fn_check_cleanflag () { 
local var=$1
if [ "$1" == "clean=1" ]; then
CLEANFLAG=1
elif [ "$1" == "clean=0" ]; then
CLEANFLAG=0
fi
}

if [ "$3" == "clean=1" ]; then
CLEANFLAG=1
TAGFLAG=""
elif [ "$3" == "clean=0" ]; then
CLEANFLAG=0
TAGFLAG=""
fi

fn_check_cleanflag $4
fn_check_cleanflag $5
TAG=$(echo $TAGFLAG | sed 's/.xml//g')

function fn_tolower () { echo $(echo $* | tr "[:upper:]" "[:lower:]"); }
email=${account}@fih-foxconn.com
ID=$(fn_tolower $account)

if [ "$1" == "" ]; then
echo "Your ID is ?????"
fn_help
fi

if [ "$2" == "" ]; then
echo "branch is ?????"
fn_help
fi

SLASH=$(echo $BRANCH | grep /)
if [ "$SLASH" ]; then
BRANCH=$(echo $SLASH | cut -d '/' -f 1-2)
DEFAULT=$(echo $SLASH | cut -d '/' -f 3)
if [ "$TAGFLAG" == "" ]; then
TAGFLAG=$DEFAULT
TAG=$TAGFLAG
fi
fi

# images 
HOST_ROOT=./$FOLDER
MANIFEST=.repo/manifests/
BRANCH_CONF="$HOST_ROOT/branch.conf"
GIT_COMMAND=git

rm -rf ~/bin/repo
export -n http_proxy
curl http://10.71.254.26/static/repo > ~/bin/repo 
chmod 777 ~/bin/repo
export PATH=$PATH:~/bin
COMMAND="repo init -u ssh://$ID@${Server_IP}/${Project_path} -b $BRANCH --reference=/mnt/MTK_Mirror"
checkout_start=`date "+%F_%H-%M-%S"`
CHECKOUT_LOG=checkout.log
CHECKOUT_OUT_LOG="$HOST_ROOT/${GIT_COMMAND}_${checkout_start}.log"
if [ "$TAGFLAG" != "" ]; then
CHECKOUT_OUT_LOG="$HOST_ROOT/${GIT_COMMAND}_${checkout_start}_$TAG.log"
fi

function fn_run_tag() {
local FILE=$1

if [ -f "$FILE" ]; then
COMMAND="cp -f $FILE $MANIFEST"
$COMMAND 
echo 1
else
echo 0
fi
}

if [ ! -d "$HOST_ROOT" ]; then
mkdir $HOST_ROOT
fi
cd $HOST_ROOT
echo "Write log to $CHECKOUT_OUT_LOG"

ssh -p ${PORT} $ID@$IP 

(echo "******************get code update info******************") 2>&1 | tee ../$CHECKOUT_LOG  
(echo "account : $account") 2>&1 | tee -a ../$CHECKOUT_LOG  
(echo "branch  : $BRANCH") 2>&1 | tee -a ../$CHECKOUT_LOG  
(echo "tag     : $TAG") 2>&1 | tee -a ../$CHECKOUT_LOG  
(echo "chipset : $CHIPSET") 2>&1 | tee -a ../$CHECKOUT_LOG  
(echo "version : $ANDROID_VERSION") 2>&1 | tee -a ../$CHECKOUT_LOG  
(echo "folder  : $FOLDER") 2>&1 | tee -a ../$CHECKOUT_LOG  
(echo "********************************************************") 2>&1 | tee -a ../$CHECKOUT_LOG 

#start real command
(echo "Start at $checkout_start") 2>&1 | tee -a ../$CHECKOUT_LOG

FIRST=1
if [ -d "$MANIFEST" ]; then
FIRST=0
fi

if [ -d "$MANIFEST" ] && [ "$TAGFLAG" != "" ]; then
RESULT=$(fn_run_tag ../$TAG.xml)
if [ $RESULT -eq 0 ]; then
RESULT=$(fn_run_tag $TAG.xml)
fi
COMMAND_FINAL="$COMMAND -m $TAG.xml"
else
RESULT=0
if [ "$DEFAULT" == "" ]; then
echo "Can not find xml" | tee -a ../$CHECKOUT_LOG
fn_help
fi
COMMAND_FINAL="$COMMAND -m $DEFAULT.xml"
fi
echo "Start init" | tee -a ../$CHECKOUT_LOG
echo y | $COMMAND_FINAL $REFERENCE  | tee -a ../$CHECKOUT_LOG

if [ $RESULT -eq 0 ] && [ "$TAGFLAG" != "" ]; then
RESULT=$(fn_run_tag ../$TAG.xml)
if [ $RESULT -eq 0 ]; then
RESULT=$(fn_run_tag $TAG.xml)
fi
if [ $RESULT -eq 1 ]; then
COMMAND_FINAL="$COMMAND -m $TAG.xml"
echo y | $COMMAND_FINAL $REFERENCE  | tee -a ../$CHECKOUT_LOG
fi
fi
if [ -d "$MANIFEST" ] && [ "$TAGFLAG" != "" ] && [ ! -f "$MANIFEST/$TAG.xml" ]; then
echo "Can not find $MANIFEST$TAG.xml" | tee -a ../$CHECKOUT_LOG
fn_help
fi
if [ $FIRST -eq 0 ] && [ $CLEANFLAG -eq 1 ]; then
echo "Start abandon master" | tee -a ../$CHECKOUT_LOG
repo abandon master 2>&1 | tee -a ../$CHECKOUT_LOG
echo "Start reset master" | tee -a ../$CHECKOUT_LOG
repo forall -c 'git reset HEAD --hard' 2>&1 | tee -a ../$CHECKOUT_LOG
fi
echo "Start sync" 2>&1 | tee -a ../$CHECKOUT_LOG
repo sync 2>&1 | tee -a ../$CHECKOUT_LOG
repo manifest -ro version_V.xml

echo "Start set account, email" 2>&1 | tee -a ../$CHECKOUT_LOG
repo forall -c git config user.name ${account}
repo forall -c git config user.email ${email}
echo "Start create master" 2>&1 | tee -a ../$CHECKOUT_LOG
repo start master --all

checkout_end=`date "+%F_%H-%M-%S"`
(echo "End at $checkout_end") 2>&1 | tee -a ../$CHECKOUT_LOG

cd ..
echo $BRANCH > $BRANCH_CONF
mv $CHECKOUT_LOG $CHECKOUT_OUT_LOG

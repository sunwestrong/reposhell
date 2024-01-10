#!/bin/bash
#TODO : make sure you are working at a repo root folder(sunweixin20231127)

if [ -e ~/repo_tool ]
then
    repotool=~/repo_tool/repo/repo
else
    if [ -e ~/.repo_tool ]
    then
        repotool=~/.repo_tool/repo/repo
    else
        repotool=repo
    fi 
fi


logtime=`date +'%Y%m%d_%H.%M.%S'`

pushd $(dirname $0)
    CUR_DIR=`pwd -P`
popd
DATA_FILE=$CUR_DIR/repolist.txt
STATUS_FILE=$CUR_DIR/gitstatus.txt

#${repotool}/./repo  list >${DATA_FILE}
if [ "$1" == "c" ]; then
    ${repotool}  list >${DATA_FILE}
fi

if [ ! -f  ${DATA_FILE} ]; then
    ${repotool}  list >${DATA_FILE}
fi

echo $logtime >$STATUS_FILE 
while read myline || [[ -n ${myline} ]]; 
do 
    PrjDir=${PWD}/$(echo ${myline%%:*})
	#PrjDir=$(echo ${myline%%:*})
    echo $PrjDir 
    pushd $PrjDir 
	echo "[$PrjDir ]">>$STATUS_FILE 
    git status . >>$STATUS_FILE 
    popd	
	#${repotool} sync $PrjDir 

done < ${DATA_FILE}

cat $STATUS_FILE 
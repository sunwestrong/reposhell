#!/bin/bash
basepath=$(dirname $0)
timestamp=$1

IFS=$'\n'

function repo_release_list()
{
    if [ "$timestamp" == "" ]
    then
        echo -e "\033[1;31mError: a timestamp is necessary!!\033[0m"
        exit
    fi
    
    if [ -e ~/repo_tool ]
    then
        repo=~/repo_tool/repo/repo
    else
        repo=~/.repo_tool/repo/repo
    fi

    repopath=$($repo list -fp|tail -1|sed 's/$/&\/\//'|sed s/$($repo list -p|tail -1|sed 's/$/&\/\//'|sed 's/\//\\&/g')//)
    repolog=$($repo forall -cp git log --pretty=format:'"%ct","%an","%ci","%s"," "," ","%H"' --after=$timestamp)

    for i in $repolog
    do
        if [ "${i:0:7}" == "project" ]
        then
            proj=${i:8}
            cd $repopath$proj
        else
            changeID=$(git log -1 $(echo ${i#*,\" \",\" \",} | sed s/\"//g) | tail -1)
            if [ "${changeID:4:10}" == "Change-Id:" ]
            then
                changeID=${changeID:15}
            else
                changeID=No\ Change\ ID
            fi
            echo "$i,\"$proj\",\"$changeID\""
        fi
    done | sort > $basepath/history_repolog.csv

    headlog=$(head -1 $basepath/history_repolog.csv)
    taillog=$(tail -1 $basepath/history_repolog.csv)
    
    echo save repo log to $basepath/history_repolog.csv
    echo -e "start : \033[1;33m${headlog%,\" \",\" \"*}\033[0m"
    echo -e "end   : \033[1;33m${taillog%,\" \",\" \"*}\033[0m"

}

repo_release_list


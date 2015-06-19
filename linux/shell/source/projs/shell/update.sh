#!/bin/bash

function update_git()
{

list_file=$1
folder_name=$2

while read line
do
    echo ====================$line
    if [ -z $line ] ; then
        continue;
    fi
    source_dir=${folder_name}/${line}.git
    if [ -d "${source_dir}" ] ; then
        cd ${source_dir}
        cd_ret=$?
        
        git fetch --all
        
        if [ ${cd_ret} -eq 0 ]; then
            cd -
        fi
    elif [ ! -z "${source_dir}" ] ; then 
        git clone --bare ssh://daiq@192.168.180.185:29418/${line} ${source_dir}
    fi
    if [ $? != 0 ] ; then
        echo "!!!!!!!!!ERROR!!!!!!!!!"
        return;
    fi
done < ${list_file}

}

update_git $1 $2

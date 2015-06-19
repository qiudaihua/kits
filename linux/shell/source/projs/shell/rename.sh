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
    rename_dir=${folder_name}/${line}
    if [ -d "${source_dir}" ] ; then
        mv ${source_dir} ${rename_dir} ;
    elif [ ! -z "${source_dir}" ] ; then 
        mv ${source_dir} ${rename_dir} ;
    fi
    if [ $? != 0 ] ; then
        echo "!!!!!!!!!ERROR!!!!!!!!!"
        return;
    fi
done < ${list_file}

}

update_git $1 $2

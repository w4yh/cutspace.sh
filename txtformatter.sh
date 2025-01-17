#!/bin/bash
# txtformatter.sh: This script cuts "space" and "zenkaku-space" and "tab",
#                  and delete blank lines and commented lines. 
# usage: ./txtformatter.sh filename
#        cat filename | ./txtformatter.sh -

TMPFILE=/tmp/cutspace.$$.$$

if [ ! -x /usr/bin/sed ];
then
  echo "/usr/bin/sed : not found"
  exit 9
fi

function funct_cut_space () {
    /usr/bin/sed -e 's/　/ /g' $1 | /usr/bin/sed -e 's/\t/ /g' | /usr/bin/sed -e 's/\ *$//g' | /usr/bin/sed -e 's/^\ *//g' | /usr/bin/grep -v ^$ | /usr/bin/grep -v ^#
}

if [ $# -ne 1 ]; 
then 
    echo "Usage: $0 $ARG1";
    exit 9
fi

if [ $1 = "-" ]; 
then 
    while read line
    do
        echo $line >> $TMPFILE
        funct_cut_space $TMPFILE
        /bin/rm -f $TMPFILE
    done
elif [ ! -r $1 ]; 
then
    echo "$1: file not exists"
    exit 9
else
    funct_cut_space $1    
fi

exit

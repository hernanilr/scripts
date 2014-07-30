#!/bin/bash

P=${0##*/}

d="/home/hernani/Documents/as3w"

for k in spree
do g="$d/spree"
   cd $g
   if [ -s "`git fetch github`" ]
   then b=`git branch|sed -n 's%\* \(.*\)%\1%p'`
        git merge github/$b
   fi
done

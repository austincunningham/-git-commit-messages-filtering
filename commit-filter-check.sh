#!/bin/bash
rm shafile.txt
currentbranch=`git branch | grep \* | cut -d ' ' -f2`
echo $currentbranch 
git log $currentbranch --pretty=format:"%H" --not master >> shafile.txt

git log --format=%B -n 1 $1
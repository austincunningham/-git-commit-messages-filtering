#!/bin/bash

# Get the current branch and apply it to a variable
currentbranch=`git branch | grep \* | cut -d ' ' -f2`
#echo $currentbranch 
# Gets the commits for the current branch and outputs to file
git log $currentbranch --pretty=format:"%H" --not master > shafile.txt

# loops through the file an gets the message
for i in `cat ./shafile.txt`;
do 
  #echo $i
  gitmessage=`git log --format=%B -n 1 "$i"`;
  # fix(commit-filter-check): add commit messages (AEROGEAR-038928990423)
  messagecheck=`echo $gitmessage | grep '[( )\-\:]'`
  if [ -z "$messagecheck"]
  then 
        echo "failed commit message check"
        return false
  else
        echo "commit message passed"
  fi  
done
rm shafile.txt

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
  echo $gitmessage
  
done
rm shafile.txt

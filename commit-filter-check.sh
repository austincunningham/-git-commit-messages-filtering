#!/bin/bash

# Get the current branch and apply it to a variable
currentbranch=`git branch | grep \* | cut -d ' ' -f2`

# Gets the commits for the current branch and outputs to file
git log $currentbranch --pretty=format:"%H" --not master > shafile.txt

# loops through the file an gets the message
for i in `cat ./shafile.txt`;
do 
  # gets the git commit message based on the sha
  gitmessage=`git log --format=%B -n 1 "$i"`

  # fix(commit-filter-check): add commit messages (AEROGEAR-038928990423)
  fix=`echo $gitmessage | grep fix`
  feat=`echo $gitmessage | grep feat`
  docs=`echo $gitmessage | grep docs`

  if [ -z "fix" ]
  then
        messagecheck=`echo $gitmessage | grep '(fix\()?(\)\: )?(AEROGEAR\-)?'`
  elif [ -z "feat" ]
  then 
        messagecheck=`echo $gitmessage | grep '(feat\()?(\)\: )?(AEROGEAR\-)?'`
  elif [ -z "docs" ]
  then 
        messagecheck=`echo $gitmessage | grep '(docs\()?(\)\: )?(AEROGEAR\-)?'`
  else
        echo "message fails first test"
  fi
  
  #(fix\()?(\)\: )?(\(AEROGEAR\-)?
  #[()\-\:9-0]
  # check to see if the messagecheck var is empty
  if [ -z "$messagecheck" ]
  then 
        #echo "$messagecheck"
        echo "$gitmessage"
        echo "failed commit message check"
        rm shafile.txt >/dev/null 2>&1
        break
  else
        echo "$messagecheck"
        echo "'$i' commit message passed"
  fi  
done
rm shafile.txt  >/dev/null 2>&1

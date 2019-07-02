#!/bin/dash

if test -d '.legit'
then
    echo "legit-init: error: .legit already exists"
    exit 1
fi

if mkdir '.legit'
then
    echo "Initialized empty legit repository in .legit"
fi

# Creating internal directories
mkdir '.legit/objects'
mkdir '.legit/refs'
touch '.legit/index'

mkdir '.legit/branch'
touch '.legit/branch/master'

# Initiate reference to HEAD as master
echo 'ref: refs/heads/master' >'.legit/HEAD'


# Store the worktree path
wd=`pwd`
echo "$wd" >'.legit/config'

exit 0

#!/bin/sh

if [ -d '.legit' ]
then
    rm -rf '.legit'
fi

echo Test fast forward merge
echo
./legit-init
echo 1 >a
./legit-add a
./legit-commit -m "Add a"
./legit-branch feature

./legit-checkout feature
echo 2 >>a
./legit-commit -a -m "Update a"
./legit-checkout master
# legit do not care about overwritting local changes
./legit-merge feature -m "Merge feature into master"
./legit-merge feature -m "Merge feature into master"
./legit-log


# clean up
rm -rf '.legit'



echo Test easy merge conflict

./legit-init
echo 1 >a
./legit-add a
./legit-commit -m "Add a"
./legit-branch feature

./legit-checkout feature
echo 2 >>a
./legit-commit -a -m "Update a"
./legit-checkout master

echo 3 >>a
./legit-add a
./legit-commit -m "Update a"
./legit-merge feature -m "Merge feature into master"


# clean up
rm -rf '.legit'

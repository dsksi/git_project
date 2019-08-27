#!/bin/dash
echo
echo Test file 7
echo Test commands: branch, checkout
echo

./legit-branch
./legit-branch a
./legit-checkout
./legit-checkout master

./legit-init
echo 1 >a
echo 2 >b
echo 3 >c
echo 44 >d
./legit-add a b c d
./legit-commit -m "Add a b c"
./legit-branch feature
./legit-status | egrep "^[abc] "
# currently all files are same in both branches
echo 1a >>a
# a: wd diff to rc

# file b 
echo 1b >>b
./legit-add b
# b: wd & index are diff to rc

# file c
rm c
# c: file deleted but not staged

echo Checkout attempt 1:
./legit-checkout feature
if test $? == 0
then
    echo Succeeds
fi

./legit-status | egrep "^[abc] "

echo 4 >d
./legit-add d
./legit-commit -m "Add d and commit b change"

./legit-status | egrep "^[abcd] "
# d : exist in currbranch commit, not in target branch commit

echo 4d >>d
# d : target branch commit diff to working directory

echo Checkout attempt 2:
./legit-checkout master

./legit-add d
echo Checkout attempt 3:
./legit-checkout master

./legit-rm --cached d
echo Checkout attempt 4:
./legit-checkout master

rm d
echo Checkout attempt 5:
./legit-checkout master

./legit-checkout feature

if test -f d
then
    echo d is back!
fi

echo
echo
# b is different to target branch

echo 2b>>b
echo Checkout attempt 6:
./legit-checkout feature
# b at index is diff to working directory

./legit-add b
echo Checkout attempt 7:
./legit-checkout feature
# b at index is diff to rc

./legit-commit -m "update b"
echo Checkout attempt 8:
./legit-checkout feature

rm a b
rm -rf .legit

echo
echo
echo Next Test Scenario
echo Test deleting unmerged branches
echo

./legit-init
echo hey >a
./legit-add a
./legit-commit -m "Add a"
./legit-branch feature1
./legit-checkout feature1

echo hi >b
./legit-add b
./legit-commit -m "Add b"

./legit-checkout master

# testing deleting branch
./legit-branch -d feature1
# Detect unmerged changes


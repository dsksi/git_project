#!/bin/dash

echo
echo Test file 8
echo Test checkout
echo

./legit-init

echo 1 >a
./legit-add a
./legit-commit -m "add a"
./legit-branch feature
./legit-checkout feature


echo 2 >a
./legit-add a
./legit-commit -m "update a"

 echo 3 >a
# directory file is different 
./legit-checkout master

./legit-rm --cached a
./legit-commit -m "delete a"
# should fail
./legit-checkout master
./legit-checkout feature
if test -f a
then
    echo a still exists
fi

rm -rf .legit
rm a

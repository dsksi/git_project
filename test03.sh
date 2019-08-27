#!/bin/dash

echo
echo Test file 4:
echo Test legit commands: init, add, commit, log, show
echo Test Situation: Repo initiated, no commits made
echo
# Ensure current directory only have legit files and this test file

if [ -d '.legit' ]
then
    rm -rf '.legit'
fi

mkdir output
mkdir expected

echo './legit-init'
./legit-init
echo "Line a1" >a
echo "Line b1" >b
echo "Line c1" >c

echo './legit-add a'
./legit-add a

echo Commit 0:
echo './legit-commit -a -m "Add a"'
./legit-commit -a -m "Add a"

echo './legit-status'
./legit-status

echo Commit 1:
echo "Line a2" >>a
echo '.legit-commit -a -m "Update a2"'
./legit-commit -a -m "Update a2"

echo Commit 2:
echo "Line a3" >>a
echo '.legit-commit -a -m "Update a3"'
./legit-commit -a -m "Update a3"

echo Commit 3:
echo "Line a4" >>a
echo '.legit-commit -a -m "Update a4"'
./legit-commit -a -m "Update a4"


echo Commit 4:
echo "Line a5" >>a
echo '.legit-commit -a -m "Update a5"'
./legit-commit -a -m "Update a5"

echo Commit 5:
echo "Line a6" >>a
echo '.legit-commit -a -m "Update a6"'
./legit-commit -a -m "Update a6"

echo Commit 6:
echo "Line b2" >>b
echo '.legit-commit -a -m "Update b2"'
echo "Expecting nothing to commit"
./legit-commit -a -m "Update b2"

echo './legit-add b'
./legit-add b
echo './legit-commit -a -m "Update b2"'
./legit-commit -a -m "Update b2"


cat >>'expected/log' <<eof
6 Update b2
5 Update a6
4 Update a5
3 Update a4
2 Update a3
1 Update a2
0 Add a
eof

./legit-log >'output/log' 
echo Difference for log output:
if ! diff 'output/log' 'expected/log'
then
    echo expected:
    cat 'expected/log'
    echo
    echo actual:
    cat 'output/log'
fi

echo "Check legit-status"
./legit-status 

# Cleanup
rm -rf .legit
rm -rf output
rm -rf expected

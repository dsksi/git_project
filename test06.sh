#!/bin/dash

echo
echo Test file 6:
echo Test legit commands: add, commit, rm
echo Test Situation: Repo initiated, commiting and removing files
echo
# Ensure current directory only have legit files and this test file

if [ -d '.legit' ]
then
    rm -rf '.legit'
fi

if [ -d 'output' ]
then
    rm -rf 'output'
fi

if [ -d 'expected' ]
then
    rm -rf 'expected'
fi

mkdir output
mkdir expected

echo './legit-init'
./legit-init
echo "1" >a
echo "2" >b

echo './legit-add a b'
mess=`./legit-add a b`
if [ ! -z "$mess" ]
then
    echo Error: should be no output for add
fi
cp a 'expected/a0'

echo './legit-commit -m "1st commit"'
mess=`./legit-commit -m "1st commit"`
if [ "$mess" != "Committed as commit 0" ]
then
    echo Error commiting: "$mess"
    exit 1
fi

echo "3" >c
echo "4" >d
echo './legit-add c d'
mess=`./legit-add c d`
if [ ! -z "$mess" ]
then
    echo Error: should be no output for add
fi
echo
echo './legit-rm --cached a c'
./legit-rm --cached a c

echo
echo './legit-commit -m "2nd commit"'
mess=`./legit-commit -m "2nd commit"`
if [ ! "$mess" = "Committed as commit 1" ]
then
    echo Incorrect output: "$mess"
fi

echo
echo check status:
./legit-status

echo
echo "Expected status:

a - untracked
b - same as repo
c - untracked
d - same as repo
Everything else should be untracked
"

echo './legit-show 0:a'
./legit-show 0:a >'output/a0'
if ! diff 'output/a0' 'expected/a0'
then
    echo expected:
    cat 'expected/a0'
    echo
    echo actual:
    cat 'output/a0'
    exit 1 
fi

echo './legit-show 1:a'
mess=`./legit-show 1:a`
if [ ! "$mess" = "legit-show: error: 'a' not found in commit 1" ]
then
    echo Fail: Incorrect error message
    echo "$mess"
fi

echo './legit-show :a'
mess=`./legit-show :a`
if [ ! "$mess" = "legit-show: error: 'a' not found in index" ]
then
    echo Fail: Incorrect error message
    echo "$mess"
fi



cat >>'expected/log' <<eof
1 2nd commit
0 1st commit
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

# Cleanup
rm -rf .legit
rm -rf output
rm -rf expected

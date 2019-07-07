#!/bin/dash

echo
echo Test file 2:
echo Test legit commands: init, add, commit, log, show
echo Test Situation: Repo initiated, no commits made
echo
# Ensure current directory only have legit files and this test file

# Case 1:
echo Test fail: existing .legit directory
if ! mkdir '.legit' >/dev/null 2>&1
then
    echo Error: Test failed!
    echo Please ensure current directory only have legit files and test files 
    exit 1
fi
mess=`./legit-init`
estat=$?
if test "$mess" = "legit-init: error: .legit already exists"
then
    echo Success: correct error message
else
    echo Fail: incorrect error message
    echo "$mess"
fi

if [ $estat -eq 1 ]
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 2:
echo
echo Test success: legit-init
rm -rf .legit
mess=`./legit-init`
estat=$?
if test "$mess" = "Initialized empty legit repository in .legit"
then
    echo Success: correct output
else
    echo Fail: incorrect output
    echo "$mess"
fi

if [ $estat -eq 0 ]
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect exit status \($estat\)
fi

# Case 3:
echo
echo Test fail: add with no argument
mess=`./legit-add`
estat=$?
if test "$mess" = "usage: legit-add <filenames>"
then
    echo Success: correct error message
else
    echo Fail: incorrect error message
    echo "$mess"
fi

if [ $estat -eq 1 ]
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 4:
echo
echo Test fail: commit with no argument
mess=`./legit-commit`
estat=$?
if test "$mess" = "usage: legit-commit [-a] -m commit-message"
then
    echo Success: correct error message
else
    echo Fail: incorrect error message
    echo "$mess"
fi

if [ $estat -eq 1 ]
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 5:
echo
echo Test fail: log with no commit
mess=`./legit-log`
estat=$?
if test "$mess" = "legit-log: error: your repository does not have any commits yet"
then
    echo Success: correct error message
else
    echo Fail: incorrect error message
    echo "$mess"
fi

if [ $estat -eq 1 ]
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 6:
echo
echo Test fail: show with no commit
mess=`./legit-show`
estat=$?
if test "$mess" = "legit-show: error: your repository does not have any commits yet"
then
    echo Success: correct error message
else
    echo Fail: incorrect error message
    echo "$mess"
fi

if [ $estat -eq 1 ]
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect error status \($estat\)
fi
# Cleanup
rm -rf .legit

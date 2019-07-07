#!/bin/dash

echo
echo Test file 1:
echo Test legit commands: init, add, commit, log, show
echo Test situation: no repo initiated
echo
# Ensure current directory only have legit files and this test file
echo Setup 1:
echo Test fail: existing .legit directory
if [ -d '.legit' ]
then
    echo Error: Test failed!
    echo Please ensure current directory have no .legit repo initiated
    exit 1
else
    echo Success: No .legit repo initiated
fi

# Case 2:
echo
echo Test fail: add with no repo
mess=`./legit-add`
estat=$?
if test "$mess" = "legit-add: error: no .legit directory containing legit repository exists"
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
echo Test fail: commit with no repo
mess=`./legit-commit`
estat=$?
if test "$mess" = "legit-commit: error: no .legit directory containing legit repository exists"
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
echo Test fail: log with no repo
mess=`./legit-log`
estat=$?
if test "$mess" = "legit-log: error: no .legit directory containing legit repository exists"
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
echo Test fail: show with no repo
mess=`./legit-show`
estat=$?
if test "$mess" = "legit-show: error: no .legit directory containing legit repository exists"
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

#!/bin/dash

# Test file 1:

# Test legit-init
# Ensure current directory only have legit files and this test file

echo Test fail: existing .legit directory
if ! mkdir '.legit' >/dev/null 2>&1
then
    echo Error: Test failed!
    echo Please ensure current directory only have legit files and test files 
    exit 1
fi
error=`sh legit-init.sh`
if test "$error" = "legit-init: error: .legit already exists"
then
    echo Success: correct error message
else
    echo Fail: incorrect error message
fi

if [ $? -eq 1 ]
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect error status \($?\)
fi

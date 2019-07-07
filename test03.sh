#!/bin/dash

echo
echo Test file 3:
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

# Make test files
echo "Line 1" >a
echo "Line 1" >b
echo "Line 1" >c
# Case 4:
echo
echo Test success: commit with one argument
mess=`./legit-add a`
estat=$?
if test -z "$mess"
then
    echo Success: no output message
else
    echo Fail: incorrect output message
    echo "$mess"
fi

if [ $estat -eq 0 ]
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 5:
echo
echo Test success: commit with one added valid argument
mess=`./legit-add a`
estat=$?
if test -z "$mess"
then
    echo Success: no output message
else
    echo Fail: incorrect output message
    echo "$mess"
fi

if [ $estat -eq 0 ]
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 6:
echo
echo Test fail: commit with one non-existent file arg
mess=`./legit-add abc`
estat=$?
if test "$mess" = "legit-add: error: can not open 'abc'"
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

# Case 7:
echo
echo Test fail: commit with one non-existent file arg, and one existing
mess=`./legit-add b abc`
estat=$?
if test "$mess" = "legit-add: error: can not open 'abc'"
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

# Case 8:
echo
echo Test fail: add with one invalid filename arg
mess=`./legit-add "h/l"`
estat=$?
if test "$mess" = "legit-add: error: invalid filename 'h/l'"
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

# Case 9:
echo
echo Test fail: add with one invalid filename arg
mess=`./legit-add "h$"`
estat=$?
if test "$mess" = "legit-add: error: invalid filename 'h$'"
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

# Case 10:
echo
echo Test fail: commit with folder name as arg
mkdir "folder" >/dev/null 2>&1
mess=`./legit-add "folder"`
estat=$?
if test "$mess" = "legit-add: error: 'folder' is not a regular file"
then
    echo Success: correct error message
else
    echo Fail: incorrect output message
    echo "$mess"
fi

if [ $estat -eq 1 ]
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 11:
echo
echo Test success: make first commit
mess=`./legit-commit -m "Add only a"`
estat=$?
if test "$mess" = "Committed as commit 0"
then
    echo Success: correct output message
else
    echo Fail: incorrect output message
    echo "$mess"
fi

if [ $estat -eq 0 ]
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect error status \($estat\)
fi

# Case 12:
mess=`./legit-status`
echo 
echo Test status update
echo "$mess"
if ! echo "$mess" | egrep "a - same as repo" >/dev/null
then
    echo Incorrect status
elif ! echo "$mess" | egrep "b - untracked" >/dev/null
then
    echo Incorrect status
elif ! echo "$mess" | egrep "c - untracked" >/dev/null
then
    echo Incorrect status
elif echo "$mess" | egrep "folder" >/dev/null
then
    echo Incorrect status: should not include folder
else
    echo Success
    echo Instruction: also check everything beside file a is untracked
fi

# Case 13:
mess=`./legit-show 0:a`
estat=$?
echo
echo Test succes: show content of a
if test "$mess" = 'Line 1'
then
    echo Success: correct content of a
else
    echo Fail: incorrect output of a
fi

if test $estat -eq 0
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect exit status \($estat\)
fi

# Case 14:
mess=`./legit-show 1:a`
estat=$?
echo
echo Test fail: show content of a with incorrect commit
if test "$mess" = "legit-show: error: unknown commit '1'"
then
    echo Success: correct error output
else
    echo Fail: incorrect error output
fi

if test "$estat" -eq 1
then
    echo Success: correct exit status 1
else
    echo Fail: incorrect exit status \($estat\)
fi

# Case 15:
mess=`./legit-show :a`
estat=$?
echo
echo Test succes: show content of a in index
if test "$mess" = 'Line 1'
then
    echo Success: correct content of a in index
else
    echo Fail: incorrect output of a
fi

if test $estat -eq 0
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect exit status \($estat\)
fi

# Case 15:
echo 'Line 2' >>a
mess=`./legit-show :a`
estat=$?
echo
echo Test succes: show content of a in index
if ! test "$mess" | egrep "Line 2" >/dev/null
then
    echo Success: correct content of a in index
else
    echo Fail: incorrect output of a
fi

if test $estat -eq 0
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect exit status \($estat\)
fi

# Case 16:
echo
echo Test success: commit -a flag
mess=`./legit-commit -a -m "Update a"`
estat=$?
if test "$mess" = "Committed as commit 1"
then
    echo Success: correct output
else
    echo Fail: incorrect output
    echo "$mess"
fi

if test $estat -eq 0
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect exit status \($estat\)
fi

# Case 17:
mess=`./legit-show 1:a`
estat=$?
echo
echo Test succes: show content of a in commit 1
if echo "$mess" | egrep 'Line 2' >/dev/null
then
    echo Success: correct content of a 
else
    echo Fail: incorrect output of a
    echo "$mess"
fi

if test $estat -eq 0
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect exit status \($estat\)
fi

# Case 18:
mess=`./legit-show 1:a`
estat=$?
echo
echo Test succes: show content of a in index
if echo "$mess" | egrep 'Line 2' >/dev/null
then
    echo Success: correct content of a 
else
    echo Fail: incorrect output of a
    echo "$mess"
fi

if test $estat -eq 0
then
    echo Success: correct exit status 0
else
    echo Fail: incorrect exit status \($estat\)
fi

# Cleanup
rm -rf .legit

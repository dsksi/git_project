#!/bin/dash

if [ ! $# -eq 2 ] && [ ! $# -eq 3 ]
then
    echo 'usage: legit-commit [-a] -m commit-message'
    exit 1
fi

a=0
m=0
if [ "$1" = '-a' ]
then
    a=1
elif [ "$1" = '-m' ] && [ "$#" -eq 2 ]
then
    m=1
else
    echo 'usage: legit-commit [-a] -m commit-message'
    exit 1
fi

if [ $# -eq 3 ]
then
    mess="$3"
    if [ "$2" = '-a' ]
    then
        echo 'usage: legit-commit [-a] -m commit-message'
        exit 1
    elif [ $m -eq 0 ] && [ "$2" = '-m' ]
    then
        m=1
    else
        echo 'usage: legit-commit [-a] -m commit-message'
        exit 1
    fi
else
    mess="$2"
fi

# Add everything from index to commit
if [ "$a" = 1 ]
then
    blobs=`cat .legit/index`    
fi

# Update legit-log
# Add number commit into log with message
num=`cat '.legit/log' | egrep -o '^[0-9]*' | head -1`
if [ ! $num ]
then
    # start at 0 commit
    num=0
    echo "$num $mess" >>'.legit/log'
else
    num=`expr $num + 1`
    sed -i "1 i\\$num $mess" '.legit/log'
fi





exit 0

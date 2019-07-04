#!/bin/dash


if [ ! -d '.legit' ]
then
    echo "legit-show: error: no .legit directory containing legit repository exists"
    exit 1
fi


if [ ! -f '.legit/log' ]
then
    echo "legit-log: error: your repository does not have any commits     yet"      
    exit 1
fi

if [ $# -ne 1 ]
then
    echo "usage: legit-show <commit>:<filename>"
    exit 1
fi

if ! echo "$1" | egrep ':' >/dev/null
then
    echo "legit-show: error: invalid object $1"
    exit 1
fi

# Get the commit number and filename to show
commit=`echo "$1" | egrep -o '^[^:]*'`
filename=`echo "$1" | egrep -o '[^:]*$'`

# If non-empty commit number
if [ ! -z "$commit" ]
then
    # Try to find commit object in commit record
    comObj=`cat '.legit/commit' | egrep "^commit$commit"`
    
    # If no matching commit object found, invalid error message
    if [ -z "$comObj" ]
    then
        echo "legit-show: error: unknown commit '$commit'"
        exit 1
    fi
    
    folder=`echo "$comObj" | cut -d' ' -f2`
    file=`echo "$comObj" | cut -d' ' -f3`
    
    # Try to find filename to show in the commit object
    fileObj=`egrep " $filename$" ".legit/objects/$folder/$file"`

    if [ -z "$fileObj" ]
    then
        echo "legit-show: error: '$filename' not found in commit $commit"
        exit 1
    fi
   
    # Try to get the blob object
    blobDir=`echo "$fileObj" | cut -d' ' -f2`
    blobName=`echo "$fileObj" | cut -d' ' -f3`
    cat ".legit/objects/$blobDir/$blobName"
else
    # If empty commit number input
    # Look for file in index
    fileObj=`egrep " $filename$" ".legit/index"`

    if [ -z "$fileObj" ]
    then
        echo "legit-show: error: '$filename' not found in index"
        exit 1
    fi
    
    # Try to get the blob object
    blobDir=`echo "$fileObj" | cut -d' ' -f2`
    blobName=`echo "$fileObj" | cut -d' ' -f3`
    cat ".legit/objects/$blobDir/$blobName"    
fi


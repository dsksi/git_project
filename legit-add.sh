#!/bin/dash

# Test if repo initiated
if [ $# -lt 1 ]
then
    echo "usage: legit-add <filenames>"
fi

if [ ! -d '.legit' ]
then
    echo "legit-add: error: no .legit directory containing legit repository exists"
    exit 1
fi

for file in $@
do
    if [ ! -e "$file" ]
    then
        echo "legit-add: error: can not open '$file'"
        exit 1
    fi

    if [ ! -f "$file" ]
    then
        echo "legit-add: error: '$file' is not a regular file"
        exit 1
    fi
done

for file in $@
do

    size=`ls -l "$file" | cut -d' ' -f4`
    content=`cat "$file"`
    # sha hash
    sha=`echo "blob$size$content" | sha1sum | egrep -o '[^ -]*'`
    # use the first two chars of shahash as directory name
    dirName=`echo "$sha" | sed 's/\(..\).*/\1/'`
    # use the rest of shahash as filename
    blobName=`echo "$sha" | sed 's/..\(.*\)/\1/'`
    
    if [ ! -d ".legit/objects/$dirName" ]
    then
        mkdir ".legit/objects/$dirName"
    fi

    if [ ! -f ".legit/objects/$dirName/$blobName" ]
    then
        echo copied $file to index
        cp "$file" ".legit/objects/$dirName/$blobName"
        echo "blob $dirName $blobName $file" >> '.legit/index'
    fi

done
exit 0

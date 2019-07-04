#!/bin/dash


touch '.legit/status'

# check for commits
if [ ! -f '.legit/commit' ]
then
    echo "legit-status: error: your repository does not have any commits yet"
fi

# Get recent HEAD commit
branch=`cat '.legit/HEAD'`
rcDir=`cat ".legit/$branch" | cut -d' ' -f1`
rcFile=`cat ".legit/$branch" | cut -d' ' -f2`

# recent commit object is at .legit/objects/$rcDir/$rcFile
rcPath="objects/$rcDir/$rcFile"

for file in *
do
    if [ ! -f "$file" ]
    then
        continue
    fi
    # Check if file's name exist in previous commit
    blobRc=`egrep " $file$" ".legit/$rcPath"`
    if [ -z "$blobRc" ]
    then
        # Check if file's name exist in index
        if ! egrep " $file$" ".legit/index" >/dev/null
        then
            # Untracked
            echo "$file - untracked" >>'.legit/status'
        else
            # Added to index
            echo "$file - added to index" >>'.legit/status'
        fi
        continue
    else
        # Compute working directory file sha hash
        size=`ls -l "$file" | cut -d' ' -f4`
        content=`cat "$file"`
        wdSha=`echo "blob$size$content" | sha1sum | egrep -o '[^ -]*'`
        rcSha=`echo "$blobRc" | cut -d' ' -f2-3 | sed 's/ //'`

        # Check if working directory hash is same as recent commit hash
        # To see if changes were made
        if echo "$wdSha" | egrep "^$rcSha$" >/dev/null
        then
            # same as repo
            echo "$file - same as repo" >>'.legit/status'
        else
            # Check if file name exist in index
            # To see if changes staged
            indexLine=`egrep " $file$" ".legit/index"`
            indSha=`echo "$indexLine" | cut -d' ' -f2-3 | sed 's/ //'`
            
            # Check if index hash is same as repo hash
            if echo "$indSha" | egrep "^$rcSha$" >/dev/null
            then
                # changes are not staged for commit
                echo "$file - file changed, changes not staged for commit" >>'.legit/status'
            else
                # there are changes staged
                # Check if working directory hash is same as index hash
                if echo "$wdSha" | egrep "^$indSha$" >/dev/null
                then
                    # same as index sha
                    echo "$file - file changed, changes staged for commit" >>'.legit/status'
                else
                    # different to index sha
                    echo "$file - file changed, different changes staged for commit" >>'.legit/status'
                fi
            fi
        fi
    fi

    # file deleted
    # file deleted, different changes staged for commit
    # deleted
done
cat '.legit/status' | sort
rm '.legit/status'

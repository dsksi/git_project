#!/bin/dash

echo
echo Test file 5:
echo Test legit commands: add, commit, rm
echo Test Situation: Repo initiated, commiting and removing files
echo
# Ensure current directory only have legit files and this test file

if [ -d '.legit' ]
then
  rm -rf '.legit'
fi

if [ ! -d 'output' ]
then
    mkdir output
fi

if [ ! -d 'expected' ]
then
    mkdir expected
fi


./legit-init
echo 1 >a
echo 2 >b
echo 3 >c
./legit-add a b c
./legit-commit -m "first commit"
./legit-status >expected/status7cm
echo 4 >>a
echo 5 >>b
echo 6 >>c
echo 7 >d
echo 8 >e
./legit-status >output/status7pre
./legit-add b c d
./legit-status >output/status7add
echo 9 >b
./legit-rm a
./legit-rm b                                                 
./legit-rm c
./legit-rm d
./legit-rm e
./legit-status >output/status7rm
./legit-rm --cached a
./legit-rm --cached b
./legit-rm --cached c
./legit-rm --cached d
./legit-rm --cached e
./legit-rm --force a
./legit-rm --force b
./legit-rm --force c
./legit-rm --force d
./legit-rm --force e
./legit-status >output/status7final
./legit-log >output/log7final

for file in output/*
do
    if echo "$file" | egrep "status" >/dev/null
    then
        egrep "^[abcde] " "$file" >output/tmp
        mv 'output/tmp' "$file"
    fi
done

for file in output/*
do
    echo Difference for: $name
    name=`basename "$file"`
    diff "expected/$name" "output/$name"
done

# Cleanup
rm -rf .legit

#!/bin/dash
echo
echo Test 08 results:
echo Testing commands: add, commit, status, rm, show
./legit-init
touch a b c d e f g h
./legit-add a b c d e f
echo
echo Status:
./legit-status | egrep "^[abcdefgh] "

./legit-commit -m "first commit"
echo
echo Status:
./legit-status | egrep "^[abcdefgh] "
echo hello >a
echo hello >b
echo hello >c

./legit-status | egrep "^[abcdefgh] "
./legit-add a b
echo
echo Status:
./legit-status | egrep "^[abcdefgh] "
rm d
echo world >a
./legit-rm e
./legit-add g
echo
echo Status:
./legit-status | egrep "^[abcdefgh] "

./legit-commit -m "second commit"
echo
echo Status:
./legit-status | egrep "^[abcdefgh] "


echo Remove a
./legit-rm a
echo Remove cached a
./legit-rm --cached a
echo Remove cached d
./legit-rm --cached d
echo Remove cached f
./legit-rm --cached f
echo Remove f
./legit-rm g

echo
echo Status:
./legit-status | egrep "^[abcdefgh] "

for arg in a b c d e f g h
do
    ./legit-show 0:$arg
done

for arg in a b c d e f g h
do
    ./legit-show 1:$arg
done

for arg in a b c d e f g h
do
    ./legit-show :$arg
done

# Cleanup
rm a c b f g h
rm -rf .legit

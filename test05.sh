# Test rm implementation

./legit-rm ji
legit-rm: error: your repository does not have any commits yet
./legit-add a
./legit-commit -m "Add a"
Committed as commit 0
./legit-rm
usage: legit-rm [--force] [--cached] <filenames>
./legit-rm b
legit-rm: error: 'b' is not in the legit repository
./legit-rm a
wagner % ls
b  c  folder  testcase1  trialname.sh
./legit-commit "delete a"
usage: legit-commit [-a] -m commit-message
./legit-commit -m  "delete a"
Committed as commit 1

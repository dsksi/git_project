# git_project
Attempt at implementing subset of gitt

## Commands Available

**legit-init**
legit-init may create initial files or directories inside .legit.
You do not have to use a particular representation to store the repository.

You do not have to create the same files or directory inside legit-init as the reference implementation.

**legit-add filenames**
The legit-add command adds the contents of one or more files to the "index".
Files are added to the repository in a two step process. The first step is adding them to the index.

You will need to store files in the index somehow in the .legit sub-directory. For example you might choose store them in a sub-directory of .legit.

Only ordinary files in the current directory can be added, and their names will always start with an alphanumeric character ([a-zA-Z0-9]) and will only contain alpha-numeric characters plus '.', '-' and '_' characters.

The legit-add command, and other legit commands, will not be given pathnames with slashes.

**legit-commit -m message**
The legit-commit command saves a copy of all files in the index to the repository.
A message describing the commit must be included as part of the commit command.

legit commits are numbered (not hashes like git). You must match the numbering scheme.

You can assume the commit message is ASCII, does not contain new-line characters and does not start with a '-' character.

**legit-log**
The legit-log command prints one line for every commit that has been made to the repository.
Each line should contain the commit number and the commit message.

**legit-show commit:filename**
The legit-show should print the contents of the specified file as of the specified commit.
If the commit is omitted the contents of the file in the index should be printed.

**legit-commit [-a] -m message**
legit-commit can have a -a option which causes all files already in the index to have their contents from the current directory added to the index before the commit.
**legit-rm [--force] [--cached] filenames**
legit-rm removes a file from the index, or from the current directory and the index.
If the --cached option is specified the file is removed only from the index and not from the current directory.

legit-rm like git rm should stop the user accidentally losing work, and should give an error message instead of if the removal would cause the user to lose work.

The --force option overrides this, and will carry out the removal even if the user will lose work.

**legit-status**
legit-status shows the status of files in the current directory, index, and repository.

**legit-branch [-d] [branch-name]**
legit-branch either creates a branch, deletes a branch or lists current branch names.

**legit-checkout branch-name**
legit-checkout switches branches.
Note unlike git you can not specify a commit or a file, you can only specify a branch.

**legit-merge branch-name|commit -m message**
legit-merge -m message adds the changes that have been made to the specified branch or commit to the index and commits them.
(Only the fast forward merge was implemented)

Title: Intro to Unix, Part 2: Navigating Files and Directories
Summary:   
Date: 9/7/2017
Tags: unix, shell, bash, file system
Category: lectures


*The notes below are modified from the excellent [Unix Shell tutorial ](http://swcarpentry.github.io/shell-novice/) that is freely available on the Software Carpentry website. I highly recommend checking out the full version for further reading. The material is being used here under the terms of the [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/).*

---

## Navigating Files and Directories

Several commands are frequently used to create, inspect, rename, and delete files and directories.
To start exploring them,
let's open a shell window:

~~~
$
~~~

The dollar sign is a **prompt**, which shows us that the shell is waiting for input;
your shell may use a different character as a prompt and may add information before
the prompt.


Next,
let's find out where we are by running a command called `pwd`
(which stands for "print working directory").
At any moment,
our **current working directory**
is our current default directory,
i.e.,
the directory that the computer assumes we want to run commands in
unless we explicitly specify something else.
Here,
the computer's response is `/Users/nelle`,
which is Nelle's **home directory**:

~~~
$ pwd
~~~


~~~
/Users/nelle
~~~


To understand what a "home directory" is,
let's have a look at how the file system as a whole is organized.  For the
sake of this example, we'll be
illustrating the filesystem on our scientist Nelle's computer.  After this
illustration, you'll be learning commands to explore your own filesystem,
which will be constructed in a similar way, but not be exactly identical.  

On Nelle's computer, the filesystem looks like this:

![The File System]({attach}/lectures/unix_git/filesystem.svg)

At the top is the **root directory**
that holds everything else.
We refer to it using a slash character `/` on its own;
this is the leading slash in `/Users/nelle`.

Inside that directory are several other directories:
`bin` (which is where some built-in programs are stored),
`data` (for miscellaneous data files),
`Users` (where users' personal directories are located),
`tmp` (for temporary files that don't need to be stored long-term),
and so on.  

Now let's learn the command that will let us see the contents of our
own filesystem.  We can see what's in our home directory by running `ls`,
which stands for "listing":

~~~
$ ls
~~~


~~~
Applications Documents    Library      Music        Public
Desktop      Downloads    Movies       Pictures
~~~

`ls` prints the names of the files and directories in the current directory in
alphabetical order,
arranged neatly into columns.
We can make its output more comprehensible by using the **flag** `-F`,
which tells `ls` to add a trailing `/` to the names of directories:

~~~
$ ls -F
~~~


~~~
Applications/ Documents/    Library/      Music/        Public/
Desktop/      Downloads/    Movies/       Pictures/
~~~


`ls` has lots of other options. To find out what they are, we can type:

~~~
$ man ls
~~~

`man` is the Unix "manual" command:
it prints a description of a command and its options,
and (if you're lucky) provides a few examples of how to use it. To navigate through the `man` pages,
you may use the up and down arrow keys to move line-by-line,
or try the "b" and spacebar keys to skip up and down by full page.
Quit the `man` pages by typing "q".

Here,
we can see that our home directory contains mostly **sub-directories**.
Any names in your output that don't have trailing slashes,
are plain old **files**.

We can also use `ls` to see the contents of a different directory.  Let's take a
look at our `Desktop` directory by running `ls -F Desktop`,
i.e.,
the command `ls` with the **arguments** `-F` and `Desktop`.
The second argument --- the one *without* a leading dash --- tells `ls` that
we want a listing of something other than our current working directory:

~~~
$ ls -F Desktop
~~~

~~~
data-shell/
~~~

Your output should be a list of all the files and sub-directories on your
Desktop, including the `data-shell` directory you downloaded at
the start of the lesson.  Take a look at your Desktop to confirm that
your output is accurate.  

The command to change locations is `cd` followed by a
directory name to change our working directory.
`cd` stands for "change directory",
which is a bit misleading:
the command doesn't change the directory,
it changes the shell's idea of what directory we are in.

Let's say we want to move to the `data` directory we saw above.  We can
use the following series of commands to get there:

~~~
$ cd Desktop
$ cd data-shell
$ cd data
~~~


These commands will move us from our home directory onto our Desktop, then into
the `data-shell` directory, then into the `data` directory.  `cd` doesn't print anything,
but if we run `pwd` after it, we can see that we are now
in `/Users/nelle/Desktop/data-shell/data`.
If we run `ls` without arguments now,
it lists the contents of `/Users/nelle/Desktop/data-shell/data`,
because that's where we now are:

~~~
$ pwd
~~~


~~~
/Users/nelle/Desktop/data-shell/data
~~~


~~~
$ ls -F
~~~


~~~
amino-acids.txt   elements/     pdb/	        salmon.txt
animals.txt       morse.txt     planets.txt     sunspot.txt
~~~


We now know how to go down the directory tree, but
how do we go up?  

There is a shortcut in the shell to move up one directory level
that looks like this:

~~~
$ cd ..
~~~


`..` is a special directory name meaning
"the directory containing this one",
or more succinctly,
the **parent** of the current directory.
Sure enough,
if we run `pwd` after running `cd ..`, we're back in `/Users/nelle/Desktop/data-shell`:

~~~
$ pwd
~~~


~~~
/Users/nelle/Desktop/data-shell
~~~


The special directory `..` doesn't usually show up when we run `ls`.  If we want
to display it, we can give `ls` the `-a` flag:

~~~
$ ls -F -a
~~~


~~~
./                  creatures/          notes.txt
../                 data/               pizza.cfg
.bash_profile       molecules/          solar.pdf
Desktop/            north-pacific-gyre/ writing/
~~~


`-a` stands for "show all";
it forces `ls` to show us file and directory names that begin with `.`,
such as `..` (which, if we're in `/Users/nelle`, refers to the `/Users` directory)
As you can see,
it also displays another special directory that's just called `.`,
which means "the current working directory".
It may seem redundant to have a name for it,
but we'll see some uses for it soon.

Note that in most command line tools, multiple parameters can be combined
with a single `-` and no spaces between the parameters: `ls -F -a` is
equivalent to `ls -Fa`.

These then, are the basic commands for navigating the filesystem on your computer:
`pwd`, `ls` and `cd`.  Let's explore some variations on those commands.  What happens
if you type `cd` on its own, without giving
a directory?  

~~~
$ cd
~~~


How can you check what happened?  `pwd` gives us the answer!  

~~~   
$ pwd
~~~


~~~
/Users/nelle
~~~

It turns out that `cd` without an argument will return you to your home directory,
which is great if you've gotten lost in your own filesystem.  

Let's try returning to the `data` directory from before.  Last time, we used
three commands, but we can actually string together the list of directories
to move to `data` in one step:

~~~
$ cd Desktop/data-shell/data
~~~


Check that we've moved to the right place by running `pwd` and `ls -F`  

If we want to move up one level from the data directory, we could use `cd ..`.  But
there is another way to move to any directory, regardless of your
current location.  

So far, when specifying directory names, or even a directory path (as above),
we have been using **relative paths**.  When you use a relative path with a command
like `ls` or `cd`, it tries to find that location  from where we are,
rather than from the root of the file system.  

However, it is possible to specify the **absolute path** to a directory by
including its entire path from the root directory, which is indicated by a
leading slash.  The leading `/` tells the computer to follow the path from
the root of the file system, so it always refers to exactly one directory,
no matter where we are when we run the command.

This allows us to move to our `data-shell` directory from anywhere on
the filesystem (including from inside `data`).  To find the absolute path
we're looking for, we can use `pwd` and then extract the piece we need
to move to `data-shell`.  

~~~
$ pwd
~~~


~~~
/Users/nelle/Desktop/data-shell/data
~~~


~~~
$ cd /Users/nelle/Desktop/data-shell
~~~


Run `pwd` and `ls -F` to ensure that we're in the directory we expect.  

### Two More Shortcuts

 The shell interprets the character `~` (tilde) at the start of a path to
 mean "the current user's home directory". For example, if Nelle's home
 directory is `/Users/nelle`, then `~/data` is equivalent to
 `/Users/nelle/data`. This only works if it is the first character in the
 path: `here/there/~/elsewhere` is *not* `here/there/Users/nelle/elsewhere`.

 Another shortcut is the `-` (dash) character.  `cd` will translate `-` into
 *the previous directory I was in*, which is faster than having to remember,
 then type, the full path.  This is a *very* efficient way of moving back
 and forth between directories. The difference between `cd ..` and `cd -` is
 that the former brings you *up*, while the latter brings you *back*. You can
 think of it as the *Last Channel* button on a TV remote.

### Tab Completion

Now in her current directory `data-shell`,
Nelle can see what files she has using the command:

~~~
$ ls north-pacific-gyre/2012-07-03/
~~~


This is a lot to type,
but she can let the shell do most of the work through what is called **tab completion**.
If she types:

~~~
$ ls nor
~~~


and then presses tab (the tab key on her keyboard),
the shell automatically completes the directory name for her:

~~~
$ ls north-pacific-gyre/
~~~


If she presses tab again,
Bash will add `2012-07-03/` to the command,
since it's the only possible completion.
Pressing tab again does nothing,
since there are 19 possibilities;
pressing tab twice brings up a list of all the files,
and so on.
This is called **tab completion**,
and we will see it in many other tools as we go on.

## Key Points:
- "The file system is responsible for managing information on the disk."
- "Information is stored in files, which are stored in directories (folders)."
- "Directories can also store other directories, which forms a directory tree."
- "`cd path` changes the current working directory."
- "`ls path` prints a listing of a specific file or directory; `ls` on its own lists the current working directory."
- `pwd` prints the user's current working directory.
- `whoami` shows the user's current identity.
- `/` on its own is the root directory of the whole file system.
- A relative path specifies a location starting from the current location.
- An absolute path specifies a location from the root of the file system.
- Directory names in a path are separated with '/' on Unix, but '\\\\' on Windows.
- '..' means 'the directory above the current one'; '.' on its own means 'the current directory'.
- Most files' names are `something.extension`. The extension isn't required, and doesn't guarantee anything, but is normally used to indicate the type of data in the file.
- Most commands take options (flags) which begin with a '-'.


## Next:

[Part 3: Working With Files and Directories]({filename}/lectures/unix_git/intro_to_unix_3_create.md)

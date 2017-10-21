Title: Intro to Unix, Part 3: Working With Files and Directories
Summary:   
Date: 9/7/2017
Tags: unix, shell, bash, file system
Category: lectures


*The notes below are modified from the excellent [Unix Shell tutorial ](http://swcarpentry.github.io/shell-novice/) that is freely available on the Software Carpentry website. I highly recommend checking out the full version for further reading. The material is being used here under the terms of the [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/).*

---

We now know how to explore files and directories,
but how do we create them in the first place?
Let's go back to our `data-shell` directory on the Desktop
and use `ls -F` to see what it contains:

~~~
$ pwd
~~~


~~~
/Users/nelle/Desktop/data-shell
~~~


~~~
$ ls -F
~~~


~~~
creatures/  molecules/           pizza.cfg
data/       north-pacific-gyre/  solar.pdf
Desktop/    notes.txt            writing/
~~~


Let's create a new directory called `thesis` using the command `mkdir thesis`
(which has no output):

~~~
$ mkdir thesis
~~~


As you might guess from its name,
`mkdir` means "make directory".
Since `thesis` is a relative path
(i.e., doesn't have a leading slash),
the new directory is created in the current working directory:

~~~
$ ls -F
~~~


~~~
creatures/  north-pacific-gyre/  thesis/
data/       notes.txt            writing/
Desktop/    pizza.cfg
molecules/  solar.pdf
~~~


## Good names for files and directories

 Complicated names of files and directories can make your life painful
 when working on the command line. Here we provide a few useful
 tips for the names of your files.

 1. Don't use whitespaces.

    Whitespaces can make a name more meaningful
   but since whitespace is used to break arguments on the command line
   is better to avoid them on name of files and directories.
    You can use `-` or `_` instead of whitespace.

 2. Don't begin the name with `-` (dash).

    Commands treat names starting with `-` as options.

 3. Stick with letters, numbers, `.` (period), `-` (dash) and `_` (underscore).

    Many other characters have special meanings on the command line.
    We will learn about some of these during this lesson.
    There are special characters that can cause your command to not work as
    expected and can even result in data loss.

 If you need to refer to names of files or directories that have whitespace
 or another non-alphanumeric character, you should surround the name in quotes (`""`).


Since we've just created the `thesis` directory, there's nothing in it yet:

~~~
$ ls -F thesis
~~~


Let's change our working directory to `thesis` using `cd`,
then run a text editor called Nano to create a file called `draft.txt`:

~~~
$ cd thesis
$ nano draft.txt
~~~




Let's type in a few lines of text.
Once we're happy with our text, we can press `Ctrl-O` (press the Ctrl or Control key and, while
holding it down, press the O key) to write our data to disk
(we'll be asked what file we want to save this to:
press Return to accept the suggested default of `draft.txt`).

![Nano in Action]({attach}/lectures/unix_git/nano-screenshot.png)

Once our file is saved, we can use `Ctrl-X` to quit the editor and
return to the shell.

`nano` doesn't leave any output on the screen after it exits,
but `ls` now shows that we have created a file called `draft.txt`:

~~~
$ ls
~~~


~~~
draft.txt
~~~

## Which Editor?

 When we say, "`nano` is a text editor," we really do mean "text": it can
 only work with plain character data, not tables, images, or any other
 human-friendly media. We use it in examples because it is one of the
 least complex text editors. However, because of this trait, it may
 not be powerful enough or flexible enough for the work you need to do
 after this workshop. On Unix systems (such as Linux and Mac OS X),
 many programmers use [Emacs](http://www.gnu.org/software/emacs/) or
 [Vim](http://www.vim.org/) (both of which require more time to learn),
 or a graphical editor such as
 [Gedit](http://projects.gnome.org/gedit/). On Windows, you may wish to
 use [Notepad++](http://notepad-plus-plus.org/).  Windows also has a built-in
 editor called `notepad` that can be run from the command line in the same
 way as `nano` for the purposes of this lesson.  

 No matter what editor you use, you will need to know where it searches
 for and saves files. If you start it from the shell, it will (probably)
 use your current working directory as its default location. If you use
 your computer's start menu, it may want to save files in your desktop or
 documents directory instead. You can change this by navigating to
 another directory the first time you "Save As..."


Let's tidy up by running `rm draft.txt`:

~~~
$ rm draft.txt
~~~


This command removes files (`rm` is short for "remove").
If we run `ls` again,
its output is empty once more,
which tells us that our file is gone:

~~~
$ ls
~~~


## Deleting Is Forever

 The Unix shell doesn't have a trash bin that we can recover deleted
 files from (though most graphical interfaces to Unix do).  Instead,
 when we delete files, they are unhooked from the file system so that
 their storage space on disk can be recycled. Tools for finding and
 recovering deleted files do exist, but there's no guarantee they'll
 work in any particular situation, since the computer may recycle the
 file's disk space right away.


Let's re-create that file
and then move up one directory to `/Users/nelle/Desktop/data-shell` using `cd ..`:

~~~
$ pwd
~~~


~~~
/Users/nelle/Desktop/data-shell/thesis
~~~


~~~
$ nano draft.txt
$ ls
~~~


~~~
draft.txt
~~~


~~~
$ cd ..
~~~


If we try to remove the entire `thesis` directory using `rm thesis`,
we get an error message:

~~~
$ rm thesis
~~~


~~~
rm: cannot remove `thesis': Is a directory
~~~

This happens because `rm` by default only works on files, not directories.

To really get rid of `thesis` we must also delete the file `draft.txt`.
We can do this with the [recursive](https://en.wikipedia.org/wiki/Recursion) option for `rm`:

~~~
$ rm -r thesis
~~~


## With Great Power Comes Great Responsibility

 Removing the files in a directory recursively can be very dangerous
 operation. If we're concerned about what we might be deleting we can
 add the "interactive" flag `-i` to `rm` which will ask us for confirmation
 before each step

~~~
 $ rm -r -i thesis
 rm: descend into directory ‘thesis’? y
 rm: remove regular file ‘thesis/draft.txt’? y
 rm: remove directory ‘thesis’? y
~~~


 This removes everything in the directory, then the directory itself, asking
 at each step for you to confirm the deletion.


Let's create that directory and file one more time.
(Note that this time we're running `nano` with the path `thesis/draft.txt`,
rather than going into the `thesis` directory and running `nano` on `draft.txt` there.)

~~~
$ pwd
~~~


~~~
/Users/nelle/Desktop/data-shell
~~~


~~~
$ mkdir thesis
$ nano thesis/draft.txt
$ ls thesis
~~~


~~~
draft.txt
~~~


`draft.txt` isn't a particularly informative name,
so let's change the file's name using `mv`,
which is short for "move":

~~~
$ mv thesis/draft.txt thesis/quotes.txt
~~~


The first parameter tells `mv` what we're "moving",
while the second is where it's to go.
In this case,
we're moving `thesis/draft.txt` to `thesis/quotes.txt`,
which has the same effect as renaming the file.
Sure enough,
`ls` shows us that `thesis` now contains one file called `quotes.txt`:

~~~
$ ls thesis
~~~


~~~
quotes.txt
~~~


One has to be careful when specifying the target file name, since `mv` will
silently overwrite any existing file with the same name, which could
lead to data loss. An additional flag, `mv -i` (or `mv --interactive`),
can be used to make `mv` ask you for confirmation before overwriting.

Just for the sake of consistency,
`mv` also works on directories

Let's move `quotes.txt` into the current working directory.
We use `mv` once again,
but this time we'll just use the name of a directory as the second parameter
to tell `mv` that we want to keep the filename,
but put the file somewhere new.
(This is why the command is called "move".)
In this case,
the directory name we use is the special directory name `.` that we mentioned earlier.

~~~
$ mv thesis/quotes.txt .
~~~


The effect is to move the file from the directory it was in to the current working directory.
`ls` now shows us that `thesis` is empty:

~~~
$ ls thesis
~~~


Further,
`ls` with a filename or directory name as a parameter only lists that file or directory.
We can use this to see that `quotes.txt` is still in our current directory:

~~~
$ ls quotes.txt
~~~


~~~
quotes.txt
~~~


The `cp` command works very much like `mv`,
except it copies a file instead of moving it.
We can check that it did the right thing using `ls`
with two paths as parameters --- like most Unix commands,
`ls` can be given multiple paths at once:

~~~
$ cp quotes.txt thesis/quotations.txt
$ ls quotes.txt thesis/quotations.txt
~~~


~~~
quotes.txt   thesis/quotations.txt
~~~


To prove that we made a copy,
let's delete the `quotes.txt` file in the current directory
and then run that same `ls` again.

~~~
$ rm quotes.txt
$ ls quotes.txt thesis/quotations.txt
~~~


~~~
ls: cannot access quotes.txt: No such file or directory
thesis/quotations.txt
~~~

This time it tells us that it can't find `quotes.txt` in the current directory,
but it does find the copy in `thesis` that we didn't delete.



## Key Points
- `cp old new` copies a file.
- `mkdir path` creates a new directory.
- `mv old new` moves (renames) a file or directory.
- `rm path` removes (deletes) a file.
- Use of the Control key may be described in many ways, including `Ctrl-X`, `Control-X`, and `^X`.
- The shell does not have a trash bin: once something is deleted, it's really gone.
- Depending on the type of work you do, you may need a more powerful text editor than Nano.

## Next:
[Part 4: Pipes and Filters]({filename}/lectures/unix_git/intro_to_unix_4_pipefilter.md)

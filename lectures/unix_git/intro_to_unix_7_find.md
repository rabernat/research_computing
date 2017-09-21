Title: Intro to Unix, Part 7: Finding Things
Summary:  
Date: 9/7/2017
Tags: unix, shell, bash, file system
Category: lectures

*The notes below are modified from the excellent [Unix Shell tutorial ](http://swcarpentry.github.io/shell-novice/) that is freely available on the Software Carpentry website. I highly recommend checking out the full version for further reading. The material is being used here under the terms of the [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/).*


---

In the same way that many of us now use "Google" as a
verb meaning "to find", Unix programmers often use the
word "grep".
"grep" is a contraction of "global/regular expression/print",
a common sequence of operations in early Unix text editors.
It is also the name of a very useful command-line program.

`grep` finds and prints lines in files that match a pattern.
For our examples,
we will use a file that contains three haikus taken from a
1998 competition in *Salon* magazine. For this set of examples,
we're going to be working in the writing subdirectory:

~~~
$ cd
$ cd writing
$ cat haiku.txt
~~~


~~~
The Tao that is seen
Is not the true Tao, until
You bring fresh toner.

With searching comes loss
and the presence of absence:
"My Thesis" not found.

Yesterday it worked
Today it is not working
Software is like that.
~~~


Let's find lines that contain the word "not":

~~~
$ grep not haiku.txt
~~~


~~~
Is not the true Tao, until
"My Thesis" not found
Today it is not working
~~~


Here, `not` is the pattern we're searching for. The grep command searches through the file, looking for matches to the pattern specified. To use it type `grep`, then the pattern we're searching for and finally the name of the file (or files) we're searching in.

The output is the three lines in the file that contain the letters "not".

Let's try a different pattern: "The".

~~~
$ grep The haiku.txt
~~~


~~~
The Tao that is seen
"My Thesis" not found.
~~~


This time,
two lines that include the letters "The" are outputted.
However, one instance of those letters is contained within a larger word,
"Thesis".

To restrict matches to lines containing the word "The" on its own,
we can give `grep` with the `-w` flag.
This will limit matches to word boundaries.

~~~
$ grep -w The haiku.txt
~~~


~~~
The Tao that is seen
~~~


Note that a "word boundary" includes the start and end of a line, so not
just letters surrounded by spaces.
Sometimes we don't
want to search for a single word, but a phrase. This is also easy to do with
`grep` by putting the phrase in quotes.

~~~
$ grep -w "is not" haiku.txt
~~~


~~~
Today it is not working
~~~


We've now seen that you don't have to have quotes around single words,
but it is useful to use quotes when searching for multiple words.
It also helps to make it easier to distinguish between the search term or phrase
and the file being searched.
We will use quotes in the remaining examples.

Another useful option is `-n`, which numbers the lines that match:

~~~
$ grep -n "it" haiku.txt
~~~


~~~
5:With searching comes loss
9:Yesterday it worked
10:Today it is not working
~~~


Here, we can see that lines 5, 9, and 10 contain the letters "it".

We can combine options (i.e. flags) as we do with other Unix commands.
For example, let's find the lines that contain the word "the". We can combine
the option `-w` to find the lines that contain the word "the" and `-n` to number the lines that match:

~~~
$ grep -n -w "the" haiku.txt
~~~


~~~
2:Is not the true Tao, until
6:and the presence of absence:
~~~


Now we want to use the option `-i` to make our search case-insensitive:

~~~
$ grep -n -w -i "the" haiku.txt
~~~


~~~
1:The Tao that is seen
2:Is not the true Tao, until
6:and the presence of absence:
~~~


Now, we want to use the option `-v` to invert our search, i.e., we want to output
the lines that do not contain the word "the".

~~~
$ grep -n -w -v "the" haiku.txt
~~~


~~~
1:The Tao that is seen
3:You bring fresh toner.
4:
5:With searching comes loss
7:"My Thesis" not found.
8:
9:Yesterday it worked
10:Today it is not working
11:Software is like that.
~~~


`grep` has lots of other options. To find out what they are, we can type:

~~~
$ grep --help
~~~


~~~
Usage: grep [OPTION]... PATTERN [FILE]...
Search for PATTERN in each FILE or standard input.
PATTERN is, by default, a basic regular expression (BRE).
Example: grep -i 'hello world' menu.h main.c

Regexp selection and interpretation:
  -E, --extended-regexp     PATTERN is an extended regular expression (ERE)
  -F, --fixed-strings       PATTERN is a set of newline-separated fixed strings
  -G, --basic-regexp        PATTERN is a basic regular expression (BRE)
  -P, --perl-regexp         PATTERN is a Perl regular expression
  -e, --regexp=PATTERN      use PATTERN for matching
  -f, --file=FILE           obtain PATTERN from FILE
  -i, --ignore-case         ignore case distinctions
  -w, --word-regexp         force PATTERN to match only whole words
  -x, --line-regexp         force PATTERN to match only whole lines
  -z, --null-data           a data line ends in 0 byte, not newline

Miscellaneous:
...        ...        ...
~~~


## Wildcards

 `grep`'s real power doesn't come from its options, though; it comes from
 the fact that patterns can include wildcards. (The technical name for
 these is **regular expressions**, which
 is what the "re" in "grep" stands for.) Regular expressions are both complex
 and powerful; if you want to do complex searches, please look at the lesson
 on [our website](http://v4.software-carpentry.org/regexp/index.html). As a taster, we can
 find lines that have an 'o' in the second position like this:

```
 $ grep -E '^.o' haiku.txt
```



``` output
 You bring fresh toner.
 Today it is not working
 Software is like that.
```


 We use the `-E` flag and put the pattern in quotes to prevent the shell
 from trying to interpret it. (If the pattern contained a `*`, for
 example, the shell would try to expand it before running `grep`.) The
 `^` in the pattern anchors the match to the start of the line. The `.`
 matches a single character (just like `?` in the shell), while the `o`
 matches an actual 'o'.


While `grep` finds lines in files,
the `find` command finds files themselves.


Nelle's `writing` directory contains one file called `haiku.txt` and four subdirectories:
`thesis` (which contains a sadly empty file, `empty-draft.md`),
`data` (which contains two files `one.txt` and `two.txt`),
a `tools` directory that contains the programs `format` and `stats`,
and a subdirectory called `old`, with a file `oldtool`.

For our first command,
let's run `find .`.

~~~
$ find .
~~~


~~~
.
./old
./old/.gitkeep
./data
./data/one.txt
./data/two.txt
./tools
./tools/format
./tools/old
./tools/old/oldtool
./tools/stats
./haiku.txt
./thesis
./thesis/empty-draft.md
~~~


As always,
the `.` on its own means the current working directory,
which is where we want our search to start.
`find`'s output is the names of every file **and** directory
under the current working directory.
This can seem useless at first but `find` has many options
to filter the output and in this lesson we will discover some
of them.

The first option in our list is
`-type d` that means "things that are directories".
Sure enough,
`find`'s output is the names of the six directories in our little tree
(including `.`):

~~~
$ find . -type d
~~~


~~~
./
./old
./data
./thesis
./tools
./tools/old
~~~


Notice that the objects `find` finds are not listed in any particular order.
If we change `-type d` to `-type f`,
we get a listing of all the files instead:

~~~
$ find . -type f
~~~


~~~
./haiku.txt
./tools/stats
./tools/old/oldtool
./tools/format
./thesis/empty-draft.md
./data/one.txt
./data/two.txt
~~~


Now let's try matching by name:

~~~
$ find . -name *.txt
~~~


~~~
./haiku.txt
~~~


We expected it to find all the text files,
but it only prints out `./haiku.txt`.
The problem is that the shell expands wildcard characters like `*` *before* commands run.
Since `*.txt` in the current directory expands to `haiku.txt`,
the command we actually ran was:

~~~
$ find . -name haiku.txt
~~~


`find` did what we asked; we just asked for the wrong thing.

To get what we want,
let's do what we did with `grep`:
put `*.txt` in single quotes to prevent the shell from expanding the `*` wildcard.
This way,
`find` actually gets the pattern `*.txt`, not the expanded filename `haiku.txt`:

~~~
$ find . -name '*.txt'
~~~


~~~
./data/one.txt
./data/two.txt
./haiku.txt
~~~


> ## Listing vs. Finding
>
> `ls` and `find` can be made to do similar things given the right options,
> but under normal circumstances,
> `ls` lists everything it can,
> while `find` searches for things with certain properties and shows them.


As we said earlier,
the command line's power lies in combining tools.
We've seen how to do that with pipes;
let's look at another technique.
As we just saw,
`find . -name '*.txt'` gives us a list of all text files in or below the current directory.
How can we combine that with `wc -l` to count the lines in all those files?

The simplest way is to put the `find` command inside `$()`:

~~~
$ wc -l $(find . -name '*.txt')
~~~


~~~
11 ./haiku.txt
300 ./data/two.txt
70 ./data/one.txt
381 total
~~~


When the shell executes this command,
the first thing it does is run whatever is inside the `$()`.
It then replaces the `$()` expression with that command's output.
Since the output of `find` is the three filenames `./data/one.txt`, `./data/two.txt`, and `./haiku.txt`,
the shell constructs the command:

~~~
$ wc -l ./data/one.txt ./data/two.txt ./haiku.txt
~~~


which is what we wanted.
This expansion is exactly what the shell does when it expands wildcards like `*` and `?`,
but lets us use any command we want as our own "wildcard".

It's very common to use `find` and `grep` together.
The first finds files that match a pattern;
the second looks for lines inside those files that match another pattern.
Here, for example, we can find PDB files that contain iron atoms
by looking for the string "FE" in all the `.pdb` files above the current directory:

~~~
$ grep "FE" $(find .. -name '*.pdb')
~~~


~~~
../data/pdb/heme.pdb:ATOM     25 FE           1      -0.924   0.535  -0.518
~~~



## Key Points
- `find` finds files with specific properties that match patterns.
- `grep` selects lines in files that match patterns.
- `--help` is a flag supported by many bash commands, and programs that can be run from within Bash, to display more information on how to use these commands or programs.
- `man command` displays the manual page for a given command.
- `$(command)` inserts a command's output in place.

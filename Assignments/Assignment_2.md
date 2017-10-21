Title: Assignment #2 -  Unix and Version Control
Summary: *Due: Thursday, 14 September*
Date: 9/7/2017
tags: assignment
Category: assignments

**Due: Thursday, 14 September**

For this assignment you will use Unix commands to efficiently parse
the contents of the Significant Earthquake Database from the National Geophysical Data Center, NOAA.

Download the database file:

 [signif.txt.tsv.zip]({attach}/Assignments/signif.txt.tsv.zip)

Unzip the file. In a terminal, run `less` or `head` on this unzipped file to have a peek at its contents. You can also try opening it in your text editor. Unless you are opening it with a really wide screen and terminal window, each line has likely wrapped around a few times. This is a tab separated data file and the first line contains the headers of each column. When viewing the file with `less` on my laptop, the header line wraps around 4 times.  

Clearly this file contains some interesting data, but its very difficult to visually inspect the contents in a terminal window. Tables like this are actually better viewed in a spreadsheet application like Excel or Google Sheets, but this file has so much data its hard to make sense of it even when viewed in a spreadsheet.

 The purpose of this assignment is to use a few Unix commands to analyze the data. For each question below, use one or more Unix commands to compute the answer. All questions except #'s 9, 10 and 12 should be answered with a single line of unix commands, using pipes `|` where necessary.

 **Create a text file called `answers.txt` and copy the questions into it. For each question, list  the unix command sequence you used and the answer it produces.**

1. How many earthquakes are listed in the table?


2. How many columns are in the table?


3. Use the `cut` command to create a new file that just has the data from the columns for YEAR, EQ_PRIMARY and COUNTRY. Hint: you can get the column numbers by using the `head` command to view the first row and then visually count the column numbers for the above fields (there is also a unix command to do this, but we didn't cover it in class).  Call the new data file 'Year_Mag_Country.tsv'. You can use 'Year_Mag_Country.tsv' for the rest of the exercises below.


4.  EQ_PRIMARY is the assigned earthquake magnitude. With your new file 'Year_Mag_Country.tsv', sort the data based on the *numeric* value of the EQ_PRIMARY column, then list the lines for the top ten largest earthquakes.

5.  How many unique countries are listed in the database? Use `cut`,`sort`,`uniq`, `wc` and a few pipes `|` to form a single expression that answers this question.


6. Use the `grep` command to count how many earthquakes in the database are located in the USA or USA TERRITORY


7. Expanding on the previous exercise, refine your command sequence so that it only counts earthquakes in the USA and not ones in USA TERRITORY. Hint: use the -v argument with grep and you
may need to call grep more than once.


8.  Compute the total number of earthquakes in each country and then display the top ten countries along with the number of earthquakes. Hint: this can be done with a command sequence similar to exercise 5, but requires a specific argument to be used with `uniq`.



9. Create a shell script named `countEq.sh` that returns the total number of earthquakes for a given country, where the country is specified as the option when calling the script. Hint: see the Shell Script notes and use the special variable `$1`.  Paste your script  below and give an example calling sequence for country USA.


10.  Create a shell script named `countEq_getLargestEq.sh` that returns both the total number of earthquakes AND the largest earthquake for a given country, where the country is specified as the option when calling the script. Use the echo command before each command to create labels for each returned value. Paste your script  below and give an example calling sequence for country CHILE.   



11.  Compute the total number of earthquakes *each year* and then output a sorted list of the top ten years with the most earthquakes. Paste your command and the top ten list below.




12. Create a shell script that loops over the top ten years with the most earthquakes (from exercise 11), finds all the earthquakes for a given year and writes them to file named $YEAR-earthquakes.txt, where $YEAR is the for loop variable assigned from the top ten list. Your code should output ten different files (one for each year in the top ten list). Hints: Take your answer from exercise 11 and extract the year column, then use this for the range in a `for` loop by inserting them like this `for YEAR in $(insert code that lists top ten years here)`. The rest is just a `grep` and  a redirect `>` to a file with the correct name.  



13. Turn in your homework by sharing it with us on a GitHub repository.  Instructions: on GitHub, create a *private* git repository called Assignment_2. Share this repository with users `roxyboy` (Takaya Uchida), `kerrykey` and `rabernat`. Clone the repository to your laptop.  Save your answers to the exercises above in a text file called `answers.txt`. Use git to `commit` `answers.txt` to your repository on your laptop, and then `push` the changes to the remote repository on GitHub.   

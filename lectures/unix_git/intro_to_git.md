Title: Intro to Git
Summary:  Introduction to version control with Git
Date: 9/7/2017
Tags: git, version control
Category: lectures
Author: Kerry Key

Follow the tutorial
 [Version Control with Git](http://swcarpentry.github.io/git-novice/)  on Software Carpentry website.

**Summary of useful Git commands**

Create a new repository:
~~~
git init      
~~~

Stage files for addition to the repository:
~~~
git add <filenames>  
~~~

Commit staged files:

~~~
git commit -m "your brief commit message goes here"
~~~

Other useful commands:

~~~
git status    # tells you what files are staged, which ones have been modified, are new,... )
git log       # view the commit log
git diff      # view file content differences
~~~

Working with a remote repository on GitHub:

~~~
git push
git pull
~~~

Basis collaboration workflow:

* update your local repo with `git pull origin master`,
* make your changes and stage them with `git add`,
* commit your changes with `git commit -m`, and
* upload the changes to GitHub with` git push origin master`

**Graphical Git**

Our lectures will center on using Git terminal commands since that is a good way to learn the fundamentals of git. Also, knowing the terminal commands well will be useful when you are working on an HPC server. However, there are also graphical git clients that offer extended functionality. Here are two freely available ones:

* [GitHub Desktop](https://desktop.github.com)  
* [Source Tree](https://www.sourcetreeapp.com)

Title: Assignment #10 - Packaging Python Code
Summary: *Due: Thursday, 16 November*
Date: 11/13/2017
tags: assignment
Category: assignments

**Due: Thursday, 16 November**

This assignment was assigned without much time for you to work on it, so it is
short. Hopefully you can complete most of it in class on Tuesday.

In this assignment, you will create a python package to help with some common
geoscience unit conversions. This is a silly exercise, because there are
already some [great packages](https://pint.readthedocs.io/en/latest/) out there
which can do this better and more comprehensively than we can hope to do in an
hour or two. However, the point is to keep the coding simple and focus on
_organization, packaging, and testing_.

Do the following:

1. Create a new folder with the proper directory structure for a python package
   called `unitconvert`. Initialize this directory as a new git repository.
1. In the package directory, create two modules:
    - A module called `temperature` which implements two functions:
      `fahrenheit_to_celsius` and `celsius_to_fahrenheit`.
    - A module called `distance` which implements two functions:
      `miles_to_kilometers` and `kilometers_to_miles`.
    - Don't forget `__init__.py`
1. Make sure your modules all have complete and properly-formatted doc-strings.
1. Write a test suite which checks each function in your package and run it
   using `pytest`
1. Write a `setup.py` script which makes your package installable.
1. Push your project to a public github repository

Optional but highly recommended (required for a score of 3):

1. Enable travis-ci integration on your github repo
1. Add a [`.travis.yml`](https://docs.travis-ci.com/user/languages/python/)
   file for your project and push it to your github repo.
1. Verify that travis-ci executed the test suite properly and add a shiny
   [travis-ci badge](https://docs.travis-ci.com/user/status-images/) to your
   readme file.

Turn in the assignment by emailing a link to your public repo to the TA and
instructors.

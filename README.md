# Research Computing in Earth Science

Pelican site repo. See [Pelican docs](http://pelican.readthedocs.io/) for
info.

## Automatic Publishing with Doctr

This site is configure to automatically publish to
https://rabernat.github.io/research_computing/
using the [doctr](https://github.com/drdoctr/doctr) utility.

Pushing to the master branch will trigger Travis CI to build the docs and
publish them to the `github-pages` branch of the repo.

[![Build Status](https://travis-ci.org/rabernat/research_computing.svg?branch=master)](https://travis-ci.org/rabernat/research_computing)

## Backup: Manual Publishing

Publish using [ghp_import](https://github.com/davisp/ghp-import).

    $ pelican content -o output -s pelicanconf.py
    $ ghp-import output
    $ git push origin gh-pages

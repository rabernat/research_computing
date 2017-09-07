#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Ryan Abernathey and Kerry Key'
SITENAME = u'Research Computing in Earth Sciences'
SITEURL = 'https://rabernat.github.io/research_computing'
RELATIVE_URLS = True

PATH = 'content'

USE_FOLDER_AS_CATEGORY = False # false is better for organzing lectures into subfolders
PYGMENTS_STYLE = 'default'  # without this it was using black background and light font

TIMEZONE = 'EST'

DEFAULT_LANG = u'en'


# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = None
# LINKS = (('Pelican', 'http://getpelican.com/'),
#          ('Python.org', 'http://python.org/'),
#          ('You can modify those links in your config file', '#'),)

# https://github.com/getpelican/pelican-themes/tree/master/pelican-bootstrap3
DISPLAY_TAGS_ON_SIDEBAR=True
DISPLAY_RECENT_POSTS_ON_SIDEBAR=True
RECENT_POST_COUNT=10

# Social widget
SOCIAL = None
#SOCIAL = (('You can add links in your config file', '#'),
#          ('Another social link', '#'),)

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

# instructions for installting
THEME = './themes/pelican-bootstrap3'
BOOTSTRAP_THEME = 'lumen'
JINJA_ENVIRONMENT = {'extensions': ['jinja2.ext.i18n']}
PLUGIN_PATHS = ['./pelican-plugins', './plugins']
PLUGINS = ['i18n_subsites',
           'liquid_tags.img', 'liquid_tags.video',
           'liquid_tags.youtube', 'liquid_tags.vimeo',
           'liquid_tags.include_code', 'tag_cloud',
           'ipynb.markup', 'bootswatch_markdown_css']
#  UserWarning: Pelican plugin is not designed to work with IPython versions
#  greater than 1.x. CSS styles have changed in later releases.
           #'liquid_tags.notebook']
CUSTOM_CSS = 'static/custom.css'
STATIC_PATHS = ['static', 'static/custom.css','lectures/unix_git','Assignments']

# banner image
BANNER = 'static/delaunay.png'
BANNER_SUBTITLE = 'Fall 2017 | Columbia University Department of Earth and Environmental Sciences'


IGNORE_FILES = ['.ipynb_checkpoints']
#IPYNB_IGNORE_CSS = True

# license
# https://github.com/getpelican/pelican-themes/tree/master/pelican-bootstrap3#content-license
CC_LICENSE = 'CC-BY-NC'

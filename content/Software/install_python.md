Title: Python
Summary:  
Date: 2 September 2017
Tags: python
Category: software

_Note: many elements in this guide are adapted from
[Daniel Rothenberg](http://danielrothenberg.com/)'s
excellent
[getting started guide](http://danielrothenberg.com/gcpy/getting_started.html)._

## What is Python?

[Python](https://www.python.org/) itself is a
[interpreted programming language](https://en.wikipedia.org/wiki/Interpreted_language)
that is popular for its flexibility and simple, elegant syntax.
However, the "core" python language does not in itself contain enough features
for serious scientific work.
"Scientific python" refers to an "ecosystem" of interrelated packages that
extend the core python language and provide different elements of the
scientific computing environment.
(This ensemble of packages is sometimes also called the scientific python
  "stack".)
For example,
[numpy](http://www.numpy.org/)
provides the data structures and functions for dealing with multidimensional
arrays of numerical values, while
[matplotlib](https://matplotlib.org/)
provides the plotting routines necessary for making figures.
Python and nearly all of the software packages in the scientific python
ecosystem are [open-source](https://opensource.org/).
They are maintained and developed by a community of scientists and programmers,
some of whose work is supported by universities, non-profits, and for-profit
corporations.
This work mostly happens in the open, via [github](http://github.com/) and other
online collaboration platforms.

Because there is no single authority which controls all of these packages, it
can be intimidating for new users to figure out how to set up a functional
scientific python environment.
Coordinating the compatibility between these different packages and their
multiple versions used to be a nightmare!
Fortunately, the problem is solved completely by using a Python _distribution_
and / or a Python _package manager_ (described in detail below).

The only hard-and-fast rule about scientific computing in Python is this:

**Do not use your system Python installation!**

The version of Python that ships with operating systems such as Red Hat Linux and
macOS is usually outdated and configured to support system functions. Although it
is entirely possible to install and use the necessary packages using the system
Python, it's much more practical on both
your local machine and any other computers you work with to use a specialized Python
installation.

**Should I use Python 2 or Python 3?**

You should use Python 3. The majority of the scientific Python packages are
[moving to only support Python 3](http://www.python3statement.org/) in the
near future without any backwards compatibility. The differences between
Python 2 and Python 3 are mostly superficial, but large enough that it is
cumbersome to maintain large codebases that are compatible with both. With the
exception of a handful of packages you may encounter which do not support
Python 3, there is no compelling reason to use Python 2 today.

## Recommended Installation Method: Use Anaconda Python

The easiest way to set up a full-stack scientific Python deployment is to use a
Python distribution. This is an installation of Python with a set of curated
packages which are guaranteed to work together.
For this class, we recommend the
**[Anaconda Python Distribution](https://www.anaconda.com/download/)**.
Follow the link above to obtain a one-click installer for Linux, Mac, or
Windows.
(Make sure you select the Python 3 installer, not Python 2.7.)
In addition to the packages themselves, Anaconda includes a graphical
utility to help manage any packages you may want to install which are not
already included in the default inclusion list.

## Lightweight Alternative: Miniconda

If you are installing python on a remote machine via ssh, or you simply don't
want to download a huge file like the Anaconda Python Distribution, there is a
lightweight alternative installation method.

1. **Obtain a minimal Python installer**
  We recommend the [Miniconda](https://conda.io/miniconda.html) installer;
  this provides a Python install for your operating system, plus the **conda**
  package manager. This way, you can only install the packages you *want*.

2. **Run the installer**
  You'll probably need to do this from the command line, e.g.

        $ sh Miniconda3-latest-MacOSX-x86_64.sh
  Follow the instructions; you can choose where to place the installation (
  preferably somewhere you have write access without super-user/root access,
  like your home directory). At the end of this process, add this path to your
  \*rc configuration

        $ echo "PATH=$PATH:/path/to/miniconda/bin" > ~/.bashrc
  If you do this, your ``$PYTHONPATH`` will be implicitly configured correctly
  and you will never have to touch it.

3. **Install any packages you want**
  As shown :ref:`before <packages>`, install whatever packages you want.
  Optionally, you can create a customized environment, as described below.

## Custom Environments

Python coupled with a package manager provides a way to make isolated,
reproducible *environments* where you have fine-tuned control over all packages
and configuration.
For scientific Python, we recommend using **conda**'s built in
environment management system. To create a conda environment, you simply
execute the following command:

    $ conda create --name my_environment python=3.6 numpy

This will create a special environment in ``$MINICONDA_HOME/envs/my_environment``
with only Python and numpy to begin with. Here, we've also told conda to install
Python version 3.6; you can specify exact versions or minima, and conda will
take care of figuring out all the compatibilties between versions for you. To use
this environment, simply "activate" it by executing:

    $ source activate my_environment

Regardless of your shell, you should now see the string ``(my_environment)``
prepended to your prompt. Now, if you execute any Python-related tool from the
command line, it will first search in ``$MINICONDA_HOME/envs/my_environment/bin``
to find them. You can deactivate your environment by typing:

    $ source deactivate

For extensive documentation on using environments, please see
[the conda documentation](https://conda.io/docs/using/envs.html). The most
important feature to review here is the ability to *share and export* your
environment; this is the basis for reproducibility in the scientific Python stack.
At any time from the shell, you can execute

    $ conda list

to get a complete summary of all the packages installed in your environment, the
channel they were installed from, and their full version info. Using this info,
you can create an **environment file** in
[YAML syntax](http://docs.ansible.com/ansible/latest/YAMLSyntax.html)
which documents the exact
contents of your environment. With that file, a new environment with the exact
configuration can be installed by executing

    $ conda env create -f my_environment.yml


## Geosciences Python Environment

Combining all of the previous sections, we can very easily spin-up a
full-featured scientific Python environment with a set of packages curated for the
geosciences. Copy and paste the following ``environment.yml`` file somewhere
on your local hard drive:

    :::yaml
    name: geo_scipy
    channels:
        - conda-forge
        - defaults
    dependencies:
        - python=3.6    # Python version 3.6
        - bottleneck    # C-optimized array functions for NumPy
        - cartopy       # Geographic plotting toolkit
        - cython        # Transpile Python->C
        - dask          # Parallel processing library
        - future        # Python 2/3 compatibility
        - h5py          # Wrapper for HDF5
        - ipython       # IPython interpreter and tools
        - jupyter       # Jupyter federation architecture
        - matplotlib    # 2D plotting library
        - netcdf4       # Wrapper for netcdf4
        - notebook      # Notebook interface
        - numpy         # N-d array and numerics
        - pandas        # Labeled array library
        - pyresample    # Geographic resampling tools
        - scipy         # Common math/stats/science functions
        - scikit-learn  # Macine learning library
        - scikit-image  # Image processing routines
        - statsmodels   # Regression/modeling toolkit
        - seaborn       # Statistical visualizations
        - six           # Python 2/3 compatibility
        - tqdm          # Nice progressbar for longer computations
        - xarray        # N-d labeled array library

(**Note:**
Installing this environment will also install many dependencies, including
compiled libraries. This is totally fine; even if you have these libraries
already installed through your system package manager, **conda** will install
and link for use in the environment a configuration which should be to play
nicely and work with all of its components.)

Create this environment through **conda**

    $ conda env create -f /path/to/environment.yml

Activate this environment

    $ source activate geo_scipy

This environment should be sufficient for all of your work in this class.

## Installing More Packages

Once you have a basic Python environment, you can easily add or remove packages
using the [conda](https://conda.io/) command line utility.
Conda was created to help manage the complex dependencies and
pre-compiled binary libraries that are necessary in scientific python.

If you set up your python environment using the Anaconda Python Distribution or
with miniconda, you should already have the **conda** command available on
the command line.
With it, you can easily install packages from an official, curated set of packages which are
built and tested for a number of different system configurations on Linux,
Windows, and macOS

    $ conda install <package-name>

Additionally, there is a
community-maintained collection of packages/recipes called
[conda forge](https://conda-forge.github.io/>)
which is accessible through conda as a special "channel"

    $ conda install -c conda-forge <package-name>

While conda allows you to install almost any science-related package, there may
be other general-use python packages you wish to you that are not available in
via conda. For these, you can use an alternative installation method.

Outside of the scientific python community,
the most common way to install packages is to search for them on the official
[PyPI](https://pypi.python.org/pypi) index. Once you've found the package you
want to install (you may have also just found it on github or elsewhere), you
use the **pip** command from a the command line:

    $ pip install <package-name>

This will fetch the source code, build it, and install it to wherever your
``$PYTHONPATH`` is set. This works in the vast majority of cases, particularly
when the code you're installing doesn't have any compiled dependencies.

If you
can't find a package on either PyPI or conda-forge, you can always install it
directly from the source code. If the package is on github, ``pip`` already has
an alias to do this for you:

    $ pip install git+https://github.com/<user>/<package-name>.git

If all else fails, you can always download the source code and install it manually
like

    $ wget https:/path/to/my/pkg/source.tar.gz
    $ tar -xvzf source.tar.gz
    $ cd source/
    $ python setup.py install

You can also use ``pip`` to install code you've downloaded:

    $ cd source/
    $ pip install -e .

This will automatically call **setup.py** for you. The "**-e**" flag will
install the package in "editable" mode, which means that any chane you make
to the source code will automatically be recognized when you load the package
in Python; this is *especially* useful when you're developing code.

Finally, you don't *have* to go through this process of installing packages. If you
have code sitting on your disk somewhere, you can always modify the environmental
variable ``$PYTHONPATH`` to include a path to that code, and Python will find it
for you. However, you *should not do this* if it can be avoided, because it is
extremely difficult (if not impossible) to be sure that any compiled code will
link against the correct libraries it needs, and it is very hard to debug errors
associated with mis-matched libraries/headers if you go this route.

## Getting Help

Your first stop for help should be the official documentation of the packages
you are using.
Reading documentation can be sometimes feel tedious if you just want a quick
answer.
But it is usually worthwhile, since it helps you reach a deeper understanding of
how a package is structured.
Here are some of the links to the official documentation of the python packages
we use in this course.

* [Python](http://docs.python.org)
* [IPython](http://ipython.org/documentation.html)
* [NumPy](http://docs.scipy.org/doc/numpy/reference/)
* [MatPlotLib](http://matplotlib.org/contents.html)
* [SciPy](http://docs.scipy.org/doc/scipy/reference/)
* [pandas](http://pandas.pydata.org/pandas-docs/stable/)
* [XArray](xarray.pydata.org/en/stable/)

Title: MPI for Python
Summary:   Parallel Programming with MPI For Python
Date: 11/16/2017
Tags: mpi, python, parallel programming
Category: lectures
Author: Kerry Key


We will start the tutorial with a brief overview on parallel computing concepts:

 [Overview of Parallel Computing]({attach}/lectures/python/MPI_Overview.pdf)


**Installation of mpi4py**

We will be using the MPI for Python package **mpi4py**. If you have a clean `geo_scipy` environment as described on Ryan's Python installation notes on this website, you should be able to install it without any issues using conda:
~~~
conda install mpi4py
~~~


**What is mpi4py?**

MPI for Python provides MPI bindings for the Python  language, allowing programmers to exploit multiple processor computing systems. mpi4py is  is constructed on top of the MPI-1/2 specifications and provides an object oriented interface which closely follows MPI-2 C++ bindings.

**Documentation for mpi4py**

The documentation for mpi4py can be found here:
[https://mpi4py.scipy.org/](https://mpi4py.scipy.org/)

However, it is still a work in progress and much of it assumes you are already  familiar with the MPI standard. Therefore, you will  probably also need to  consult the MPI standard documentation:

[http://mpi-forum.org/docs/](http://mpi-forum.org/docs/)

 The MPI docs only cover the C and Fortran implementations, but the extension to Python syntax is straightforward and in most cases much simpler than the equivalent C or Fortran statements.

 Another useful place to look for help is the API reference for mpi4py:

 [https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI-module.html](https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI-module.html)

 In particular, the section for Class Comm lists all the methods you can use with a communicator object:

 [https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI.Comm-class.html](https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI.Comm-class.html)

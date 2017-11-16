Title: Parallel Programming with MPI For Python
Summary:    MPI For Python
Date: 11/16/2017
Tags: mpi, python, parallel programming
Category: lectures
Author: Kerry Key

# Parallel Computing Overview

We will start the tutorial with a brief overview on parallel computing concepts:

 [Overview of Parallel Computing](https://www.dropbox.com/s/2yidkm4e94p0yyj/MPI%20Overview.pdf?dl=0)


## Installation of mpi4py

We will be using the MPI for Python package **mpi4py**. If you have a clean *geo_scipy* environment as described on Ryan's Python installation notes on this website, you should be able to install it without any issues using conda:
~~~
conda install mpi4py
~~~


## What is mpi4py?

MPI for Python provides MPI bindings for the Python  language, allowing programmers to exploit multiple processor computing systems. mpi4py is  is constructed on top of the MPI-1/2 specifications and provides an object oriented interface which closely follows MPI-2 C++ bindings.

## Documentation for mpi4py

The documentation for mpi4py can be found here:
[https://mpi4py.scipy.org/](https://mpi4py.scipy.org/)

However, it is still a work in progress and much of it assumes you are already  familiar with the MPI standard. Therefore, you will  probably also need to  consult the MPI standard documentation:

[http://mpi-forum.org/docs/](http://mpi-forum.org/docs/)

 The MPI docs only cover the C and Fortran implementations, but the extension to Python syntax is straightforward and in most cases much simpler than the equivalent C or Fortran statements.

 Another useful place to look for help is the API reference for mpi4py:

 [https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI-module.html](https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI-module.html)

 In particular, the section for Class Comm lists all the methods you can use with a communicator object:

 [https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI.Comm-class.html](https://mpi4py.scipy.org/docs/apiref/mpi4py.MPI.Comm-class.html)


## Running Python Scripps with MPI

Assuming you have the *geo_scipy* environment setup on your machine, the first thing to do is to open a terminal shell and activate *geo_scipy*:
~~~
source activate geo_scipy
~~~

Python programs that use MPI commands must be run using an MPI interpreter, which is provided with the command `mpirun`. On some systems this command is instead called `mpiexec` and mpi4py seems to include both.

Make sure your environment is correct by checking that `mpirun` is in your anaconda directory for *geo_scipy* by using the `which` Unix comamnd:
~~~
$ which mpirun
/anaconda/envs/geo_scipy/bin/mpirun
~~~

You can run a MPI Python script using the `mpirun` command as follows:
~~~
mpirun -n 4 python script.py
~~~
Here the `-n 4` tells MPI to use four processes, which is the number of cores I have on my laptop. Then we tell MPI to run the python script named `script.py`.

If you are running this on a desktop computer, then you should adjust the `-n` argument to be the number of cores on your system or the maximum number of processes needed for your job, whichever is smaller. Or on a large cluster you would specify the number of cores that your program needs or the maximum number of cores available on the particular cluster.


## Communicators and Ranks

Our first MPI for python example will simply import MPI from the mpi4py package, create a *communicator* and get the *rank* of each process:
~~~
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
print('My rank is ',rank)
~~~

Save this to a file call `comm.py` and then run it:
~~~
mpirun -n 4 python comm.py
~~~
Here we used the default communicator named `MPI.COMM_WORLD`, which consists of all the processors. For many MPI codes, this is the main communicator that you will need. However, you can create custom communicators using subsets of the processors in `MPI.COMM_WORLD`. See the documentation for more info.

## Point-to-Point Communication

Now we will look at how to pass data from one process to another. Here is a very simple example where we pass a dictionary from process 0 to process 1:
~~~
from mpi4py import MPI
import numpy

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

if rank == 0:
    data = {'a': 7, 'b': 3.14}
    comm.send(data, dest=1)
elif rank == 1:
    data = comm.recv(source=0)
    print('On process 1, data is ',data)
~~~    

Here we sent a dictionary, but you could also send an integer with a similar code:

~~~
from mpi4py import MPI
import numpy

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

if rank == 0:
    idata = 1
    comm.send(idata, dest=1)
elif rank == 1:
    idata = comm.recv(source=0)
    print('On process 1, data is ',idata)
~~~
Note how `comm.send` and `comm.recv` have lower case `s` and `r`.

Now let's look at a more complex example where we send a numpy array:

~~~
from mpi4py import MPI
import numpy

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

# passing MPI datatypes explicitly
if rank == 0:

    numData = 10  # in a real code, this would be read from a data file
    comm.send(numData, dest=1)

    data = numpy.linspace(0.0,3.14,numData)  
    comm.Send(data, dest=1)

elif rank == 1:

    numData = comm.recv(source=0)
    print('Number of data to receive: ',numData)

    data = numpy.empty(numData, dtype='d')  # allocate space to receive the array
    numData = comm.Recv(data, source=0)

    print('data received: ',data)
~~~
Note how `comm.Send` and `comm.Recv` used to send and recieve the numpy array have upper case `S` and `R`.

Title: Introduction to the Habanero HPC Cluster
Summary:   Intro to Habanero
Date: 11/21/2017
Tags: habanero, parallel computing, cluster
Category: lectures
Author: Kerry Key

## Overview

This brief tutorial is intended to introduce you to parallel computing on HPC systems through a hands-on experience. You have been given a user account on Columbia's Habanero Cluster, and so now you will learn how to login to the system, setup your environment and start running jobs.

We don't have time to cover much in this tutorial, so consult the Habanero documentation for further information:

[Habanero HPC Cluster User Documentation](https://confluence.columbia.edu/confluence/display/rcs/Habanero+HPC+Cluster+User+Documentation)


## Tutorial:


### Login
Login to Habanero by using the `ssh` command in a unix shell:
~~~bash
ssh <UNI>@habanero.rcs.columbia.edu
~~~
where you replace `<UNI>` with your UNI.

Check to see where your home directory is:
~~~bash
[kwk2115@holmes ~]$ pwd
/rigel/home/kwk2115
~~~

### Modules

Most clusters use a module environment where you have to load certain modules to gain access to various software libraries and compilers. A module system is used so that various incompatible libraries or old and new versions of a given library are kept in separate modules.  


List the currently loaded modules:
~~~bash
[kwk2115@holmes ~]$ module list

Currently Loaded Modules:
  1) shared   2) DefaultModules   3) gcc/6.1.0   4) slurm/16.05.8
~~~


List all the modules that are available:
~~~bash
[kwk2115@holmes ~]$ module avail
(...)
~~~

Since the demo code we will be running is in Python, we need to load the ***anaconda*** module. Let's grab the latest version available and load it:

~~~bash
[kwk2115@holmes ~]$ module load anaconda/3-4.4.0
~~~

Now if you run `module list` you will see anaconda in the list of loaded modules.

If you always use certain modules on the cluster, you can simply add the `module load <module_name>` command to your `.bashrc` file in your home directory (your home directory on Habanero, not your laptop). This file is always read in right as you log in, so any commands there get executed when your shell starts up.



### Setting up the geo_scipy environment

For this tutorial we will run some simple `mpi4py` commands, so let's get a geo_scipy environment setup using the `environment.yml` file below. Make sure yours includes the MPI line at the bottom.

~~~yaml
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
    - mpi4py        # mpi for python library
~~~    

Save that text as environment.yml either in your home folder or a new folder (if so cd to that folder). I used the `nano` terminal text editor to create it directly in the shell.

Then create this environment using **conda**:

~~~bash
 conda env create -f environment.yml
~~~

This will take a few minutes.

Finally, activate the environment:
~~~bash
source activate geo_scipy
~~~

###  Running a cluster job

When you run codes on the cluster, you must submit them to the cluster's queueing system. The queuing system manages all the requested jobs from all the users that are currently logged on as well as any jobs that were added to the queue at some earlier time but have yet to run.

**Note: Do not run any of your codes on the login nodes without submitting them to the queue.  If you run codes on the login nodes straight from the terminal, it will make other users on Habanero angry since your code may bog down the login nodes and make the system inaccessible or unresponsive. Habanero is a shared resource; maintaining a happy user community  requires that you use this resource responsibly.**

Okay, with that out of the way, it is okay for you to compile your codes and  upload and download files using the login nodes.

Habanero using the [Slurm Workload Manager](https://slurm.schedmd.com/quickstart.html) for its queueing system. There are many ways to submit a job using Slurm. One of the most common ways is to create a bash script that outlines what cluster resources you would like to use and then lists the commands you'd like to execute. Consider this example file called `HelloWorld.sh`:
~~~bash
#!/bin/sh
#
# Simple "Hello World" submit script for Slurm.
#
# Replace <ACCOUNT> with your account name before submitting.
#
#SBATCH --account=edu            # The account name for the job.
#SBATCH --job-name=HelloWorld    # The job name.
#SBATCH -c 1                     # The number of cpu cores to use.
#SBATCH --time=1:00              # The time the job will take to run.
#SBATCH --mem-per-cpu=1gb        # The memory the job will use per cpu core.

echo "Hello World"
sleep 10
date
# End of script
~~~
We can submit this to the slurm with the  `sbatch` command:

~~~bash
(geo_scipy) [kwk2115@holmes ~]$ sbatch HelloWorld.sh
Submitted batch job 3571213
~~~
The `#SBATCH` directives in the shell script are commands that Slurm interprets. Here we listed the account to use (the edu account is our teaching account on Habanero), the job name (whatever you want to call it) and then a few parameters that specify what resources to use.

Below that are three simple shell commands that the script then executes. These shell script commands (echo and date) write to standard output in the terminal.  Any standard output will be written to a file called `slurm-<job #>.out.`

 My job ran right away and produced file ` slurm-3571213.out`:
~~~bash
(geo_scipy) [kwk2115@holmes ~]$ more slurm-3571213.out
Hello World
Tue Nov 21 08:22:01 EST 2017
~~~

Now let's try running a simple Python code. Create a file called `HelloWorld.py` that has the contents:

~~~python
print('Hello World')
a = 5
b = 6
c = a + b
print('The value of c is: ',c)
~~~

We can run this code using the batch script:

~~~bash
#!/bin/sh
#
# Simple "Hello World" submit script for Slurm.
#
# Replace <ACCOUNT> with your account name before submitting.
#
#SBATCH --account=edu            # The account name for the job.
#SBATCH --job-name=HelloWorld    # The job name.
#SBATCH -c 1                     # The number of cpu cores to use.
#SBATCH --time=1:00              # The time the job will take to run.
#SBATCH --mem-per-cpu=1gb        # The memory the job will use per cpu core.

python HelloWorld.py

# End of script
~~~
I saved that as script `HelloWorldPy.sh`.

Submit the shell script to Slurm:

~~~bash
(geo_scipy) [kwk2115@holmes ~]$ sbatch HelloWorldPy.sh
~~~


###  Running an MPI for Python job:

For our demonstration of running a `mpi4py` code, we will use the following code that simply has each process print its rank to standard output:

~~~python
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
print('Hello World, my rank is ',rank)
~~~
Save this as the file `HelloWorldMPI.py`.  

To run an MPI code, we need a slightly different batch script:
~~~bash
#!/bin/sh
#
# Simple "Hello World" submit script for Slurm.
#
# Replace <ACCOUNT> with your account name before submitting.
#
#SBATCH --account=edu            # The account name for the job.
#SBATCH --job-name=HelloWorld    # The job name.
#SBATCH -N 1                     # The number of nodes to use
                                 #(note there are 24 cores per node)
#SBATCH --exclusive                                 
#SBATCH --time=1:00              # The time the job will take to run.

source activate geo_scipy
mpirun -n 24 python HelloWorldMPI.py

# End of script
~~~
Save this as `HelloWorldMPI.sh` and submit it to Slurm:

~~~bash
(geo_scipy) [kwk2115@holmes ~]$ sbatch HelloWorldMPI.sh
~~~
When your job finishes, the `.job` file should have 24 lines of `Hello World, my rank is <rank>` where rank is the rank of each process. Notice that the statements are not in order. Although all the print statements execute at the same time, nothing in MPI requires them to be printed in  numerical order.

In the example above, we used all 24 cores available on the single node we requested. You could use fewer cores by changing the value after the `-n` command on the `mpirun` line. Note that it is also possible to accidentally  *oversubscribe*  a node. For example, if we instead used `-n 48`, MPI would create 48 processes and these would be competing for CPU time on the 24 cores available.

MPI does not prevent your from oversubscribing nodes, so its important that you make sure your job is sensible. The line `#SBATCH -N  <number of nodes>` specifies the number of nodes, and there are 24 cores per node on Habanero. So your ` mpirun -n <number of MPI processes>` line should specify a value that is equal to or less than the `24 x <number of nodes>.` For example, if we wanted to run on 96 cores, we would use the following script:
~~~bash
#!/bin/sh
#
# Simple "Hello World" submit script for Slurm.
#
# Replace <ACCOUNT> with your account name before submitting.
#
#SBATCH --account=edu            # The account name for the job.
#SBATCH --job-name=HelloWorld    # The job name.
#SBATCH -N 4                     # The number of nodes to use
                                 #(note there are 24 cores per node)
#SBATCH --exclusive                                 
#SBATCH --time=1:00              # The time the job will take to run.

source activate geo_scipy
mpirun -n 96 python HelloWorldMPI.py

# End of script
~~~

#### Time
The time argument tells Slurm that you job should use no more than the requested amount of time. In our examples above, we told it our job would only use 1 minute. Of course our simple command probably took less than a second to execute, but if we were instead running some complicated codes that required more than a minute, Slurm would kill our job at the minute mark. So for that case you will want to specify a longer run time. However note that the more nodes you request and the long run time you specify, the longer a wait your job may have in the Slurm queue (if there are lots of jobs in the queue).

### Monitoring jobs submitted to the Slurm queue

See [Habanero HPC Cluster User Documentation](https://confluence.columbia.edu/confluence/display/rcs/Habanero+HPC+Cluster+User+Documentation)

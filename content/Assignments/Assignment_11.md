Title: Assignment #11 - MPI for Python on Habanero
Summary: *Due: Tuesday, 30 November*
Date: 11/21/2017
tags: assignment
Category: assignments

**Due: Thursday, 30 November**

This purpose of this homework assignment is to get you more familiar with  MPI programming concepts and to run some parallel scaling tests of a code on the Habanero cluster.

Do the following:

### 1. Dust of your *alternating series* function from Assignment #3.

Your function should look something like this. Here we have added an explicit timer function using the `timeit`  module:

~~~python
from timeit import default_timer as timer

def alternating_harmonic_series(N):
    val = 0.
    for n in range(1, N+1):
        val += (-1)**(n+1) / n
    return val

start = timer()
N     = 100000
value = alternating_harmonic_series(N)
stop  = timer()

print(' Number of terms in series: ',N)
print(' Ending value of series: ',value)
print(' Elapsed time: ',stop-start)
~~~

Test that this serial version of the code works on your laptop. The printed value of the alternating series should be around 0.69314.

### 2. Create a parallel version of the alternating series code.
You can start from the serial code above, and just add a few lines of code to make it run in parallel. Here are some tips:

Your main code should get the MPI communicator size and rank of each processor using:

~~~python
comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()
~~~

These should be placed after the alternating series function and before `start = timer()`.

Pass in the process `rank` and `size` of the communicator to your function:

~~~python
def alternating_harmonic_series(N,rank,size):
    < details of  function code>
~~~

The function will be called by each parallel process (i.e., each rank). So you you need to modify  `range(1,N+1)`   to loop over a unique range for each parallel process. In other words, each parallel process will compute part of the sum, and then the results from each parallel process will be later added to give the total sum. See the next bullet point for how to do this.

On each process, set the starting value of the sum integer to be  `rank`+1 and the stride of the loop (aka the increment value) to be the `size` of the communicator. For example, if we use 4 processors, this means   the rank 0 process will compute the sum over values ***n = 1, 5, 9, 13...N*** while the rank 1 process will use  ***n = 2, 6, 10, 14...N***. You  should generalize this using the communicator `size`.

You will use `comm.Reduce()` to add the partial sum results (in `value`) from each process together on  the root (rank 0) process.  You will have to first convert `value` to an np.array since `comm.Reduce` will only work for np.arrays. For example use  `send_val = np.array(value,'d')`.   Then you will have a command that should be
`comm.Reduce(send_val,sum,op=MPI.SUM,root=0)` or similar, where the total sum is now in variable `sum`.

The parallel code should print out the same things as the serial code above. So modify the  code so that the timers and the print statements are only executed on the rank 0 process.  For example:

~~~python
if rank == 0:
  print(' Number of terms in series: ',N)
  <rest of commands>
~~~

Make sure the value of the sum agrees with your serial code when you run the MPI version using one processor.  When running on more processors, there will be small differences due to rounding errors in the reduction operations.

If you call your parallel code `alternatingSeriesMPI.py`, you can run it using the command below (where I'm using the 4 cores on my laptop):

~~~bash
$ mpirun -n 4 python alternatingSeriesMPI.py
~~~

### 3. Run the parallel alternating series code on Habanero.

But first test that it works on your laptop! Make sure that `sum`  after the `comm.Reduce` command agrees with your serial code (at least the first several digits should agree).

Remember to load the anaconda module after you ssh into Habanero:

~~~bash
$ module load anaconda/3-4.4.0
~~~

Set N=100000000 (that's 100,000,000) in the alternating series code.

Run it with the number of MPI processes varying from 1,2,3,6,12,24,48,96.  You can run it on 4 Habanero nodes and then specify the various number of processors to use using the `-n` argument with MPI. Here's what I used for the shell script `alternatingSeries.sh`:

~~~bash
!/bin/sh
#SBATCH --account=edu      
#SBATCH --job-name=AlternatingSeries    
#SBATCH -N 4
#SBATCH --exclusive
#SBATCH --time=5:00   

source activate geo_scipy

mpirun -n 1 python alternatingSeriesMPI.py
mpirun -n 2 python alternatingSeriesMPI.py
mpirun -n 3 python alternatingSeriesMPI.py
mpirun -n 6 python alternatingSeriesMPI.py
mpirun -n 12 python alternatingSeriesMPI.py
mpirun -n 24 python alternatingSeriesMPI.py
mpirun -n 48 python alternatingSeriesMPI.py
mpirun -n 96 python alternatingSeriesMPI.py
~~~

Note that you need to use the `#SBATCH --exclusive` directive above so that you have exclusive access to the `-N 4` nodes. The  4 compute nodes each have 24 processing cores, so you can run up to 96 MPI processes without oversubscribing the system.

Submit your script to the Slurm scheduler so that it runs on the cluster:

~~~bash
(geo_scipy) [kwk2115@holmes ~]$ sbatch alternatingSeries.sh
~~~

Save a table of the timer results for each MPI run that has [number_of_pocesses, time]. I ran the above script several times and noticed up to about 50% variability in the run times when `-n 48` and `-n 96` which implies some network latency issues since these larger jobs require two and four nodes communicating over the network. This isn't required, but if you want a more robust scaling test, you should run the script several times and then take the fastest times for each of the `-n` values used.

Use matplotlib to make a plot of the parallel run time scaling. So time on the y axis versus number of processes on the x axis. **Use log scaling for both the x and y axes.** Don't forget to label the axes.  


### 4. Upload to your github in a new folder called Assignment_11 with
- your python code
- the bash script you used on Habanero
- the time scaling plot.

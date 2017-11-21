Title: Assignment #11 - MPI for Python on Habanero
Summary: *Due: Tuesday, 28 November*
Date: 11/21/2017
tags: assignment
Category: assignments

**Due: Tuesday, 28 November**

This purpose of this homework assignment is to get you more familiar with  MPI programming concepts and to run some parallel scaling tests of a code on the Habanero cluster.

Do the following:

1. **Dust of your *alternating series* function from Assignment #3.** Add an explicit timer to your function using the `timeit` library.  Here's an example of how to record the time for a function call using `timeit`:
~~~python
from timeit import default_timer as timer

#...
# insert function definition here
#...

start = timer()

#...
# insert call to function here
#...

stop = timer()

print(' elapsed time: ',stop-start)

~~~

Test that this serial version of the code works on your laptop.

2. **Create a parallel version of the alternating series  code.**
Here are some tips:

- Your main code should get the MPI communicator size and rank of each processor using:
~~~python
comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()
~~~

- Your should pass in the process rank and size of the communicator to your function:
~~~python
def alternating_harmonic_series(N,rank,size):
    < details of  function code>
~~~

- You will parallelize the loop over ***n*** in the alternating series sum.  On each process, set the starting value of the sum integer to be  `rank`+1 and the stride of the loop (aka the increment value) to be the `size` of the communicator. For example, if we use 4 processors, this means   the rank 0 process will compute the sum over values ***n = 1, 5, 9, 13...*** while the rank 1 process will use  ***n = 2, 6, 10, 14...***. You could should generalize this using the communicator `size`.

- Use `comm.Reduce()` to compute the sum of the partial values from each process and save that on the root process.  

- The root process should print out the value N (the total number of terms in the sum) and the value of the sum. Make sure the values agrees with your serial code when you run the MPI version using one processor.  When running on more processors, there will be small differences due to rounding errors in the reduction operations.

- Add a timer on the rank 0 process. You code should have

~~~python
if rank == 0:
    start = timer()
~~~
and later on there should be a stop timer on the root process and a print statement that specifies the elapsed time as well as the `size` of the communicator.

3. **Run the parallel alternating series code on Habanero.**

- Run it for values of N=100,000,000 (that's 1 with 8 zeros afterward) for the number terms in the sum.
 - Run it with the number of MPI processes varying from 1,2,3,6,12,24,48,96. So you will run it on up to 4 Habanero nodes.
- Save a table of the timer results for each MPI run. So [number_of_pocesses, time].
- Use matplotlib to make a plot of the parallel run time scaling. So time (y axis) versus number of processes (x axis).

4. **Upload to github in folder Assignment 11**
- your python code
- the bash script you used on Habanero
- the time scaling plot. 

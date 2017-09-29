Title: Assignment #5 -  Fortran
Summary: *Due: Thursday, 5 October*
Date: 9/28/2017
tags: assignment
Category: assignments

**Due: Thursday, 5 October**



 **Matrix Multiplication**. In this example you will use Fortran to create two square matrices `A` and `B` with dimensions `n` x `n`. You will then use [matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication) to compute their product with the results being stored in matrix `C`. Thus, you will be computing the matrix equation `C = AB`. Note that matrix multiplication is different from element by element array multiplication. See the [wikipedia page](https://en.wikipedia.org/wiki/Matrix_multiplication) if you are unsure what matrix multiplication is.

**Part 1 - Analyze the problem**

For this part, list your answers in a plain text file called `answers_part1.txt` and submit that file to github in a new  folder named `assignment_5`.

1a) How many *megabytes* of RAM will be required to store matrices `A`,`B` and `C` in the computer's memory for a given matrix size `n`? State the formula.


1b) Element `C(i,j)` is equal to the sum of `A(i,k)*B(k,j)` over all values of index `k` from 1 to `n`.  How many multiplication operations does it take to compute the single element `C(i,j)`? How many addition operations does it  take to compute the single element `C(i,j)`?   

1c) Write down the code snippet for computing element `C(i,j)` using a `do` loop.  Assume i and j are given fixed values so you don't need to loop over i or j here.



1d) State the code for computing element `C(i,j)` where you use the intrinsic function `sum` instead of a `do` loop.



1e) Now state the code snippet for computing every element in matrix `C` using your answer from 1c) or 1d) as a starting point. You don't need to write down the entire Fortran program. Just state the part that performs the matrix product  `C = AB`.  


1f) How many total operations does it take to compute the matrix product  `C = AB`? State your answer as a single formula in terms of `n`.


1g) Simplify your result from 1f) by stating it using [big-O](https://en.wikipedia.org/wiki/Big_O_notation) notation. In big-O notation you just state the dominant term and ignore any constants. Write your answer as  O(`X`), where `X` is the dominant term.


1h) Big-O notation is used to classify the performance of an algorithm as a function of the size of the input `n`. Assume your matrix product algorithm will take time `t0` to run on your computer when `n=1`.  How long should it them take for `n=10,n=100,n=1000`?


1i ) If all elements of  `A` and `B` to have the value 1, what value should any element of `C` be?


**Part 2 - Write the code**

2) Now that you have all the pieces, write a Fortran program named `MatrixMultiply.f90` that computes `C=AB` for the `n x n` matrices `A,B,C`.  Your program should
  - Have a `write` and `read` statement pair that asks you to input the matrix size `n`
  - use an `allocate` statement to allocate matrices `A,B,C`
  - assign all elements of matrices `A` and `B` to have the value 1.
  - use the answer from exercise 1e) to carry out the matrix multiplication
  - use calls to `cpu_time()` before and after the do loops to assign the time it takes to compute `C=AB`. Save this time to a variable called `time`
  - write out the values of `n` and `time` to the shell in a user friendly form.
  - save the first ten rows and first five columns of `C` to a file called `C.txt`

**Part 3 - Analyze the results**

3a) Create a text file named `MatrixMultiplyTimers.txt` that lists the timing results for `n=10, n=100, n=1000` with columns for the values `n` and `time`.  

3b) Load `MatrixMultiplyTimers.txt` into MATLAB and plot `time` versus `n` on a log-log plot. Save the MATLAB figure to a file called  `MatrixMultiplyTimers.pdf`.

3c) Based on these results and the big-O scaling, how long do you think it would
take for `n=10000` and `n=100,000`. How much RAM would you need on your computer for these two cases?

**Part 4 - Turn it in**

Put all the files created for this assignment into a folder called assignment_5 and upload that folder to your github repository.  

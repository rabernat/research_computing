Title: Intro to Fortran
Summary:  Introduction to Fortran
Date: 9/28/2017
Tags: fortran
Category: lectures
Author: Kerry Key

Fortran is a powerful language for creating  fast and memory efficient codes for heavy numerical  computations. However, it is also a more verbose language than Python and MATLAB, so it generally will take you much longer to write Fortran codes compared to an equivalent code in Python and MATLAB. Also, unlike MATLAB and Python which can easily be run interactively, Fortran codes must be compiled before you can run them in a terminal shell. That makes debugging and testing a bit slower too.  Finally, Fortran doesn't have a built-in graphics library, so you can't interactively plot results like you can with MATLAB and Python. So with those points in mind, we recommend you stick to MATLAB and Python for you day-to-day scientific computing tasks. However,  Fortran is good when you have some computational problem where you need it to run as fast as possible, for example when it would take days to run on MATLAB or Python. Learning the basics of Fortran will also be useful for when you come across  Fortran codes that do some computational task you need and you  want to interface those codes with your own codes or you might want to modify them for your own research needs.



**Programs**

Fortran is a procedural language where you define a sequence of commands to execute in a program file. The program file is then compiled using a Fortran compiler. The compiler turns the program commands in the text file  into machine language instructions that will execute on the computer's CPU.  You  run the compiled code from a terminal shell.  

Let's begin by looking at a  simple example showing the basic workflow for using Fortran. Start by making  a plain text file named `HelloWorld.f90` that has the following content:
``` Fortran
program HelloWorld
  write(*,*) 'Hello world'
end program HelloWorld
```
Compile the code using the command
```  
$ gfortran HelloWorld.f90 -o HelloWorld
```
Run the code in the terminal using
```
$ ./HelloWorld
Hello World
```

A Fortran program has to have a single `program` file that lists the sequence of commands to execute. The program file has to start with the first command being the word `program` and it must end with the last command being the keyword `end`. The words `program HelloWorld` after the final   `end` statement aren't necessary, but they are a  useful organization construct for pointing out what exactly is ending, especially when your program file is very long and also contains subroutine and function code beneath the  `program` section.

**Compiling**

In the example above, we compiled the code by calling our compiler, here the *gfortran* compiler which is open source and freely available.  Intel's *ifort* compiler is a commercial compiler that is fairly ubiquitous, especially on cluster systems. For some codes, ifort can produce an executable that runs 10-20x faster than what gfortran produces.

To compile our HelloWorld.f90 code, we used the output flag `-o` and then listed the name we wanted to use for the compiled program that was output. Here we used HelloWorld for the name, but if for some (not recommended!) reason we wanted to name it MyProgram instead, we could compile it using
```  
$ gfortran HelloWorld.f90 -o MyProgram
```
If you don't specify `-o` and the output program name, then the compiler will by default name the program  `a.out`.

If there are any errors with your code, the compiler should let you know what the problem is. For example, try compiling the code below, which has an errant 'a' character:

``` Fortran
program HelloWorld
  write(*,*) 'Hello World'
a
end program HelloWorld
```
The compiler returns an error message:
```
$ gfortran HelloWorld.f90
HelloWorld.f90:3:0:

 a

Error: Unclassifiable statement at (1)
```
The statement `HelloWorld.f90:3:0:` specifies that the 'unclassifiable statement' is in file HelloWorld.f90 on line 3, column 0. It then prints out what is on that line (here the errant letter a). When there are errors in long and complicated Fortran codes, the first error the compiler finds can lead it to  other errors which stem from it not being able to interpret the code that had the first error. So if you get more than one error message when compiling a code, go fix the first listed error and try recompiling the code to see if the other errors are now gone.


**Comments**

Anything to the right of an exclamation point `!` in a Fortran code is considered a comment. For example a commented version of our HelloWorld.f90 program is
``` Fortran
!
! This program writes 'Hello world' to the shell.
! Version 0.1, September 27, 2017
!
program HelloWorld

!
! Send a message to the world:
!
  write(*,*) 'Hello world'

!
! All done, goodbye
!
end program HelloWorld
```

We haven't talked much about writing comments in your codes, but they are an essential part of good coding practice. You can use them to document what each section of a code does; this can be very helpful for when you return to a code you wrote a long time ago and are trying to remember what it does, or when you get someone else's code and are trying to understand what it does. You can also use code comments as an outline when first starting to write a long and complicated code. The comments can outline  the sequence of steps you intend the code to do. Once your outline is complete, you can start coding by filling in the necessary commands below each section of comments.

At a minimum, your code should have at least a few comments at the start of the text file that indicates what the codes does. This is also a place where you can add a date stamp and possibly a version number. You can also list the authorship of the code, which can be useful if it will be shared with other or is part of a collaborative effort .

**Variables**

Unlike MATLAB and Python, Fortran requires you to declare the type of each variable. For example, you need to declare whether a variable is an `integer`, `real`, `complex`, `logical` or `character`. Here is an example program declaring several different variable types:

``` Fortran
program VariableShowcase

implicit none

! Declare variables:
integer         :: i
real(8)         :: x
complex(8)      :: z
logical         :: bTest
character(32)   :: sFileName

i = 1
x = 1.0
z = cmplx(0.5,2.0)
bTest = .false.    ! logical types are .true. or .false.
sFileName = 'data.txt'

write(*,*) 'i: ', i
write(*,*) 'x: ', x
write(*,*) 'z: ', z
write(*,*) 'bTest: ', bTest
write(*,*) 'sFileName: ', sFileName

end program VariableShowcase
```
Compile and run this demo:
``` Bash
$ gfortran VariableShowcase.f90 -o VariableShowcase; ./VariableShowcase
```

Note that the variable declarations in Fortran have to be made at the start of the program (or subroutine or function), before any commands are made. Unlike Python, you can't declare a new variable in the middle of a sequence of commands.  If you try to, the compiler will throw an error message.

**Fortran is case insensitive**

Fortran is case insensitive, meaning that it will treat variables `x` and `X` as the same quantity.

| Fortran | Python | MATLAB|
|-------------|-------------|-------|
| case insensitive | case sensitive| case sensitive|


**Variable Precision**

`real(8)` declared above means a real variable that has 8 bytes (64 bits) of precision. This is what is known as [double precision](https://en.wikipedia.org/wiki/Double-precision_floating-point_format), which is  the default precision in MATLAB and Python.  You can also declare a lower or higher order precision (e.g. `real(4)` and `real(16)`) but you should only do this if you have a very good reason to do so. 99.99% of the time you should just use `real(8)` rather than (4) or (16). The `complex(8)` declaration means a complex number with 8 bytes of precision for each of the real and imaginary parts of the number. For integers, you typically  don't need to specify the precision and most of the time you can just use `integer` and then let the compiler assign the precision (usually either 4 or 8 bytes).

You can use the `huge()` intrinsic function to show the largest numbers that can be represented by each precision. For example, compile and run this code to see the largest possible values that can be represented by each numerical variable type:

``` Fortran
program PrecisionTest

implicit none

! Declare variables:
integer         :: i
integer(4)      :: i4
integer(8)      :: i8
real(4)         :: x4
real(8)         :: x8

write(*,*) 'integer:    ', huge(i)
write(*,*) 'integer:    ', huge(i)
write(*,*) 'integer(4): ', huge(i4)
write(*,*) 'integer(8): ', huge(i8)
write(*,*) 'real(4):    ', huge(x4)
write(*,*) 'real(8):    ', huge(x8)

end program PrecisionTest
```

In this tutorial I am using modern Fortran syntax to define the variables.  However, there are older ways of defining variables that you should be aware of since you may stumble across them. The older syntax does not use the `::` separator between the declaration and the list of variable names and has slightly different type names.   Most Fortran compilers support the older and modern syntax:

``` Fortran
! Old style Fortran variable types:
double precision      ! same as real(8)
real*8                ! same as real(8)
real*4                ! same as real(4)
double complex        ! same as complex(8)
complex*16            ! same as complex(8)
integer*4             ! same as integer(4)
```

**Integer Division**

Be careful when dividing integers in Fortran. For example, the expression `fraction = (N-1)/N` where `N` is an integer and `fraction` has been declared as `real(8)` will result in `fraction` being assigned the value 0. Why is this? Because all the terms in `(N-1)/N` are integers so the compiler uses integer division. You can easily fix this by making at least one of the terms in the expression a floating point number. Either of the following expressions will force the compiler to use floating point arithmetic and `fraction` will then be assigned the intended value:

``` Fortran
fraction = (N-1.)/N
```

``` Fortran
fraction = (dble(N)-1)/N
```

where the `dble()` function turns integer `N` into a double precision value.

**implicit none**

*You should always include the statement `implicit none` at the start of your Fortran codes (programs, subroutines and functions).*

By default, Fortran has a rather insidious implicit typing for variables that have certain first letters in their names.  Unless specified otherwise, all variables starting with letters I, J, K, L, M and N are default integers, and all others are default real. This can lead to nasty programming errors if you aren't careful. For example, consider the following code:


``` Fortran
program ImplicitTypeTest

ireal = 1.5   ! we want this to be a real number, but since the variable
              ! name starts with an i Fortran thinks its an integer.

write(*,*) 'ireal is: ', ireal

end program ImplicitTypeTest
```

Try running this program and you will see that it prints out ireal as the integer 1. If instead, you use `implicit none` at the start of this code, the compiler will issue an error because `ireal` was not yet declared.  If we had instead used `implicit none` at the start of the code, the compiler would have warned us that `ireal` was undeclared.

Here's another example where `implicit none` would help avoid getting the wrong result. Can you spot the error?  

``` Fortran
program TestUndeclared

real(8)  :: distance, velocity, time

time     = 2.0
velocity = 5.0

distance = velocity*times

write(*,*) 'distance: ', distance

end program TestUndeclared
```



**Relational operators**


| Older Fortran | Newer Fortran | Python | MATLAB|  Description |
|-------------|-------------|--------|-------|--------------|
| .eq. | == | == | == | equality|
| .ne. | /= | != | ~= | not equality |
| .lt. | < | < | < | less than |
| .le. | <= | <= | <= | less than or equal to |
| .gt. | > | > | > | greater than |
| .ge. | >= | >= | >= | greater than or equal to |
| .and. | .and. | and | &  | logical and |
| .or. | .or. | or |  \|  | logical or |
| .not. | .not. | not |  ~  | logical not |


``` Fortran
program TestRelationalOps

real(8) :: x,y,z
logical :: ltest1, ltest2, ltest3

x = 1.0
y = 2.0
z = 1.0

ltest1 = x < y
ltest2 = x == z
ltest3 = (ltest1.and.ltest2)

write(*,*) 'ltest1: ', ltest1
write(*,*) 'ltest2: ', ltest2
write(*,*) 'ltest3: ', ltest3

end program TestRelationalOps
```


**if statements**


These are similar to MATLAB and Python, except that  the logical or relational statements need to be in parentheses and you need to include the keyword `then` after the logical statement. The `if` statement also ends with the keyword `endif`.

``` Fortran
if (x < y) then
    write(*,*) 'x is less than y'
elseif (x > y ) then
    write(*,*) 'x is greater than y'
elseif (x == y ) then
    write(*,*) 'x equals y'
else
    write(*,*) 'this case should never be found'      
endif
```

**do loops**


Loops in Fortran are done using the `do` `enddo` construct:
``` Fortran
program DoLoopTest
implicit none

integer :: i, n

n = 10

do i = 1,n
  write(*,*) 'i is ', i
enddo

end program DoLoopTest
```
Note that unlike Python, you don't need to indent the commands inside the `do` `enddo` construct. However, it helps to make your code much more readable if you do indent the commands. Indenting is also super helpful if you loop has spans a page or more of code, since the indentation is a visual guide to the scope of the loop. Indenting is also helpful when you have nested loops. For example, both of these loops below are valid Fortran, but which one is easier to read?

``` Fortran
do i = 1,l
do j = 1,m
do k = 1,n
write(*,*) i,j,k
enddo
endo
enddo

do i = 1,l
  do j = 1,m
    do k = 1,n
      write(*,*) i,j,k
    enddo
  endo
enddo

```

You can change the increment for a do loop using the syntax `start,stop,increment`. Also, Fortran is like MATLAB where the loop is inclusive over the stop value. This is in contrast to Python, which is exclusive for the stop value (meaning Python counts up to but not including the stop value).

```Fortran
do i = 0,100,5
  write(*,*) i
enddo
```

**do while loops**

The `do while` loop is similar but instead of using a counter, it uses a logical variable to exit the loop.

``` Fortran
program DoWhileTest

implicit none

integer :: i, iCounter
logical :: lKeepGoing

lKeepGoing = .true.
iCounter   = 0

do while (lKeepGoing)

  iCounter = iCounter + 1
  write(*,*) 'iCounter: ',iCounter

  if (iCounter == 10 ) lKeepGoing = .false.

enddo
write(*,*) 'All done'

end program DoWhileTest
```

**arrays**

The modern way of declaring a fixed size array in Fortran is to use the `dimension()` keyword. For example:

``` Fortran
program TestArray

real(8), dimension(10) :: xArray
integer                :: i

do i = 1,size(xArray)
  xArray(i) = 5.0*i
enddo

write(*,*) 'xArray: ', xArray

end program TestArray
```

Arrays can have multiple dimensions, otherwise referred to as the rank of the array. The Fortran2008 standard allows up to rank 15, whereas the previous standard only allowed a maximum rank of 7. Here are some examples:

``` Fortran
real(8), dimension(10)          :: xArray1D
real(8), dimension(10,20)       :: xArray2D
real(8), dimension(10,20,10)    :: xArray3D
integer, dimension(10,5,30,50)  :: xArray4D
```

You can get the length or size of any dimension of the array using the `size(array,dim)` function where `dim` is an integer for the dimension you want to measure. For example we can write out the lengths of all four dimensions of `xArray4D` that was defined above using the commands:

``` Fortran
write(*,*) 'The four dimensions of xArray4D have lengths: ', size(xArray4D,1),size(xArray4D,2),size(xArray4D,3),size(xArray4D,4)
```
Note that that line is quite long, we can use the *continuation* character `&` to break that command into multiple lines using:
``` Fortran
write(*,*) 'The four dimensions of xArray4D have lengths: ', &  
& size(xArray4D,1),size(xArray4D,2),size(xArray4D,3),size(xArray4D,4)
```


**allocatable arrays**

The arrays above are fixed dimensional, meaning that we declared their sizes in the declaration statements.  A more flexible construct is the allocatable array. The arrays you have already seen in Python and MATLAB were allocatable arrays, but you didn't need to do anything special to create them. In Fortran you need to explicitly declare them using the `allocatable` keyword.

``` Fortran
integer                             :: m,n
real(8),dimension(:),   allocatable :: xArray1D
real(8),dimension(:,:), allocatable :: xArray2D

m = 5
n = 10

allocate(xArray1D(m))
allocate(xArray2D(m,n))
```

You can then assign values to the elements of the arrays.

If you need to free up memory later on in your program, you can `deallocate` the arrays:

``` Fortran
deallocate(xArray1D, xArray2D)
```
You can use the  `size` command to get their lengths in each dimension:

``` Fortran
write(*,*) size(xArray2D,1)   ! returns the size of the 1st dimension
write(*,*) size(xArray2D,2)   ! returns the size of the 2nd dimension
write(*,*) size(xArray2D)     ! returns the total number of elements (m*n in this example)
```

There is another type of array called an *automatic* array, but we won't discuss those until we get to the subroutine section below.


**Reading and writing data from the terminal**

We've already seen some writing commands in action in the code snippets above. Now lets look at reading and writing data in a little bit more detail.

``` Fortran
write(unit#, format, options) item1, item 2,...
read(unit#, format, options) item1, item2,...
```
The `unit#` is an integer which tells Fortran where to read or write teh data from. Standard Fortran reserves two unit numbers for I/O to user. They are:
``` Fortran
     UNIT = 5   for input from the keyboard with the READ statement

     UNIT = 6   for output to the screen with the WRITE statement
```
However, you can also use the asterisk `*` instead of having to specify units 5 and 6 and this will have the input and  output be done from the terminal shell. For example, to ask a question and read the answer, we can use

``` Fortran
program AskQuestion

real(8) :: number

write(*,*) 'What is your favorite number?'
read(*,*) number
write(*,*) 'You entered ', number

end program AskQuestion
```

**Reading and writing data from a file**

To read or write data from a file, you need to first open the file using the `open()` command. When you are done, you use the `close()` command. For example, to read data from an existing file:
``` Fortran
program FileReadTest

integer                            :: u, n
real(8), dimension(:), allocatable :: a,b

! Open the file:
open(newunit=u, file='log.txt', status='old')

! The first line of the file has the number of values for arrays a and b:
read(u,*) n

! Allocate the arrays:
allocate(a(n),b(n))

! Read in the values using an inline expression:
read(u, *) ( a(i), b(i), i = 1,n)

! or you could use a do loop:
! do i = 1,n
!   read(u, *) a(i), b(i)
! enddo
!

! Close the file:
close(u)

! Display the values:
do i = 1,n
    write(*,*) a(i), b(i)
enddo

end program FileReadTest

```
A few comments on this code. First, the Fortran2008 standard introduced the `newunit` keyword, which automatically creates a file unit number when you open a file. Here, the variable `u` is assigned the new unit number. In previous versions of Fortran, you has to pick a number (usually an integer between 10 - 100) and assign that as the file unit. It's much easier and better to have Fortran pick the number for you (like MATLAB and Python) and then you use that unit number for all read or write commands to the file, rather than having to refer to it by the filename each time. `status = 'old'` tells Fortran that the file exists already. This is optional, but can be helpful since if the file doesn't exist, Fortran will issue a helpful error message.

For the read commands, here we are using the asterisk `*` to denote a free-format read, which means that Fortran will decide what the format is.

Now lets look at writing to a file. Suppose the code above  modified the values in arrays `a` and `b`. We could then save the modified values to a new file using:

``` Fortran
open(newunit=u, file='newlog.txt', status='replace')
write(u, *) a, b
close(u)
```

If we want to append the values to an existing file, we could use:
``` Fortran
open(newunit=u, file='log.txt', position='append', status='old')
write(u, *) a,b
close(u)
```
**Format specifiers**

In all of our read and write examples above we used the generic `*` for the format specifier. When writing, Fortran will write out the full precision of each floating point number. For example: 0.65569999999999995.  You can use the format specifier to specify another format. We don't have time to go into the details of format specifiers here, but you can look them up online. In Fortran, they are often referred to as "edit descriptors". Here are a few examples:

``` Fortran
real(8) :: x

x = 1234.1234567890
write(*,*)  'the number is',x
write(*,'(a,1x,f6.1)')  'the number is',x
write(*,'(a,1x,e15.3)') 'the number is',x
```
`a` specifies character string output, `1x` means add a space and the others are for fixed point `f` and floating point format `e` with the format `w.d` where w is the width (number of characters) and d is the number of decimal places. Try them out.

**Functions**

You can define functions using the `function` keyword.  Functions are useful when you need to do a complicated calculation that has only one result.
 Functions need to be either in a separate .f90 file or have to be listed outside the main program. For example:

``` Fortran
program FunctionTest

implicit none

real(8) :: a,b,c,myFunction

a = 2.0
b = 5.0

c = myFunction(a,b)

write(*,*) 'c is: ', c

end program FunctionTest

!-----------------------------------
! This is the external function:
real(8) function myFunction(x,y)  

real(8) :: x,y
myFunction = x*y

end function myFunction
!-----------------------------------
```

**Subroutines**

Use a subroutine to break your code up unto various sections that are easier to read. Subroutines are like functions, but the I/O is all done as arguments after the subroutine name.

``` Fortran
program SubRoutineTest

implicit none

real(8) :: a,b,c,d

a = 2.0
b = 5.0

call subroutineA(a,b,c)  ! a and b are input, c is returned
call subroutineB(a,b,c,d)  ! a,b and c are input, d is returned
write(*,*) 'c is: ', c
write(*,*) 'd is: ', d

end program SubRoutineTest

!-----------------------------------
subroutine subroutineA(a,b,c)
implicit none
real(8), intent(in)  :: a,b
real(8), intent(out) :: c

c = a*b

end subroutine subroutineA
!-----------------------------------
subroutine subroutineB(a,b,c,d)
implicit none
real(8), intent(in)  :: a,b,c
real(8), intent(out) :: d

real(8)              :: x

x = 11d0

d = a + b + x*c

end subroutine subroutineB
!-----------------------------------
```


**Timing subroutine**

The `cpu_time()` function can be used to time sections of Fortran code.  The command `cpu_time(time)` returns the time in variable time. You need to difference two calls to this subroutine to get the time difference.

```Fortran
real(8)  :: time_start, time_end

...
call cpu_time(time_start)

... section of code to test goes in between ...

call cpu_time(time_end)

write(*,*) 'Time to run section of code:' , time_end - time_start, ' seconds'
```

**Modules**

Modern Fortran best practices are to put all subroutines and functions into one or more module files. A module file is similar to an object, if you are familiar with object oriented program. In a module you can define variables and all the actions that work on them. You can have public and private variables, subroutines and functions. Your main program can then use the modules. Variables defined at the top of a module are available to be used in any of the contained subroutines (so they are globally available).  Unfortunately we don't have time to cover modules, so look them up for more information.


**Compiler Optimization Flags**

You can specify an optimization flag when compiling a code and it will tell the compiler to spend time analyzing your code in order
to find ways to make the code run faster.  We don't have time to go into the details and all the possible optimization options, but in general using the optimization flag `-O2` results in a code that will run much faster.  You give the optimization flag right after specifying the compiler:

$ gfortran -O2 HelloWorld.f90 -o MyProgram

**Free and fixed form source code: the .f90 and .f extensions**

Modern Fortran uses a free form source code format and these files are specified by the .f90 extension.  The .f90 file extension is used for any codes adhering to the Fortran 2015, Fortran 2008, Fortran 2003, Fortran 95 or Fortran 90 standards.  

Prior to Fortran 90, Fortran was known as FORTRAN77 and used a fixed form file format specified with the .f and .for extensions. The fixed form came from the really old days when FORTRAN code was entered onto punch cards that were read by the earliest computers. Fix form  requires that you have 6 spaces at the start of each line before any commands. There is also maximum width of 72 characters for each line (including the 6 spaces). If you need extra space you can put any character in column 6 to indicate that line is a continuation of the previous line's commands.

Thankfully Fortran moved to using free form files with the .f90 extension. However, there is quite a bit of legacy code out there that is in the .f fixed format files.  

**Linking multiple object files**

We're out of time, so you will need to look this up online.

**Further Help**

The Fortran90 website is incredibly useful. Despite its name, it actually has recommendations for best practices that include commands up to the modern Fortran2008 standard. It also has a nice *Python Fortran Rosetta Stone* that will help Python experts translate Python commands into Fortran commands.

[http://www.fortran90.org/](http://www.fortran90.org/)

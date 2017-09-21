Title: Intro to MATLAB
Summary:  Introduction to MATLAB
Date: 9/21/2017
Tags: MATLAB
Category: lectures
Author: Kerry Key

Here we give an introductory tutorial to get you started with MATLAB. For further training, you can find more tutorials online. In particular, Mathworks, the company that owns MATLAB, has [an extensive suite of tutorials](https://matlabacademy.mathworks.com) on their website (you need to sign up for a free account to access them). There is also a good MATLAB tutorial at [Software Carpentry](
http://swcarpentry.github.io/matlab-novice-inflammation/).

**Command Window**

Open MATLAB. We will be mostly working in the Command Window and the Editor panels. The Command Window is similar to a Unix shell and to the iPhython shell. It is where you  enter MATLAB commands interactively and where MATLAB displays text output.  Some unix commands such as ``pwd ``  ``cd`` ``ls`` ``cp`` ``mv``  etc work in the command window.

Enter commands to the right of the prompt symbol ``>>``.  You can use MATLAB like a calculator. For example, type in an expression and then hit enter
```
>> 1 + 2.2
ans =
    3.2000
```
By default, MATLAB returns the value of this addition in the variable ans.  You can instead assign it to a variable

```
>> a = 1 + 2.2
a =
    3.2000
```
You can suppress the answer being printed out by terminating the expression with a semicolon
```
>> a = 1 + 2.2;
```
There are lots of ways to create expressions and assign the answer to a new variable, for example
```
>> a = 1;
>> b = 2;
>> c = a + b;
```

```
>> a = 1;
>> b = 2;
>> c = 3;
>> d = (a+b)*c
d =
     9
```

The various arithmetic, relational and logical operators in MATLAB can be found by typing ``help ops`` in the command Window
```
>> help ops

  Operators and special characters.

  Arithmetic operators.
    plus       - Plus                               +    
    uplus      - Unary plus                         +    
    minus      - Minus                              -    
    uminus     - Unary minus                        -    
    mtimes     - Matrix multiply                    *    
    times      - Array multiply                    .*    
    mpower     - Matrix power                       ^    
    power      - Array power                       .^    
    mldivide   - Backslash or left matrix divide    \    
    mrdivide   - Slash or right matrix divide       /    
    ldivide    - Left array divide                 .\    
    rdivide    - Right array divide                ./    
    idivide    - Integer division with rounding option.
    kron       - Kronecker tensor product   

  Relational operators.
    eq         - Equal                             ==     
    ne         - Not equal                         ~=     
    lt         - Less than                          <      
    gt         - Greater than                       >      
    le         - Less than or equal                <=     
    ge         - Greater than or equal             >=     

  Logical operators.
    relop      - Short-circuit logical AND         &&     
    relop      - Short-circuit logical OR          ||     
    and        - Element-wise logical AND           &      
    or         - Element-wise logical OR            |      
    not        - Logical NOT                        ~      
    punct      - Ignore function argument or output ~
    xor        - Logical EXCLUSIVE OR
    any        - True if any element of vector is nonzero
    all        - True if all elements of vector are nonzero

   ```

To see what variables are in the workspace, you can either view the Workspace Panel or simply type in ``whos`` in the Command Window.
   ```
>> whos
     Name      Size            Bytes  Class     Attributes

     a         1x1                 8  double              
     b         1x1                 8  double              
     c         1x1                 8  double              
     d         1x1                 8  double              
```

To clear a variable from the workspace, you can ``clear`` it

```
>> clear b
```

To clear all the variables from the workspace, use

```
>> clear all
```

This will clear all the variables and release the memory they were holding, which can be useful when you have been working with large vectors or matrices.

**Matrices and vectors**

MATLAB was designed originally for easy matrix and vector computations and linear algebra. Vectors and matrices can de defined using square brackets

Create a row vector:
```
>> a = [1 2 3 4];
```
Create a column vector be separating the rows with semicolons.
```
>> b = [5; 6; 7; 8];
```

You can compute a vector dot product using the ``*`` Operators
```
>> a*b
ans =
    70
```
However, this will only work if the vectors are compatible for linear algebra. One needs to be a row vector and the other a column vector and they have to have the same number of Element-wise
```
>>   length(a)
ans =
     4
>>   length(b)
     ans =
          4     
```
While ``length`` returns the number of elements in a vector, the ``size`` command is more general and gives the number of rows and columns.
```
>> size(a)
ans =
     1     4
```
This command is more useful when you assign the output to some variables
```
>> [nrows, ncols] = size(a)
nrows =
     1
ncols =
     4
```
A key sticking point for new MATLAB uses is to remember that ``*`` does vector (and also matrix) multiplication. To instead do array multiplication, use the ``.*`` operator. The vectors or matrices to be multiplied should have the same size (same number of rows and columns).

```
>> c = [9 10 11 12];
>> a.*c
ans =
     9    20    33    48
```
Similarly, you can raise the elements of an array to a power using the ``.^ `` Operators

```
>> a.^2
ans =
     1     4     9    16
```

Matrices are like vectors. Define them by rows, separating the columns using semicolons:

```
>> m = [ 1 2 3 4; 5 6 7 8]
m =
     1     2     3     4
     5     6     7     8
```
You can take the transpose of a matrix using the ``'`` operator or using the ``transpose`` function
```
>> m'
ans =
     1     5
     2     6
     3     7
     4     8
>> transpose(m)
ans =
     1     5
     2     6
     3     7
     4     8
```
You can add matrices
```
>> n = [9 10 11 12; 13 14 15 16]
n =
     9    10    11    12
    13    14    15    16
>> m+n
ans =
    10    12    14    16
    18    20    22    24
```     

You can create arrays of numbers using index notation

``` >> series = 1:10
series =
     1     2     3     4     5     6     7     8     9    10
```   
To change the spacing, using the notation ``start:spacing:stop``
```
>>  series = 1:2:20
series =
     1     3     5     7     9    11    13    15    17    19
```

**Slicing  vectors and matrices**
You can use indices to extract a slice from a matrix or vector
```
>> subset = series(1:4)
subset =
     1     3     5     7
```
You can use the keyword ``end`` to specify slicing all the way to the end rather than listing the specific index for the last value
```
>> subset = series(3:end)
subset =
     5     7     9    11    13    15    17    19
```
Matrices are easily sliced too:
```
>> msubset = m(2,3:4)
msubset =
     7     8
```

**linspace and logspace**

You can create arrays of evenly spaced numbers using the ``linspace`` and ``logspace`` functions.
```
>> linspace(-1,10,5)
ans =
   -1.0000    1.7500    4.5000    7.2500   10.0000
```
Type ``help linspace`` for more info.
```
>> logspace(-1,3,5)
ans =
   1.0e+03 *
    0.0001    0.0010    0.0100    0.1000    1.0000
```
Notice how the exponent of these numbers is shown.

**Help and Documentation**

You can type ``help <function name>`` into the command window if you know the name of the function. The MATLAB Documentation is also very helpful. Type ``doc`` into the Command Window to launch the Documentation browser.

**Strings**

Character strings in MATLAB are defined using single quotes:

```
>> clear all;
astring = 'hello world';
whos
  Name         Size            Bytes  Class    Attributes

  astring      1x11               22  char       
```
You can slice strings too
```
>> astring(1:5)
ans =
    'hello'
```



**Scripts**

You can create a script file containing MATLAB commands. This are known as m-files, since their name must end with the extension '.m'. You can then run the m-file in the command window, and MATLAB will read the file and execute the comands as if you had typed them into the command window at the prompt.

 Create an m-file called 'test.m' using the MATLAB editor. Paste this in for the contents
 ```
 str = 'hello world';
 disp(str);

a = [1 2 3 4];
b = 2*a;
disp(b)
 ```
Then in the command window run test.m:
```
>> ls
test.m

>> test
hello world
     2     4     6     8
```
This was just a simple script, but you can make much more complex scripts that read and write data, do complex operations and plot results in figures, etc.

**Functions**

MATLAB comes with a large number of built-in standard mathematical functions such as ``sin()``,``cos()``,``log()``,``log10()``,``exp()``, etc. You can find lists of all the built in mathematical  functions by looking in the Documentation browser.

You can also defined you own custom functions by creating function m-files. For example, create an m-file called myfunc.m with the contents
```
function y = myfunc(x)
  y = x.^2;
end
```
Then call it from the command window
```
>> x = [1:10];
>> y = myfunc(x);
>> disp(y)
     1     4     9    16    25    36    49    64    81   100
```
Functions can have more than one input and more than one output:
```
function [z,z2,x2,y2] = myfunc2(x,y)
  x2 = x.^2;
  y2 = y.^2;
  z2 = x2 + y2;
  z  = sqrt(z2);
end
```

**Loops**
In myfun2() above, we used array notation to deal with case when the inputs x and y are vectors or matrices. MATLAB is optimized to work fastest using array operations. However, sometimes it is inevitable that you need to use a ``for`` or ``while`` loop to carry out some operations. Here are two simple examples

```
clear x y
x = [1 2 3 4 5];
for i = 1:length(x)
  y(i) = x(i).^2;
end
disp(y)
```
Note that you do not need to indent the for loop code in MATLAB (but you do in Python). So the above could also be written as
```
clear x y
x = [1 2 3 4 5];
for i = 1:length(x); y(i) = x(i).^2; end
disp(y)
```
However, the indented code in the middle of the for-loop is easier to read and so we recommend that from a stylistic viewpoint.

You can define for loops on the command line, but typically they are best used in m-files.

Here's an example of a very simple while loop:
```
x = 0;
while x < 10
  x = x + 1;
  disp(x)
end

```
**Flow control**

You can control the flow of your code using an `if` statement. For example
```
if I == J
  A(I,J) = 2;
elseif abs(I-J) == 1
  A(I,J) = -1;
else
  A(I,J) = 0;
end
```
If you have more than two or three `if`,`elseif` conditions, it is better to use a `switch`:

```
method = 'Bilinear';
switch lower(method)
   case {'linear','bilinear'}
     disp('Method is linear')
   case 'cubic'
     disp('Method is cubic')
   case 'nearest'
     disp('Method is nearest')
   otherwise
     disp('Unknown method.')
end
```
Here method is a string and `lower(method)` converts it to lower case for use in the switch construct.

**Plotting**
```
x = linspace(0,10,100);
y = x.^2;
plot(x,y,'b-');
```
Plot two items on the same figure:
```
u = x.^3;
plot(x,y,'b-',x,u,'r-')
xlabel('x axis')
ylabel('y axis')
title('This is the title')
```
or you can add then sequentially using the `hold` command
```
figure;
plot(x,y,'b-');
hold on;
plot(x,u,'r-')
plot(x,u,'ro')
plot(x,y,'b.');
xlabel('x axis')
ylabel('y axis')
title('This is the title')
legend('y','u')
```

Some other useful plotting commands:

```
surf(x,y,z)
pcolor(x,y,z)
semilogx(x,y)
semilogy(x,y)
loglog(x,y)
subplot(m,n,p)
```


**Structures**

**Reading and writing data**

**Working with time and dates**

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
```matlab
>> 1 + 2.2
ans =
    3.2000
```
By default, MATLAB returns the value of this addition in the variable ans.  You can instead assign it to a variable

```matlab
>> a = 1 + 2.2
a =
    3.2000
```
You can suppress the answer being printed out by terminating the expression with a semicolon
```matlab
>> a = 1 + 2.2;
```
There are lots of ways to create expressions and assign the answer to a new variable, for example
```matlab
>> a = 1;
>> b = 2;
>> c = a + b;
```

```matlab
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

```matlab
>> whos
     Name      Size            Bytes  Class     Attributes

     a         1x1                 8  double              
     b         1x1                 8  double              
     c         1x1                 8  double              
     d         1x1                 8  double              
```

To clear a variable from the workspace, you can ``clear`` it

```matlab
>> clear b
```

To clear all the variables from the workspace, use

```matlab
>> clear all
```

This will clear all the variables and release the memory they were holding, which can be useful when you have been working with large vectors or matrices.

**Matrices and vectors**

MATLAB was designed originally for easy matrix and vector computations and linear algebra. Vectors and matrices can de defined using square brackets

Create a row vector:
```matlab
>> a = [1 2 3 4];
```
Create a column vector be separating the rows with semicolons.
```matlab
>> b = [5; 6; 7; 8];
```

You can compute a vector dot product using the ``*`` Operators
```matlab
>> a*b
ans =
    70
```
However, this will only work if the vectors are compatible for linear algebra. One needs to be a row vector and the other a column vector and they have to have the same number of Element-wise
```matlab
>>   length(a)
ans =
     4
>>   length(b)
     ans =
          4     
```
While ``length`` returns the number of elements in a vector, the ``size`` command is more general and gives the number of rows and columns.
```matlab
>> size(a)
ans =
     1     4
```
This command is more useful when you assign the output to some variables
```matlab
>> [nrows, ncols] = size(a)
nrows =
     1
ncols =
     4
```
A key sticking point for new MATLAB uses is to remember that ``*`` does vector (and also matrix) multiplication. To instead do array multiplication, use the ``.*`` operator. The vectors or matrices to be multiplied should have the same size (same number of rows and columns).

```matlab
>> c = [9 10 11 12];
>> a.*c
ans =
     9    20    33    48
```
Similarly, you can raise the elements of an array to a power using the ``.^ `` Operators

```matlab
>> a.^2
ans =
     1     4     9    16
```

Matrices are like vectors. Define them by rows, separating the columns using semicolons:

```matlab
>> m = [ 1 2 3 4; 5 6 7 8]
m =
     1     2     3     4
     5     6     7     8
```
You can take the transpose of a matrix using the ``'`` operator or using the ``transpose`` function
```matlab
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
```matlab
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

```matlab
>> series = 1:10
series =
     1     2     3     4     5     6     7     8     9    10
```   
To change the spacing, using the notation ``start:spacing:stop``
```matlab
>>  series = 1:2:20
series =
     1     3     5     7     9    11    13    15    17    19
```

**Slicing  vectors and matrices**
You can use indices to extract a slice from a matrix or vector
```matlab
>> subset = series(1:4)
subset =
     1     3     5     7
```
You can use the keyword ``end`` to specify slicing all the way to the end rather than listing the specific index for the last value
```matlab
>> subset = series(3:end)
subset =
     5     7     9    11    13    15    17    19
```
Matrices are easily sliced too:
```matlab
>> msubset = m(2,3:4)
msubset =
     7     8
```

**linspace and logspace**

You can create arrays of evenly spaced numbers using the ``linspace`` and ``logspace`` functions.
``` matlab
>> linspace(-1,10,5)
ans =
   -1.0000    1.7500    4.5000    7.2500   10.0000
```
Type ``help linspace`` for more info.
``` matlab
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

``` matlab
>> clear all;
astring = 'hello world';
whos
  Name         Size            Bytes  Class    Attributes

  astring      1x11               22  char       
```
You can slice strings too
``` matlab
>> astring(1:5)
ans =
    'hello'
```



**Scripts**

You can create a script file containing MATLAB commands. This are known as m-files, since their name must end with the extension '.m'. You can then run the m-file in the command window, and MATLAB will read the file and execute the comands as if you had typed them into the command window at the prompt.

 Create an m-file called 'test.m' using the MATLAB editor. Paste this in for the contents:  
``` matlab
str = 'hello world';
disp(str);

a = [1 2 3 4];
b = 2*a;
disp(b)
```
Then in the command window run test.m:
``` matlab
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
~~~ matlab
function y = myfunc(x)
  y = x.^2;
end
~~~
Then call it from the command window
~~~ matlab
>> x = [1:10];
>> y = myfunc(x);
>> disp(y)
     1     4     9    16    25    36    49    64    81   100
~~~
Functions can have more than one input and more than one output:
``` matlab
function [z,z2,x2,y2] = myfunc2(x,y)
  x2 = x.^2;
  y2 = y.^2;
  z2 = x2 + y2;
  z  = sqrt(z2);
end
```

**Loops**
In myfun2() above, we used array notation to deal with case when the inputs x and y are vectors or matrices. MATLAB is optimized to work fastest using array operations. However, sometimes it is inevitable that you need to use a ``for`` or ``while`` loop to carry out some operations. Here are two simple examples

``` matlab
clear x y
x = [1 2 3 4 5];
for i = 1:length(x)
  y(i) = x(i).^2;
end
disp(y)
```
Note that you do not need to indent the for loop code in MATLAB (but you do in Python). So the above could also be written as
``` matlab
clear x y
x = [1 2 3 4 5];
for i = 1:length(x); y(i) = x(i).^2; end
disp(y)
```
However, the indented code in the middle of the for-loop is easier to read and so we recommend that from a stylistic viewpoint.

You can define for loops on the command line, but typically they are best used in m-files.

Here's an example of a very simple while loop:
``` matlab
x = 0;
while x < 10
  x = x + 1;
  disp(x)
end

```
**Control flow**

You can control the flow of your code using an `if` statement. For example
``` matlab
if I == J
  A(I,J) = 2;
elseif abs(I-J) == 1
  A(I,J) = -1;
else
  A(I,J) = 0;
end
```
If you have more than two or three `if`,`elseif` conditions, it is better to use a `switch` command
sequence:

``` matlab
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
Here method is a string and `lower(method)` converts it to lower case for use in the switch construct. Notice
has the first `case` has two strings; if either is matched, that case is executed. You can also use numeric values and mix them with strings (e.g., `case{1,2,3,'one','two','three'}`).   

**Plotting**
``` matlab
x = linspace(0,10,100);
y = x.^2;
plot(x,y,'b-');
```
Plot two items on the same figure:
``` matlab
u = x.^3;
plot(x,y,'b-',x,u,'r-')
xlabel('x axis')
ylabel('y axis')
title('This is the title')
```
or you can add then sequentially using the `hold` command
``` matlab
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

``` matlab
surf(x,y,z)
pcolor(x,y,z)
semilogx(x,y)
semilogy(x,y)
loglog(x,y)
subplot(m,n,p)
```
Once you create a plot figure, you can add more plots to it by using the `hold on` command. If you don't use the hold command, MATLAB will erase the previous plot.

There are many commands for changing the appearance of your plots, depending on the particular plot type. Here are a few that are pretty commonly used (look them up in the documentation for further info):
``` matlab
xlabel
ylabel
zlabel
title
shading
colormap
colorbar
caxis
axis
```

The `figure` command creates a new figure. When you have lots of figures, it can be helpful to create variables that refers to each figure:
``` matlab
hFigure1 = figure;
% insert plot commands here

hFigure2 = figure;
% insert more plot commands here
```
Here variables `hFigure1` and `hFigure2` are handle variables that refer to the two figures. After creating the figures, type `hFigure1` into the command window. Here you will see the hidden world of all the possible settings you can specify for a figure's appearance. You can also create variables that refer to particular plot axes (created with `subplot`) as well as variables for each plot object (line, points, surfaces, etc). All of these have attributes that control their appearance. We don't have time to cover them in class, but you can dig deep into the documentation to figure out how to customize their appearances.

**Saving figures**
There are a few ways to save figures. You can use the buttons in the figure's menu bar to adjust its size on the printed page (or you can do this using the figure's handle variable mentioned above) and then to save it to a file. However, for programming, its generally better to use commands in your codes to automatically save the figure. The easiest command is `saveas(H,'FILENAME','FORMAT')`. Here are a few examples where we will save the figure with handle variable hFigure 1 (as created above):
``` matlab
saveas(hFigure1,'myFigure','fig')
```
This will save the figure in MATLAB's .fig format. You can click on the figure and it will reopen, allowing you to use MATLAB to continue interacting with the figure (i.e., adding stuff to it or changing its appearance).

If you  want to print the figure, you can specify an image format such as one of these.
``` matlab
saveas(hFigure1,'myFigure','jpg')
saveas(hFigure1,'myFigure','png')
saveas(hFigure1,'myFigure','pdf')
```
There are many other formats, see the help for `saveas` and `print` commands. The PDF format is useful since it stores the graphics in a vector image format, allowing you to later use software like Adobe Illustrator to fine tune the appearance if desired. However, I recommend learning how to control the plot appearance using you MATLAB scripts to, e.g., change the line width and color, marker size and color, etc so that you don't need to do anything else in graphical design software later.  The other formats such as jpg and png create bitmapped images where the graphical objects get turned into pixels, so you can't later edit their appearance.


**Structures**

Structures in MATLAB are a construct for grouping many variables together into a single object. You can define a structure two different ways
``` matlab
S =   struct('field1',VALUES1,'field2',VALUES2,...)  
```
or
``` matlab
S.field1 = VALUES1;
S.field2 = VALUES2;
...
```
How are structures useful? Consider this example. Suppose you have a complicated set of data that has many different attributes. For example the main data is the variable `data`, which is some measured quantity of interest. However, in addition to `data`, you might have lots of meta-data that describes the data collection method, location, and other related variables such as the latitude and longitude of the data collection, time, date, temperature, elevation, instrument name, sensor ID number, etc. You get the idea. You could define a variable for each of these quantities. However, if they are normal variables, you will have to keep track of all of them. For example suppose you read them in and then want to pass them to a function, you would have to have a code similar to this
``` matlab
...
[data, latitude, logitude, time,date,temperature,elevation,instrument_name, ...
sensor_ID] = readMyData(fileName);

results = processData(data, latitude, logitude, time,date,temperature,elevation,instrument_name, ...
sensor_ID);
...
```
Now suppose you instead read these variables into a structure

``` matlab
function S = readData(fileName);
% ... commands to open file and read in the variables...
%...

% Then assign to structure:
S.data = data;
S.latitude = latitude;
S.latitude = latitude;
S.logitude = logitude;
S.time    = time;
...
```
Now your main code will be much more readable:

``` matlab
S = readMyData(fileName);

results = processData(S);
```
So you can think of structures as being like a box that you use to hold onto a collection of variables. Then instead of passing each variable to a function one at a time, you instead can just pass the box that holds all of them.

**Reading and writing data**

The save command will save variables to a file. Here are some examples from the documentation:
``` matlab
% Save all variables from the workspace to test.mat:
    save test.mat

    % Save two variables, where FILENAME is a variable:
    savefile = 'pqfile.mat';
    p = rand(1, 10);
    q = ones(10);
    save(savefile, 'p', 'q');

    % Save the fields of a structure as individual variables:
    s1.a = 12.7;
    s1.b = {'abc', [4 5; 6 7]};
    s1.c = 'Hello!';
    save('newstruct.mat', '-struct', 's1');
```
By default, MATLAB will save using its own binary .mat format. You can instead save as an ascii text file using the `'-ascii'` option. See the help for further details.

The `load` command is used to read in a data file in MATLAB's .mat format. It will also work to load in ascii text files as long as they only have numbers in them and are either a simple vector or matrix.Here are some examples from the documentation:
``` matlab
  gongStruct = load('gong.mat')      % All variables
  load('handel.mat', 'y')            % Only variable y
  load('accidents.mat', 'hwy*')      % Variables starting with "hwy"
  load('topo.mat', '-regexp', '\d')  % Variables containing digits

  % Using command form
  load gong.mat
  load topo.mat -regexp \d
  load 'hypothetical file.mat'       % Filename with spaces
```      

`xlsread` will read in an excel spreadsheet.

You can also write you own custom code to read in more complicated data file formats. See the help for commands `fopen`,`fclose`,`fgets`,`fscanf`,`sscanf` to get started. Likewise, there are custom commands you can use to write data to files using your own custom format.

**Working with time and dates**

MATLAB has some built-in functions that are helpful for working with times and dates.

`datenum` is a command that converts a date into a serial date
 	numbers N.  A serial date number of 1 corresponds to Jan-1-0000.  
 	The year 0000 is merely a reference point and is not intended to be
 	interpreted as a real year.  Examples:
``` matlab
  n = datenum('19-May-2000')                % returns n = 730625.
  n = datenum(2001,12,19)                   % returns n = 731204.
  n = datenum(2001,12,19,18,0,0)            % returns n = 731204.75.
  n = datenum('19.05.2000','dd.mm.yyyy')    % returns n = 730625.
```
  Why is this useful? It is useful since now the time and date has been converted into a single number that you can perform operations on (add, subtract, compare, etc).  The command `now` returns the current time and date as a datenum.

  You can then convert a datenum into a string using the `datestr` command:
``` matlab
  n = now;
  datestr(n)
  datestr(n,1)
  datestr(n,13)
```
  See the documentation for `datestr` for futher info.  

  If you plot a time series using a datenum vector for the x-axis, you can use the `datetick` command to get nicely formatted time stamps on the x-axis labels.

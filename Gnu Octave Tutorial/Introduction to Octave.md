# About 

GNU Octave is named after the chemist Octave Levenspiel and has nothing to do with music
and harmonic waves. The project was started by James B. Rawlings and John G. Ekerdt, but
it has mainly been developed by John W. Eaton, who has put a lot of effort into the project.
GNU Octave is an official GNU project (hence, the GNU prefix), and the source code is
released under the GNU General Public License (GPL). 

# What is Gnu Octave 

Gnu Octave is a multi functional tool for sophisticated numerical analysis. Gnu Octave provides you with the following  :
1. Large set of built in functionalities to solve many type of different problems.
2. Plotting facilities 
3. MATLAB compatible (except some cases)

### Little comparison between MATLAB and Octave :

Matlab is both interpreted and complied language , depending on the context.
*  When you run a .m script  or a function in MATLAB , it is interpreted line by line by the MATLAB engine.
* This is common during development  - quick testing , prototyping etc.
* While using the MATLAB compiler the code is compiled to executable.
* While using the MATLAB coder the code is compiled to C/C++ 

On the other hand GNU Octave is primarily an interpreted language, its much like the base which is MATLAB but with some nuances. Most .m files in Octave are interpreted line-by-line during execution. This applies to both the signal and the functions. 

# LIMITATIONS of OCTAVE 
Octave is mainly designed to perform numerical computations and is not meant to be
a general purpose programming language such as C or C++. As it is always the case, you
should choose your programming language depending on the problem you wish to solve.
Nevertheless, Octave has a lot of functionality that can help you with, for example, reading
from and writing to files, and you can even use a package named sockets for accessing a
network directly.

The fact that Octave uses an interpreter means that Octave first has to convert the
instructions into machine readable code before executing it. This has its advantages as
well as drawbacks. The main advantage is that the instructions are easy to implement
and change, without having to go through the edit, compile, and run phase and gives the
programmer or user a very high degree of control. The major drawback is that the program
executes relatively slowly compared to pre-compiled programs written in languages such
as C or Fortran. Octave is therefore perhaps not the first choice if you want to do extremely
large scale parallelized computations, such as state-of-art weather forecasting.

However, as you will experience later in the book, Octave will enable you solve very
advanced and computationally demanding problems with only a few instructions or
commands and with satisfactory speed. The last chapter of this book teaches you some
optimization techniques and how you can use C++ together with Octave to speed things up
considerably in some situations.

Octave is not designed to do analytical (or symbolic) mathematics. For example, it is not
the best choice if you wish to find the derivative of a function, say f (x) = x2. Here software
packages such as Maxima and Sage can be very helpful. It should be mentioned that there
exists a package (a package is also referred to as a toolbox) for Octave which can do some
basic analytical mathematics.

# Octave and MATLAB

It is in place to mention MATLAB. Often Octave is referred to as a MATLAB-clone (MATLAB
is a product from MathWorksTM). In my opinion, this is wrong! Rather, Octave seeks to be
compatible with MATLAB. However, be aware, in some cases you cannot simply execute your
Octave programs with MATLAB and vice-versa. Throughout the book, it will be pointed out
where compatibility problems can occur, but we shall stick with Octave and make no special
effort to be compatible with MATLAB.
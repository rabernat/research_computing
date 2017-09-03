Title: Fortran
Summary: 
Date: 9/2/2017
tags: fortran


## Installing Fortran

 
#### OS X:

Download the  installer package from <a href=" https://gcc.gnu.org/wiki/GFortranBinaries/"  target="_blank">  https://gcc.gnu.org/wiki/GFortranBinaries/  </a> 

Make sure you follow the instructions in the file Readme.html that comes with the installer.
 You will need to install Apple's Xxode software and the Xcode command-line tools BEFORE installing gfortran (see instructions in the Readme.html file).

#### Linux:
Download and install the appropriate package for your Linux distribution. See 
 <a href=" https://gcc.gnu.org/wiki/GFortranDistros/"  target="_blank">  https://gcc.gnu.org/wiki/GFortranDistros/ </a> 

#### Windows:
 
 In the Cygwin environment, download and install the gcc-fortran package.

## Sample Code
 

 

``` fortran
program example

    implicit none
    integer :: i,j,k   
    real(8) :: x,y,z

    i = 1
    j = 2
    k = i + j
    
    write(*,*) 'k = ', k
    
! Comments in Fortran begin with a "!"    

    x = 1.8
    y = 2.4
    z = x + y    ! this is another comment
    
    write(*,*) 'z = ', z
 
end program
```

##   Online resources

* <a href=" http://fortranwiki.org/fortran/show/HomePage"  target="_blank"> Fortran Wiki </a> 
* <a href="https://stackoverflow.com/questions/tagged/fortran"  target="_blank"> Stack Overflow Fortran  </a> 

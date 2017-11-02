Title: Assignment #9 -  Map Making and GeoMapApp
Summary: *Due: Thursday, 9 November*
Date: 11/02/2017
tags: assignment
Category: assignments

**Due: Thursday, 9 November**


**Part 1. Extract a topography profile from GeoMapApp and analyze the slope**

1a. In GeoMapApp, use the "Distance/Profile Tool" to extract a topography profile from (-159.3E, 52.2N) to (-160.8E, 55.0N). Your profile should be crossing the Aleutian-Alaskan subduction zone trench.  Make sure you are using a "great circle" and not a straight line.

1b. Save the profile data (position and height) to an ASCII file named "AASZ_topo.txt".  

1c. Load the data into either MATLAB or Python. Create a 2 x 1 subplot grid.  The top plot should show the topography as a function of position (like what you saw in GeoMapApp). The bottom plot should show the seafloor slope as a function of position, where ***slope is shown in units of degrees***. For this you will need to compute the slope by first computing the derivative dz/dx using a first order finite difference approximation. In other words you will be differencing neighboring z values to approximate dz, and differencing neighboring position values to approximate dx, then  using: dz./dx. Make sure you keep track of the units of all variables and convert to other units when necessary, and that your final slope angles are reasonable.

1d. Save the figure to a file named AASZ_topo_slope.pdf.


**Part 2. Use GMT to make a topography map showing the USarray seismic station locations**

2a. In GeoMapApp, zoom the map so that you have a nice view of the entire continental US (i.e., the contiguous lower 48 states PLUS Alaska) and not much else. Hit the "Load/Unload GMRT Grid" button so that it loads the GMRT grid data.

2b. Save the grid file as a netCDF-3 .nc file. Call it "us.nc".

2c.  Download this list of all the USArray Transportable Array seismic stations: http://ds.iris.edu/files/earthscope/usarray/_US-TA-StationList.txt

2d. Create a GMT bash script that plots the shaded topography data and  shows the USArray station locations as small circles that are color coded by their start year.

Here are some tips:

  - use `grdgradient` on the file `us.nc` to create a gradient file that will be used to shade the topography
  - use `grdimage` to plot the shaded topography
  - use `psscale` to add a color scale to the plot
  - These first three steps will be nearly identical to the intro to GMT tutorial lecture, so reviewing those notes is a good starting place. I recommend you use either the `topo` or `relief` color palettes so that the  land and sea are clearly differently colored.
  - add the national boundaries to the map using `pscoast`
  - add the US state boundaries to the map using `pscoast`. Perhaps using a thinner line so that the map isn't too cluttered.
  - Their are many ways to plot the station locations by color. You could use the Unix skills  learned early in this course to parse the relevant parts of the txt file, or you can try using the cryptic `-i` and `-h` arguments with the `psxy` command (see the Japan earthquakes example in section 3 here for tips on this:  [GMT Tutorial](http://gmt.soest.hawaii.edu/doc/5.4.2/GMT_Tutorial.html). )
  - add a legend that shows which color corresponds to which year.
  - Save your figure as the file `USArray.pdf`




**Turn it in**

Put all the files created (codes and PDF figures) for this assignment into a folder called assignment_9 and upload that folder to your github repository.  

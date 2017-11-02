Title: Introduction to Generic Mapping Tools (GMT)
Summary:  Intro to GMT
Date: 10/31/2017
Tags: GMT
Category: lectures
Author: Kerry Key

This lecture is modified from a small subset of the material on the official GMT tutorial, which can be found here: [GMT Tutorial](http://gmt.soest.hawaii.edu/doc/5.4.2/GMT_Tutorial.html).

**Intro**

Today's lecture focuses on GMT, also known as the Generic Mapping Tools software.  GMT was invented by two LDEO graduate students in 1988, Paul Wessel and Walter H.F. Smith. GMT can do a wide range of functions, including reading and plotting data, but its most unique and powerful use today lies in its ability to create sophisticated map projections and visualizations.  Since plotting data is now quite simple to do with MATLAB and Python, we will instead  concentrate here on the versatile mapping functions available in GMT.

GMT is a Unix based suite of software tools and we will interact with it through a command shell, just like how we interacted with the Unix commands earlier in this course.  




**Setup**

You should have obtained the Documentation folder when you downloaded GMT. It has the following contents

* copying
* examples
* html
* pdf
* supplements
* tutorial

The `html` and `pdf` folders contain the GMT documentation. A PDF file with the complete GMT_Tutorial can be found in the `pdf` folder.   We will be working with items in the `tutorial` directory. I recommend you make a copy of that directory and work in the copy rather than the original.

Open the GMT 5.4.2 app and it will launch a new terminal shell. Then cd to the Documentation folder and make the copy:

~~~
$ cp -R tutorial tutorial_copy
$ cd tutorial_copy
~~~
Note that the -R tells `cp` to recursively copy the folder.



**Workflow**

The typical GMT workflow consists of inputing optional files to GMT, such as an ascii or binary table of data or a gridded data set (e.g., topography or other surfaces). GMT will then process the file, depending on your sequence of GMT commands, and then it will output one or more files. Typically you will have it output a postscript (.ps) or .pdf plot file, but you can also use GMT to re-grid or reformat data files, so sometimes it will just output the re-gridded or processed data files, depending on how you use it.

We will use a few Unix common commands like file redirection, piping and wildcards when constructing our GMT scripts.

**Help**

The GMT online web documentation is a great resource for learning GMT commands. There you can find help pages for particular GMT commands. However, the help pages can be overwhelming since they tell you every possible option for each command. It is often helpful enough to just see a command in use in a script.  I highly recommend that you check out the *Gallery* and *Cookbook* sections in the online documentation since they contain tons of examples. Look through the images to find one that is similar to what you'd like to do, and then click in the link to see the associated GMT commands used to create the plot.

You can also learn more about GMT commands from within the GMT shell. For example
~~~
$ gmt --help
~~~
lists all available GMT commands. Help for a given GMT module is listed with the commands
~~~
$ gmt <module_name> --help
~~~
where `<module_name>` should be replaced with the specific module's name.


**Simple Plotting**

The most essential part of making a map plot is the projection used to convert the positions, which are locations on the surface of a sphere, into a flat representation.  GMT supports a huge number of [map projections](http://gmt.soest.hawaii.edu/doc/5.4.2/proj_codes_GMT.html). We will look at a small number of them here.

Typically, a GMT command has a calling sequence that looks like this:
~~~
$ gmt <module_name>  <options>  >  outputFileName.ps
~~~
where `<module_name>` lists the specific GMT command to invoke, and `<options>` lists any required and optional arguments. While GMT is very powerful, it has an overwhelming plethora of options that can be quite daunting to new users. Again, learning by example is often easier than consulting the documentation, at least when you're just beginning.  For reference, here's a link to a nice place to look up some of the [standard options](http://gmt.soest.hawaii.edu/doc/5.4.2/std_opts.html).  

The ` >  outputFileName.ps` part uses the Unix redirection symbol `>` to tell GMT to output the results to the file named outputFileName.ps. Which is a poscript format file (an early vector graphics file that was a precursor to the PDF format).  

To create a basic map plot, you use the `psbasemap` command, which is shorthand for "postscript base map". For example, run the command:
~~~
$ gmt psbasemap -R10/70/-30/30 -JX4i/3i -Ba -P > GMT_tut_1.ps
~~~
You can view the results by opening the file by clicking on it, or by typing `open GMT_tut_1.ps` in the shell.

Here we've used four common standard options: `-R,-J,-B,-P`.  

***-R***  specifies the region of interest to plot, with the syntax `-Rxmin/xmax/ymin/ymax`.  Typically `xmin` and `xmax` would specify the minimum and maximum longitudes and `ymin` and `ymax` would specify the minimum and maximum latitudes.

***-J*** specifies the map projection to use and has syntax `-JXwidth[/height]`. Here `-JX` means to use a generic cartesian plot (i.e., a non-geographic projection). We've specified to make the plot 4 inches wide and 3 inches tall by stating `-JX4i/3i`.

***-B*** specifies the annotations to use on the plot axes. Here we used `-Ba` where the `a` tells GMT to automatically determing the best annotations.
Now try a more advanced version of the command, using
~~~
$ gmt psbasemap -R10/70/-30/30 -JX4i/3i -Ba -B+glightred+t"My first plot" -P > GMT_tut_1.ps
~~~
Here the additional `-B` arguments tell GMT to fill the axes (`+g`) with a `lightred` color and to make the title (`+t`) be `"My first plot"`.  See the help for a detailed explanation and the onslaught of other possible options for `-B`.

***-P*** specifies to make the plot with the page set to portrait mode, whereas by default it plots in landscape mode. We don't have time to cover this, but you can change any of the default behaviors of GMT using the `gmt.conf` file in your home directory. See the GMT help for the details.

**Plotting Coastlines**

Here we will use the `pscoast` command to make map plots that have coastlines, rivers, lakes and national boundaries.  This geographic information is included in GMT with the GSHHG database (Global Self-consistent, Hierarchical, High-resolution Geography Database).  

Try running this command and viewing the output:
~~~
$ gmt pscoast -R-90/-70/0/20 -JM6i -P -Ba -Gchocolate > GMT_tut_3.ps
~~~

Here `-JM6i` tells GMT to use a Mercator conformal projection to make a 6 inches wide plot.

`pscoast` has many options:


Option	| Purpose
-------| ---
-A	| Exclude small features or those of high hierarchical levels  
-D	| Select data resolution (full, high, intermediate, low, or crude)
-G	| Set color of dry areas (default does not paint)
-I	| Draw rivers (chose features from one or more hierarchical categories)
-L	| Plot map scale (length scale can be km, miles, or nautical miles)
-N	| Draw political borders (including US state borders)
-S	| Set color for wet areas (default does not paint)
-W	| Draw coastlines and set pen thickness

One of -W, -G, -S must be selected.  For example, use `-Df` to get the full resolution shoreline boundary data (and note how much larger the output file size is).   Let's try turning on a bunch of the options:

~~~
$ gmt pscoast -R-90/-70/0/20 -JM6i -P -Ba -Wblack -Df -Ia/thin,blue -N1/2p,red -Slightblue -Gtan > GMT_tut_3.ps
~~~

**Changing the GMT defaults**

You can temporarily change the GMT defaults for you r current shell session by using the `gmtset` command.  Type `gmtdefaults` to see all the default settings for GMT. Suppose you want to plot the maps with a plain line for the frame rather than the white and black checkerboard that GMT uses by default. You can change that default by entering the command:
~~~
$ gmtset MAP_FRAME_TYPE plain
~~~

**Some Other Projections**

Here are a few more projection examples. There are many more projection options than what we have space to show here, so consult the documentation for more info.


Albers projection:
~~~
$ gmt pscoast -R-130/-70/24/52 -JB-100/35/33/45/6i -Ba -B+t"Conic Projection" -N1/thickest -N2/thinnest -A500 -Ggray -Wthinnest -P > GMT_tut_4.ps
~~~

Polar stereographic projection:
~~~
$ gmt pscoast -R-180/180/-90/-60 -Js0/-90/3i/-60 -B30g10  -Wthinnest -Glightbrown -Slightblue -Di -P > stereo.ps
~~~  


Here are a few of the global projection options:

Orthographic projection:
~~~
$ gmt pscoast -Rg -JG280/30/6i -Bag -Dc -A5000 -Gwhite -SDarkTurquoise -P > GMT_tut_5.ps
~~~

Hammer projection:
~~~
$ gmt pscoast -Rg -JH0/6i -X0.25i -Y0.2i -K -Bg30 -Dc -Glightbrown -Slightblue -P > test.ps
~~~

Eckert VI project:
~~~
$ gmt pscoast -Rg -JKs180/9i -Bag -Dc -A5000 -Glightbrown -Slightblue -Wthinnest > GMT_tut_6.ps
~~~


**Lines and Symbols**

Here we will learn how to use GMT to plot lines, symbols and text. The two main relevant commands are `psxy` for plotting lines and symbols and `pstext` for adding text labels to plots. These commands have tons and tons of options but we will only be covering their simple usage here.

For the tutorial, we will first plot the data in file `data` in the tutorial folder. Take a peek at the data in here:
~~~
$ more data
1       1
2       2
3       2
2       5
5       2
4       4
3       2.1
~~~
So this file has two columns of numbers that range from 1 to 5. We can also use the `info` command to see what GMT thinks of this file:
~~~
$ gmt info data
data: N = 7	<1/5>	<1/5>
~~~
GMT sees that there are N=7 rows with values spanning from 1 to 5 in each column. Plot the data using `psxy`:
~~~
$ gmt psxy data -R0/6/0/6 -Jx1i -P -Baf  > GMT_tut_7.ps
~~~
By default GMT plotted this as a line. We can change the appearance of the line using the `-W` arguments:
~~~
$ gmt psxy data -R0/6/0/6 -Jx1i -W2p,green -P -Baf  > GMT_tut_7.ps
~~~
Here I've told it to use a 2-point thickness and to color the line green. We could also plot the line instead as a filled polygon using the `-G` argument with a fill color:
~~~
$ gmt psxy data -R0/6/0/6 -Jx1i -W2p,green -L -Glightblue  -P -Baf  > GMT_tut_7.ps
~~~
Now let's plot symbols for each (x,y) position in data:
~~~
$ gmt psxy data -R0/6/0/6 -Jx1i  -Si0.2i  -Baf > GMT_tut_7b.ps
~~~
Here the `-S` argument tells `psxy` to plot the data as symbols and the `i` in `-Si` tells it to use inverted triangles. See the help for `psxy` to learn about all the other symbol types that are possible. The `0.2i` part tells it to make the symbols 0.2 inches in size.

Now let's plot both the line and the symbols. To do this, you first plot the line, then add the symbols as an overlay:
~~~
$ gmt psxy data -R0/6/0/6 -Jx1i -Baf -P -K -W2p,green > GMT_tut_8.ps
$ gmt psxy data -R -J -O -W -Si0.2i >> GMT_tut_8.ps
~~~
Note the `-K` argument in the first line, which tells GMT to keep the file open for further additions. Then in the second line we used the `-O` argument to tell GMT to add the triangles in overlay mode. We also used the Unix `>>` append operator, which appends the overlay to the plot file rather than overwriting the file.

Now we will make a plot of earthquakes around Japan where the color of the symbol indicates depth and the size of the symbol indicates magnitude. See file `quakes.ngdc`:
~~~
$ gmt makecpt -Cred,green,blue -T0,70,300,10000 > quakes.cpt
$ gmt pscoast -R130/150/35/50 -JM6i -B5 -P -Ggray -K > GMT_tut_9.ps
$ gmt psxy -R -J -O quakes.ngdc -Wfaint -i4,3,5,6s0.1 -h3 -Scc -Cquakes.cpt >> GMT_tut_9.ps
~~~
The first line above makes are color palette of red, green and blue for earthquakes with depths from 0 to 70, 70 to 300 and greater than 300 km depth. The second line creates a plot of northern Japan's outline.  The third line plots the earthquakes. `-h3` tells GMT to skip the first three header lines. `-i4,3,5,6s0.1` tells it to read columns 5,4,6,7 (note it uses 0 based indexing!) and to scale the values in the 7th column by 0.1. Since the 7th column is the earthquake magnitude, this converts it to a number that will be useful to use as the centimeter size of the symbols. `-Scc` tells it to plot the symbols as circles using centimeters as the size units.

We don't have time to cover `pstext`, but it uses similar syntax. See the examples in the GMT tutorial and online cookbook for further info.

**Gridded Surfaces**

Here we will use GMT to create a shaded map plot of  gridded topography data.  We will use the file tutorial file `us.nc`, which contains a subset of high-resolution topography data from the global 30” DEM called SRTM30+ (SRTM stands for the  shuttle radar topography mission).

Let's peek inside this file to see what it contains. Since this is a binary format, we can't open it in a text editor. Instead we use GMT's `grdinfo` command:
~~~
$ gmt grdinfo us.nc
us.nc: Title: Produced by grdreformat
us.nc: Command: grdreformat -fg usgs_30c_dem.i2 us.nc=ns
us.nc: Remark: /home/aa5/wessel/dem/usgs_30c_dem.i2
us.nc: Pixel node registration used [Geographic grid]
us.nc: Grid file format: ns = GMT netCDF format (16-bit integer), COARDS, CF-1.5
us.nc: x_min: -108 x_max: -103 x_inc: 0.00833333333333 name: longitude [degrees_east] n_columns: 600
us.nc: y_min: 35 y_max: 40 y_inc: 0.00833333333333 name: latitude [degrees_north] n_rows: 600
us.nc: z_min: 1052 z_max: 4328 name: Topography [m]
us.nc: scale_factor: 1 add_offset: 0
us.nc: format: netCDF-4 chunk_size: 150,150 shuffle: on deflation_level: 9
~~~

Here you can see that the file goes from -108 to -103º longitude and 35 to 40º latitude, with z spanning from 1052 to 4328 m.

 GMT has many [built in color palettes (CPT's)](http://gmt.soest.hawaii.edu/doc/5.4.2/GMT_Docs.html#built-in-color-palette-tables-cpt) that you can use for your colormap on shaded plots. You can also download some really nice freely available ones (see http://soliton.vm.bytemark.co.uk/pub/cpt-city/). Here we will use GMT's rainbow color palette to create a colormap that spans the z range of the data in `us.nc` using the `makecpt` command:
~~~
$ gmt makecpt -Crainbow -T1000/5000/500 -Z > topo.cpt
~~~
This command mapped GMT's rainbow color palette to the elevations 1000 to 5000 (`-T` command) and made the color scale have continuous shading (`-Z`) rather than the default which is discrete shaded colors. The output was saved to file `topo.cpt`.

Now let's make a shaded figure of this data.
~~~
$ gmt grdimage us.nc -JM6i -P -Ba -Ctopo.cpt -V > GMT_tut_15.ps
~~~
Take a look at that figure. It looks okay, but there is no illumination to create shadows that help define the topography, so it looks quite flat.

You can add illumination to your GMT map plots by first computing the gradient of the topography using the  `grdgradient` command. The gradients are then used to shade the topography:
~~~
$ gmt grdgradient us.nc -Ne0.8 -A100 -fg -Gus_i.nc
$ gmt grdimage us.nc -Ius_i.nc -JM6i -P -Ba -Ctopo.cpt -K > GMT_tut_16.ps
$ gmt psscale -DjTC+w5i/0.25i+h+o0/-1i -Rus.nc -J -Ctopo.cpt -I0.4 -By+lm -O >> GMT_tut_16.ps
~~~
Here we used grdgradient to output the gradients to file `us_i.nc` using the `-G` argument. We then included the gradient data in the `grdimage` command using thhe `-I` flag.  Also note the new use of the `-K` flag in the `grdimage` line. That flag tells GMT to keep the file open for further additions. We then used the `psscale` command to add a colorscale to the top of the figure. Note that  `psscale` was called with the `-O` option, which means overlay it on top of the previously plotted stuff. We also used `>>` for the redirection, which tells GMT to append the color scale to the previously plotted file. Getting the syntax write for these types of multilayered plots can be tricky, so study the examples on the GMT help carefully. See also  the help for `psscale` for more info.

We don't have time to cover this, but you could create contours for topography using the `grdcontour` command. There are lots more useful GMT commands but we are out of time, so go checkout the GMT cookbook examples for further knowledge.

**Closing Comments**

GMT is really powerful but the calling sequences can be highly cryptic. Check out the online examples and cookbook as useful starting places.

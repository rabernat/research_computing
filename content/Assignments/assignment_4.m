%% Assignment 4: Ploting and analyzing a magnetic field induction time series
%
% - Answer the questions below by inserting the MATLAB commands you used into
%   the blank space below each question.
%
% - When a question asks for a specific value (e.g., what is the length of vector x)
%   list your answer as a comment by inserting it after a % symbol to the right of
%   the command you used to get the answer. For example:
%   length(x)    %  returns the value 12
%
%   This way, we should be able to run your assignment_4.m script without
%   any errors being returned.
%
%  - For each figure created, save it as a PDF file.
%
% Turn in your assignment by uploading it to GitHub into a directory named
% assignment_4. Make sure you upload the THREE figure PDF files in addition to assignment_4.m
%
%

% 0. Its usually a good idea to start your scripts with a clean workspace,
% so:

    clear all;

%% 1. In this section you will load the data file and examine what it contains.

% 1a. Load the data file (list the command):


% 1b. What is the name of the variable that was loaded?


% 1c. What class type is it?


% 1d. How many memory bytes does it occupy?


% 1e. What is the name of the station where this data was collected?


% 1f. What is the magnetic field component measured and what are the units of the data?


% 1g. What island was this data collected on?


% 1h. What is the sampling rate of the time series?


% 1i. What specific variable is the time series stored in?

% 1j. What is the start date and time of the time series? Hint: the
% variable holding the start time uses MATLAB's datenum format.
% Use the command that will convert it to a nicely formated date and time string.


%% 2. In this section you will plot the data and add some labels and a title:


% 2a. How many minutes long is the time series?


% 2b. Create a vector called minutes that gives the time in units of minutes
% for each sample. The first sample should be at 0.0 minutes.


% 2c. Plot the magnetic field time series vector versus the minutes vector
% as a blue line. Add labels on the x and y axes for the
% correct units.


% 2d. Add an informative title to the plot. You can create the string
% using bracket notation:
%
% titleString = ['Station: ' <insert variable> ', Date and Time: ' <insert variable>];
%
% Replace each <insert variable> with the correct variables for the station
% name and the start date and time. Then use this string to make a title on
% the plot.


%2e. Save the figure as the file 'timeseries.pdf'. List the command you
%    used below.


%% 3. In this section you will compute the power spectral density (PSD) of the time series.
% The PSD is often just referred to as the spectrum of the time series. It
% shows the power present in the time series as a function of frequency.
% If you have already taken QMDA, you have already learned about
% power spectra. If not, have a quick read of the wikipedia page for
% Spectral Density.
%

% 3a. How many samples are in 300 seconds of the data?


% 3b. Make a vector called first that has the first five minutes of data and another
% vector called last which has the last five minutes of data:


% 3c. Create a new time vector called seconds that has time in seconds for
% the first and last vectors. The starting value should be zero. This should
% be similar to what you did in exercise 2b but now for seconds rather than
% minutes.


% 3d. Make a new figure with a subplot grid containing 2 rows x 1 column.
% In the top subplot, plot both the first and last vectors versus the seconds
% vector. Plot first as a blue line and last as a red line. Make sure you label the x
% and y axes with the proper units. Add a legend with the labels 'first 5 minutes'
% and 'last 5 minutes'.


% 3e. Compute the power spectrum of the first and last
% time series vectors. To do this, use the function
% pspectrum.m (which you downloaded above) to compute the PSD


% 3f. In the 2nd subplot, plot both power spectra using a log scale for
% frequency on the x axis and a log scale for power on the y axis. Again
% use a blue line for the first data and a red line for the last data. Add
% labels for the x and y axis units. Note that the units of the PSD are T^2/Hz.


% 3g. Save the figure as file 'first_last_psd.pdf'. But first use the
% command 'orient tall' to tell MATLAB to make the figure fill the
% entire printed page. List the commands you used below.


% 3h. The broad peaks (bumps) in the spectra around 7.8, 14.3, 20.8, ... Hz are
% the Schumann resonances formed by the energy from lightning strikes
% resonating in the non-conducting cavity between the electrically
% conductive ground and conductive ionosphere about 90 km above. Large
% lightning strikes will excite normal modes in this cavity as the energy
% repeatedly travels around the Earth. Do the Shumann resonances for the
% first and last five minutes of data look similar or different?


% 3g. What differences do the power spectra show at frequencies below
% 1 Hz?  Does that agree with what the time series shows?


%% 4. Spectrogram. For many time series, the PSD is non-stationary,
% meaning that it changes over time, like what we saw in exercise 3.
% You can show the time evolution in a nice graphical form by creating a spectrogram,
% which is basically a series of power spectra computed by chopping up
% a time series into small sections and computing the PSD for each section.
% The resulting matrix of PSD's can be shown as a 2D matrix or surface
% plot as a function of time and frequency. In this exercise, you
% will go through the steps to make a spectrogram.

% 4a. We will use 300 second long sections of data for the spectrogram.
% Create a variable called nSamplesPerSection which has the number of time
% series points (i.e. samples) for each 300 s long data section.


% 4b. For an arbitrary section i (where i is an integer), write the commands
% that will give the starting and ending indices of the data for that section
% in the time series. Call them iStart and iEnd.


% 4c. Given the value in nSamplesPerSection, create a variable called
% nSections that has the total number of sections that will be created by
% chopping up the time series in sections of 300 s length.


% Check your formulas for iStart and iEnd. If you assign i to be the last
% section, does iEnd equal the length of st.data?

% 4d. Now its time to put all the pieces together to compute the
% spectrogram. Create a for loop that will compute the PSD for each data section.
% The resulting spectra should be stored in a matrix call PSD_matrix.
% PSD_matrix will have length(f) rows and nSections columns.
%
% Hints: create a for loop over nSections, use iStart and iEnd to
% extract that section of data from st.data, and then compute the power spectrum of
% that section. Insert the resulting spectrum into a column in PSD_matrix.
%
% This will be somewhat computationally intensive. It took a minute to run
% on my laptop. If your for loop variable is i, insert  "disp(i);" inside the
% for loop so you can track its progress while its running.


%%
% 4e. Create a new figure and plot the spectrogram using the pcolor command.
% The y axis should be frequency on a log10 scale and the x axis should
% be time in minutes (you will need to create a time vector that represents
% the 5 minute spacing between data sections).

% Additional instructions:
% - Since the power spectra cover a large dynamic range, use log10(PSD_matrix) inside the pcolor command.
% - Use the "shading" command with one of its options to improve the appearance of the plot
% - Add unit labels to the x and y axis
% - Add a title using the results from exercise 2d.
% - Add a colorbar
% - Experiment with the color limits by using the "caxis" command.


% 4f.  Save the figure as file 'spectrogram.pdf'.

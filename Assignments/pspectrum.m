%
% Adaptive multi-taper power spectral density estimation routine
% from Robert L. Parker, Scripps Institution of Oceanography
%
% Downloaded from:
% https://igppweb.ucsd.edu/~parker/Software/index.html
%
% Usage:
% 
% [psd, frequencies] = pspectrum(x, samplingRate)
%
% Returns the psd and associated frequencies for time series x with
% sampling rate samplingRate in Hz.
%
function [psd, f] = pspectrum(x, fsamp)
%  function [psd, f] = pspectrum(x, fsamp)
%  Adaptive multitaper estimator of power spectral density (psd) of
%  the stationary time series x .
%  fsamp is the sampling frequency =1/(sampling interval).  If fsamp
%  is absent, use fsamp=1.
%
%  psd of length nf gives spectrum at nf evenly spaced frequencies: 
%  f=[ 0, df, 2*df, ... (nf-1)*df]', where nf = 1+ n/2, and n=length(x),
%  and df=1/T.  If n is odd, x is truncated by 1.
%

% -------  Tuning parameters -------------
%   Cap=maximum number of tapers allowed per freq; then uncertainty
%   of estimates >= psd/sqrt(Cap).
Cap = 5000;  

%  Niter=number of refinement iterations; usually <= 5
Niter = 2;

%   Ndecimate: number of actual psd calculations is n/Ndecimate;
%   the rest are filled in with interpolation.  Sampling in
%   frequency is variable to accommodate spectral shape
Ndecimate = 1;
if length(x) < 10000; Ndecimate=1; end

%            -----------------

%  Get pilot estimate of psd with fixed number of tapers
initap=20;

psd = psdcore(x, initap, 1);
nf = length(psd);

%  Iterative refinement of spectrum 
ntaper = initap*ones(nf, 1);
for iterate = 1 : Niter

  kopt = riedsid(psd, ntaper);
  ntaper = min(ones(1,nf)*Cap, kopt')';
  psd = psdcore(x, ntaper, Ndecimate);

end

%  Scale to physical units and provide frequency vector
if nargin==1; fsamp=1; end
psd = psd/fsamp;
f = linspace(0, fsamp/2, nf)';

end


function psd = psdcore(x,  ntaper, ndecimate)
%  function psd = psdcore(x,  ntaper)
%  Compute a spectral estimate of the power spectral density
%  (psd) for the time series x using sine multitapers.
%  Normalised to sampling interavl of 1.
%  
%  ntaper gives the number of tapers to be used at each frequency:
%  if ntaper is a scalar, use same value at all freqs; if a
%  vector, use ntaper(j) sine tapers at frequency j. 
%  If series length is n, psd is found at 1 + n/2 evenly spaced freqs;
%  if n is odd, x is truncted by 1.

%  ndecimate: number of psds actually computed = (1+n/2)/ndecimate;
%  these values are linearly interpolated into psd.

persistent fftz n nhalf varx

%  When ntaper is a scalar, initialize
if length(ntaper) == 1

  n = length(x(:));
  n = n - mod(n,2);    % Force series to be even in length
  nhalf = n/2;
  varx = var(x(1:n));
  ntap = ones(nhalf+1,1)*ntaper;  % Make a vector from scalar value

%  Remove mean; pad with zeros
  z = [reshape(x(1:n),[],1)  - mean(x(1:n)); zeros(n,1)];

%  Take double-length fft
  fftz = fft(z);    
else
  ntap = ntaper;
end

%  Decimation argument is optional
if nargin==2 ndecimate=1; end

%  Select frequencies for PSD evaluation
if  length(ntaper)  > 1 && ndecimate > 1
  nsum = cumsum(1 ./ntap); 
  tmp = nhalf * (nsum-nsum(1))/(nsum(end)-nsum(1));
  f =[ round(interp1(tmp,[0:nhalf]', [0 :ndecimate: nhalf]','linear','extrap')); nhalf]; 
  % KWK Aug 2, 2014: added 'extrap' to handle occasional finite precision
  % error from cumsum, resulting in nhalf - max(tmp)  /= 0 but ~10^-11,
  % which then results in a Nan at f(end-1)

  iuniq = 1 + find(diff(f) > 0);
  f = [0; f(iuniq)];   %  Remove repeat frequencies in the list
else
  f= [0 : nhalf]';
end

%  Calculate the psd by averaging over tapered estimates
nfreq = length(f);
psd = zeros(nfreq,1);

%  Loop over frequency
for j = 1: nfreq

   m = f(j);
   tapers = ntap(m+1);
%  Sum over taper indexes; weighting tapers parabolically
   k = 1 : tapers;
   w = (tapers^2 - (k-1).^2)*(1.5/(tapers*(tapers-0.25)*(tapers+1)));
   j1=mod(2*m+2*n-k, 2*n);
   j2=mod(2*m+k, 2*n);
   psd(j) = w * abs(fftz(j1+1)-fftz(j2+1)).^2;

end

%  Interpolate if necessary to uniform freq sampling
if length(ntaper) > 1 && ndecimate > 1
  psd = interp1(f,psd, [0:nhalf]');
  end

%  Normalize by variance
area = (sum(psd) - psd(1)/2 - psd(end)/2)/nhalf;  % 2*Trapezoid
psd = (2*varx/area)*psd;

end

function kopt = riedsid(psd, ntaper)
%  function kopt = riedsid(psd, ntaper)
%  Estimates optimal number of tapers at each frequency of
%  given psd, based on Riedel-Sidorenko MSE recipe and other
%  tweaks due to RLP.  
%  ntaper is the vector of taper lengths in the previous iteration.
%
%  Initialize with ntaper=scalar

eps=1e-78;  %  A small number to protect against zeros

nf = length(psd(:));
ntap = ntaper;
if (size(ntaper)==1) ntap=ntaper*ones(nf,1); end

nspan = round( min([0.5*nf*ones(1,nf); 1.4*ntap(:)']))' ;

%  Create log psd, and pad to handle begnning and end values
nadd = 1 + max(nspan);
Y = log(eps + [psd(nadd:-1:2); psd; psd(nf-1:-1:nf-nadd)] );

%  R = psd"/psd = Y" + (Y')^2 ; 2nd form preferred for consistent smoothing
%  
d2Y = zeros(nf,1);  dY=d2Y;
for j = 1 : nf

  j1 = j-nspan(j)+nadd-1; 
  j2 = j+nspan(j)+nadd-1; 

%  Over an interval proportional to taper length, fit a least
%  squares quadratic to Y to estimate smoothed 1st, 2nd derivs
  u = [j1 : j2] - (j1+j2)/2;
  L = j2-j1+1; uzero=(L^2-1)/12;

  dY(j) = u*Y(j1:j2)*(12/(L*(L^2-1)));
  d2Y(j) = (u.^2 - uzero)*Y(j1:j2)*(360/(L*(L^2-1)*(L^2-4)));

end

%  Riedel-Sidorenko recipe: kopt = (12*abs(psd ./ d2psd)).^0.4; but
%  parabolic weighting in psdcore requires: (480)^0.2*abs(psd./d2psd)^0.4
%
%  Original form:  kopt = 3.428*abs(psd ./ d2psd).^0.4;

kopt = round( 3.428 ./abs(eps + d2Y + dY.^2).^0.4 );

%  Curb run-away growth of kopt due to zeros of psd''; limits
%  slopes to be < 1 in magnitude, preventing greedy averaging:
%  Scan forward and create new series where slopes <= 1
state=0;
for j = 2:nf
  if (state == 0)
     slope=kopt(j)-kopt(j-1);
     if slope >= 1 
        state=1;
        kopt(j)=kopt(j-1)+1;
     end
  else
     if kopt(j) >= kopt(j-1)+1
        kopt(j) = kopt(j-1)+1;
     else
        state=0;
     end
  end
end

%  Scan backward to bound slopes >= -1
state=0;
for j = nf :-1: 2
  if (state == 0)
     slope=kopt(j-1)-kopt(j);
     if slope >= 1 
        state=1;
        kopt(j-1)=kopt(j)+1;
     end
  else
     if kopt(j-1) >= kopt(j)+1
        kopt(j-1) = kopt(j)+1;
     else
        state=0;
     end
  end
end

%  Never average over more than the psd length!
kopt = min([kopt'; ones(1,nf)*round(nf/3)] )';

end  % riedsid

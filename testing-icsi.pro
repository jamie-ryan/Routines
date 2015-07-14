; IDL Version 8.2.2 (linux x86_64 m64)
; Journal File for jsr2@msslex.mssl.ucl.ac.uk
; Working directory: /disk/solar3/jsr2/Data/SDO
; Date: Tue Jul 14 15:59:33 2015
 
f = iris_files('../IRIS/iris_l2_20140329_140938_3860258481_raster_t000_r00173.fits')
;       0  
;../IRIS/iris_l2_20140329_140938_3860258481_raster_t000_r00173.fits
;      31 MB
d = iris_load(f)
hdr = d->gethdr(/struct)
d->show_lines
;Spectral regions(windows)
; 0   1335.71   C II 1336
; 1   1343.37   1343    
; 2   1349.43   Fe XII 1349
; 3   1355.60   O I 1356
; 4   1402.77   Si IV 1403
; 5   2832.69   2832    
; 6   2826.61   2826    
; 7   2814.41   2814    
; 8   2796.20   Mg II k 2796
;Loaded Slit Jaw images
; 1   SJI_1400
; 2   SJI_2796
; 3   SJI_2832
lambda = d->getlam(8)
spec = d->getvar(8,/load)
help, lambda, spec
specint = spec[*,435,3]
help, lambda, specint
plot, lambda, specint, /xst
.r icsi
icsi, lambda, specint
; % Illegal subscript range: WAVF.
retall
;;;;try making smaller data set???
;;;;let's look at 2791.6 peak
plot, lambda[0:100], specint[0:100]
plot, lambda[10:100], specint[10:100]
plot, lambda[50:100], specint[50:100]
plot, lambda[30:100], specint[30:100]
icsi, lambda[30:100], specint[30:100]
;Converged after        5 iterations
;;;hmmm, nice, looks like it worked...i think?
help, wavf
retall
help
icsi, lambda[30:100], specint[30:100]
;Converged after        5 iterations
help
delvar, wvaf
icsi, lambda[30:100], specint[30:100]
;Converged after        5 iterations
help
icsi, lambda[30:100], specint[30:100]
;Converged after        5 iterations
help

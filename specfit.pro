; IDL Version 8.2.2 (linux x86_64 m64)
; Journal File for jsr2@msslex.mssl.ucl.ac.uk
; Working directory: /disk/solar3/jsr2/Data/SDO
; Date: Wed Jul 15 12:27:06 2015
 
f = iris_files('../IRIS/iris_l2_20140329_140938_3860258481_raster_t000_r00173.fits')
;       0  ../IRIS/iris_l2_20140329_140938_3860258481_raster_t000_r00173.fits      31 MB
d = iris_load(f)
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
wav = d-> getlam(8)
spec = d->getvar(8,/load)
int = spec[30:100,435,3]
wav = wav[30:100]
.r
   if not keyword_set(fact) then fact = 99
   if not keyword_set(int_dev_max) then int_dev_max = 1.e-5
   if not keyword_set(niterations) then niterations = 100
   nwav = n_elements(wav)
   nwavf = nwav*fact
   wavf = dblarr(nwavf)
   dwav = dblarr(nwav)  
   rms = dblarr(niterations)   
   
   for i = 1, nwav-2 do begin
      dwav(i) = 0.5*(wav(i+1) - wav(i-1))
	  wsub = (dindgen(fact) + 0.5)/fact*dwav(i)
	  wavf(i*fact:(i+1)*fact-1) = wsub + 0.5*(wav(i) + wav(i-1))
   endfor
end
;  First bin   
   dwav(0) = wav(1) - wav(0)   
   wsub = (dindgen(fact) + 0.5)/fact*dwav(0)
   wavf(0:fact-1) = wsub + wav(0) - 0.5*dwav(0) 
   
;  Last bin   
   dwav(nwav-1) = wav(nwav-1) - wav(nwav-2)
   wsub = (dindgen(fact) + 0.5)/fact*dwav(nwav-1)
   wavf(nwavf-fact:nwavf-1) = wsub + wav(nwav-1) - 0.5*dwav(nwav-1)
   
; F (spline fit, fine resolution)
   intf_all = dblarr(niterations, nwavf)     
   intf_all(0,*) = interpol(int, wav, wavf, /spline)    ; initial spline fit
   cor_all = fltarr(niterations,nwav)                   ; correction factors
; I (corrected intensity, original resolution)
   int_new_all = fltarr(niterations, nwav)   
   int_new_all(0,* )= int                               ; initial intensity
; F_avg (average value of spline fit, original resolution)
   int_avg_all = dblarr(niterations, nwav)    
   
; Percent deviation of spline fit average from true average (original resolution)
   int_dev_all = dblarr(niterations, nwav)
   i_d_max = dblarr(niterations)   ;   maximum for iteration
.r
; Loop over iterations
   for i = 1, niterations-1 do begin
; Loop over original wavelength grid
      for j = 0, nwav-1 do begin
; F_1/2, value of spline fit at position wav of previous iteration
;        (wav is equal to the midpoint of the bin only if the original grid is uniform)
         jfmin = fact*j
		 jfmax = fact*(j+1) - 1
         fhalf = interpol(intf_all(i-1,jfmin:jfmax),  $
		         wavf(jfmin:jfmax), wav(j))				 
;    The following line can replace the above if there is need to speed up the calculation  
;    and if the original grid is approximately uniform
;		 fhalf = intf_all(i-1, fact*j + fact/2)
; F_avg, bin-averaged value of spline fit at previous iteration
         favg = total(intf_all(i-1, fact*j:fact*(j+1)-1))/fact
         int_avg_all(i-1, j) = favg
         cor = fhalf/favg
		 
; I, corrected intensity, original resolution (intensity appropriate to position wav)
         int_new_all(i, j) = cor*int(j)
         cor_all(i, j) = cor
		 
      endfor
	  
; Deviation of spline fit average, F_avg, from true average, int
         ss = where(int ne 0.)
         int_norm = max(int)
         int_dev_all(i-1,*) = (int_avg_all(i-1,*) - int)/int_norm
		 i_d_max(i-1) = max(abs(int_dev_all(i-1,ss)))
		 if (i_d_max(i-1) le int_dev_max) then begin
		    print, 'Converged after ', i-1, ' iterations'
			intf = reform(intf_all(i-1,*))
		    goto, jump1
		 endif
; F, new spline fit
      intf_all(i,*)= interpol(reform(int_new_all(i,*)), wav, wavf, $
	                         /spline)  
												 
   endfor
   
   print, 'Not converged after ', niterations, ' iterations'
   print, 'Maximum fractional intensity deviation = ',   $
           max(abs(int_dev_all(niterations-2,*)))
   intf = reform(intf_all(niterations-1,*))
   
jump1:
; Correct NaN values
   test=finite(intf)
   ss=where(test eq 0)
   intf(ss)=0.
   
   ss = where(i_d_max ne 0.)
   idmax = i_d_max(ss)
   
; Corrected intensities at the original grid positions
   int_cor = int_new_all(i-1,*)   
   jump99:
specfit = create_struct('wavf',wavf, 'intf', intf, 'int_cor', int_cor)
end
;Converged after        5 iterations
help, specfit
specfit = create_struct('wav', wav, 'int', int,'wavf',wavf, 'intf', intf, 'int_cor', int_cor)
help, specfit
st = max(wav)
print, st
;       2793.0260
stt = min(wav)
print, stt
;       2791.2438
nm = (st+stt)/2
print, nm
;       2792.1349
nmstr = string(nm, f = 'I0')
; % '(' expected.
;   "I0"
;    ^
nmstr = string(nm, format = '(I0)')
print, nmstr
;2792
structname = 'specfit'+nmstr
print, structname
;specfit2792
specfit2792 = specfit
help, specfit2792
help, structname
help, specfit2792
save, structfit2792, filename = structname+'.sav'
; % SAVE: Undefined item not saved: STRUCTFIT2792.
save, specfit2792, filename = structname+'.sav'
$ls
wav = d->getlam(8)
help, wav
help, wav, dat
help
help, wav, spec

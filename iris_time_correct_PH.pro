;FUNCTION:
;Using the starting time of the entire observation (t0[0]) and the correct exposure times, 
;this function makes a corrected time array by adding succesive corrected exposure times onto
;t0+ti, where ti is the accumulated time after each exposure.
;
;INPUT:
;f          = a 1D string array containing iris fits file paths. Must contain the entire observation. 
;OUTPUT:
;times_out  = is an array containig corrected raster step time strings and is returned by the function
function iris_time_correct_PH, f, times_out
tic

nfiles = n_elements(f)
spec_line = 6;d->show_lines
d = iris_obj(f[0])
dat = d->getvar(spec_line, /load)
wave = d->getlam(spec_line)
nwav = n_elements(wave)
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
exp = dblarr(xpix, nfiles)
times_out = strarr(xpix, nfiles) ;times_out[j,i]
t0 = d->ti2utc() ;times for first raster 

obj_destroy, d

;scan_time = time taken to move the slit from position 8 to 1
;scan_time = 9 ;seconds

;convert time string into floats
t0z = t0[0]+'Z'
timestamptovalues,t0z, year=yr,month=mth,day=day,hour=hr,minute=mins,second=sec,offset=0

;convert hrs, mins into seconds
hrs2sec = hr*60.*60.
mins2sec = mins*60.

times_out[0,0] = t0[0]

;Calculate new corrected times array
;raster loop
for i = 0, nfiles - 1 do begin
print, 'i = ',i
    ;read in iris object and get correct exposure times
    d = iris_obj(f[i])
    exp[*,i] = d->getexp(iexp,iwin=spec_line)
    obj_destroy, d
    
    ;slit position loop
    for j = 0, xpix - 1 do begin
    print, 'j = ',j
    tic
        ;calculate the corrected time for each slit position
        ;;;;;;;may need to use the if statement below to add the scan_time 
        ;if (j eq 0) then t_new = hrs2sec + mins2sec + sec + exp[j,i] + scan_time else $
        ;t_new = hrs2sec + mins2sec + sec + exp[j,i]
        t_new = hrs2sec + mins2sec + sec + exp[j,i]
        hr_new = t_new/60./60.
        min_new = (hr_new - fix(hr_new))*60.
        sec_new = (min_new - fix(min_new))*60.
        
        ;convert floats back to strings
        yrstr = string(yr, format = '(I0)')
        mthstr = string(mth, format = '(I0)')
        daystr = string(day, format = '(I0)')
        hrstr = string(hr_new, format = '(I0)')
        minstr = string(min_new, format = '(I0)')
        secstr = strcompress(string(sec_new, format ='(F0.3)'),/remove_all)

        ;make time string in format 2014-03-29T14:09:39.000       
        tstr = yrstr+'-'+mthstr+'-'+daystr+'T'+hrstr+':'+minstr+':'+secstr

        ;for the first iteration, set time string to t0[0]
        times_out[j,i] = tstr
        toc
    endfor
endfor

;pass corrected time array back to procedure
return, times_out
toc
end

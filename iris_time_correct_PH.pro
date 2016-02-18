function iris_time_correct, f, t0, times_out

;times_in is the time string arrays for each raster (see balm_data)
;/new_data will generate a new sp2826 structure, otherwise the code defaults to a pre-existing .sav
;times_out is an array containig corrected raster step time strings and is returned by the function




;endif
nfiles = n_elements(f)
spec_line = 6;d->show_lines
d = iris_obj(f[0])
dat = d->getvar(spec_line, /load)
wave = d->getlam(spec_line)
;nwav = n_elements(wave[39:44]) ;wavelength range for balmer
nwav = n_elements(wave)
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
exp = dblarr(xpix, nfiles)
tcorr = dblarr(xpix, nfiles)
times_out = strarr(xpix, nfiles) ;times_out[j,i]
obj_destroy, d

;make new (corrected) timestring array

timestamptovalues,t0, year=yr,month=mth,day=day,hour=hr,minute=mins,second=sec,offset=0
;convert hrs, mins into seconds
hrs2sec = hr*60.*60.
mins2sec = mins*60.
for i = 0, nfiles - 1 do begin
    d = iris_obj(f[i])
    exp[*,i] = d->getexp(iexp,iwin=spec_line)
    obj_destroy, d
    for j = 0, xpix - 1 do begin

        ;calculate slit times
        t_new = hrs2sec + min2sec + sec + exp[j,i]
        hr_new = t_new/60./60.
        min_new = (hr_new - fix(hr_new))*60.
        sec_new = (min_new - fix(min_new))*60.
        
        yrstr = string(yr, format = '(I0)')
        mthstr = string(mth, format = '(I0)')
        daystr = string(day, format = '(I0)')
        yrstr = string(hr_new, format = '(I0)')
        minstr = string(min_new, format = '(I0)')
        secstr = string(sec_new)
        ;make time string in format 2014-03-29T14:09:39.000       
        tstr = yrstr+'-'+mthstr+'-'+daystr+'T'+hrtsr+':'minstr+':'+secstr
        times_out[j,i] = tstr

        ;mkae timestring in ccsds format
;        utcstruct = {year:yr, month:mth, day:day,hour:hr_new, minute:min_new, second:sec_new, millisecond:millsecs}
;        times_out[j,i] = utc2str(utcstruct)
    endfor
endfor

return, times_out
end

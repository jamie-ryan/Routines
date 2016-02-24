function iris_time_correct,f, lambda, times_out
;new_data = new_data,
;times_in is the time string arrays for each raster (see balm_data)
;/new_data will generate a new sp2826 structure, otherwise the code defaults to a pre-existing .sav
;times_out is an array containig corrected raster step time strings and is returned by the function


;if keyword_set(new_data) then begin
;irisl2struct,f, 2826 else 
;restore, '/unsafe/jsr2/sp2826-Feb17-2016.sav'


;if not keyword_set(new_data) then begin

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

for i = 0, nfiles - 1 do begin
    d = iris_obj(f[i])
    exp[*,i] = d->getexp(iexp,iwin=spec_line)
    obj_destroy, d
endfor




;;;Check raster cadence (times) against summed exposure times
;need to ammend each raster time 
for i = 0, nfiles - 1 do begin
    spec = iris_getwindata(f[i],lambda)
    for j = 0, xpix - 1 do begin
	    wrong_exp = spec.exposure_time[j]
        wrong_time = spec.time[j]
;        tstr = sp2826.tag00.time_ccsds[0]+'Z'
        tstr = spec.time_ccsds[j]
        tstr = tstr+'Z'
        timestamptovalues,tstr, year=yr,month=mth,day=day,hour=hr,minute=min,second=sec,offset=0

	    ;remove excess time
        if (exp[j,i] lt wrong_exp) then begin 
	        sec_corr = sec - (wrong_exp - exp[j,i]) ;subtracts time difference
            sec_actual = sec_corr
            min_actual = min
            hr_actual = hr 
            ;correct for changing minutes and hours
            if (sec_corr lt 0.) then begin
                min_corr = min - 1.
                sec_actual = 60. + sec_corr ;sec_corr is negative here
                ;set to previous hour if the second subtraction crosses an hour boundary
                if (min_corr lt 0.) then begin 
                    hr_actual = hr - 1 
                    min_actual = 60. + min_corr 
                endif
            endif
	    endif

	    ;add excess time
        if (exp[j,i] gt wrong_exp) then begin
	        sec_corr = sec + (exp[j,i] - wrong_exp)
            sec_actual = sec_corr
            ;correct for changing minutes and hours
            if (sec_corr gt 60.) then begin
                min_corr = min + 1.
                sec_actual = sec_corr - 60. ;sec_corr is positive here
                ;set to previous hour if the second subtraction crosses an hour boundary
                if (min_corr gt 60.) then begin
                    hr_actual = hr + 1 
                    min_actual = 60. - min_corr
                endif
            endif
	    endif

    ;;;convert milliseconds after decimal into an integer (required by utc2str)
    sec_act = fix(sec_actual)
    millsecs = fix((sec_actual - sec_act)*1000)

    utcstruct = {year:yr, month:mth, day:day,hour:hr_actual, minute:min_actual, second:sec_actual,millisecond:millsecs}
    times_out[j,i] = utc2str(utcstruct)

    endfor
endfor
return, times_out
end

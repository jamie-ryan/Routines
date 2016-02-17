pro iris_time_correct,times_in, /new_data, times_out

;times is the time string arrays for each raster (see balm_data)

f1 = iris_files(path='/unsafe/jsr2/IRIS/preflare/')
f2 = iris_files(path='/unsafe/jsr2/IRIS/old/')
f = [f1,f2]

if keyword_set(new_data) then begin
irisl2struct,f, 2826
endif

if not keyword_set(new_data) then begin
restore, '/unsafe/jsr2/sp2826-Feb17-2016.sav'
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
obj_destroy, d

for i = 0, nfiles - 1 do begin
    d = iris_obj(f[i])
    exp[*,i] = d->getexp(iexp,iwin=spec_line)
    obj_destroy, d
endfor




;;;Check raster cadence (times) against summed exposure times
;need to ammend each raster time 
tags = tag_names(sp2826)
for i = 0, nfiles - 1 do begin
    for j = 0, xpix - 1 do begin
	com = 'wrong_exp = sp2826.'+tags[i]+'.exposure_times[j]'
	exe = execute(com)	
	com = 'wrong_time = sp2826.'+tags[i]+'.time[j]'
	exe = execute(com)	

	;remove excess time
        if (exp[j,i] lt wrong_exp) then begin 
	    tcorr[j,i] = wrong_time - (wrong_exp - exp[j,i])
	endif

	;add excess time
        if (exp[j,i] gt tmp) then 
	    tcorr[j,i] = wrong_time + (exp[j,i] - wrong_exp)
	endif
    endfor

tsrt = sp2826.tag00.time_ccsds[0]+'Z'                                                   
timestamptovalues,tsrt, year=yr,month=mth,day=day,hour=hr,minute=min,second=sec,offset=0
julnum = julday(mth, day, yr, hr, min, sec);;;;does this work?


    ;correct time string from times_in and place in times_out
    times_out = stri
strmid(sp2826.tag00.time_ccsds[0], 11, 21)ng()

endfor
endif
end
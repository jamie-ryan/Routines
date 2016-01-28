function rhessi_time_string_iterator, nt, hrstart, hrend, minstart, minend, secst, secend, tout

;INPUTS:
;nt = number of time intervals
;hrstart = start hour, eg 17 ...in integer format
;minstart = start min, eg 00 ...in integer format
;hrend = end hour, eg 17 ...in integer format
;minend = end min, eg 00 ...in integer format

;OUTPUT:
;tout = time interval string array used by hsi_im2map.pro

tout = strarr(2,nt)
;in the format
;[ ['29-Mar-2014 17:44:00.000', '29-Mar-2014 17:44:30.000'], $
;['29-Mar-2014 17:44:30.000', '29-Mar-2014 17:45:00.000'], $
;['29-Mar-2014 17:45:00.000', '29-Mar-2014 17:45:30.000'], $  
;['29-Mar-2014 17:47:00.000', '29-Mar-2014 17:47:30.000']] 

nhrsec = (((hrend - hrstart) * 60 * 60)) / nt

nminsec = (((minend - minstart) * 60)) / nt

ntotsec = nhrsec + nminsec + secst

;calculate number of seconds per iteration
nsec = ntotsec / nt


for i = 0, nt - 1 do begin
nhr = fix((nhrsec * i) / 60. / 60.)
nhr1 = fix((nhrsec * (i+1)) / 60. / 60.)
nmin = fix((nminsec * i) / 60.)
nmin1 = fix((nminsec * (i+1)) / 60.)
nsecs = nsec + nsec * i
nsecs1= nsec + nsec * (i + 1)

ns = fix((nsecs )/60.)
ns1 = fix((nsecs1 )/60.)
;convert nsecs into time units
nsecs = ( ( nsecs / 60. ) -  ns ) * 60
nsecs1 = ( ( nsecs1 / 60. ) -  ns1 ) * 60

hrs = string(hrstart + nhr, format = '(I0)')
hrs1 = string(hrstart + nhr1, format = '(I0)')

if (minstart + nmin lt 10) then $
mins = '0'+string(minstart + nmin, format = '(I0)') $
else mins = string(minstart + nmin, format = '(I0)')

if (minstart + nmin1 lt 10) then $      
mins1 = '0'+string(minstart + nmin1, format = '(I0)') $
else mins1 = string(minstart + nmin1, format = '(I0)')

if (nsecs lt 10) then secs = '0'+string(nsecs, format = '(I0)') $
else secs = string(nsecs, format = '(I0)')

if (nsecs1 lt 10) then secs1 = '0'+string(nsecs1, format = '(I0)') $
else secs1 = string(nsecs1, format = '(I0)')

tout[0,i] = '29-Mar-2014 '+hrs+':'+mins+':'+secs+'.000'
tout[1,i] = '29-Mar-2014 '+hrs1+':'+mins1+':'+secs1+'.000'
endfor
return, tout
end

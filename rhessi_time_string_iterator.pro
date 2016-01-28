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

nhrsec = ((hrend - hrstart) * 60 * 60)/nt

;if there is zero hours change then prevent loop crashing
if (nhrsec eq 0) then nhr = 1 else nhr = nhrsec

;if zero mins then stop program
nminsec = ((minend - minstart) * 60)/nt
if (nhrsec eq 0) then end

;calculate number of seconds per iteration
nsec = (nhrsec + nminsec + secst) / nt


for i = 0, nt - 1 do begin
nhr = (nhrsec + nsec * i) / 60 / 60
nmin = (nminsec + nsec * i) / 60
nsecs = nsec + nsec * i

ns = fix((nsec * i)/60)
;convert nsecs into time units
nsecs = ( ( nsecs / 60 ) -  ns ) * 60

hrs = string(nhr, format = '(I0)')
mins = string(nmin, format = '(I0)')
if (nsecs = 0) then secs = '00' else secs = string(nsecs, format = '(I0)')
tout[0,i] = '29-Mar-2014 '+hrs+':'+mins+':'+secs+'.000'
tout[1,i] = '29-Mar-2014 '+hrs+':'+mins+':'+secs+'.000'
endfor
return, tout
end

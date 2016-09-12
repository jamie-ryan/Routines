function rhessi_time_intervals, timg, yrst, yrend, mthst, mthend, dyst, dyend, hrstart, hrend, minstart, minend, secst, secend, tout
search_network, /enable
;INPUTS:
;nt = number of time intervals
;timg = integration time... minimum 4 seconds... must be a multiple of rhessi spin period
;hrstart = start hour, eg 17 ...in integer format
;minstart = start min, eg 00 ...in integer format
;hrend = end hour, eg 17 ...in integer format
;minend = end min, eg 00 ...in integer format

;OUTPUT:
;tout = time interval string array used by hsi_im2map.pro and rhessi_img etc


;in the format
;[ ['29-Mar-2014 17:44:00.000', '29-Mar-2014 17:44:30.000'], $
;['29-Mar-2014 17:44:30.000', '29-Mar-2014 17:45:00.000'], $
;['29-Mar-2014 17:45:00.000', '29-Mar-2014 17:45:30.000'], $  
;['29-Mar-2014 17:47:00.000', '29-Mar-2014 17:47:30.000']] 

;start time string
t1 = dyst+'-'+mthst+'-'+yrst+' '+hrstart+':'+minstart+':'+secst+'.000'
t1_since_1st_jan_1979 = anytim(t1)

;temp end time string
t2 = dyend+'-'+mthend+'-'+yrend+' '+hrend+':'+minend+':'+secend+'.000'
t2_since_1st_jan_1979 = anytim(t2)

;total time in seconds
ttot = t2_since_1st_jan_1979 - t1_since_1st_jan_1979

;is total time an integer number of timg
nt = ttot/timg

;if ttot is not an integer number of timg... make ammendments
if (nt - fix(nt) gt 0) then begin 
    ;ammend nt to include extra time interval
    nt = fix(nt) + 1
    ;ammend ttot to include extra time interval 
    ttot = nt * timg
endif

;ammended end time based on integer number of timg
;;t2 = anytim(t1_since_1st_jan_1979 + ttot, /yoh)
;;t2_since_1st_jan_1979 = anytim(t2)
;;tfull = [t1,t2]

;grab attenuator state change times
;;obs=hsi_obs_summary(obs_time=tfull)
;;changes = obs->changes()
;;atten = changes.attenuator_state

;will produce a result of -1 if there are no attenuator changes during time period
;;zero = atten.start_times[0]

;if therer is an attenuator change at any point between start and finish time
;ammend time_intervals to isolate bad data
;;if (zero gt -1) then begin
;;    attend0 = atten.end_times - zero
;;    which_iter = attend0/timg
;;    tperiod = 




tout =strarr(2, nt)
for i = 0, nt -1 do begin
t = t1_since_1st_jan_1979 + timg*i
tt = t1_since_1st_jan_1979 + timg*(i+1)
tout[0,i] = anytim(t, /yoh)
tout[1,i] = anytim(tt, /yoh)
endfor



return, tout
end

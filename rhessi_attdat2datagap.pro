function rhessi_attdat2datagap, $
rhessicube, $
time_intervals, $
tbuff

search_network, /enable  

;restore, '/unsafe/jsr2/rhessi-spectra-Jun7-2016/energy-3-to-20/increments-1keV/timg-20sec/BackProjection/rhessidata.sav'

tfull = [time_intervals[0, 0],time_intervals[1,-1]]
;t='21-apr-2002 ' + ['00:00','02:00']
obs=hsi_obs_summary(obs_time=tfull)
changes = obs->changes()
atten = changes.attenuator_state
ti_1st_jan_1979 = anytim(time_intervals)

;normalise
zero = atten.start_times[0]
attend0 = atten.end_times - zero
ti0 = ti_1st_jan_1979 - zero  


natt = n_elements(atten.end_times)

for j = 0, natt -1 do begin
   i = WHERE(ti0[0,*] EQ attend0[j] - tbuff , count)
   IF (count GT 0) THEN rhessicube[*,*,*, i] = !VALUES.F_NAN
endfor

return, rhessicube
end

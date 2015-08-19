pro rhessi_data
search_network, /enable
tr ='29-Mar-14 '+['17:35:28','18:14:36']
obs = hsi_obs_summary(obs_time_interval = tr)
corrected_data = obs -> getdata(/corrected)
times = obs -> getdata(/time_array)
data = corrected_data.countrate
ntt = n_elements(times)
obs -> plot ;will plot all energy ranges

;to plot individually
utplot, times-times[0], data[0,*] ;data[energy-channel, dn]
;or
utplot, atime(times), data[0,*]

end

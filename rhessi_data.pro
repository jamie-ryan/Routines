pro rhessi_data

;steph sent me this code
search_network, /enable
tr ='29-Mar-14 '+['17:35:28','18:14:36']
obs = hsi_obs_summary(obs_time_interval = tr)
corrected_data = obs -> getdata(/corrected)
times = obs -> getdata(/time_array)
data = corrected_data.countrate
ntt = n_elements(times)
obs -> plot ;will plot all energy ranges

;to plot individually:
;data[0,*] = 3 - 6 keV
;data[1,*] = 6 - 12 keV
;data[2,*] = 12 - 25 keV
;data[3,*] = 25 - 50 keV
;data[4,*] = 50 - 100 keV
;data[5,*] = 100 - 300 keV
;data[6,*] = 300 - 800 keV
;data[7,*] = 800 - 7000 keV
;data[8,*] = 7000 - 20000 keV
s = 's!E-1!N'
det = 'detector!E-1!N'
ytitl = 'Count Rate ('+s+' '+det+')'
loadct, 
utplot, times-times[0], data[4,*], ytitle = ytitl, title = 'RHESSI 25 - 50 and 50 - 100 keV', /ylog 
oplot, times-times[0], data[3,*]
;or
utplot, atime(times), data[4,*], ytitle = ytitl, title = 'RHESSI 25 - 50 and 50 - 100 keV', /ylog 
oplot, atime(times), data[3,*]



;RHESSI IMAGING VIA GUI see rhessi_imaging_kontar_2009.pdf
search_network, /enable
hessi

;;RHESSI IMAGING VIA COMMAND LINE see rhessi_imaging_kontar_2009.pdf
search_network, /enable ;access to rhessi data
obj = hsi_image() ;define imaging object
obj-> set, det_index_mask= [0, 0, 1, 1, 1, 1, 1, 1, 0] ;detectors used 3 to 8
obj-> set, im_energy_binning= [50.0, 100.0] ;energy range
obj-> set, im_time_interval= ' 29-Mar-2014 '+['17:47:18', '17:47:22'] ;time range
obj-> set, image_algorithm= 'Back Projection' ;or 'Clean' or 'Pixon' etc
obj-> set, image_dim= [128, 128] ;image size in pixels
obj-> set, pixel_size= [32., 32.] ;pixel size in arcseconds
obj-> set, use_flare_xyoffset= 1 ;if set to 1 uses catalogue data, if set to 0 it doesn't
obj-> set, xyoffset= [0.0, 0.0] ;set image centre coordinates
data = obj-> getdata() ; retrieve the last image made









end

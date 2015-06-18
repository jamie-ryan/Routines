pro whereMGWpix


restore, 'SJ2832.sav'


tmp2832 = dat2832

t = 166

minhi = 1150
;maxhi = 5000

;pixel range
x0 = 320
xf = 700
y0 = 393
yf = 557

;array manipulation...leaves only pixels of interest
tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
;tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmp2832[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmp2832[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/61/iris-mgiiw-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

t = 167

minhi = 1150
;maxhi = 5000

;pixel range
x0 = 404
xf = 652
y0 = 391
yf = 534

;array manipulation...leaves only pixels of interest
;tmpmg[WHERE(tmpmg[*,*,t] lT minhi, /NULL)] = 0
tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
;tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmp2832[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmp2832[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/62/iris-mgiiw-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit




t = 168
minhi = 1300
maxhi = 2000

;pixel range
x0 = 411
xf = 625
y0 = 379
yf = 507

;array manipulation...leaves only pixels of interest
;tmpmg[WHERE(tmpmg[*,*,t] lT minhi, /NULL)] = 0
tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmp2832[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmp2832[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/63/iris-mgiiw-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit






t = 169
minhi = 1100
maxhi = 3000

;pixel range
x0 = 527
xf = 622
y0 = 395
yf = 464

;array manipulation...leaves only pixels of interest
;tmpmg[WHERE(tmpmg[*,*,t] lT minhi, /NULL)] = 0
tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmp2832[WHERE(tmp2832[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmp2832[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmp2832[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/64/iris-mgiiw-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit

end

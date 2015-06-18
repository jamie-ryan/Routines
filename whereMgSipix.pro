pro whereMgSipix

restore, 'iris-16-03-15.sav'


;diffhmitmp =  diffhmi
tmpmg = submgdata
tmp1400 = map1400data

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;hmi =61, mg = 159, SiIV = 495;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;MGII = 159
;frame
t = 159
;threshold
minhi = 800
maxhi = 2000

;pixel range
x0 = 279
xf = 775
y0 = 356
yf = 625

;array manipulation...leaves only pixels of interest
;tmpmg[WHERE(tmpmg[*,*,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmpmg[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmpmg[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/61/iris-mgii-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit

;;;;;SiIV = 495
;frame
t = 495
;threshold
minhi = 1000
maxhi = 3000
;pixel range
x0 = 70 ;;;pinpoint emission bottom left - might match hmi?
xf = 765
y0 = 144
yf = 613
;array manipulation...leaves only pixels of interest
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
;save pixel coordinates (machine format)
ind = where(tmp1400[x0:xf,y0:yf,t] gt 0)
;convert pixel coordinates to human readable
loc = array_indices(tmp1400[x0:xf,y0:yf,t],ind)
;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/61/iris-siiv-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;hmi =62, mg = 161, SiIV = 496;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;MGII = 161
;frame
t = 161
;threshold
minhi = 800
maxhi = 2000
;pixel range
x0 = 279
xf = 778
y0 = 356
yf = 625
;array manipulation...leaves only pixels of interest
;tmpmg[WHERE(tmpmg[*,*,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmpmg[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmpmg[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/62/iris-mgii-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit

;;;;;SiIV = 495
;frame
t = 496
;threshold
minhi = 1000
maxhi = 3000
;pixel range
x0 = 228
xf = 807
y0 = 369
yf = 626
;array manipulation...leaves only pixels of interest
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
;save pixel coordinates (machine format)
ind = where(tmp1400[x0:xf,y0:yf,t] gt 0)
;convert pixel coordinates to human readable
loc = array_indices(tmp1400[x0:xf,y0:yf,t],ind)
;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/62/iris-siiv-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;hmi =63, mg = 164, SiIV = 498;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;MGII = 164
;frame
t = 164
;threshold
minhi = 800
maxhi = 2000
;pixel range
x0 = 279
xf = 775
y0 = 349
yf = 655
;array manipulation...leaves only pixels of interest
;tmpmg[WHERE(tmpmg[*,*,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmpmg[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmpmg[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/63/iris-mgii-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit

;;;;;SiIV = 498
;frame
t = 498
;threshold
minhi = 0
maxhi = 1000
;pixel range
x0 = 270
xf = 768
y0 = 340
yf = 681
;array manipulation...leaves only pixels of interest
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
;save pixel coordinates (machine format)
ind = where(tmp1400[x0:xf,y0:yf,t] gt 0)
;convert pixel coordinates to human readable
loc = array_indices(tmp1400[x0:xf,y0:yf,t],ind)
;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/63/iris-siiv-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;hmi =64, mg = 166, SiIV = 500;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;MGII = 166
;frame
t = 166
;threshold
minhi = 800
maxhi = 2000
;pixel range
x0 = 279
xf = 775
y0 = 340
yf = 661
;array manipulation...leaves only pixels of interest
;tmpmg[WHERE(tmpmg[*,*,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmpmg[WHERE(tmpmg[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0

;save pixel coordinates (machine format)
;ind = where(tmpmg[*,*,t] gt 0)
ind = where(tmpmg[x0:xf,y0:yf,t] gt 0)

;convert pixel coordinates to human readable
;loc = array_indices(tmpmg[*,*,t],ind)
loc = array_indices(tmpmg[x0:xf,y0:yf,t],ind)

;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/64/iris-mgii-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit

;;;;;SiIV = 500
;frame
t = 500
;threshold
minhi = 0 
maxhi = 5000
;pixel range
x0 = 286
xf = 762
y0 = 353
yf = 664
;array manipulation...leaves only pixels of interest
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
tmp1400[WHERE(tmp1400[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
;save pixel coordinates (machine format)
ind = where(tmp1400[x0:xf,y0:yf,t] gt 0)
;convert pixel coordinates to human readable
loc = array_indices(tmp1400[x0:xf,y0:yf,t],ind)
;put coordinates into array
locactual = intarr(2,n_elements(loc[0,*]))
;convert pixel coordinates into a form relevent to submap 
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

;put coordinates into a file
stt = string(t)
filename = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/64/iris-siiv-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


end

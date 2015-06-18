pro whereWLpix


restore, 'hmi-16-03-15.sav'
diffhmitmp =  diffhmi

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;61;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
t = 61
minhi = 700
maxhi = 2075
x0 = 53
xf = 75
y0 = 79
yf = 90

diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
ind = where(diffhmitmp[x0:xf,y0:yf,t] gt 0)
loc = array_indices(diffhmitmp[x0:xf,y0:yf,t],ind)
locactual = intarr(2,n_elements(loc[0,*]))
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

stt = string(t)
filename = strcompress('hmi-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;PLOTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;AMMENDMENT: need to open relevent file, read values into array and plot
nni = n_elements(locactual[0,*])

for i = 0, nni-1, 1 do begin 
stloc0i = string(locactual[0,i])
stloc1i = string(locactual[1,i])
lcfile = strcompress('hmi-intensity-vs-time-'+stloc0i+'-'+stloc1i+'-'+stt+'.eps', /remove_all)
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
utplot, sbhmi.time, sbhmi.data[locactual[0,i],locactual[1,i],*]
device,/close
set_plot,mydevice
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;62;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
t = 62
minhi = 1900
maxhi = 5008
x0 = 22
xf = 73
y0 = 71
yf = 95

diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
ind = where(diffhmitmp[x0:xf,y0:yf,t] gt 0)
loc = array_indices(diffhmitmp[x0:xf,y0:yf,t],ind)
locactual = intarr(2,n_elements(loc[0,*]))
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*]  

stt = string(t)
filename = strcompress('hmi-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;PLOTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;AMMENDMENT: need to open relevent file, read values into array and plot
nni = n_elements(locactual[0,*])

for i = 0, nni-1, 1 do begin 
stloc0i = string(locactual[0,i])
stloc1i = string(locactual[1,i])
lcfile = strcompress('hmi-intensity-vs-time-'+stloc0i+'-'+stloc1i+'-'+stt+'.eps', /remove_all)
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
utplot, sbhmi.time, sbhmi.data[locactual[0,i],locactual[1,i],*]
device,/close
set_plot,mydevice
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;63;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
t = 63
minhi = 1200
maxhi = 5020
x0 = 15
xf = 75
y0 = 65
yf = 95

diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
ind = where(diffhmitmp[x0:xf,y0:yf,61] gt 0)
loc = array_indices(diffhmitmp[x0:xf,y0:yf,t],ind)
locactual = intarr(2,n_elements(loc[0,*]))
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

stt = string(t)
filename = strcompress('hmi-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun
printf, unit, locactual
free_lun, unit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;PLOTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;AMMENDMENT: need to open relevent file, read values into array and plot
nni = n_elements(locactual[0,*])

for i = 0, nni-1, 1 do begin 
stloc0i = string(locactual[0,i])
stloc1i = string(locactual[1,i])
lcfile = strcompress('hmi-intensity-vs-time-'+stloc0i+'-'+stloc1i+'-'+stt+'.eps', /remove_all)
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
utplot, sbhmi.time, sbhmi.data[locactual[0,i],locactual[1,i],*]
device,/close
set_plot,mydevice
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;64;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
t = 64
minhi = 1400
maxhi = 1750
x0 = 29
xf = 34
y0 = 83
yf = 90

diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
ind = where(diffhmitmp[x0:xf,y0:yf,t] gt 0)
loc = array_indices(diffhmitmp[x0:xf,y0:yf,t],ind)
locactual = intarr(2,n_elements(loc[0,*]))
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 

stt = string(t)
filename = strcompress('hmi-high-intenstiy-pixels-frame-'+stt+'.dat', /remove_all)

openw, unit, filename, /get_lun, /append
printf, unit, locactual


x0 = 55
xf = 77
y0 = 65
yf = 75
diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] lT minhi, /NULL)] = 0
diffhmitmp[WHERE(diffhmitmp[x0:xf,y0:yf,t] gT maxhi, /NULL)] = 0
ind = where(diffhmitmp[x0:xf,y0:yf,t] gt 0)
loc = array_indices(diffhmitmp[x0:xf,y0:yf,t],ind)
locactual = intarr(2,n_elements(loc[0,*]))
locactual[0,*] = x0+loc[0,*]  
locactual[1,*] = y0+loc[1,*] 


printf, unit, locactual
free_lun, unit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;PLOTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;AMMENDMENT: need to open relevent file, read values into array and plot
;nni = n_elements(locactual[0,*])

;for i = 0, nni-1, 1 do begin 
;stloc0i = string(locactual[0,i])
;stloc1i = string(locactual[1,i])
;lcfile = strcompress('hmi-intensity-vs-time-'+stloc0i+'-'+stloc1i+'-'+stt+'.eps', /remove_all)
;mydevice=!d.name
;set_plot,'ps'
;device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;utplot, sbhmi.time, sbhmi.data[locactual[0,i],locactual[1,i],*]
;device,/close
;set_plot,mydevice
;end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end



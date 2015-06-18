pro makemaps

restore, 'hmi-16-03-15.sav'
restore, '/disk/solar8/sam/29mar14/sji_mgii_saub.sav'
restore, '/disk/solar8/sam/29mar14/sji_1400map.sav'

nhmi = n_elements(sbhmimap) 
nmg = n_elements(submg)
nsi = n_elements(map1400[385:*])


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;HMI
for i = 0, nhmi-1, 1 do begin
ii = string(i)

filename ='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/hmi-diff-'+ii+'.eps'
mydevice=!d.name
set_plot,'ps'
device, decomposed=0,color=1
loadct,3
plot_map, diff[i], dmin = 200, dmax = 2000, title = 'SDO HMI DIFF Photosphere'
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
filename ='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/hmi-'+ii+'.eps'
device,filename ,/portrait,/encapsulated, decomposed=0,color=1
loadct,3
plot_map, sbhmimap[i], dmin = 200, dmax = 2000, title = 'SDO HMI Photosphere'
device,/close
set_plot,mydevice


endfor

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;MGII
for i = 0, nmg-1, 1 do begin
ii = string(i)

filename ='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-mgii-'+ii+'.eps'
mydevice=!d.name
set_plot,'ps'
device,filename,/portrait,/encapsulated, decomposed=0,color=1

loadct,3
plot_map, submg[159], dmin = 0, dmax = 2000, title = 'IRIS SJ Chromosphere'
device,/close
set_plot,mydevice

endfor

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SiIV
for i = 0, nsi-1, 1 do begin
ii = string(i)

filename ='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-siIV-'+ii+'.eps'
mydevice=!d.name
set_plot,'ps'
device,filename,/portrait,/encapsulated, decomposed=0,color=1

loadct,3
plot_map, map1400[495], /log, title = 'IRIS SJ Transition Region'
device,/close
set_plot,mydevice

endfor

end

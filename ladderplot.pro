restore, 'iris-16-03-15.sav'
restore, 'sp2826-Apr28-2015.sav'
restore, 'hmi-12-05-15.sav'

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'

;;date string
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2

;;directories
dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'

;;;;high intensity pixel coordinate files
fmg = findfile(datdir+'*mgii-high*')
fmgw = findfile(datdir+'*mgiiw-high*')
fsi = findfile(datdir+'*siiv-high*')
;fsp = iris_files('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
fsp = findfile('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
;ffsp = findfile(datdir+'*balmer-high*')
ff = findfile(datdir+'hmi-high*')

sample = 1



nmg = n_elements(submg) ;nmg = n_elements(submg[17:*])
nmgw = n_elements(diff2832[*])
nsi = n_elements(map1400) ;nsi = n_elements(map1400[387:*])
nn = n_elements(fsp)
nnn = n_elements(diff)

for j = 0, n_elements(fmg) - 1 do begin
;;;;;;;open files 

openr,lun,fmg[j],/get_lun

;;;count lines in file
nlinesmg = file_lines(fmg[j])

;;;make array to fill with values from the file
hmg=intarr(2,nlinesmg)

;;;read file contents into array
readf,lun,hmg

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fmgw[j],/get_lun

;;;count lines in file
nlinesmgw = file_lines(fmgw[j])

;;;make array to fill with values from the file
hmgw=intarr(2,nlinesmgw)

;;;read file contents into array
readf,lun,hmgw

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fsi[j],/get_lun

;;;count lines in file
nlinessi = file_lines(fsi[j])

;;;make array to fill with values from the file
hsi=intarr(2,nlinessi)

;;;read file contents into array
readf,lun,hsi

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,ff[j],/get_lun

;;;count lines in file
nlines = file_lines(ff[j])

;;;make array to fill with values from the file
h=intarr(2,nlines)

;;;read file contents into array
readf,lun,h

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;rhessi;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

com = 'boxarrmg'+string(j,format = '(I0)')+' = fltarr(nmg)'
exe = execute(com)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmg-1, 1 do begin
;com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) '
com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[i].data[hmg[0,*],hmg[1,*]]) '
exe = execute(com)
endfor
;;;flux and energy of flare area
com = 'iris_radiometric_calibration,boxarrmg'+string(j,format = '(I0)')+ $
', wave = 2796, n_pixels = nlinesmg ,F_area_mgii'+string(j,format = '(I0)')+ $
', E_area_mgii'+string(j,format = '(I0)')+' ,/sji'
exe = execute(com)

;;;balmer;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	for i = 0, nn-1, 1 do begin
;		comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
;		exet1 = execute(comt)
;		comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
;		exet = execute(comi)
;	endfor


;;;mgiiw;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

com = 'boxarrmgw'+string(j,format = '(I0)')+' = fltarr(nmgw)'
exe = execute(com)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmgw-1, 1 do begin
com = 'boxarrmgw'+string(j,format = '(I0)')+'[i] = total(diff2832[i].data[hmgw[0,*],hmgw[1,*]])
exe = execute(com)
endfor
;;;flux and energy of flare area
com = 'iris_radiometric_calibration,boxarrmgw'+string(j,format = '(I0)')+ $
', wave = 2832, n_pixels = nlinesmgw ,F_area_mgiiw'+string(j,format = '(I0)')+ $
', E_area_mgiiw'+string(j,format = '(I0)')+' ,/sji'
exe = execute(com)


;;siiv;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;501?

com = 'boxarrsi'+string(j,format = '(I0)')+' = fltarr(nsi)'
exe = execute(com)
;loop to fill arrays with summed pixel intensity values
for i = 0, nsi-1, 1 do begin
;com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[387 + i].data[hsi[0,*],hsi[1,*]]) '
com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[i].data[hsi[0,*],hsi[1,*]]) '
exe = execute(com)
endfor
;;;flux and energy of flare area
com = 'iris_radiometric_calibration, boxarrsi'+string(j,format = '(I0)')+', wave = 1400, n_pixels = nlinessi , F_area_siiv'+string(j,format = '(I0)')+', E_area_siiv'+string(j,format = '(I0)')+' ,/sji'

exe = execute(com)

;;hmi continuum;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
com = 'boxarr'+string(j,format = '(I0)')+' = fltarr(nnn)'
exe = execute(com)
;bgarr = fltarr(nnn)
for i = 0, nnn-1, 1 do begin
com = 'boxarr'+string(j,format = '(I0)')+'[i] = total(diff[i].data[h[0,*],h[1,*]])'
exe = execute(com) 
endfor
;;;;;intensity of flare area in erg/s.cm^2.sr
com = 'hmi_radiometric_calibration, boxarr'+string(j,format = '(I0)')+', n_pixels = nlines, F_area_hmi'+string(j,format = '(I0)')+', E_area_hmi'+string(j,format = '(I0)')+''
exe = execute(com)
endfor

;import all savs, make 4d array, loop the ladderplots
;FLARE-RIBBON AREA PLOTS
;calculate plotting position coordinates for ladder plots
plot_pos_calc, n_plots = 4, xpos, ypos
base = '29-Mar-14 17:26:00'
sec = 19.*60. ;location in seconds for vertical line...17:45 - 17:26 = 19 mins...19mins*60secs

o = 3
xyx = xpos[0] + 1.3*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = flux
utplot, map1400[447:*].time, E_area_siiv2[447:*], $ 
base, $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]]
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm

o = 2
xyx = xpos[0] + 1.3*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = flux
utplot, submg[595:*].time, E_area_mgii2[597:*], $ ;583
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

o = 1
xyx = xpos[0] + 1.3*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = flux
utplot, map2832[150:*].time, E_area_mgiiw2[150:*], $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 1.3*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = flux
utplot, diff[36:78].time, E_area_hmi2[36:78], $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, 0.92*xyx, xyy, 'SDO HMI Continuum', /norm













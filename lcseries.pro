pro lcseries
;pro lcseries, hmiframe, mgwframe, mgframe, siframe
;lcseries, 63, 166, 164, 498
;restore, '/disk/solar3/jsr2/Data/SDO/hmi-16-05-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
;restore, 'SJ2832.sav'
dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'
;f = string(hmiframe)
;mg = string(mgframe)
;mgw = string(mgwframe)
;si = string(siframe)
;ff = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+f+'/hmi-high-intenstiy-pixels-frame-'+f+'.dat',/remove_all)
ff = datdir+'hmi-all*.dat'
;fmg = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+f+'/iris-mgii-high-intenstiy-pixels-frame-'+mg+'.dat',/remove_all)
fmg = datdir+'*mgii-all*.dat'
;fmgw = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/61/iris-mgiiw-high-intenstiy-pixels-frame-'+mgw+'.dat',/remove_all)
fmgw = datdir+'*mgiiw-all*.dat'
;fsi = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+f+'/iris-siiv-high-intenstiy-pixels-frame-'+si+'.dat',/remove_all)
fsi = datdir+'*siiv-all*.dat'
fsp = iris_files('../IRIS/*raster*.fits')
nn = n_elements(fsp)
sample = 1

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
;;;;;;;open files 
openr,lun,ff,/get_lun

;;;count lines in file
nlines = file_lines(ff)

;;;make array to fill with values from the file
h=intarr(2,nlines)

;;;read file contents into array
readf,lun,h

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fmg,/get_lun

;;;count lines in file
nlinesmg = file_lines(fmg)

;;;make array to fill with values from the file
hmg=intarr(2,nlinesmg)

;;;read file contents into array
readf,lun,hmg

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fmgw,/get_lun

;;;count lines in file
nlinesmgw = file_lines(fmgw)

;;;make array to fill with values from the file
hmgw=intarr(2,nlinesmgw)

;;;read file contents into array
readf,lun,hmgw

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fsi,/get_lun

;;;count lines in file
nlinessi = file_lines(fsi)

;;;make array to fill with values from the file
hsi=intarr(2,nlinessi)

;;;read file contents into array
readf,lun,hsi

;;close file and free up file unit number
free_lun, lun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;hmi;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nnn = n_elements(diff)
boxarr = fltarr(nnn)
;bgarr = fltarr(nnn)
for i = 0, nnn-1, 1 do begin
boxarr[i] = total(diff[i].data[h[0,*],h[1,*]]) 
;bgarr[i] = total(sbhmimap[i].data[h[0,*],h[1,*]]) 
endfor
;;;;;intensity of flare area in erg/s.cm^2.sr
hmi_radiometric_calibration, boxarr, n_pixels = nlines, F_area_hmi, E_area_hmi



;;;mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nmg = n_elements(submg[17:*])
boxarrmg = fltarr(nmg)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmg-1, 1 do begin
boxarrmg[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) 
endfor
;;;flux and energy of flare area
;F_area_mgii = flux_func(boxarrmg, wave = [2796], /sji)
;E_area_mgii = energy_func(F_area_mgii, wave = [2796], /sji, pixnum = nlinesmg)
iris_flux_energy,boxarrmg, wave = [2796],F_area_mgii, E_area_mgii ,/sji
tmg = submg[17:*].time


;;;mgiiw;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nmgw = n_elements(diff2832[*])
boxarrmgw = fltarr(nmgw)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmgw-1, 1 do begin
boxarrmgw[i] = total(diff2832[i].data[hmgw[0,*],hmgw[1,*]])
endfor
;;;flux and energy of flare area
;F_area_mgiiw = flux_func(boxarrmgw, wave = [2832] , /sji)
;E_area_mgiiw = energy_func(F_area_mgiiw, wave = [2832] , /sji, pixnum = nlinesmgw)
iris_flux_energy,boxarrmg, wave = [2832],F_area_mgiiw, E_area_mgiiw ,/sji
tmgw = diff2832.time

;;siiv;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;501?
nsi = n_elements(map1400[387:*])
boxarrsi = fltarr(nsi)
;loop to fill arrays with summed pixel intensity values
for i = 0, nsi-1, 1 do begin
boxarrsi[i] = total(map1400[387 + i].data[hsi[0,*],hsi[1,*]]) 
endfor
;;;flux and energy of flare area
;F_area_siiv = flux_func(boxarrsi, wave = [1400] , /sji)
;E_area_siiv = energy_func(F_area_siiv, wave = [1400] , /sji, pixnum = nlinessi)
iris_flux_energy,boxarrmg, wave = [1400],F_area_siiv, E_area_siiv ,/sji
tsi = map1400[387:*].time


;spectrum;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
spboxarr = fltarr(sample*nn)
timearr = strarr(sample*nn)
rbboxarr = fltarr(sample*nn)
;sp quake
for i = 0, nn-1, 1 do begin
comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
exet1 = execute(comt)
comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
exet = execute(comi)
endfor
;calculate flux and energy
w1 = sp2826.tag00.wvl[39]
w2 = sp2826.tag00.wvl[44]
;Fspqk = flux_func(spboxarr, wave = [w1, w2], /sg)
;Espqk = energy_func(Fspqk, wave = [w1, w2], /sg, pixnum = 1) ;
iris_flux_energy, spboxarr, wave = [w1, w2],Fspqk, Espqk ,/sg
tsp = timearr

;sp ribbon
for i = 0, nn-1, 1 do begin
;comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
;exet1 = execute(comt)
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,482])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,487])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,488])/((44-39)*2)'
comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,486])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,487])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,489])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,490])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,491])/((44-39)*2)'
exet = execute(comi)
endfor
;calculate flux and energy
;Fsprb = flux_func(rbboxarr, wave = [w1, w2], /sg)
;Esprb = energy_func(Fsprb,wave = [w1, w2], /sg, pixnum = 1)
iris_flux_energy, rbboxarr, wave = [w1, w2],Fsprb, Esprb ,/sg



;utplot, timearr[157:*], rbboxarr[157:*]

;;contrasts
;imin = fltarr(nnn)
iminmg = fltarr(nmg)
iminmgw = fltarr(nmgw)
iminsi = fltarr(nsi)
spimin = fltarr(sample*nn)
sprbimin = fltarr(sample*nn)
;spimin = fltarr(sample*nn)





imin = 500
;imin[*] = (total(boxarr[35:55])+total(boxarr[75:95]))/(40*nlines)
iminsi[*] = total(boxarrsi[0:71])/(72*nlinessi)
iminmg[*] = total(boxarrmg[0:95])/(96*nlinesmg)
iminmgw[*] = 750;total(boxarrmgw[0:95])/(96*nlinesmgw)
iminmgwrb = 250
spimin[*] = 200 ;total(spboxarr[20:60])/(40)
sprbimin[*] = 75 ;total(rbboxarr[157:177])/(20)


spimax = max(spboxarr)
rbimax = max(rbboxarr)

spqkcontrast = ((spimax-spimin[0])/spimin[0])
sprbcontrast = ((rbimax-sprbimin[0])/sprbimin[0])

spqkcontrastr = string(spqkcontrast, format = '(f0.2)')
sprbcontrastr = string(sprbcontrast, format = '(f0.2)')

spqkconstr = strcompress(spqkcontrastr, /remove_all)
sprbconstr = strcompress(sprbcontrastr, /remove_all)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Sarah's pixel locations [arcsec]:
;quake is at = 517,264 
;ribbon position = 511, 272


;HMI
;qk location?: x = 506, y = 264
qkxa = 517.2
qkya = 261.4

rbxa = 511
rbya = 272
rbxpcorr = 39
rbypcorr = 90
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;convert arcsecs to pixels
qkxp = (qkxa/diffindex[0].cdelt1) + diffindex[0].crpix1 - 1
qkyp = (qkya/diffindex[0].cdelt2) + diffindex[0].crpix2 - 1
;rbxp = (rbxa/diffindex[0].cdelt1) + diffindex[0].crpix1 - 1
;rbyp = (rbya/diffindex[0].cdelt2) + diffindex[0].crpix2 - 1
;print, qkxp, qkyp, rbxp, rbyp
;;take pre and post flare values from multiple frames and pixels to make a averaged non-flare pixel intensity
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;IRIS
qkirxa = 519.;506;517
qkirya = 262.;264;264 
;rbirxa = 510.90;511
;rbirya = 272.100;272
;;;pixels to arcsecs
;qkxa = (SJI_1400_hdr[0].cdelt1)*(qkxp - SJI_1400_hdr[0].crpix1 + 1)
;;;convert arcsecs to pixels
qkmgxp = 588 ;(qkirxa/SJI_2796_hdr[0].cdelt1) + SJI_2796_hdr[0].crpix1 - 1
qkmgyp = 441 ;(qkirya/SJI_2796_hdr[0].cdelt2) + SJI_2796_hdr[0].crpix2 - 1
rbmgxp = 504 ;rbmgxp = (509.75028/SJI_1400_hdr[0].cdelt1) + SJI_1400_hdr[0].crpix1 - 1
rbmgyp = 487 ;rbmgyp = (270.88814/SJI_1400_hdr[0].cdelt2) + SJI_1400_hdr[0].crpix2 - 1
;print,qkmgxp,qkmgyp,rbmgxp,rbmgyp

qksixp = 588 ;(qkirxa/SJI_1400_hdr[0].cdelt1) + SJI_1400_hdr[0].crpix1 - 1
qksiyp = 441 ;(qkirya/SJI_1400_hdr[0].cdelt2) + SJI_1400_hdr[0].crpix2 - 1
rbsixp = 511 ; (rbirxa/map1400index[0].cdelt1) + map1400index[0].crpix1 - 1
rbsiyp = 485 ; (rbirya/map1400index[0].cdelt2) + map1400index[0].crpix2 - 1
;print,qksixp,qksiyp,rbsixp,rbsiyp


qkimax = fltarr(nnn)
rbimax = fltarr(nnn)
qkcontrast = fltarr(nnn)
rbcontrast = fltarr(nnn)

qkmgmax = fltarr(nmg)
rbmgmax = fltarr(nmg)
qkmgcontrast = fltarr(nmg)
rbmgcontrast = fltarr(nmg)

qkmgwmax = fltarr(nmgw)
rbmgwmax = fltarr(nmgw)
qkmgwcontrast = fltarr(nmgw)
rbmgwcontrast = fltarr(nmgw)


qksimax = fltarr(nsi)
rbsimax = fltarr(nsi)
qksicontrast = fltarr(nsi)
rbsicontrast = fltarr(nsi)
;imin[*] = (total(bgarr[35:55])+total(bgarr[75:95]))/(40*nlines)


;hmi loop
for i = 0, nnn-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkimax[i] = diff[i].data[qkxp, qkyp]
qkcontrast[i] = (qkimax[i] - imin[0])/imin[0]
rbimax[i] = diff[i].data[rbxpcorr, rbypcorr]
rbcontrast[i] = (rbimax[i] - imin[0])/imin[0]
endfor
;calculate flux and energy???
hmi_radiometric_calibration, qkimax, n_pixels = 1, Fhmiqk, Ehmiqk
hmi_radiometric_calibration, rbimax, n_pixels = 1, Fhmirb, Ehmirb

;;mgw loop
for i = 0, nmgw-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgwmax[i] = map2832[i].data[588,441 ]  ;559, 441
qkmgwcontrast[i] = (qkmgwmax[i] - iminmgw[0])/iminmgw[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgwmax[i] = map2832[i].data[483, 475]
rbmgwcontrast[i] = (rbmgwmax[i] - iminmgwrb)/iminmgwrb
endfor   
;calculate flux and energy
Fmgwqk = flux_func(qkmgwmax, wave = [2832], /sji)
Emgwqk = energy_func(Fmgwqk,wave = [2832], /sji, pixnum = 1)
Fmgwrb = flux_func(rbmgwmax, wave = [2832], /sji)
Emgwrb = energy_func(Fmgwrb, wave = [2832], /sji, pixnum = 1)





;;mg loop
for i = 0, nmg-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgmax[i] = submg[17 + i].data[qkmgxp, qkmgyp]
qkmgcontrast[i] = (qkmgmax[i] - iminmg[0])/iminmg[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgmax[i] = submg[17 + i].data[rbmgxp, rbmgyp]
rbmgcontrast[i] = (rbmgmax[i] - iminmg[0])/iminmg[0]
endfor
;calculate flux and energy
Fmgqk = flux_func(qkmgmax, wave = [2976], \sji)
Emgqk = energy_func(Fmgqk, wave = [2976], \sji, pixnum = 1)
Fmgrb = flux_func(rbmgmax,  wave = [2976], \sji)
Emgrb = energy_func(Fmgrb,  wave = [2976], \sji, pixnum = 1)





;;si loop
for i = 0, nsi-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qksimax[i] = map1400[387 + i].data[qksixp, qksiyp]
qksicontrast[i] = (qksimax[i] - iminsi[0])/iminsi[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbsimax[i] = map1400[387 + i].data[rbsixp, rbsiyp]
rbsicontrast[i] = (rbsimax[i] - iminsi[0])/iminsi[0]
endfor
;calculate flux and energy
Fsiqk = flux_func(qksimax, wave = [1400], /sji)
Esiqk = energy_func(Fsiqk, wave = [1400], /sji, pixnum = 1)
Fsirb = flux_func(rbsimax, wave = [1400], /sji)
Esirb = energy_func(Fsirb, wave = [1400], /sji, pixnum = 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
save, F_area_siiv,E_area_siiv, F_area_mgii,E_area_mgii,F_area_mgiiw,E_area_mgiiw, Fsprb,Esprb,Fsiqk,Esiqk, Fsirb,Esirb, Fmgqk, Fmgrb, Emgqk, Emgrb, Fmgwqk, Emgwrb, Fmgwrb, Emgwrb, tmg, tmgw, tsi, tsp, filename = 'flux-energy-iris-sj.sav'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;Relative Intensity PLOTS;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;INDIVIDUAL QUAKE PLOTS
qkareacon = max(qkcontrast[0:79])
quakeloccontraststr = string(qkareacon, format = '(f0.2)')
qkconstr = strcompress(quakeloccontraststr, /remove_all)

qkmgwareacon = max(qkmgwcontrast)
quakemgwloccontraststr = string(qkmgwareacon, format = '(f0.2)')
qkmgwconstr = strcompress(quakemgwloccontraststr, /remove_all)


qkmgareacon = max(qkmgcontrast)
quakemgloccontraststr = string(qkmgareacon, format = '(f0.2)')
qkmgconstr = strcompress(quakemgloccontraststr, /remove_all)

qksiareacon = max(qksicontrast)
quakesiloccontraststr = string(qksiareacon, format = '(f0.2)')
qksiconstr = strcompress(quakesiloccontraststr, /remove_all)

rbareacon = max(rbcontrast[0:79])
ribbonloccontraststr = string(rbareacon, format = '(f0.2)')
rbconstr = strcompress(ribbonloccontraststr, /remove_all)

rbsiareacon = max(rbsicontrast)
ribbonsiloccontraststr = string(rbsiareacon, format = '(f0.2)')
rbsiconstr = strcompress(ribbonsiloccontraststr, /remove_all)

rbmgareacon = max(rbmgcontrast)
ribbonmgloccontraststr = string(rbmgareacon, format = '(f0.2)')
rbmgconstr = strcompress(ribbonmgloccontraststr, /remove_all)

rbmgwareacon = max(rbmgwcontrast)
ribbonmgwloccontraststr = string(rbmgwareacon, format = '(f0.2)')
rbmgwconstr = strcompress(ribbonmgwloccontraststr, /remove_all)

dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'

;;;HMI
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-QK-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('SDO-HMI-6173'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,diff[36:78].time, qkimax[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz ;, /ylog
;oplot, [1435,1435],[-9000,7000],color=150,thick=1
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+qkconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice

;;;IRIS 2832
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-QK-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('IRIS-2832'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,diff2832[150:*].time, map2832[150:*].data[559,441], linestyle = 0, title = titl, ytitle = ytitl,/ynoz;, /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+qkmgwconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice

;;;IRIS 2796
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-QK-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('IRIS-2796'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,submg[100:*].time, submg[100:*].data[qkmgxp, qkmgyp], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+qkmgconstr, /norm, charsize = 0.6

device,/close
set_plot,mydevice

;;;IRIS 1400
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-QK-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('IRIS-1400'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,map1400[450:*].time, map1400[450:*].data[qksixp, qksiyp], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+qksiconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice

;;;IRIS BALMER
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-BALMER-QK-LC.eps',/portrait,/encapsulated, decomposed=0,color=1


mx = max(spboxarr[157:*])
mn = min(spboxarr[157:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,timearr[157:*], spboxarr[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx]; , /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+spqkconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice

;;;;INDIVIDUAL RIBBON PLOTS

;;;HMI
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-RB-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('SDO-HMI-6173'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,diff[36:78].time, rbimax[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz ;, /ylog
;oplot, [1435,1435],[-9000,7000],color=150,thick=1
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+rbconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice

;;;IRIS 2832
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-RB-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('IRIS-2832'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,diff2832[150:*].time, map2832[150:*].data[483, 475], linestyle = 0, title = titl, ytitle = ytitl,/ynoz ;, /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+rbmgwconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice

;;;IRIS 2796
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-RB-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('IRIS-2796'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,submg[100:*].time, submg[100:*].data[rbmgxp, rbmgyp], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+rbmgconstr, /norm, charsize = 0.6

device,/close
set_plot,mydevice

;;;IRIS 1400
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-RB-LC.eps',/portrait,/encapsulated, decomposed=0,color=1

titl =  strcompress('IRIS-1400'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,map1400[450:*].time, map1400[450:*].data[rbsixp, rbsiyp], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+rbsiconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice

;;;IRIS BALMER
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-BALMER-RB-LC.eps',/portrait,/encapsulated, decomposed=0,color=1


mx = max(rbboxarr[157:*])
mn = min(rbboxarr[157:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,timearr[157:*], rbboxarr[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx] ;, /ylog
xyouts, 0.2, 0.85, 'Max Intensity Contrast = '+sprbconstr, /norm, charsize = 0.6


device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;Flux and Energy PLOTS;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;SINGLE PIXEL LOCATION, QUAKE AND RIBBON PLOTS
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'

;;;;;HMI
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-QK-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,diff[36:78].time, Fhmiqk[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-QK-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'QUAKE-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot, diff[36:78].time,Ehmiqk[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice



mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-RB-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,diff[36:78].time, Fhmirb[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-RB-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'RIBBON-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot, diff[36:78].time,Ehmirb[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice


;;;BALMER
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-BALMER-QK-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
mx = max(Fspqk[157:*])
mn = min(Fspqk[157:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,timearr[157:*], Fspqk[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx]
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-BALMER-QK-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
mx = max(Espqk[157:*])
mn = min(Espqk[157:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'QUAKE-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot, timearr[157:*],Espqk[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-BALMER-RB-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
mx = max(Fspqk[157:*])
mn = min(Fspqk[157:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot, timearr[157:*],Fsprb[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx]
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-BALMER-RB-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
mx = max(Espqk[157:*])
mn = min(Espqk[157:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'RIBBON-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot, timearr[157:*],Esprb[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx]
device,/close
set_plot,mydevice


;;;2832
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-QK-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2832'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,map2832[150:*].time, Fmgwqk[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-QK-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2832'+angstrom+'-QUAKE-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot,map2832[150:*].time, Emgwqk[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-RB-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2832'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,map2832[150:*].time, Fmgwrb[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-RB-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2832'+angstrom+'-RIBBON-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot,map2832[150:*].time, Emgwrb[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
device,/close
set_plot,mydevice

;;;2796
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-QK-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2796'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,submg[100:*].time, Fmgqk[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-QK-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2796'+angstrom+'-QUAKE-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot,submg[100:*].time, Emgqk[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-RB-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2796'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,submg[100:*].time, Fmgrb[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-RB-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2796'+angstrom+'-RIBBON-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot,submg[100:*].time, Emgrb[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

;;;1400
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-QK-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-1400'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,map1400[450:*].time, Fsiqk[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-QK-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-1400'+angstrom+'-QUAKE-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot,map1400[450:*].time, Esiqk[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-RB-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-1400'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = flux
utplot,map1400[450:*].time, Fsirb[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-RB-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-1400'+angstrom+'-RIBBON-LOCATION-ENERGY' ,/remove_all)
ytitl = energy
utplot,map1400[450:*].time, Esirb[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;FLARE AREA PLOTS: FLUX AND ENERGY: F_area_siiv, F_area_mgii, F_area_mgiiw

;;;;;;;;;;;;;;;;;;HMI
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'FLARE-AREA-FLUX' ,/remove_all)
ytitl = flux
utplot,diff[36:78].time, F_area_hmi[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'FLARE-AREA-ENERGY' ,/remove_all)
ytitl = energy
utplot, diff[36:78].time,E_area_hmi[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice


;;;;;;;;;;;;;;;;;;Si IV
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-1400'+angstrom+'-FLARE-AREA-FLUX' ,/remove_all)
ytitl = flux
utplot,map1400[450:*].time, F_area_siiv[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-1400-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-1400'+angstrom+'-FLARE-AREA-ENERGY' ,/remove_all)
ytitl = energy
utplot,map1400[450:*].time, E_area_siiv[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;Mg II h&k


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2796'+angstrom+'-FLARE-AREA-FLUX' ,/remove_all)
ytitl = flux
utplot,submg[100:*].time, F_area_mgii[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2796-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2796'+angstrom+'-FLARE-AREA-ENERGY' ,/remove_all)
ytitl = energy
utplot,submg[100:*].time, E_area_mgii[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mg II w

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2832'+angstrom+'-FLARE-AREA-FLUX' ,/remove_all)
ytitl = flux
utplot,map2832[150:*].time, F_area_mgiiw[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'IRIS-2832-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('IRIS-2832'+angstrom+'-FLARE-AREA-ENERGY' ,/remove_all)
ytitl = energy
utplot,map2832[150:*].time, E_area_mgiiw[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
device,/close
set_plot,mydevice

end

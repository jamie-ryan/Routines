pro iris_plots
!EXCEPT=2 ;will highlight parts of the code that cause floating point errors
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'

dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'


fmg = findfile(datdir+'*mgii-high*')
fmgw = findfile(datdir+'*mgiiw-high*')
fsi = findfile(datdir+'*siiv-high*')
fsp = iris_files('../IRIS/*raster*.fits')

sample = 1

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'


nmg = n_elements(submg[17:*])
nmgw = n_elements(diff2832[*])
nsi = n_elements(map1400[387:*])
nn = n_elements(fsp)


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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	;;;mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	com = 'boxarrmg'+string(j,format = '(I0)')+' = fltarr(nmg)'
	exe = execute(com)
	;loop to fill arrays with summed pixel intensity values
	for i = 0, nmg-1, 1 do begin
		com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) '
		exe = execute(com)
	endfor
	;;;flux and energy of flare area
	com = 'iris_radiometric_calibration,boxarrmg'+string(j,format = '(I0)')+ $
	', wave = 2796, n_pixels = nlinesmg ,F_area_mgii'+string(j,format = '(I0)')+ $
	', E_area_mgii'+string(j,format = '(I0)')+' ,/sji'
	exe = execute(com)


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
		com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[387 + i].data[hsi[0,*],hsi[1,*]]) '
		exe = execute(com)
	endfor
	;;;flux and energy of flare area
	com = 'iris_radiometric_calibration, boxarrsi'+string(j,format = '(I0)')+ $
	', wave = 1400, n_pixels = nlinessi , F_area_siiv'+string(j,format = '(I0)')+ $
	', E_area_siiv'+string(j,format = '(I0)')+' ,/sji'

	exe = execute(com)

	;;;;;;;;;;;;;;;;;;Si IV
	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'IRIS-1400-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('IRIS-1400'+angstrom+'-FLARE-AREA-FLUX' ,/remove_all)
	ytitl = flux
	com = 'F = F_area_siiv'+string(j,format = '(I0)')
	exe = execute(com)
	utplot,map1400[450:*].time, F[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
	device,/close
	set_plot,mydevice

	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'IRIS-1400-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('IRIS-1400'+angstrom+'-FLARE-AREA-ENERGY' ,/remove_all)
	ytitl = energy
	com = 'E = E_area_siiv'+string(j,format = '(I0)')
	exe = execute(com)
	utplot,map1400[450:*].time, E[63:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  /ylog,xmargin = [12,3]
	device,/close
	set_plot,mydevice

	;;;;;;;;;;;;;;;;;;;Mg II h&k


	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'IRIS-2796-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('IRIS-2796'+angstrom+'-FLARE-AREA-FLUX' ,/remove_all)
	ytitl = flux
	com = 'F = F_area_mgii'+string(j,format = '(I0)')
	exe = execute(com)
	utplot,submg[100:*].time, F[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
	device,/close
	set_plot,mydevice

	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'IRIS-2796-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('IRIS-2796'+angstrom+'-FLARE-AREA-ENERGY' ,/remove_all)
	ytitl = energy
	com = 'E = E_area_mgii'+string(j,format = '(I0)')
	exe = execute(com)
	utplot,submg[100:*].time, E[83:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, /ylog,xmargin = [12,3]
	device,/close
	set_plot,mydevice

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mg II w

	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'IRIS-2832-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('IRIS-2832'+angstrom+'-FLARE-AREA-FLUX' ,/remove_all)
	ytitl = flux
	com = 'F = F_area_mgiiw'+string(j,format = '(I0)')
	exe = execute(com)
	utplot,map2832[150:*].time, F[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
	device,/close
	set_plot,mydevice


	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'IRIS-2832-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('IRIS-2832'+angstrom+'-FLARE-AREA-ENERGY' ,/remove_all)
	ytitl = energy
	com = 'E = E_area_mgiiw'+string(j,format = '(I0)')
	exe = execute(com)
	utplot,map2832[150:*].time, E[150:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,xmargin = [12,3]
	device,/close
	set_plot,mydevice

endfor


qkirxa = 519.
qkirya = 262.
;;;convert arcsecs to pixels
qkmgxp = 588 
qkmgyp = 441 
rbmgxp = 504 
rbmgyp = 487 

qksixp = 588 
qksiyp = 441 
rbsixp = 511 
rbsiyp = 485 

;set up arrays
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

spboxarr = fltarr(sample*nn)
timearr = strarr(sample*nn)
rbboxarr = fltarr(sample*nn)


;;;;;;;;;FILL ARRAYS

;;SI IV 1400
for i = 0, nsi-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qksimax[i] = map1400[387 + i].data[qksixp, qksiyp]
;;calculate contrast value for ribbon pixel on all frames to save time
rbsimax[i] = map1400[387 + i].data[rbsixp, rbsiyp]
endfor
;calculate flux and energy
iris_radiometric_calibration, qksimax, wave = 1400., n_pixels = 1, Fsiqk, Esiqk, /sji
iris_radiometric_calibration, rbsimax, wave = 1400., n_pixels = 1,Fsirb, Esirb, /sji


;;MG II 2796
for i = 0, nmg-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgmax[i] = submg[17 + i].data[qkmgxp, qkmgyp]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgmax[i] = submg[17 + i].data[rbmgxp, rbmgyp]
endfor
;calculate flux and energy
iris_radiometric_calibration, qkmgmax, wave = 2976., n_pixels = 1,Fmgqk, Emgqk, /sji
iris_radiometric_calibration, rbmgmax, wave = 2976., n_pixels = 1,Fmgrb, Emgrb, /sji


;;BALMER
;sp quake
for i = 0, nn-1, 1 do begin
	comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
	exet1 = execute(comt)
	comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
	exet = execute(comi)
endfor
;calculate flux and energy

tsp = timearr

;sp ribbon
for i = 0, nn-1, 1 do begin
	comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
	exet = execute(comi)
endfor
;calculate flux and energy
w1 = sp2826.tag00.wvl[39]
w2 = sp2826.tag00.wvl[44]
iris_radiometric_calibration, spboxarr, wave = [w1, w2], n_pixels = 10,Fspqk, Espqk ,/sg
iris_radiometric_calibration, rbboxarr, wave = [w1, w2], n_pixels = 5,Fsprb, Esprb ,/sg


;;MGW 2832
for i = 0, nmgw-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgwmax[i] = map2832[i].data[588,441 ]  ;559, 441
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgwmax[i] = map2832[i].data[483, 475]
endfor   
;calculate flux and energy
iris_radiometric_calibration, qkmgwmax, wave = 2832., n_pixels = 1,Fmgwqk, Emgwqk, /sji
iris_radiometric_calibration, rbmgwmax, wave = 2832., n_pixels = 1,Fmgwrb, Emgwrb, /sji



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



;;;time arrays for .sav
tmg = submg[17:*].time
tmgw = diff2832.time
tsi = map1400[387:*].time
tsp = timearr

;;;MAKE SAVE FILE
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2
save, $
F_area_siiv0, E_area_siiv0, $
F_area_siiv1, E_area_siiv1, $
F_area_siiv2, E_area_siiv2, $
F_area_siiv3, E_area_siiv3, $
F_area_mgii0, E_area_mgii0, $
F_area_mgii1, E_area_mgii1, $
F_area_mgii2, E_area_mgii2, $
F_area_mgii3, E_area_mgii3, $
F_area_mgiiw0, E_area_mgiiw0, $
F_area_mgiiw1, E_area_mgiiw1, $
F_area_mgiiw2, E_area_mgiiw2, $
F_area_mgiiw3, E_area_mgiiw3, $
Fspqk, Espqk, $
Fsprb, Esprb, $
Fsiqk, Esiqk, $
Fsirb, Esirb, $
Fmgqk, Emgqk, $
Fmgrb, Emgrb, $
Fmgwqk, Emgwqk, $
Fmgwrb, Emgwrb, $
tmg,  $
tmgw,  $
tsi,  $
tsp,  $
filename = 'iris-energies-'+date+'.sav'
end

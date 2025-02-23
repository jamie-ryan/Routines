;+
; NAME:
;       lcseries   
; PURPOSE: 
;       isolate HMI and IRIS lightcurve data from flare event. Convert to real units, calculate energy, save and plot.
;
; CALLING SEQUENCE: 
;       lcseries, plot = plot, sav = sav
;
; INPUT PARAMETERS: 
;       
;	
;
; OUTPUT PARAMETERS:
;       .sav files	will make .sav files containing flux and energy arrays for flare area, quake and ribbon location.
;       plots		plots light curves.        
;
; EXAMPLES:
;       IDL>lcseries, /plot, /sav
; PROCEDURE:
;       
; NOTES:
;       
; MODIFICATION HISTORY:
;       Written 13/03/15 by Jamie Ryan
;	modified 14/08/15

pro lcseries, plot = plot, sav = sav

restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'

dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'

ff = findfile(datdir+'hmi-high*')
fmg = findfile(datdir+'*mgii-high*')
fmgw = findfile(datdir+'*mgiiw-high*')
fsi = findfile(datdir+'*siiv-high*')
fsp = iris_files('../IRIS/*raster*.fits')

sample = 1

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'

nnn = n_elements(diff)
nmg = n_elements(submg[17:*])
nmgw = n_elements(diff2832[*])
nsi = n_elements(map1400[387:*])
nn = n_elements(fsp)

for j = 0, n_elements(ff) - 1 do begin
	;;;;;;;open files 
	openr,lun,ff[j],/get_lun

	;;;count lines in file
	nlines = file_lines(ff[j])

	;;;make array to fill with values from the file
	h=intarr(2,nlines)

	;;;read file contents into array
	readf,lun,h

	;;close file and free up file unit number
	free_lun, lun
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	;;hmi;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	com = 'boxarr'+string(j,format = '(I0)')+' = fltarr(nnn)'
	exe = execute(com)
	;bgarr = fltarr(nnn)
	for i = 0, nnn-1, 1 do begin
		com = 'boxarr'+string(j,format = '(I0)')+'[i] = total(diff[i].data[h[0,*],h[1,*]])'
		exe = execute(com) 
	endfor
	;;;;;intensity of flare area in erg/s.cm^2.sr
	com = 'hmi_radiometric_calibration, boxarr'+string(j,format = '(I0)')+', n_pixels = nlines, F_area_hmi, E_area_hmi'
	exe = execute(com)


	;;;mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	com = 'boxarrmg'+string(j,format = '(I0)')+' = fltarr(nmg)'
	exe = execute(com)
	;loop to fill arrays with summed pixel intensity values
	for i = 0, nmg-1, 1 do begin
		com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) '
		exe = execute(com)
	endfor
	;;;flux and energy of flare area
	com = 'iris_flux_energy,boxarrmg'+string(j,format = '(I0)')+', wave = [2796],F_area_mgii, E_area_mgii ,/sji'
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
	com = 'iris_flux_energy,boxarrmgw'+string(j,format = '(I0)')+', wave = [2832],F_area_mgiiw, E_area_mgiiw ,/sji'
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
	com = 'iris_flux_energy,boxarrsi'+string(j,format = '(I0)')+', wave = [1400],F_area_siiv, E_area_siiv ,/sji'
	exe = execute(com)

	;INSERT AREA PLOTS HERE!!!
	if keyword_set(plot) then begin
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;FLARE AREA PLOTS: FLUX AND ENERGY:

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
	endif

	if keyword_set(sav) then begin
		thmi = diff.time
		tmg = submg[17:*].time
		tmgw = diff2832.time
		tsi = map1400[387:*].time
		com = 'fsav = flare-area-flux-energy-hmi-iris-'+string(j,format = '(I0)')+'.sav'
		exe = execute(com)
		save, $
		thmi,  $
		tmg,  $
		tmgw,  $
		tsi,  $
		F_area_hmi, $
		E_area_hmi, $
		F_area_siiv, $
		E_area_siiv, $
		F_area_mgii, $
		E_area_mgii, $
		F_area_mgiiw, $
		E_area_mgiiw,  $
		filename = fsav
	endif
endfor




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;QUAKE AND RIBBON LOCATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;QUAKE AND RIBBON COORDINATES
;HMI
qkxa = 517.2
qkya = 261.4

rbxa = 511
rbya = 272
rbxpcorr = 39
rbypcorr = 90
;;;convert arcsecs to pixels
qkxp = (qkxa/diffindex[0].cdelt1) + diffindex[0].crpix1 - 1
qkyp = (qkya/diffindex[0].cdelt2) + diffindex[0].crpix2 - 1


;IRIS
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




;;;;;CONTRAST CONSTANTS
;;non-flare DN/pixel for contrasts 
nlinessi = file_lines(fsi[2])
nlinesmg = file_lines(fmg[2])

imin = 500 ;hmi
iminsi = total(boxarrsi2[0:71])/(72*nlinessi) ;si 
iminmg = total(boxarrmg2[0:95])/(96*nlinesmg) ; mg
iminmgw = 750 ;mgw
iminmgwrb = 250 ;mgw
spimin = 200 ;balmer qk
sprbimin = 75 ;balmer rb


;;;SETUP ARRAYS
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

spboxarr = fltarr(sample*nn)
timearr = strarr(sample*nn)
rbboxarr = fltarr(sample*nn)


;;;;;;;;;FILL ARRAYS

;;SI IV 1400
for i = 0, nsi-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qksimax[i] = map1400[387 + i].data[qksixp, qksiyp]
qksicontrast[i] = (qksimax[i] - iminsi[0])/iminsi[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbsimax[i] = map1400[387 + i].data[rbsixp, rbsiyp]
rbsicontrast[i] = (rbsimax[i] - iminsi[0])/iminsi[0]
endfor
;calculate flux and energy
iris_flux_energy, qksiwmax, wave = 1400., Fsiqk, Esiqk, /sji
iris_flux_energy, rbsiwmax, wave = 1400., Fsirb, Esirb, /sji


;;MG II 2796
for i = 0, nmg-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgmax[i] = submg[17 + i].data[qkmgxp, qkmgyp]
qkmgcontrast[i] = (qkmgmax[i] - iminmg[0])/iminmg[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgmax[i] = submg[17 + i].data[rbmgxp, rbmgyp]
rbmgcontrast[i] = (rbmgmax[i] - iminmg[0])/iminmg[0]
endfor
;calculate flux and energy
iris_flux_energy, qkmgmax, wave = 2976., Fmgqk, Emgqk, /sji
iris_flux_energy, rbmgmax, wave = 2976., Fmgrb, Emgrb, /sji


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
	comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39)*2)'
	exet = execute(comi)
endfor
;calculate flux and energy
w1 = sp2826.tag00.wvl[39]
w2 = sp2826.tag00.wvl[44]
iris_flux_energy, spboxarr, wave = [w1, w2],Fspqk, Espqk ,/sg
iris_flux_energy, rbboxarr, wave = [w1, w2],Fsprb, Esprb ,/sg


;;MGW 2832
for i = 0, nmgw-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgwmax[i] = map2832[i].data[588,441 ]  ;559, 441
qkmgwcontrast[i] = (qkmgwmax[i] - iminmgw[0])/iminmgw[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgwmax[i] = map2832[i].data[483, 475]
rbmgwcontrast[i] = (rbmgwmax[i] - iminmgwrb)/iminmgwrb
endfor   
;calculate flux and energy
iris_flux_energy, qkmgwmax, wave = 2832., Fmgwqk, Emgwqk, /sji
iris_flux_energy, rbmgwmax, wave = 2832., Fmgwrb, Emgwrb, /sji


;HMI
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;MAKE SAVE FILE
if keyword_set(sav) then begin
	save, $
	Fsprb, $
	Esprb, $
	Fsiqk, $
	Esiqk,  $
	Fsirb, $
	Esirb,  $
	Fmgqk,  $
	Fmgrb,  $
	Emgqk,  $
	Emgrb,  $
	Fmgwqk,  $
	Emgwrb,  $
	Fmgwrb,  $
	Emgwrb, $
	thmi,  $
	tmg,  $
	tmgw,  $
	tsi,  $
	tsp,  $
	filename = 'flux-energy-hmi-iris.sav'
endif

IF KEYWORD_SET(PLOT) THEN BEGIN
	;;;;CONTRASTS
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

	spimax = max(spboxarr)
	rbimax = max(rbboxarr)
	spqkcontrast = ((spimax-spimin[0])/spimin[0])
	sprbcontrast = ((rbimax-sprbimin[0])/sprbimin[0])
	spqkcontrastr = string(spqkcontrast, format = '(f0.2)')
	sprbcontrastr = string(sprbcontrast, format = '(f0.2)')
	spqkconstr = strcompress(spqkcontrastr, /remove_all)
	sprbconstr = strcompress(sprbcontrastr, /remove_all)



	;;;;INDIVIDUAL QUAKE PLOTS

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
ENDIF

end

pro hmi_plots
restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'

dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'


ff = findfile(datdir+'hmi-high*')

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'

nnn = n_elements(diff)

for j = 0, n_elements(ff) do begin
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

	com = 'boxarr'+string(j,format = '(I0)')+' = fltarr(nnn)'
	exe = execute(com)
	;bgarr = fltarr(nnn)
	for i = 0, nnn-1, 1 do begin
		com = 'boxarr'+string(j,format = '(I0)')+'[i] = total(diff[i].data[h[0,*],h[1,*]])'
		exe = execute(com) 
	endfor
	;;;;;intensity of flare area in erg/s.cm^2.sr
	com = 'hmi_radiometric_calibration, boxarr'+string(j,format = '(I0)')+ $
	', n_pixels = nlines, F_area_hmi'+string(j,format = '(I0)')+ $
	', E_area_hmi'+string(j,format = '(I0)')+''
	exe = execute(com)


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;FLARE AREA PLOTS: FLUX AND ENERGY:
	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'HMI-CONTINUUM-6173-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'FLARE-AREA-FLUX' ,/remove_all)
	ytitl = flux
	com = 'F = F_area_hmi'+string(j,format = '(I0)')
	exe = execute(com)
	utplot,diff[36:78].time, F[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
	device,/close
	set_plot,mydevice

	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'HMI-CONTINUUM-6173-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'FLARE-AREA-ENERGY' ,/remove_all)
	ytitl = energy
	com = 'E = E_area_hmi'+string(j,format = '(I0)')
	exe = execute(com)
	utplot, diff[36:78].time,E[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
	device,/close
	set_plot,mydevice
endfor


qkxa = 517.2
qkya = 261.4

rbxa = 511
rbya = 272
rbxpcorr = 39
rbypcorr = 90
;;;convert arcsecs to pixels
qkxp = (qkxa/diffindex[0].cdelt1) + diffindex[0].crpix1 - 1
qkyp = (qkya/diffindex[0].cdelt2) + diffindex[0].crpix2 - 1

;;;set up single pixel arrays
qkimax = fltarr(nnn)
rbimax = fltarr(nnn)

;HMI single pixel
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


;;;;;SINGLE PIXEL PLOTS
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



;HMI quake area array
qkarea = fltarr(nnn)
;based on the four iris pixels (4*0.1667") flagged by quake_area.pro.....more detailed version needed
;assuming 2 iris pixels relate to the radius of a circular quake impact, 
;but 0.505/0.1667 = 3 therefore 3 iris pixels equal one hmi pixel, which sets minimum resolution
;iris_quake_radius = 2*(0.1667*7.5e5)  
;iris_quake_area = !pi*quake_radius^2 
for i= 0, nnn-1 do begin
	qkarea[i] = diff[i].data[qkxp, qkyp] + $
	diff[i].data[qkxp, qkyp + 1] + $
	diff[i].data[qkxp - 1, qkyp + 1] + $
	diff[i].data[qkxp - 1, qkyp] + $
	diff[i].data[qkxp - 1, qkyp - 1] + $
	diff[i].data[qkxp, qkyp - 1] + $
	diff[i].data[qkxp + 1, qkyp - 1] + $
	diff[i].data[qkxp + 1, qkyp] + $
	diff[i].data[qkxp + 1, qkyp + 1]
endfor
hmi_radiometric_calibration, qkarea, n_pixels = 9, Fqk_9px_area, Eqk_9px_area

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-QK-AREA-FLUX.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'QUAKE-AREA-INTENSITY' ,/remove_all)
ytitl = flux
utplot,diff[36:78].time, Fqk_9px_area[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'HMI-CONTINUUM-6173-QK-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'QUAKE-AREA-ENERGY' ,/remove_all)
ytitl = flux
utplot,diff[36:78].time, Eqk_9px_area[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz
device,/close
set_plot,mydevice

save, $
F_area_hmi0, E_area_hmi0, $
F_area_hmi1, E_area_hmi1, $
F_area_hmi2, E_area_hmi2, $
F_area_hmi3, E_area_hmi3, $
Fhmiqk, Ehmiqk, $
Fhmirb, Ehmirb, $
Fqk_9px_area, Eqk_9px_area, $
filename = 'hmi-energies.sav'
end

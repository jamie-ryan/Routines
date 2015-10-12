pro ladder, allpix = allpix, areapix = areapix, singlepix = singlepix, quakepix = quakepix, multi_ribbon = multi_ribbon

;set number of plots manually for now....later include in call command
;n_plts = 6 ;with rhessi x 1, iris x 4, hmi x 1
;n_plts = 5 ;iris x 4, hmi x 1

;RHESSI

;IRIS 1400SJ, 2796SJ, BalmerSG, 2832SJ, HMI
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'


;;strings;;;;;;;;;;;;; 
;for plots
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
fsp = iris_files('../IRIS/*raster*.fits')
;ffsp = findfile(datdir+'*balmer-high*')
ff = findfile(datdir+'hmi-high*')

sample = 1



nmg = n_elements(submg[17:*])
nmgw = n_elements(diff2832[*])
nsi = n_elements(map1400[387:*])
nn = n_elements(fsp)
nnn = n_elements(diff)

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

;SDO HMI 
qkxa = 517.2
qkya = 261.4
rbxa = 511
rbya = 272
rbxpcorr = 39
rbypcorr = 90
;;;convert arcsecs to pixels
qkxp = (qkxa/diffindex[0].cdelt1) + diffindex[0].crpix1 - 1
qkyp = (qkya/diffindex[0].cdelt2) + diffindex[0].crpix2 - 1



		if keyword_set(areapix) then begin
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
					com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) '
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
					com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[387 + i].data[hsi[0,*],hsi[1,*]]) '
					exe = execute(com)
				endfor
				;;;flux and energy of flare area
				com = 'iris_radiometric_calibration, boxarrsi'+string(j,format = '(I0)')+ $
				', wave = 1400, n_pixels = nlinessi , F_area_siiv'+string(j,format = '(I0)')+ $
				', E_area_siiv'+string(j,format = '(I0)')+' ,/sji'

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
				com = 'hmi_radiometric_calibration, boxarr'+string(j,format = '(I0)')+ $
				', n_pixels = nlines, F_area_hmi'+string(j,format = '(I0)')+ $
				', E_area_hmi'+string(j,format = '(I0)')+''
				exe = execute(com)
	
	

				;FLARE-RIBBON AREA PLOTS
				;calculate plotting position coordinates for ladder plots
				plot_pos_calc, n_plots = 4, xpos, ypos

				;;;;;;;;;;;;;;;;;;
				;;;Flux v Time
				;;;;;;;;;;;;;;;;;;
				mydevice=!d.name
				set_plot,'ps'
				fnm = dir+'29-Mar-14-Area-Flux-Ladder'+date+'.eps'
				device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
				titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
				ytitl = flux

				;;;;;;;;;;;;;;;;;;RHESSI
			;	o = 4
			;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
			;
			;	utplot,rhessi.time, Frhessi[*], $
			;	linestyle = 0, $
			;	ytitle = ytitl, $
			;	/ynoz, $
			;	/ylog, $
			;	xmargin = [12,3], $
			;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
			;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

				;;;;;;;;;;;;;;;;;;Si IV
				o = 3
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'F = F_area_siiv'+string(j,format = '(I0)')
				exe = execute(com)

				utplot, map1400[450:*].time, F[63:*], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $
				/ylog, $
				xmargin = [12,3], $
				position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


				;;;;;;;;;;;;;;;;;;Mg II	h&k
				o = 2
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'F = F_area_mgii'+string(j,format = '(I0)')
				exe = execute(com)

				utplot,submg[100:*].time, F[83:*], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $
				/ylog, $
				xmargin = [12,3], $
				position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm


				;;;;;;;;;;;;;;;;;;Mg II	wing
				o = 1
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'F = F_area_mgiiw'+string(j,format = '(I0)')
				exe = execute(com)

				utplot, map2832[150:*].time, F[150:*], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $
				/ylog, $
				xmargin = [12,3], $	
				position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

				;;;;;;;;;;;;;;;;;;HMI continuum
				o = 0
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'F = F_area_hmi'+string(j,format = '(I0)')
				exe = execute(com)

				utplot, diff[36:78].time, F[36:78], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $ 
				xmargin = [12,3], $
			 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'SDO HMI continuum', /norm

				;;;;;;;;;;;;;
				device,/close
				set_plot,mydevice



				;;;;;;;;;;;;;;;;;;;;
				;;;;;Energy vs Time
				;;;;;;;;;;;;;;;;;;;;
				mydevice=!d.name
				set_plot,'ps'
				fnm = dir+'29-Mar-14-Area-Energy-Ladder'+date+'.eps'
				device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
				titl =  strcompress('29-Mar-14-Flare-Energy' ,/remove_all)
				ytitl = energy

				;;;;;;;;;;;;;;;;;;RHESSI
			;	o = 4
			;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
			;
			;	utplot,rhessi.time, Erhessi[*], $
			;	linestyle = 0, $
			;	ytitle = ytitl, $
			;	/ynoz, $
			;	/ylog, $
			;	xmargin = [12,3], $
			;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
			;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

				;;;;;;;;;;;;;;;;;;Si IV
				o = 3
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'E = E_area_siiv'+string(j,format = '(I0)')
				exe = execute(com)

				utplot,map1400[450:*].time, E[63:*], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $
				/ylog, $
				xmargin = [12,3], $
				position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


				;;;;;;;;;;;;;;;;;;Mg II	h&k
				o = 2
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'E = E_area_mgii'+string(j,format = '(I0)')
				exe = execute(com)

				utplot,submg[100:*].time, E[83:*], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $
				/ylog, $
				xmargin = [12,3], $
				position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm


				;;;;;;;;;;;;;;;;;;Mg II	wing
				o = 1
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'E = E_area_mgiiw'+string(j,format = '(I0)')
				exe = execute(com)

				utplot, map2832[150:*].time, E[150:*], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $
				/ylog, $
				xmargin = [12,3], $	
				position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

				;;;;;;;;;;;;;;;;;;HMI continuum
				o = 0
				xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
				xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

				com = 'E = E_area_hmi'+string(j,format = '(I0)')
				exe = execute(com)

				utplot, diff[36:78].time, E[36:78], $
				linestyle = 0, $
				ytitle = ytitl, $
				/ynoz, $ 
				xmargin = [12,3], $
			 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
				xyouts, xyx, xyy, 'SDO HMI continuum', /norm

				;;;;;;;;;;;;;
				device,/close
				set_plot,mydevice


		endfor
	endif ;areapix

	if keyword_set(singlepix) then begin

	;;;set up single pixel arrays
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

	qkimax = fltarr(nnn)
	rbimax = fltarr(nnn)


	;;;;;;;;;FILL ARRAYS

	;;SI IV 1400
	for i = 0, nsi-1, 1 do begin
	;;calculate contrast value for quake pixel on all frames to save time
	qksimax[i] = map1400[387 + i].data[qksixp, qksiyp]
	;;calculate contrast value for ribbon pixels on all frames to save time
	rbsimax[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax1[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax2[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax3[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax4[i] = map1400[387 + i].data[rbsixp, rbsiyp]
	endfor
	;calculate flux and energy
	iris_radiometric_calibration, qksimax, wave = 1400., n_pixels = 1, Fsiqk, Esiqk, /sji
	iris_radiometric_calibration, rbsimax, wave = 1400., n_pixels = 1,Fsirb, Esirb, /sji
;	iris_radiometric_calibration, rbsimax1, wave = 1400., n_pixels = 1,Fsirb1, Esirb1, /sji
;	iris_radiometric_calibration, rbsimax2, wave = 1400., n_pixels = 1,Fsirb2, Esirb2, /sji
;	iris_radiometric_calibration, rbsimax3, wave = 1400., n_pixels = 1,Fsirb3, Esirb3, /sji
;	iris_radiometric_calibration, rbsimax4, wave = 1400., n_pixels = 1,Fsirb4, Esirb4, /sji

	;;MG II 2796
	for i = 0, nmg-1, 1 do begin
	;;calculate contrast value for quake pixel on all frames to save time
	qkmgmax[i] = submg[17 + i].data[qkmgxp, qkmgyp]
	;;calculate contrast value for ribbon pixel on all frames to save time
	rbmgmax[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax1[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax2[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax3[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax4[i] = submg[17 + i].data[rbmgxp, rbmgyp]
	endfor
	;calculate flux and energy
	iris_radiometric_calibration, qkmgmax, wave = 2976., n_pixels = 1,Fmgqk, Emgqk, /sji
	iris_radiometric_calibration, rbmgmax, wave = 2976., n_pixels = 1,Fmgrb, Emgrb, /sji
;	iris_radiometric_calibration, rbmgmax1, wave = 2976., n_pixels = 1,Fmgrb1, Emgrb1, /sji
;	iris_radiometric_calibration, rbmgmax2, wave = 2976., n_pixels = 1,Fmgrb2, Emgrb2, /sji
;	iris_radiometric_calibration, rbmgmax3, wave = 2976., n_pixels = 1,Fmgrb3, Emgrb3, /sji
;	iris_radiometric_calibration, rbmgmax4, wave = 2976., n_pixels = 1,Fmgrb4, Emgrb4, /sji


	;;BALMER
	;sp quake
	for i = 0, nn-1, 1 do begin
		comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
		exet1 = execute(comt)

		comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
		exet = execute(comi)

		comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
		exet = execute(comi)

;		comi = 'rbboxarr1[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

;		comi = 'rbboxarr2[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

;		comi = 'rbboxarr3[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

;		comi = 'rbboxarr4[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

	endfor
	;calculate flux and energy

	tsp = timearr

	;sp ribbon
	for i = 0, nn-1, 1 do begin
	endfor
	;calculate flux and energy
	w1 = sp2826.tag00.wvl[39]
	w2 = sp2826.tag00.wvl[44]
	iris_radiometric_calibration, spboxarr, wave = [w1, w2], n_pixels = 10,Fspqk, Espqk ,/sg
	iris_radiometric_calibration, rbboxarr, wave = [w1, w2], n_pixels = 5,Fsprb, Esprb ,/sg
;	iris_radiometric_calibration, rbboxarr1, wave = [w1, w2], n_pixels = 5,Fsprb1, Esprb1 ,/sg
;	iris_radiometric_calibration, rbboxarr2, wave = [w1, w2], n_pixels = 5,Fsprb2, Esprb2 ,/sg
;	iris_radiometric_calibration, rbboxarr3, wave = [w1, w2], n_pixels = 5,Fsprb3, Esprb3 ,/sg
;	iris_radiometric_calibration, rbboxarr4, wave = [w1, w2], n_pixels = 5,Fsprb4, Esprb4 ,/sg


	;;MGW 2832
	for i = 0, nmgw-1, 1 do begin
	;;calculate contrast value for quake pixel on all frames to save time
	qkmgwmax[i] = map2832[i].data[588,441 ]  ;559, 441
	;;calculate contrast value for ribbon pixel on all frames to save time
	rbmgwmax[i] = map2832[i].data[483, 475]
;	rbmgwmax1[i] = map2832[i].data[483, 475]
;	rbmgwmax2[i] = map2832[i].data[483, 475]
;	rbmgwmax3[i] = map2832[i].data[483, 475]
;	rbmgwmax4[i] = map2832[i].data[483, 475]
	endfor   
	;calculate flux and energy
	iris_radiometric_calibration, qkmgwmax, wave = 2832., n_pixels = 1,Fmgwqk, Emgwqk, /sji
	iris_radiometric_calibration, rbmgwmax, wave = 2832., n_pixels = 1,Fmgwrb, Emgwrb, /sji
;	iris_radiometric_calibration, rbmgwmax1, wave = 2832., n_pixels = 1,Fmgwrb1, Emgwrb1, /sji
;	iris_radiometric_calibration, rbmgwmax2, wave = 2832., n_pixels = 1,Fmgwrb2, Emgwrb2, /sji
;	iris_radiometric_calibration, rbmgwmax3, wave = 2832., n_pixels = 1,Fmgwrb3, Emgwrb3, /sji
;	iris_radiometric_calibration, rbmgwmax4, wave = 2832., n_pixels = 1,Fmgwrb4, Emgwrb4, /sji

	;HMI single pixel
	for i = 0, nnn-1, 1 do begin
	;;calculate contrast value for quake pixel on all frames to save time
	qkimax[i] = diff[i].data[qkxp, qkyp]
	rbimax[i] = diff[i].data[rbxpcorr, rbypcorr]
;	rbimax1[i] = diff[i].data[rbxpcorr, rbypcorr]
;	rbimax2[i] = diff[i].data[rbxpcorr, rbypcorr]
;	rbimax3[i] = diff[i].data[rbxpcorr, rbypcorr]
;	rbimax4[i] = diff[i].data[rbxpcorr, rbypcorr]
	endfor
	;calculate flux and energy???
	hmi_radiometric_calibration, qkimax, n_pixels = 1, Fhmiqk, Ehmiqk
	hmi_radiometric_calibration, rbimax, n_pixels = 1, Fhmirb, Ehmirb
;	hmi_radiometric_calibration, rbimax1, n_pixels = 1, Fhmirb1, Ehmirb1
;	hmi_radiometric_calibration, rbimax2, n_pixels = 1, Fhmirb2, Ehmirb2
;	hmi_radiometric_calibration, rbimax3, n_pixels = 1, Fhmirb3, Ehmirb3
;	hmi_radiometric_calibration, rbimax4, n_pixels = 1, Fhmirb4, Ehmirb4

			;;;;;;;;;;;;;;;;;;;;
			;;;;;Quake Pixel Flux vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Quake-Pixel-Flux-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Quake-Pixel-Flux' ,/remove_all)
			ytitl = flux

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fsiqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, F[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fmgqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, F[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fspqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], F[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fmgwqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, F[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fhmiqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, F[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


			;;;;;;;;;;;;;;;;;;;;
			;;;;;Quake Pixel Energy vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Quake-Pixel-Energy-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Quake-Pixel-Energy' ,/remove_all)
			ytitl = energy

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esiqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, E[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, E[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Espqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], E[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm



			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgwqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, E[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Ehmiqk'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, E[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;Ribbon Pixels Flux vs Time
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Fsirb, Esirb, Fmgrb, Emgrb, Fsprb, Esprb, Fmgwrb, Emgwrb, Fhmirb, Ehmirb
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Ribbon Pixel 1
			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 1 Flux vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-1-Flux-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-1-Flux' ,/remove_all)
			ytitl = flux

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fsirb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, F[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fmgrb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, F[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fsprb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], F[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fmgwrb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, F[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fhmirb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, F[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice

			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 1 Energy vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-1-Energy-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-1-Energy' ,/remove_all)
			ytitl = energy

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esirb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, E[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgrb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, E[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esprb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], E[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm



			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgwrb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, E[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Ehmirb'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, E[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice

		if keyword_set(multi_ribbon) then begin
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Ribbon Pixel 2
			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 2 Flux vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-2-Flux-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-2-Flux' ,/remove_all)
			ytitl = flux

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fsirb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, F[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fmgrb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, F[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fsprb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], F[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fmgwrb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, F[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fhmirb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, F[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 2 Energy vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-2-Energy-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-2-Energy' ,/remove_all)
			ytitl = energy

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esirb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, E[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgrb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, E[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esprb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], E[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm



			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgwrb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, E[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Ehmirb1'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, E[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Ribbon Pixel 3
			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 3 Flux vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-3-Flux-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-3-Flux' ,/remove_all)
			ytitl = flux

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fsirb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, F[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fmgrb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, F[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fsprb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], F[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fmgwrb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, F[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fhmirb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, F[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 3 Energy vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-3-Energy-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-3-Energy' ,/remove_all)
			ytitl = energy

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esirb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, E[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgrb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, E[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esprb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], E[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm



			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgwrb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, E[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Ehmirb2'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, E[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Ribbon Pixel 4
			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 4 Flux vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-4-Flux-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-4-Flux' ,/remove_all)
			ytitl = flux

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fsirb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, F[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fmgrb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, F[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fsprb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], F[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fmgwrb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, F[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fhmirb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, F[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 4 Energy vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-4-Energy-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-4-Energy' ,/remove_all)
			ytitl = energy

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esirb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, E[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgrb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, E[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esprb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], E[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm



			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgwrb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, E[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Ehmirb3'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, E[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice

			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Ribbon Pixel 5
			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 5 Flux vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-5-Flux-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-5-Flux' ,/remove_all)
			ytitl = flux

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fsirb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, F[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fmgrb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, F[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Fsprb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], F[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fmgwrb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, F[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'F = Fhmirb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, F[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice


			;;;;;;;;;;;;;;;;;;;;
			;;;;;Ribbon Pixel 5 Energy vs Time
			;;;;;;;;;;;;;;;;;;;;
			mydevice=!d.name
			set_plot,'ps'
			fnm = dir+'29-Mar-14-Ribbon-Pixel-5-Energy-Ladder'+date+'.eps'
			device,filename=fnm,/portrait,/encapsulated, decomposed=0,color=1
			titl =  strcompress('29-Mar-14-Ribbon-Pixel-5-Energy' ,/remove_all)
			ytitl = energy

			;;;;;;;;;;;;;;;;;;RHESSI
		;	o = 5
		;	xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
		;	xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange
		;
		;	utplot,rhessi.time, Erhessi[*], $
		;	linestyle = 0, $
		;	ytitle = ytitl, $
		;	/ynoz, $
		;	/ylog, $
		;	xmargin = [12,3], $
		;	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
		;	xyouts, xyx, xyy, 'RHESSI HXR 10 - 100 keV '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;Si IV
			o = 4
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esirb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,map1400[450:*].time, E[63:*], $ ;map1400[450:*].time, Fsiqk[63:*]
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 1400 '+angstrom, /norm


			;;;;;;;;;;;;;;;;;;Mg II	h&k
			o = 3
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgrb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,submg[100:*].time, E[83:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2796 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;;Balmer
			o = 2
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Esprb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot,timearr[157:*], E[157:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'Balmer 2825.7-2825.8'+angstrom, /norm



			;;;;;;;;;;;;;;;;;;Mg II	wing
			o = 1
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Emgwrb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, map2832[150:*].time, E[150:*], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $
			/ylog, $
			xmargin = [12,3], $	
			position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'IRIS SJ 2832 '+angstrom, /norm

			;;;;;;;;;;;;;;;;;;HMI continuum
			o = 0
			xyx = xpos[0] + ((xpos[1] - xpos[0])/2) ;middle of xrange
			xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.9) ;y0 plus 90% of yrange

			com = 'E = Ehmirb4'+string(j,format = '(I0)')
			exe = execute(com)

			utplot, diff[36:78].time, E[36:78], $
			linestyle = 0, $
			ytitle = ytitl, $
			/ynoz, $ 
			xmargin = [12,3], $
		 	position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
			xyouts, xyx, xyy, 'SDO HMI continuum', /norm

			;;;;;;;;;;;;;
			device,/close
			set_plot,mydevice
		endif ;multi_ribbon

	endif ;singlepix



	if keyword_set(quakepix) then begin
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
	utplot,diff[36:78].time, Fqk_9px_area[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, xmargin = [12,3]
	device,/close
	set_plot,mydevice

	mydevice=!d.name
	set_plot,'ps'
	device,filename=dir+'HMI-CONTINUUM-6173-QK-AREA-ENERGY.eps',/portrait,/encapsulated, decomposed=0,color=1
	titl =  strcompress('HMI-CONTINUUM-6173'+angstrom+'QUAKE-AREA-ENERGY' ,/remove_all)
	ytitl = energy
	utplot,diff[36:78].time, Eqk_9px_area[36:78], linestyle = 0, title = titl, ytitle = ytitl,/ynoz, xmargin = [12,3]
	device,/close
	set_plot,mydevice
	endif ;quakepix

end


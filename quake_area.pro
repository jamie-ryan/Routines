pro quake_area, plot = plot
;routine to plot spectra surrounding the quake location
dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/qkspectra/'
restore, '/disk/solar3/jsr2/Data/SDO/sp2796-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2814-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2832-Apr28-2015.sav'

tag = 173
tag = string(tag,format = '(I0)')
tag = strcompress('tag0'+tag, /remove_all)

;tag0173.time_ccsds[3] = 17:46:04

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'

lambda1 = 2832
lambda2 = 2826
lambda3 = 2814
lambda4 = 2796
lambda1 = string(lambda1, format ='(I0)' )
lambda2 = string(lambda2, format ='(I0)' )
lambda3 = string(lambda3, format ='(I0)' )
lambda4 = string(lambda4, format ='(I0)' )

;nnn1 = n_elements(sp2796.tag00.wvl)
;nnn2 = n_elements(sp2814.tag00.wvl)
;nnn3 = n_elements(sp2826.tag00.wvl)
;nnn4 = n_elements(sp2832.tag00.wvl)
com = 'nnn1 = n_elements(sp2796.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn2 = n_elements(sp2814.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn3 = n_elements(sp2826.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn4 = n_elements(sp2832.'+tag+'.wvl)'
exe = execute(com)

nnn = nnn1 + nnn2 + nnn3 + nnn4

spectra = dblarr(2,nnn)
qkspectra = dblarr(2,nnn)
;spectra[0,0:nnn1-1] = sp2796.tag00.wvl[*]
;spectra[0,nnn1:nnn1 + nnn2-1] = sp2814.tag00.wvl[*]
;spectra[0,nnn1 + nnn2:nnn1 + nnn2 + nnn3-1] = sp2826.tag00.wvl[*]
;spectra[0,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.tag00.wvl[*]
com = 'spectra[0,0:nnn1-1] = sp2796.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1 + nnn2:nnn1 + nnn2 + nnn3-1] = sp2826.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.wvl[*]'
exe = execute(com)

;make quake spectrum for comparative over plot
qkspectra[0,*] = spectra[0,*]
com = 'qkspectra[1,0:nnn1-1] = sp2796.'+tag+'.int[*,3,435]'
exe = execute(com)
com = 'qkspectra[1,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.int[*,3,435]'
exe = execute(com)
com = 'qkspectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.'+tag+'.int[*,3,435]'
exe = execute(com)
com = 'qkspectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.int[*,3,435]'
exe = execute(com)
qkspectra[WHERE(spectra lT 0, /NULL)] = 0

;;open file for spec properties

filename = dir+'quake-spec.dat'
openw, unit, filename, /get_lun

;set up main loop to incrementally generate high res spec fit
specstart = 30
inc = 70
for i = specstart, (n_elements(qkspectra[0,*]))-1, 70
fit = spec_fit(qkspectra[0,i], qkspectra[1,i])

;calculates the factor by which the original spec array, differs from the high res spec fit array
spec_diff = (n_elements(fit[0,*]))/(n_elements(qkspectra[0,*]) )
	
	;set up second loop for generating spec props from high res spec fit
	for j = specstart*spec_diff, (n_elements(fit[0,*])) - 1, inc*spec_diff
	width = spec_width(fit[0,j], fit[1,j])
;	dopp = spec_dopp(fit[0,j], fit[1,j])
	Intensity = spec_int(fit[0,j], fit[1,j])
	;put spec props into file in format 1 row, 4 columns, e,g centroid, width, dopp, intensity
	printf, unit, width[0], width[1], dopp, Intensity, /append	
	endfor 
endfor
free_lun, unit

;put spec props into array from file
openr, unit, filename, /get_lun
nlines = file_lines(filename)
qkspecprop = fltarr(4,nlines)
readf, unit, qkspecprop
free_lun, unit

specprop = fltarr(4,nlines)

;loops to grab spectra from area surrounding quake, generate spec props and make plots
;slit position (x) 3:4 = quake
for i = 2, 5, 1 do begin
ii = string(i, format ='(I0)' )

	;y position 435 = quake
	for j = 430, 440, 1 do begin 
	jj = string(j, format ='(I0)' )
	com = 'spectra[1,0:nnn1-1] = sp2796.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	com = 'spectra[1,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	com = 'spectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	com = 'spectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	spectra[WHERE(spectra lT 0, /NULL)] = 0


		;set up main loop to incrementally generate high res spec fit
		specstart = 30
		inc = 70
		for k = specstart, (n_elements(spectra[0,*]))-1, 70
		fit = spec_fit(spectra[0,k], spectra[1,k])

		;calculates the factor by which the original spec array, differs from the high res spec fit array
		spec_diff = (n_elements(fit[0,*]))/(n_elements(spectra[0,*]) )
	
			;set up second loop for calculating spec props from high res spec fit
			for l = specstart*spec_diff, (n_elements(fit[0,*])) - 1, inc*spec_diff

			if (l eq specstart*spec_diff) then count = 0 else count = (l-specstart*spec_diff)/inc

			width = spec_width(fit[0,l], fit[1,l])
			dopp = spec_dopp(fit[0,l], fit[1,l], qkspecprop[0,count])
			Intensity = spec_int(fit[0,l], fit[1,l])
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
			;compare surrounding spectrum to quake spectrum 

			;wavelength...0.9999928485 is based on max centroid shift of 0.02 angstroms...ask sarah???
			wavcheck = 0
			fwhmcheck = 0
;			doppcheck = 0 
			intcheck = 0 

			if (qkspecprop[0,0] gt width[0]) then begin 
				if (width[0]/qkspecprop[0,0] gt 0.9999928485 ) then wavcheck = 1 else wavcheck = 0
				if (width[1]/qkspecprop[1,0] gt 0.75 ) then fwhmcheck = 1 else fwhmcheck = 0 	
;				if (dopp/qkspecprop[2,0] gt ) then doppcheck = 1 else doppcheck = 0 
				if (Intensity/qkspecprop[3,0] gt 0.75) then intcheck = 1 else intcheck = 0 
			endif


			if (qkspecprop[0,0] lt width[0]) then begin 
				if (qkspecprop[0,0]/width[0] gt 0.9999928485 ) then wavcheck = 1 else wavcheck = 0
				if (qkspecprop[1,0]/width[1] gt 0.75 ) then fwhmcheck = 1 else fwhmcheck = 0 
;				if (qkspecprop[2,0]/dopp gt ) then doppcheck = 1 else doppcheck = 0 
				if (qkspecprop[3,0]/Intensity gt 0.75 ) then intcheck = 1 else intcheck = 0 
			endif
			
			endfor		
		endfor			  



		if keyword_set(plot) then begin
		;make plot of local spectrum compared to quake spectrum 
		filey = dir+'IRIS-SPECTRA-SLITPOS-'+ii+'-PIXEL-'+jj'.eps'
		titl =  'IRIS-SPECTRA-SLITPOS-'+ii+'-PIXEL-'+jj
		ytitl = '[DN Pixel!E-1!N]'
		xtitl = 'Wavelength '+angstrom
		mydevice=!d.name
		set_plot,'ps'
		device, filename= filey, /portrait, /encapsulated, decomposed=0, color=1
		plot, spectra[0,*],spectra[1,*], ytitle = ytitl, xtitle = xtitl, title = titl
		loadct, 3
		oplot, qkspectra[0,*],qkspectra[1,*],  color = 150
		device, /close
		set_plot, mydevice
		endif
	endfor
endfor

end

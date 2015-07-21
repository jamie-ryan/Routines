pro quake_area, plot = plot
;routine to compare spectra around the sunquake location 
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

com = 'spectra[0,0:nnn1-1] = sp2796.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1 + nnn2:nnn1 + nnn2 + nnn3-1] = sp2826.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.wvl[*]'
exe = execute(com)

;Sunquake spectrum: used as control spectrum
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
openw, unit, filename, /get_lun, /append

;set up main loop to incrementally generate high res spec fit 
;and calculate spec props for each high res spec fit then store in a file
num = 10
inc = fix((n_elements(qkspectra[0,*]))/num )

for i = 0, (n_elements(qkspectra[0,*]))-1, inc do begin
	fit = spec_fit(qkspectra[0,i:i+inc], qkspectra[1,i:i+inc])


	width = spec_width(fit[0,*], fit[1,*])
;	dopp = spec_dopp(fit[0,j], fit[1,j])
	Intensity = spec_int(fit[0,*], fit[1,*])
	;put spec props into file in format 1 row, 4 columns, e,g centroid, width, dopp, intensity
	printf, unit, width[0], width[1], Intensity

endfor
free_lun, unit

;puts sunquake spec props into array from file
openr, unit, filename, /get_lun
nlines = file_lines(filename)
qkspecprop = fltarr(4,nlines)
readf, unit, qkspecprop
free_lun, unit


;opens a file to store locations of those spectra that match the sunquake spectra
filnm = dir+'quake-area.dat'
openw, unit, filnm, /get_lun, /append


;loops to grab spectra from area surrounding quake, generate spec props and compare to sunquake spectrum
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


		;loop to incrementally generate high res spec fit
		;and calculate/compare spec props
		checksum = 0
		inc = fix((n_elements(spectra[0,*]))/num )

		for k = 0, (n_elements(spectra[0,*]))-1, inc do begin
		fit = spec_fit(spectra[0,k:k+inc], spectra[1,k:k+inc])

		width = spec_width(fit[0,*], fit[1,*])
;		dopp = spec_dopp(fit[0,*], fit[1,*], qkspecprop[0, count])
		Intensity = spec_int(fit[0,*], fit[1,*])
			
				
		;compare surrounding spectrum to quake spectrum 
		;wavelength...0.9999928485 is based on max centroid shift of 0.02 angstroms...ask sarah???
;		doppcheck = 0  don't need this, as used central wavelength instead
		wavcheck = 0
		fwhmcheck = 0
		intcheck = 0 

		if (qkspecprop[0,0] gt width[0]) then begin 
			if (width[0]/qkspecprop[0,0] gt 0.9999928485 ) then wavcheck = 1 else wavcheck = 0
			if (width[1]/qkspecprop[1,0] gt 0.75 ) then fwhmcheck = 1 else fwhmcheck = 0 	
;			if (dopp/qkspecprop[2,0] gt ) then doppcheck = 1 else doppcheck = 0 
			if (Intensity/qkspecprop[3,0] gt 0.75) then intcheck = 1 else intcheck = 0 
		endif


		if (qkspecprop[0,0] lt width[0]) then begin 
			if (qkspecprop[0,0]/width[0] gt 0.9999928485 ) then wavcheck = 1 else wavcheck = 0
			if (qkspecprop[1,0]/width[1] gt 0.75 ) then fwhmcheck = 1 else fwhmcheck = 0 
;			if (qkspecprop[2,0]/dopp gt ) then doppcheck = 1 else doppcheck = 0 
			if (qkspecprop[3,0]/Intensity gt 0.75 ) then intcheck = 1 else intcheck = 0 
		endif
			
		if (wavcheck + fwhmcheck + intcheck eq 3) then begin

		str1 = string(spectra[0:k])
		str2 = string(spectra[0:k+inc])
		str3 = str1+'-'+str2
		str4 = strcompress(str3, /remove_all)
		print, 'Spectral match between '+str4+' located at slit-position '+ii+', pixel location '+jj+'.' 
			
		checksum = checksum + 1			
			
		endif

		endfor		
	
	;checks to see if every part of spectrum matches quake spectrum			  
	if (checksum eq fix(n_elements(spectra[0,*])/inc)) then begin
	print, 'Spectral match located at tag '+tag+', slit-position '+ii+', pixel location '+jj+'.' 
	printf, unit, tag, i, j

		;make plot spectrum with quake spectrum overplot 
		if keyword_set(plot) then begin
		filey = dir+'IRIS-SPECTRA-SLITPOS-'+ii+'-PIXEL-'+jj+'.eps'
		titl =  'IRIS-SUNQUAKE-SPECTRA-MATCH-SLITPOS-'+ii+'-PIXEL-'+jj
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
	endif

	endfor
endfor
free_lun, unit

end

pro quake_area
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

;loops to make plots from area surrounding quake
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

	;some how measure widths of major peaks
	;;;;;;wv0 = 2791.6 wv1 = 2791.1 to wv2 = 2792.1
	wv0 = qkspectra[0,?]
	wv1 = qkspectra[0,?]
	wv2 = qkspectra[0,?]
	peak 
	trough1 = qkspectra[0,wv1]
	where(qkspectra[0,wv1:wv2] eq peak = max(qkspectra[1,*]))]
	broad = 

	;some how measure amplitude difference
	intensity = 

	;some how measure Doppler shift difference
	dopplershift = 

	;make plot of local spectrum compared to quake spectrum 
	filey = dir+'IRIS-SPECTRA-SLIT-POS'+ii+'-PIXEL-'+jj
	titl =  'IRIS-SPECTRA-SLIT-POS'+ii+'-PIXEL-'+jj
	ytitl = '[DN Pixel!E-1!N]'
	xtitl = 'Wavelength'+angstrom
	mydevice=!d.name
	set_plot,'ps'
	device, filename= filey, /portrait, /encapsulated, decomposed=0, color=1
	plot, spectra[0,*],spectra[1,*], ytitle = ytitl, xtitle = xtitl, title = titl
	loadct, 3
	oplot, qkspectra[0,*],qkspectra[1,*],  color = 150
	device, /close
	set_plot, mydevice

	endfor
endfor

end

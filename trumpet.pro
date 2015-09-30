pro trumpet, wave
;wave = magnetogram, intensity, dopplergram, 131, 094 etc

;;;code to analyse the anglular resolution of intensity enhancement during solar flares.
;;;could this be a tracer of magnetic field morphology?
xp0 = 2830
xpf = 2980
yp0 = 2425
ypf = 2565

nwav = n_elements(wave)
for i = 0, nwav - 1 do begin
;;;aiaprep


aiadata,wave[i]

;;;convert pixels to arcsecs...then into string
xa0 = (xp0-ind[0].crpix1+1)*ind[0].cdelt1
xaf = (xpf-ind[0].crpix1+1)*ind[0].cdelt1
ya0 = (yp0-ind[0].crpix2+1)*ind[0].cdelt2
yaf = (ypf-ind[0].crpix2+1)*ind[0].cdelt2

xa0 = string(xa0,format = '(I0)')
xaf = string(xaf,format = '(I0)')
ya0 = string(ya0,format = '(I0)')
yaf = string(yaf,format = '(I0)')

if (wave eq 'magnetogram') then wavestr = wave else wavestr = string(wave, format ='(I0)')
if (wave eq 'dopplergram') then wavestr = wave else wavestr = string(wave, format ='(I0)')
if (wave eq 'intensity') then wave = wave else wavestr = string(wave, format ='(I0)')

com = 'index2map, ind, dat, map'+wavstr
exe = execute(com)

com = 'sub_map, map'+wavstr+', xr=['+xa0+','+xaf+'], yr=['+ya0+','+yaf+'], sbmap'+wavstr
exe = execute(com)

	switch wave of
		'intensity':loadct,
		'magnetogram':loadct,
		'dopplergram':loadct,
		131: loadct,
		 94: loadct,
		335: loadct,
		211: loadct,
		193: loadct,
		171: loadct,

		nt = n_elements(ind)
		if (wave eq 'intensity') then begin
			;FILTERING
			;;hmi differencing
			com 'sub = coreg_map(sbmap'+wavestr+',sbmap'+wavestr+'[5])'
			exe = execute(com)
			diff=diff_map(sub(1),sub(0),/rotate)
				for k=1, nt-1, 1 do begin
					diff1=diff_map(sub(k),sub(k-1),/rotate)
					;diff1=diff_map(sub(i),sub(0),/rotate)
					com = 'sbmap'+wavstr+'=str_concat(diff,diff1)'
					exe = execute(com)
				endfor
		endif


	for j = 0, nt-1 do begin
	jj = string(j, format = '(I0)')


	time = ind[j].t_obs
	filename = 'aia_'+wavstr+'-29-Mar-2014-'+time
	
	set_plot,'z'
			fileplot = filename +'.png'
			com = 'plot_map, sbmap'+wavstr+'['+jj+'], dmin = 0, dmax = 5000'
			exe = execute(com) 
			image = tvread(TRUE=3)
			image = transpose(image, [2,0,1])
			write_png, fileplot, image
	set_plot,'x'
	endfor
	endswitch
endfor

;;;;;ADD IRIS and RHESSI




end

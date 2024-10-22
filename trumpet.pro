pro trumpet
;wave = magnetogram, intensity, dopplergram, 131, 094 etc

;;;code to analyse the anglular resolution of intensity enhancement during solar flares.
;;;could this be a tracer of magnetic field morphology?
xp0 = 2830
xpf = 2980
yp0 = 2425
ypf = 2565

wave = [131, 94, 335, 211, 193, 171]
nwav = n_elements(wave)
for i = 0, nwav - 1 do begin
	;;;aiaprep
	wavestr = string(wave[i], format ='(I0)')
	files = findfile('aia.lev1.'+wavestr+'A*')
	aia_prep,files,-1,ind,dat,/uncomp_delete,/norm, /despike

	;;;convert pixels to arcsecs...then into string
	xa0 = (xp0-ind[0].crpix1+1)*ind[0].cdelt1
	xaf = (xpf-ind[0].crpix1+1)*ind[0].cdelt1
	ya0 = (yp0-ind[0].crpix2+1)*ind[0].cdelt2
	yaf = (ypf-ind[0].crpix2+1)*ind[0].cdelt2

	xa0 = string(xa0,format = '(I0)')
	xaf = string(xaf,format = '(I0)')
	ya0 = string(ya0,format = '(I0)')
	yaf = string(yaf,format = '(I0)')


	com = 'index2map, ind, dat, map'+wavstr
	exe = execute(com)

	com = 'sub_map, map'+wavstr+', xr=['+xa0+','+xaf+'], yr=['+ya0+','+yaf+'], sbmap'+wavstr
	exe = execute(com)

	switch wave[i] of ;for now, temporary colour 
		131: loadct,3
		 94: loadct,4
		335: loadct,5
		211: loadct,6
		193: loadct,7
		171: loadct,8

		nt = n_elements(ind)


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

;;;hmi

wave = ['Ic', 'm', 'v'] ;Ic = Intensity continuum, m = LOS mag, v = Dopplergram 
nwav = n_elements(wave)
for i = 0, nwav - 1 do begin

	;;;aiaprep
	files = findfile('hmi.'+wave[i]+'*')
	aia_prep,files,-1,ind,dat,/uncomp_delete,/norm, /despike


	;;;convert pixels to arcsecs...then into string
	xa0 = (xp0-ind[0].crpix1+1)*ind[0].cdelt1
	xaf = (xpf-ind[0].crpix1+1)*ind[0].cdelt1
	ya0 = (yp0-ind[0].crpix2+1)*ind[0].cdelt2
	yaf = (ypf-ind[0].crpix2+1)*ind[0].cdelt2

	xa0 = string(xa0,format = '(I0)')
	xaf = string(xaf,format = '(I0)')
	ya0 = string(ya0,format = '(I0)')
	yaf = string(yaf,format = '(I0)')

	wavestr = string(wave[i], format ='(I0)')

	com = 'index2map, ind, dat, map'+wavstr
	exe = execute(com)

	com = 'sub_map, map'+wavstr+', xr=['+xa0+','+xaf+'], yr=['+ya0+','+yaf+'], sbmap'+wavstr
	exe = execute(com)

	switch wave[i] of ;for now, temporary colour 
		'Ic':loadct,0
		'm' :loadct,1
		'v' :loadct,2

		nt = n_elements(ind)
		if (wave[i] eq 'Ic') then begin
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
			filename = 'hmi_'+wave[i]+'-29-Mar-2014-'+time
	
			set_plot,'z'
					fileplot = filename +'.png'
					com = 'plot_map, sbmap'+wave[i]+'['+jj+'], dmin = 0, dmax = 5000'
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

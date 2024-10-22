pro rbspectra, plot = plot

;location of IRIS fits files
;irisdir = '/disk/solar3/jsr2/Data/IRIS/'
f = iris_files('../IRIS/iris_l2_20140329_140938_3860258481_raster_t000_r00173.fits')

;load object
d = iris_load(f)

;read in files containing slit jaw image high intensity pixel locations
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'
;datfile = datdir+'iris-all-high-intensity-pixels.dat' 
;openr, unit, datfile, /get_lun
;nlines = file_lines(datfile)
;coords = fltarr(2, nlines)
;readf, unit, coords
;free_lun, unit

plotdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/rbspectra/'

;string to make an angstrom symbol
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'

;;;use x location to figue out slit position;;;;;;;;;;;;;;;;
;slit pixel locations relative to sji...check width of slit, is it more than one pixel?
;slitpos0 = 
;slitpos1 = 
;slitpos2 = 
;slitpos3 = 
;slitpos4 =  
;slitpos5 = 
;slitpos6 = 
;slitpos7 = 

;file to store spectral properties of each slitpos and pixel
specfile = plotdir+'ribbon-spectral-properties.dat'
openw, lun, specfile, /get_lun, /append
 

	


	;grab indices of array elements that match slitposition x-coord in the sji .dat file
;	com = 'sp'+spstr+' = where(coords[0,*] eq slitpos'+spstr+', ind'+spstr+')'
;	exe = execute(com)

	;use indices from above to put y-coords into a slitpos .dat file
;	com = 'filename = '+datdir+'iris-ycoords-slitpos-'+spstr+'.dat'
;	exe = execute(com)
;	openw, unit, filename, /get_lun
;	com = 'printf, unit, coords[1, ind'+spstr+'[*]]'
;	exe = execute(com)
;	free_lun, unit	

	;count number of y-pixels at slitpos
;	com = 'ynum = n_elements(coords[1, ind'+spstr+'[*]])'
;	exe = execute(com)
;	com = 'ind = ind'+spstr
;	exe = execute(com)



;;;Constants...REMEMBER cgs UNITS!!!
thermal_width = 0 ;for now
inst_width = 0 ;for now
specific_heat_ratio = 1 ;for now
pressure = 1 ;for now
density = 1 ;for now
c = (specific_heat_ratio*pressure)/density ;for now


ystart = 325
yfinish = 665

;ln relates to d->show_lines....is there a way to define the range automatically?
for ln = 0,7 do begin

;convert ln into sting
line = string(ln, format = '(I0)')

;grab wavelength
com = 'wav = d-> getlam('+line+')'
exe = execute(com)

;grab spectral data
com = 'spec = d->getvar('+line+',/load)'
exe = execute(com)

	;slit-position loop
	for sp = 0,7 do begin
	;make string version of loop counter
	spstr = string(sp, format = '(I0)')

		;loop to create a spectrum for each y-pixel
		for pix = ystart, yfinish -1 do begin
		
			;pixel string
			pixstr = string(pix, format = '(I0)')

			;calculate peak wavelength and peak wavelength width profile of spectrum
			width = spec_width(wav, spec[*, pix , sp]) ;NOT GAUSSIAN...also looking at entire profile so need to define lambda range

			;convert the FWHM to velocity (subtract a thermal width and the instrumental width)
			corrected_width = width[1] - thermal_width - inst_width
			velocity = c*(width[1]/width[0]);Velocity = c * (delta lambda)/lambda =c*(width[1]/width[0]) BASED ON GAUSSIAN?			
			
			;calculate intensity 
			intensity = spec_int(wav, spec[*, pix , sp])
						
	
			;put properties into file
			printf, lun, pix, sp, width[0], width[1], velocity, intensity

			;plot each spectrum
			if keyword_set(plot) then begin
				filey = plotdir+'IRIS-RIBBON-SPECTRA-SLITPOS-'+spstr+'-PIXEL-'+pixstr+'.eps'
				titl =  'IRIS-RIBBON-SPECTRUM-SLITPOS-'+spstr+'-PIXEL-'+pixstr
				ytitl = '[DN Pixel!E-1!N]'
				xtitl = 'Wavelength '+angstrom
				mydevice=!d.name
				set_plot,'ps'
				device, filename= filey, /portrait, /encapsulated, decomposed=0, color=1
				plot, wav, spec[*, sp, coords[1,ind[i]]], ytitle = ytitl, xtitle = xtitl, title = titl
				device, /close
				set_plot, mydevice
			endif
		endfor
	endfor
endfor
free_lun, lun

end

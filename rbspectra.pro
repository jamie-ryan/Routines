pro rbspectra

;restore .sav files containing spectral data
restore, '/disk/solar3/jsr2/Data/SDO/sp2796-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2814-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2832-Apr28-2015.sav'


;read in files containing slit jaw image high intensity pixel locations
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'
datfile = datdir+'iris-all-high-intensity-pixels.dat' 
openr, unit, datfile, /get_lun
nlines = file_lines(datfile)
coords = fltarr(2, nlines)
readf, unit, coords
free_lun, unit

;structure tag relating to impulsive phase ;tag0173.time_ccsds[3] = 17:46:04
tag = 173
tag = string(tag,format = '(I0)')
tag = strcompress('tag0'+tag, /remove_all)

;string to make an angstrom symbol
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'


;;;use x location to figue out slit position;;;;;;;;;;;;;;;;
;slit pixel locations relative to sji...check width of slit, is it more than one pixel?
slitpos1 = 
slitpos2 = 
slitpos3 = 
slitpos4 =
slitpos5 =  
slitpos6 =
slitpos7 = 
slitpos8 =

;;;grab array indices that match slit positions
sp1 = where(coords[0,*] eq slitpos1, ind1)
sp2 = where(coords[0,*] eq slitpos2, ind2)
sp3 = where(coords[0,*] eq slitpos3, ind3)
sp4 = where(coords[0,*] eq slitpos4, ind4)
sp5 = where(coords[0,*] eq slitpos5, ind5)
sp6 = where(coords[0,*] eq slitpos6, ind6)
sp7 = where(coords[0,*] eq slitpos7, ind7)
sp8 = where(coords[0,*] eq slitpos8, ind8)  

;;;use slit position indices to find y-axis pixels
y1 = coords[1,ind1]
y2 = coords[1,ind2]
y3 = coords[1,ind3]
y4 = coords[1,ind4]
y5 = coords[1,ind5]
y6 = coords[1,ind6]
y7 = coords[1,ind7]
y8 = coords[1,ind8]


;fill array with wavelength values
com = 'nnn1 = n_elements(sp2796.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn2 = n_elements(sp2814.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn3 = n_elements(sp2826.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn4 = n_elements(sp2832.'+tag+'.wvl)'
exe = execute(com)

nnn = nnn1 + nnn2 + nnn3 + nnn4

;slitpos
for i = 0, 7 do begin

	;pixel
	for j = 
	com = 'spectra[1,0:nnn1-1] = sp2796.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	com = 'spectra[1,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	com = 'spectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	com = 'spectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.int[*,'+ii+','+jj+']'
	exe = execute(com)
	spectra[WHERE(spectra lT 0, /NULL)] = 0

	
	endfor
endfor
end

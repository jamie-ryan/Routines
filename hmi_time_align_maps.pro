pro hmi_time_align_maps
fdir = '/unsafe/jsr2/project2/'
flnm = fdir+''+directories.txt' ;eg, flnm=hmicoords.txt
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun


flnm = '/unsafe/jsr2/project2/peaks.txt' ;eg, flnm=hmicoords.txt
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
peaks = strarr(nlin)
readf, lun, peaks
free_lun, lun


for ddd = 0, nlin -1 do begin
  restore, fdir+''+directories[ddd]+'/HMI/v/doppdiff.sav'
  restore, fdir+''+directories[ddd]+'/HMI/ic/fepmaps.sav'
print,directories[ddd]+' doppdiff = ', n_elements(doppdiff), '     ::::     ', directories[ddd]+' pmap = ', n_elements(pmap)
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ''
print,  'doppdiff.[0].time = ', doppdiff[0].time, '     ::::     ', 'pmap[0].time = ', pmap[0].time
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ''
print,  'doppdiff[-1].time = ', doppdiff[-1].time, '     ::::     ', 'pmap[-1].time = ', pmap[-1].time
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
print, ''

endfor

end

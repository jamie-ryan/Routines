pro rbspectra
datfile = 'DATA-ANALYSIS/............'

openr, unit, datfile, /get_lun
nlines = file_lines(datfile)
coords = fltarr(2, nlines)
readf, unit, coords
free_lun, unit

ycoords = coords[1,*]



end

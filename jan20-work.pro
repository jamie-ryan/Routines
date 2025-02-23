;;;ribcord2oplot....
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
nrb = 20 ; number ribbon coords
time_frames = 2 
npt = 1 + (nrb/time_frames)

;instrument specific radius (not including central pixel)
iradius = 4.* 0.167;iris qk radius in arcseconds 
sradius = 1. * 0.505;sdo qk radius in arcseconds

sub_map, map1400, ssi, xrange = [460., 560.], yrange = [220., 320.]
sub_map, submg, smg, xrange = [460., 560.], yrange = [220., 320.]
sub_map, diff2832, smgw, xrange = [470., 560.], yrange = [220., 310.] 


dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
for i = 1,2 do begin
    ii = string(i, format = '(I0)')
    for k = 0, n_elements(dataset)-1 do begin
        flnm = dataset[k]+'coords'+ii+'.txt' ;eg, flnm=hmicoords1.txt
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        tmp = fltarr(2, nlin)
        readf, lun, tmp
        com = dataset[k]+'coords'+ii+ '= tmp' ;readf,lun,hmg
        exe = execute(com)
        free_lun, lun
    endfor
endfor

coords = sicoords1
nrb = n_elements(coords[0,*])
box_size = iradius
;cgloadct, 0, /reverse
loadct, 0
plot_map, ssi[494], /log

for i = 0 ,nrb-1 do begin
    central_coord_x = coords[0,i]
    central_coord_y = coords[1,i]
    x0 = central_coord_x - box_size
    xf = central_coord_x + box_size
    y0 = central_coord_y - box_size
    yf = central_coord_y + box_size
loadct, 6
        oplot, [x0, x0], [y0, yf], color = 125 ;left side
        oplot, [x0, xf], [yf, yf], color = 125 ;top
        oplot, [xf, xf], [yf, y0], color = 125 ;right side
        oplot, [x0, xf], [y0, y0], color = 125 ;bottom
ii = string(i+1, format = '(I0)')
XYouts, x0, yf, ii, COLOR=FSC_Color('red'), $
        ALIGN=0.5, CHARSIZE=0.75
endfor

loadct, 0
coords = sicoords2
for i = 0 ,nrb-1 do begin
    central_coord_x = coords[0,i]
    central_coord_y = coords[1,i]
    x0 = central_coord_x - box_size
    xf = central_coord_x + box_size
    y0 = central_coord_y - box_size
    yf = central_coord_y + box_size
        oplot, [x0, x0], [y0, yf], color = 125 ;left side
        oplot, [x0, xf], [yf, yf], color = 125 ;top
        oplot, [xf, xf], [yf, y0], color = 125 ;right side
        oplot, [x0, xf], [y0, y0], color = 125 ;bottom
ii = string(i+1, format = '(I0)')
XYouts, x0, yf, ii, COLOR=FSC_Color('red'), $
        ALIGN=0.5, CHARSIZE=0.75
endfor

;Plot, x, y, BACKGROUND=FSC_Color('ivory'), COLOR=FSC_Color('navy')
   OPlot, x, y, COLOR=FSC_Color('ivory'), PSYM=cgSymCat(15), SYMSIZE=2.0
   XYouts, x, y, StrTrim(Sindgen(50)+1, 2), COLOR=FSC_Color('red'), $
        ALIGN=0.5, CHARSIZE=0.75





;;;;balm_bk into mesa_cp
restore, 'balmdat-Jan20-2016.sav'
restore, '/unsafe/jsr2/sp2826-Jan19-2016.sav'
fsp = findfile('/unsafe/jsr2/IRIS/*raster*.fits')
nfiles = n_elements(fsp)
;;;some variables for loops, arrays element definition and header info 
sample = 1 ;use this for spectra
nrb = 20 ; number ribbon coords
time_frames = 2 
time_frame_string = strarr(time_frames)
time_frame_string[0] = '17:45'
time_frame_string[1] = '17:46'
npt = 1 + (nrb/time_frames) ; number of ribbon coords per time_frame + 1 qk coord
columns = 4 ;x,y,E,F
fande = 2 ;columns for error arrays containing f and e
wav1 = sp2826.tag00.wvl[39]
wav2 = sp2826.tag00.wvl[44]

;instrument specific radius (not including central pixel)
iradius = 4.;iris qk radius in pixels
sradius = 1.;sdo qk radius in pixels
inp = (iradius + 1)*(iradius + 1) ;npixels for iris radiometric calibration
snp = (sradius + 1)*(sradius + 1) ;npixels for sdo radiometric calibration

balmwidth = (3600. - 1400.)/0.1  ;in angstroms
visiblewidth = (7500. - 3800.)/76.e-3 ;in angstroms
tbalm = strarr(time_frames, npt, nfiles) 

balmerdata = fltarr(time_frames, columns, npt, nfiles)
for i = 0, npt-1 do begin ;fill with pixel coords from balm_bk
for j = 0, nfiles -1 do begin
balmerdata[0,0,i,j] = balmpix[0,0,i,j]
balmerdata[0,1,i,j] = balmpix[0,1,i,j]
balmerdata[1,0,i,j] = balmpix[1,0,i,j]
balmerdata[1,1,i,j] = balmpix[1,1,i,j]
endfor
endfor
for i = 0, n_elements(balmercoords1[0,*]) - 1 do begin
for j = 0, nfiles-1 do begin
tbalm[0, i, j] = times[j, balmpix[0,0,i,j]] 
tbalm[1, i, j] = times[j, balmpix[1,0,i,j]]
endfor    
    iris_radiometric_calibration, balmdat[0,i,*]*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
    balmerdata[0, 2, i, *] = f
    balmerdata[0, 3, i, *] = e

    iris_radiometric_calibration, balmdat[1,i,*]*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
    balmerdata[1, 2, i, *] = f
    balmerdata[1, 3, i, *] = e

endfor
for j = 0, nfiles-1 do begin
    tbalm[0, npt-1, j] = times[j, balmpix[0,0,npt-1,j]]
    tbalm[1, npt-1, j] = times[j, balmpix[1,0,npt-1,j]]
endfor    
iris_radiometric_calibration, balmdat[0,npt-1,*]*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
balmerdata[0, 2, npt-1, *] = f
balmerdata[0, 3, npt-1, *] = e

iris_radiometric_calibration, balmdat[1, npt-1,*]*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
balmerdata[1, 2, npt-1, *] = f
balmerdata[1, 3, npt-1, *] = e


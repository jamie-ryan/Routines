pro balm_bk, date
;determine background values based on slit position
;restore, '/unsafe/jsr2/sp2826-Jan15-2016.sav'
restore, '/unsafe/jsr2/sp2826-Jan19-2016.sav'
f = iris_files(path='/unsafe/jsr2/IRIS/old')
nfiles = n_elements(f)
sample = 1 ;use this for spectra
nrb = 20 ; number ribbon coords
time_frames = 2 
time_frame_string = strarr(time_frames)
time_frame_string[0] = '17:45'
time_frame_string[1] = '17:46'
npt = 1 + (nrb/time_frames) ; number of ribbon coords per time_frame + 1 qk coord
columns = 4 ;x,y,E,F
;quake position 
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014
iradius = 4.;iris qk radius in pixels


;find x and y slit positions in arcsec and times
;these arrays will be passed to mesa_cp as coordinates for other data
iris_x_pos = fltarr(8, nfiles)
iris_y_pos = fltarr(1093, nfiles)
times = strarr(8, nfiles)
for i = 0, nfiles -1 do begin
    d = iris_obj(f[i])
    iris_x_pos[*, i] = d->getxpos()
    iris_y_pos[*, i] = d->getypos()
    times[*, i] = d->ti2utc()
    obj_destroy, d
endfor



;;;read in data
;;;find the numbers needed to create alldata array
d = iris_obj(f[0])
dat = d->getvar(6, /load)
wavelength = d->getlam(6)
fitnum_max = 179 ;specific to event, used in allhdr tag naming
fitnum_min = (fitnum_max - nfiles) + 1
nwav = n_elements(wavelength[39:44]) ;wavelength range for balmer
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
alldat = fltarr(xpix, ypix, nfiles) ;data array
balmdat = fltarr(time_frames, npt, nfiles)
 
obj_destroy, d
hdr = 0
dat = 0
;fill data and time arrays
for i = 0, nfiles - 1 do begin

    ;load data and put into data array
    d = iris_obj(f[i])
    dat = d->getvar(6, /load)
    
    ;sum across Balmer continuum range 2825.7 to 2825.8 angstroms
    a = 0
    for l = 39, 44 do begin 
    a = a + dat[l, *, *]
    endfor
    alldat[*,*, i] = a

    ;clean up 
    obj_destroy, d
endfor


;;fill array with intensity from sunquake area 
alldat[where(alldat lt 0., /null)] = 0 
for i = 0, npt - 1 do begin
    for j = 0, nfiles -1 do begin

        ;;convert iris_x_pos to pixel_pos
                  

;        balmdat[0, i, j] = alldat[balmpix[0, 0, i, j], balmpix[0, 1, i, j], j]
;        balmdat[1, i, j] = alldat[balmpix[1, 0, i, j], balmpix[1, 1, i, j], j]
        balmdat[0, i, j] = sumarea(alldat[*,*,j], balmpix[0, 0, i, j], balmpix[0, 1, i, j], iradius, /sg)
        balmdat[1, i, j] = sumarea(alldat[*,*,j], balmpix[1, 0, i, j], balmpix[1, 1, i, j], iradius, /sg)
    endfor
endfor

balmbk = fltarr(8)
;;;find array indices for slit positions 0 to 7 and make balmbk
for i = 0, 7 do begin
ws = 0
wi = 0
ii = i*1.

;times[0:30, 0] = 16:51 to 17:29
ws = where(balmpix[0, 0, *, 0:30] eq ii)
wi = array_indices(balmpix[0, 0, *, 0:30], ws)

;balmbk contains the avg value for each slit pos
balmbk[i] = avg(balmdat[0, wi[2, *],wi[3, *]])
endfor

;remove background
balmdat[0,*,*]=balmdat[0,*,*] - balmbk[balmpix[0,0,*,*]]
balmdat[1,*,*]=balmdat[1,*,*] - balmbk[balmpix[1,0,*,*]]

preflare = 
;remove preflare
balmdat[0,*,*]=balmdat[0,*,*] 
balmdat[1,*,*]=balmdat[1,*,*] 



d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
filnm = strcompress('/unsafe/jsr2/'+date+'/balmdat-'+date+'.sav', /remove_all)

save,alldat, allhdr, times, balmdat, balmercoords1, balmercoords2, balmpix, balmbk, filename = filnm
end

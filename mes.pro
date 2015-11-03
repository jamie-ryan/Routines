pro mes, time_frames, nsi, nmg, nbalm, nmgw, nhmi

;time_frames = the number of time frames that ribbon coords have been sampled from.
;nsi, nmg, nbalm, nmgw, nhim are the number of ribbon coords for each data set. I think this is the bast way, as each data set has different sized ribbons, therefore it is unreasonable to assume that one spatial coord could relate to that of another dataset. So instead, I am going to produce high resolution energy distribution plots for each dataset, looking for common features. This approach should help to highlight regions in each dataset-ribbons that are related. i.e, there's a peak here and a trough to the right, there's the same feature in the ribbon above and below (in altitude)

;;;start timer
tic

;;;restore data sav files
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'
;restore, '/disk/solar3/jsr2/Data/SDO/HMI-diff-15-Oct-15.sav'

;;;date string
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2

;;;directories
dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'

;;;iris spectra fits
fsp = findfile('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')

sample = 1

;;;set time series to run from 17:20 to 17:55 
tsi = map1400.time[]
tmg = submg.time[]
tbalm = tspqk[]
tmgw = diff2832.time[]
thmi = diff.time[]


;;;arrays to contain energy values for each coord through the entire time series.
;eg: sidata[time_frame, xcoord, ycoord, time]
sidata = fltarr(time_frames, nsi, nsi, n_elements(tsi))
mgdata = fltarr(time_frames,nmg,nmg,n_elements(tmg))
balmerdata = fltarr(time_frames,nbalm,nbalm,n_elements(tbalm))
mgwdata = fltarr(time_frames,nmgw,nmgw,n_elements(tmgw))
hmidata = fltarr(time_frames,nhmi,nhmi,n_elements(thmi))

;;;calculate pixel location from given arcsec coords
;quake position
;hqkxa = 517.2 ;my old coords for hmi
;hqkya = 261.4 ;my old coords for hmi
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014
hqkxp = convert_coord_hmi(hqkxa, diffindex[63],  /x, /a2p)
hqkyp = convert_coord_hmi(hqkya, diffindex[63],  /y, /a2p)
qkxp = convert_coord_hmi(qkxa, diffindex[63],  /x, /a2p)
qkyp = convert_coord_hmi(qkya, diffindex[63],  /y, /a2p)
qksixp = convert_coord_iris(qkxa, sji_1400_hdr[498], /x, /a2p)
qksixa = convert_coord_iris(qkxa, sji_1400_hdr[498], /x, /p2a)
qksiyp = convert_coord_iris(qkya, sji_1400_hdr[498], /y, /a2p)
qkmgxp = convert_coord_iris(qkxa, sji_2796_hdr[664], /x, /a2p)
qkmgxa = convert_coord_iris(qkxa, sji_2796_hdr[664], /x, /p2a)
qkmgyp = convert_coord_iris(qkya, sji_2796_hdr[664], /y, /a2p)
qkmgwxp = convert_coord_iris(qkxa, sji_2832_hdr[167], /x, /a2p)
qkmgwxa = convert_coord_iris(qkxa, sji_2832_hdr[167], /x, /p2a)
qkmgwyp = convert_coord_iris(qkya, sji_2832_hdr[167], /y, /a2p)
;qkslitp = ;find_iris_slit_pos(qkxa,sp2826)
;qkspyp = ;find_iris_slit_pos(qkya,sp2826, /y, /a2p)


;;;read in coord files for each data set
;;;(to change coords ammend file, eg, hmicoords1.txt)
;;;based on naming convention (no zero, always start with 1), eg, hmicoords1, hmicoords2, hmicoords3 etc.
dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
for i = 1,time_frames do begin
    ii = string(i, format = '(I0)')
    for k = 0, n_elements(dataset)-1 do begin
        flnm = dataset[k]+'coords'+ii+'.txt' ;eg, flnm=hmicoords1.txt
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        tmp = fltarr(2, nlin)
        readf, lun, tmp
        com = dataset[k]+'data[i-1, *, 0, *]= tmp[0,*]' ;readf,lun,hmg
        exe = execute(com)
        com = dataset[k]+'data[i-1, 0, *, *]= tmp[1,*]' ;readf,lun,hmg
        exe = execute(com)
        free_lun, lun
    endfor
endfor










end

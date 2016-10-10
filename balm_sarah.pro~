file = findfile('/unsafe/jsr2/IRIS/Oct6/iris_l2_20140329_140938_3860258481_raster_t000*')

nfiles = n_elements(file)                                 
spec_line = 6;d->show_lines
d = iris_obj(file[0])
wave = d->getlam(spec_line)
wd=iris_getwindata(file[0],6)
times = strarr(n_elements(wd.int[0,*,0]), nfiles)
times[*,0] = wd.time_ccsds
iris_x_pos = fltarr(n_elements(wd.int[0,*,0]), nfiles)
iris_y_pos = fltarr(n_elements(wd.int[0,0,*]), nfiles)
iris_x_pos[*, 0] = d->getxpos() ;get y pixel locations in heliocentric coords
iris_y_pos[*, 0] = d->getypos() ;get x pixel locations (slit position) in heliocentric coords         

for i=1,nfiles - 1 do begin
    d = iris_obj(file[i])   
    iris_x_pos[*, i] = d->getxpos() ;get y pixel locations in heliocentric coords
    iris_y_pos[*, i] = d->getypos() ;get x pixel locations (slit position) in heliocentric coords         
    wd_temp=iris_getwindata(file[i],6)
    wd=str_concat(wd,wd_temp)
;    times_temp = wd_temp.time_ccsds
    times[*,i] = wd[i].time_ccsds
endfor
wd_temp = 0
;lc=total(wd.int[41:44,3,438,*],1)
;etime=reform(wd.exposure_time[3,*])
;lc_corr=lc/etime





;;;;CREATE DATA ARRAYS TO PASS TO IRIS_HMI_ENERGY.PRO
;get sampling coords
dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coordsfinal.txt' ;eg, flnm=hmicoords1.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor

;;;Sampling coords specific arrays for iris_hmi_energy.pro
ncoords = n_elements(balmercoords[0,*])
balmdat = fltarr(ncoords, nfiles)
columns = 5 ;x,y,F,E,P
balmerdata = fltarr(columns, ncoords, nfiles)
texp = fltarr(ncoords, nfiles)


;common pix will contain the pixel locations of the x coords in balmercoords.txt
;common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos)
common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos[*,23])
iris_y_pix = find_iris_slit_pos_new(balmercoords[1, *], iris_y_pos[*,23])
for i = 0, n_elements(balmerdata[0,0,*]) - 1 do begin 
    balmerdata[0, *, i] = common_x_pix[*] ;think this will give a constant x y pix? check
    balmerdata[1, *, i] = iris_y_pix[*]
endfor
bk = 170.
for j = 0,  ncoords - 1 do begin 
    texp[j,*] = reform(wd.exposure_time[common_x_pix[j],*])
    balmdat[j,*] = (total(wd.int[41:44,common_x_pix[j], iris_y_pix[j],*],1) - bk)/texp[j,*]
endfor

;;;;Save variables for iris_hmi_energy.pro
fsav = '/unsafe/jsr2/'+date+'/balmerdata-sarah-'+date+'.sav'
save, balmerdata, balmdat, times, wave, texp, wd,  filename = fsav

pro rhessi_img, $
energy_range =  energy_range, $
increment, $
;dayst, $
;monthst, $
;yearst, $
;dayend, $
;monthend, $
;yearend, $
yrst, $
yrend, $
mthst, $
mthend, $
dyst, $
dyend, $
hrstart, $ 
minstart, $
secst, $
hrend, $
minend, $
secend, $ 
timg, $
algorithm
;INPUT:
;energy_range = either a single number, or a 2 element array. eg energy_range = [10.0D, 100.0D]
;increments = spectrum x-axis energy increment, in keV. eg increment = 1 is 1 kev  
;dayst
;monthst = month in 3 character string format, i.e, 'Mar'
;yearst
;dayend
;monthend
;yearend
;hrstart = starting hour of observation. In number format eg 17 
;minstart = starting minute. eg, 44
;secst = starting second. eg, 0
;hrend = ending hour. eg, 17
;minend = ending minute. eg, 52
;secend = ending second. eg, 30
;timg = secomds per time interval. eg 20 [sec]  
;algorithm = image construction algorithm. eg  'CLEAN'       
        ;'Back Projection'
        ;'CLEAN' 
        ;'PIXON' 
        ;'MEM_NJIT' 
        ;'FORWARDFIT'
        ;'VIS_FWDFIT' 

;OUTPUT:
 
;syntax
;rhessi_img, energy_range = [10.,100.], 10., 17, 40, 0, 17, 54, 0, 20., 'PIXON'
                              
;hsi image object                                                                                         
; For a complete list of control parameters look at the tables in                         
; http://hesperia.gsfc.nasa.gov/ssw/hessi/doc/hsi_params_all.htm                          
;                                                                                         
                                                                                    
; Once you have run the script (via one of those 3 methods), you will have an             
; hsi_image object called obj that is set up as it was when you wrote the script.         
; You can proceed using obj from the command line or the hessi GUI.  To use               
; it in the GUI, type                                                                     
;   hessi,obj    
tic                                                                         
search_network, /enable   
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
datstr = 'rhessi-spectra-'+d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+datstr

if (n_elements(energy_range) eq 1) then e1 = string(energy_range, format = '(I0)') else $
e1 = string(energy_range[0], format = '(I0)')
e2 = string(energy_range[1], format = '(I0)')
estr = 'energy-'+e1+'-to-'+e2
spawn, 'mkdir /unsafe/jsr2/'+datstr+'/'+estr
incst = string(increment, format = '(I0)')
inc = 'increments-'+incst+'keV'
spawn, 'mkdir /unsafe/jsr2/'+datstr+'/'+estr+'/'+inc
timst = string(timg, format = '(I0)')
tim = 'timg-'+timst+'sec'
spawn, 'mkdir /unsafe/jsr2/'+datstr+'/'+estr+'/'+inc+'/'+tim
algo = strcompress(algorithm, /remove_all)
spawn, 'mkdir /unsafe/jsr2/'+datstr+'/'+estr+'/'+inc+'/'+tim+'/'+algo
outdir = '/unsafe/jsr2/'+datstr+'/'+estr+'/'+inc+'/'+tim+'/'+algo+'/'

;number of energy bands
nenergy = (max(energy_range)-min(energy_range))/increment
erng = energy_range[0] + findgen(nenergy+1)*increment

;time start
;dayststr = string(dayst, format = '(I0)')
;mthststr = string(monthst, format = '(I0)')
;yrststr = string(yearst, format = '(I0)')
;hrststr = string(hrstart, format = '(I0)')
;minststr = string(minstart, format = '(I0)')
;secststr = string(secst, format = '(I0)')

;time end
;dayedstr = string(dayend, format = '(I0)')
;mthedstr = string(monthend, format = '(I0)')
;yredstr = string(yearend, format = '(I0)')
;hredstr = string(hrend, format = '(I0)')
;minedstr = string(minend, format = '(I0)')
;secedstr = string(secend, format = '(I0)')


;convert in to seconds for rhessi time iterator
;hrsec = (hrend - hrstart)*60.*60.
;mindiff = (minend - minstart)*60.
;secdiff = (secend - secst)
;tsec = hrsec + mindiff + secdiff
;nt = tsec/timg

;make time intervals array and ammend to omit attenuator state changes
;time_intervals = rhessi_time_string_iterator(nt, hrstart, hrend, minstart, minend, secst, secend)
time_intervals = rhessi_time_intervals(timg, yrst, yrend, mthst, mthend, dyst, dyend, hrstart, hrend, minstart, minend, secst, secend, tout)

;find attenuator state changes...will be in same units as time_intervals_secjan1979
tfull = [time_intervals[0, 0],time_intervals[1,-1]]
;t='21-apr-2002 ' + ['00:00','02:00']
obs=hsi_obs_summary(obs_time=tfull)
changes = obs->changes()

atten = changes.attenuator_state


;convert time_intervals into jultime ref time is 1st of jan 1979
ti_1st_jan_1979 = anytim(time_intervals)

;normalise
zero = atten.start_times[0]

;if therer is an attenuator change at any point between start and finish time
;ammend time_intervals to isolate bad data
if (zero gt -1) then begin
    attend0 = atten.end_times - zero
    ti0 = ti_1st_jan_1979 - zero  
    maxt = ti0[*, -1]
    
    ;time list
    ;tlist = list()
    ;tlist.add, item [,index] [,/extract] [,/no_copy] 
    ;tlist.add, ti_1st_jan_1979 - zero
    ;tlist = list(ti_1st_jan_1979[0,*] - zero, ti_1st_jan_1979[1,*] - zero)
    ;maxt = tlist[*, -1]

    ;ammend time intervals to isolate attenuator state changes
    for i = 0, n_elements(attend0) -1 do begin
    ;for i = 0, 3 do begin
        print, 'FINDING ATTENUATOR CHANGES'
        ;ws = where(ti0[0,*] lt attend0[i], ind)
        ;wws = array_indices(ti0[0,*], ws)

        ;last element in wws is closest to attenuator change
        ;a = ti0[0,wws[1,-1]]

        we = where(ti0[1,*] gt attend0[i], ind)
        wwe = array_indices(ti0[1,*], we)

        ;first element in wwe is closest to attenuator change
        ;b = ti0[1,wwe[1,0]]
        if (wwe[1,0] eq n_elements(ti0[0,*]) -1 ) then begin
            ti00 = fltarr(2, n_elements(ti0[0,*]) + 2)
            ti00[0, 0:n_elements(ti0[0,*]) -1] = ti0[0,*]
            ti00[1, 0:n_elements(ti0[0,*]) -1] = ti0[1,*]
            ti0 = ti00
            ti00 = 0
        endif         
        timebuff = 2.
        ti0[1,wwe[1,0]] = attend0[i] - timebuff
        ti0[0,wwe[1,0] + 1] = ti0[1,wwe[1,0]]
        ti0[1,wwe[1,0] + 1] = ti0[1,wwe[1,0]] + 2*timebuff 
        ti0[*, wwe[1,0] + 2 : -1] =  ti0[*, wwe[1,0]+ 2 : -1] - (ti0[0,wwe[1,0] + 2] - ti0[1,wwe[1,0] + 1]) 
    ;    arrayextra = ceil(abs(maxt[1, -1] - max(ti0[1,*]))/increment) - n_elements(ti0[0,*])
        arrayextra = ceil(abs(maxt[1, -1] - max(ti0[1,*]))/timg)


        if (arrayextra gt 0.) then begin   
            if (ti0[1,-1] gt  max(attend0) - timg) and (ti0[1,-1] lt  max(attend0) + timg) then arrayextra = arrayextra + 1 
            tmp = fltarr(2, n_elements(ti0[0,*]) + arrayextra)
            tmp[0, 0:n_elements(ti0[0,*])-1] = ti0[0,*]
            tmp[1, 0:n_elements(ti0[1,*])-1] = ti0[1,*]
            for j = 0, arrayextra - 1 do begin
                print, n_elements(ti0[0,*]) - 1 + j
                tmp[0, n_elements(ti0[0,*]) + j] = tmp[0,n_elements(ti0[0,*]) - 1 + j] +timg
                tmp[1, n_elements(ti0[1,*]) + j] = tmp[1,n_elements(ti0[1,*]) - 1 + j] +timg
            endfor
            ti0 = tmp
            tmp = 0
        endif
    endfor
    att_ind = where(ti0[1,*] - ti0[0, *] eq 2.*timebuff)
    bad_ind = where(ti0[1,*] - ti0[0, *] eq 0.)
    tot_remove = n_elements(att_ind) + n_elements(bad_ind)
    ti00 = reform(ti0[0,*])
    ti01 = reform(ti0[1,*])
    index = [att_ind, bad_ind]
    remove, index, ti00
    remove, index, ti01
    ti0 = 0
    ti0 = fltarr(2, n_elements(ti00))
    ti0[0,*] = ti00
    ti0[1,*] = ti01

    ;tti0[*, ???] = ti0[*, ???]
    ;ti0 = 0   
    ;convert ti0 to string
    time_intervals = 0
    time_intervals = anytim(ti0 + zero, /yoh)
    ;clean up a bit
    ti0 = 0
    ti00 = 0
    ti01 = 0
endif




;;;Image Construction                           
obj = hsi_image()                    
;obj-> set, im_energy_binning= [10.000000D, 100.00000D]                                    
obj-> set, im_energy_binning = [erng]

;set use detectors 1,2,3,4,5,6,7,8 [0 = off, 1 = on]
obj-> set, det_index_mask= [1, 0, 0, 1, 1, 1, 0, 0, 1]  ;based on de Costa 2016

;choose time interval
;        obj-> set, im_time_interval= [ [time_intervals[0, t]], [time_intervals[1, t]] ]
obj-> set, im_time_interval= time_intervals

;;;set image construction algorithm
;obj-> set, /pixon_noplot
obj-> set, image_algorithm= algorithm
;obj-> set, image_algorithm= 'Back Projection'
;obj-> set, image_algorithm= 'CLEAN' 
;obj-> set, image_algorithm= 'PIXON' 
;obj-> set, image_algorithm= 'MEM_NJIT' 
;obj-> set, image_algorithm= 'FORWARDFIT'
;obj-> set, image_algorithm= 'VIS_FWDFIT'              

obj-> set, time_bin_def= [1.00000, 2.00000, 4.00000, 4.00000, 8.00000, 16.0000, 32.0000, $
 64.0000, 64.0000]                                                                        
obj-> set, time_bin_min= 512L                                                             

;retrieve index                           
obj-> set, use_single_return_mode = 0 ; retrieve all images in cube  
;while (!d.window gt -1) do wdelete
data = obj-> getdata()



;time string for fits file name
flaredate = strcompress(strmid(time_intervals[0,0],0,9), /remove_all)
hrs = string(hrstart, format = '(I0)')
hre = string(hrend, format = '(I0)')
mns = string(minstart, format = '(I0)')
mne = string(minend, format = '(I0)')
t1 = hrs+''+mns
t2 = hre+''+mne
tt = flaredate+'-'+t1+'to'+t2

;im2fits
ffit= outdir+'rhessi-imgs-'+estr+'-time-'+tt+'.fits'
;        ffit = outdir+'tmp.fit'
obj-> set, im_out_fits_filename = ffit
obj->fitswrite



;;;;;;;;;;;;;;;;;make sav variables just incase you need them
rhessidata = data                                      
fil = outdir+'rhessidata.sav'

;make errors array
;rhessierror = fltarr()

;save, time_intervals, rhessiindex, rhessidata, filename = fil                         
save, time_intervals, rhessidata, $ 
energy_range, $
increment, $
timg, $
algorithm, $
filename = fil

;Time elapsed
tsec_total = toc()
thr = tsec_total/60./60.
thr_remainder = thr - fix(thr)
tmin = thr_remainder * 60.
tmin_remainder = tmin - fix(tmin)
tsec = tmin_remainder * 60.

thr = string(thr, format = '(I0)')
tmin = string(tmin, format = '(I0)')
if (tsec lt 0.01) then tsec = string(tsec, format = '(E0.2)') else $
tsec = string(tsec, format = '(F0.2)')
print, 'Time elapsed: '+thr+' hours, '+tmin+' minutes and '+tsec+' seconds.

;delete last instance of tmp.fit
;spawn, 'rm '+outdir+'tmp.fit'
end

pro dopp_tran_detect, velocity_threshold, sav_dopp_diff = sav_dopp_diff


velothresh = string(abs(velocity_threshold), format = '(I0)')
filemod = velothresh+'_diffb4posrem'
;velocity_threshold = a negative velocity value



;;read in directories.txt and peaks.txt

flnm = '/unsafe/jsr2/project2/directories.txt' ;eg, flnm=hmicoords.txt
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

ndir = n_elements(directories)
nmap = n_elements(hmidopp)
npk = n_elements(peaks)





logfile = '/unsafe/jsr2/project2/diff_then_remove_positives/'+velothresh+'.log'
openw, lunl, logfile, /get_lun, /append
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf,lunl ,'***************** HMI DOPPLER TRANSIENT LOG *******************'
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf,lunl ,'***************** VELOCITY = '+velothresh+'********************'
printf,lunl ,'***************************************************************'
count = 0
for ddd = 0, ndir - 1 do begin
    hmidopp = 0
    doppdiff = 0
    sub = 0
    diff1 = 0
    tmp = 0
    printf,lunl ,'***************************************************************'
    printf,lunl ,'***************************************************************'
    printf,lunl ,'DIRECTORY = '+directories[ddd]
    restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/hmi-dopp.sav'
    spawn, 'mkdir /unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/v'+velothresh+'_diffb4posrem'
    nmap = n_elements(hmidopp)
;    tmp = hmidopp.data
    tmp = hmidopp
    sub = coreg_map(tmp,tmp[n_elements(tmp)/2])
    doppdiff = diff_map(sub(2),sub(0),/rotate)

    for i=1, n_elements(hmidopp) - 1 do begin
        ;;differencing
;        diff1=diff_map(sub[i],sub[i-2],/rotate) ;running difference
        diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
        doppdiff=str_concat(temporary(doppdiff),diff1)    
    endfor


    tmp = doppdiff.data

    ;remove positiiive velocities
;    for i = 0, n_elements(hmidopp) - 1 do begin
;        tmp[i].data[where(temporary(tmp[i].data) gt 0, /null)] = 0
;    endfor
    tmp[where(tmp gt 0)] = 0
    doppdiff.data = temporary(tmp)
    if keyword_set(sav_dopp_diff) then begin
        savf = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/doppdiffb4posrem.sav'
        save, doppdiff, filename = savf
    endif



    ;define array range to look for doppler transients, based on peak emission time
;    for i = 0, npk - 1 do begin
    a = 0
    b = 0

    ;find time range indices covering impulsive phase
;    a = where(strmatch(doppdiff.time, '*'+peaks[ddd]+'*') eq 1, ind)
;    b = array_indices(doppdiff.time, a)
    
    ;open file for doppler transient coords and time element
    filename = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/v'+velothresh+'_diffb4posrem/dopp_transient_v'+velothresh+'_coords_'+directories[ddd]+'.txt'
    openw, lun, filename, /get_lun, /append
;    for j = b[0] - 8, b[0]  + 8 do begin ;based on visual inspection
    for j = 0, nmap - 1 do begin
;        findtrans = where(doppdiff[j].data lt velocity_threshold, ind)
        findtrans = where(doppdiff[j].data lt velocity_threshold, ind)
        if (findtrans[0] ne -1) then begin
        dopptrans = array_indices(doppdiff.data, findtrans)
        sz = size(dopptrans, /dimensions) ;gives array dimensions sz[0] = columns sz[1] = rows
        count = temporary(count) + sz[1]
        jj = string(j, format = '(I0)')
        szst = string(sz[1], format = '(I0)')
        printf,lunl ,szst+'Doppler transients detected in doppdiff['+jj+']'
            ;if only one transient location
            if (n_elements(sz) eq 1) then begin
            dopptrans[2] = j 
            dtxy = fltarr(2,1)            
            ;convert pixels locations into helioseismic coords
            dtxy[0,0] = convert_coord_hmi(dopptrans[0], hmidopp_ind[j], /x, /p2a)
            dtxy[1,0] = convert_coord_hmi(dopptrans[1], hmidopp_ind[j], /y, /p2a)

            ;make plot
            dopp_plot, doppdiff.time, doppdiff.data[dopptrans[0], dopptrans[1]], directories[ddd], coords = dtxy, filemod


            ;multiple transient locations
            endif else begin
            ;fill with correct time element
            dopptrans[2, *] = j
            ;arrays to contain heliocentric coords            
            dtxy = fltarr(2,sz[1])

                ;iterate through each row in dopptrans for coord conversion to heliocentric
                for k = 0, sz[1] - 1 do begin
                    ;convert pixels locations into helioseismic coords
                    dtxy[0,k] = convert_coord_hmi(dopptrans[0, k], hmidopp_ind[j], /x, /p2a)
                    dtxy[1,k] = convert_coord_hmi(dopptrans[1, k], hmidopp_ind[j], /y, /p2a)

                    ;make plot
                    dopp_plot, doppdiff.time, doppdiff.data[dopptrans[0,k], dopptrans[1,k]], directories[ddd], coords = [dtxy[0,k],dtxy[1,k]], filemod
                endfor
            endelse
        ;put pixel, time element and heliocentric coords into a file
        dopptran = [dopptrans, dtxy]
        printf, lun, dopptran       
        endif

    endfor
    free_lun, lun
    findtrans = 0
    dopptrans = 0
    dtx = 0
    dty = 0
endfor
cnt = string(count, format = '(I0)')
nd = string(ndir, format = '(I0)')
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf, lunl, 'A total of '+cnt+' Doppler transients were detected in '+nd+' directories.'
free_lun, lunl
end

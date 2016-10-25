pro dopp_tran_detect, velocity_threshold


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




;;;detect
;restore, '/unsafe/jsr2/project2/20140329/HMI/v/hmi-dopp.sav'

for ddd = 0, ndir - 1 do begin
    hmidopp = 0
    doppdiff = 0
    sub = 0
    diff1 = 0
    tmp = 0

    restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/hmi-dopp.sav'

;    tmp = hmidopp.data
    tmp = hmidopp

    ;remove positiiive velocities
    for i = 0, n_elements(hmidopp) - 1 do begin
        tmp[i].data[where(tmp[i].data gt 0, /null)] = 0
    endfor
    sub = coreg_map(tmp,tmp[n_elements(tmp)/2])
    doppdiff = diff_map(sub(2),sub(0),/rotate)

    for i=1, n_elements(hmidopp) - 1 do begin
        ;;differencing
        diff1=diff_map(sub[i],sub[i-2],/rotate) ;running difference
    ;    diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
        doppdiff=str_concat(doppdiff,diff1)    
    endfor
    tmp = 0


    ;define array range to look for doppler transients, based on peak emission time
;    for i = 0, npk - 1 do begin
    a = 0
    b = 0

    ;find time range indices covering impulsive phase
    a = where(strmatch(doppdiff.time, '*'+peaks[ddd]+'*') eq 1, ind)
    b = array_indices(doppdiff.time, a)
    
    ;open file for doppler transient coords and time element
    filename = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/dopp_transient_coords_'+directories[ddd]+'.txt'
    openw, lun, filename, /get_lun, /append
    for j = b[0] - 3, b[0]  + 3 do begin
;        image_statistics, doppdiff[j].data, maximum = ma, minimum = mi, mean = me, stddev = s, sum_of_squares = sos, variance = v
        findtrans = where(doppdiff[j].data lt velocity_threshold, ind)
        if (findtrans[0] ne -1) then begin
        dopptrans = array_indices(doppdiff.data, findtrans)
        sz = size(dopptrans, /dimensions) ;gives array dimensions sz[0] = columns sz[1] = rows
            ;if only one transient location
            if (n_elements(sz) eq 1) then begin
            dopptrans[2] = j 
            
            ;convert pixels locations into helioseismic coords
            dtx = convert_coord_hmi(dopptrans[0], hmidopp_ind[j], /x, /p2a)
            dty = convert_coord_hmi(dopptrans[1], hmidopp_ind[j], /y, /p2a);coord, index, x = x, y = y, p2a = p2a, a2p = a2p

            ;make plot
            dopp_plot, doppdiff[j].time, doppdiff[j].data[dopptrans[0], dopptrans[1]], directories[ddd], coords = [dtx,dty]


            ;multiple transient locations
            endif else begin
            ;fill with correct time element
            dopptrans[2, *] = j
            ;arrays to contain heliocentric coords            
            dtx = fltarr(sz[1])
            dty = fltarr(sz[1])
                ;iterate through each row in dopptrans for coord conversion to heliocentric
                for k = 0, sz[1] - 1 do begin
                    ;convert pixels locations into helioseismic coords
                    dtx[k] = convert_coord_hmi(dopptrans[0, k], hmidopp_ind[j], /x, /p2a)
                    dty[k] = convert_coord_hmi(dopptrans[1, k], hmidopp_ind[j], /y, /p2a);coord, index, x = x, y = y, p2a = p2a, a2p = a2p

                    ;make plot
                    dopp_plot, doppdiff[j].time, doppdiff[j].data[dopptrans[0,k], dopptrans[1,k]], directories[ddd], coords = [dtx[k],dty[k]]
                endfor
            endelse
        ;put pixel, time element and heliocentric coords into a file
        printf, lun, dopptrans, dtx, dty        
        endif

    endfor
    free_lun, lun
    findtrans = 0
    dopptrans = 0
    dtx = 0
    dty = 0
endfor
end

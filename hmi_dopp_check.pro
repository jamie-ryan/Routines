flnm = '/unsafe/jsr2/project2/directories.txt' ;eg, flnm=hmicoords.txt
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

ndir = n_elements(directories)
;IDL> print, directories
;20150311 
restore, '/unsafe/jsr2/project2/'+directories[0]+'/HMI/v/hmi-dopp.sav'
movie_map, hmidopp
print, min(hmidopp.data)
-7082.46

velocity_threshold = -5000.
    nmap = n_elements(hmidopp)
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
;        diff1=diff_map(sub[i],sub[i-2],/rotate) ;running difference
        diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
        doppdiff=str_concat(doppdiff,diff1)    
    endfor
    for j = 0, nmap - 1 do begin
        findtrans = where(hmidopp[j].data lt velocity_threshold, ind)
        if (findtrans[0] ne -1) then begin
        dopptrans = array_indices(doppdiff.data, findtrans)
        sz = size(dopptrans, /dimensions) ;gives array dimensions sz[0] = columns sz[1] = rows
            ;if only one transient location
            if (n_elements(sz) eq 1) then begin
            dopptrans[2] = j 
            dtxy = fltarr(2,1)            
            ;convert pixels locations into helioseismic coords
            dtxy[0,0] = convert_coord_hmi(dopptrans[0], hmidopp_ind[j], /x, /p2a)
            dtxy[1,0] = convert_coord_hmi(dopptrans[1], hmidopp_ind[j], /y, /p2a)
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
                endfor
            endelse
        ;put pixel, time element and heliocentric coords into a file
        dopptran = [dopptrans, dtxy]
        endif

    endfor
time = doppdiff.time
array = doppdiff.data[dopptrans[0], dopptrans[1]]
utplot, time, array


;20140329 


;20140207 20140202 20140107 201311071428 201311070339 20131106 20130708 20130213 20121023 20120706 201207051134 201207050325 20120704 20120510 20120509 20110926 20110730 20110215

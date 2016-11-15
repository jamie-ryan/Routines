pro hmi_dopp_detect, plot = plot

;open and read in file containing data directories
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun



;open and set up log file for overall view of all detections
logfile = '/unsafe/jsr2/project2/hmi_dopp_detect.log'
openw, lunl, logfile, /get_lun, /append
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf,lunl ,'***************** HMI DOPPLER TRANSIENT LOG *******************'
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'

;this is used to count the number of detections
count = 0

;loop through directories
for ddd = 0, nlin - 1 do begin
    ;save some memory
    hmidopp = 0
    doppdiff = 0
    sub = 0
    diff1 = 0
    tmp = 0
    velocity = 0

    ;log file
    printf,lunl ,'***************************************************************'
    printf,lunl ,'***************************************************************'
    printf,lunl ,'DIRECTORY = '+directories[ddd]

    ;restore hmi-dopp sav file and make directory to contain results and plots
    restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/hmi-dopp.sav'

    ;set up and run backwards difference filter
    tmp = hmidopp
    sub = coreg_map(tmp,tmp[n_elements(tmp)/2])
    doppdiff = diff_map(sub(0),sub(1),/rotate)
    for i=1, n_elements(hmidopp) - 2 do begin 
        diff1=diff_map(sub[i],sub[i+1],/rotate) ;backwards difference
    ;        diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
        doppdiff=str_concat(temporary(doppdiff),diff1)    
    endfor

    ;create depth image: difference between min and max for each pixel across entire time series
    ;used to find locations with greatest doppler shift
    xpix = n_elements(doppdiff[0].data[*,0])
    ypix = n_elements(doppdiff[0].data[0,*])
    nt = n_elements(doppdiff)
    depth_image = fltarr(xpix,ypix)
    sum_image = fltarr(xpix,ypix)
    for i = 0, xpix - 1 do begin 
        for j = 0, ypix - 1 do begin
            mint = min(doppdiff[*].data[i,j])
            maxt = max(doppdiff[*].data[i,j])
            depth_image[i,j] =  maxt - mint
            sum_image[i,j] = total(doppdiff[*].data[i,j])
        endfor
    endfor
    isolate = depth_image^10/sum_image
    isolate = isolate/(max(isolate))
    ;use depth image to identify regions with velocities larger than 3*sigma over mean.... this seems more sensible
;    IMAGE_STATISTICS, depth_image, MAXIMUM=ma, MINIMUM=mi, MEAN=me, STDDEV=s, SUM_OF_SQUARES=sos, VARIANCE=v
    findtrans = where(depth_image gt 1400., ind)

    ;if dopp trans are found in the depth image then findtrans will not equal -1
    if (findtrans[0] ne -1) then begin

        ;open alog file to document locations of dopp trans found in depth image... 
        filename = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/dopp_transient_coords_'+directories[ddd]+'.txt'
        openw, lun, filename, /get_lun, /append

        ;remove background to make pure -ve velocity enhancement for plotting
        tmp = doppdiff.data
        tmp[where(tmp gt 0)] = 0
        doppdiff.data = temporary(tmp)

        ;convert array elements given by findtrans into array pixel locations
        dopptrans = array_indices(depth_image, temporary(findtrans))

        ;differentiate flagged pixels looking for steep gradients in data 
        ;how many detections?
        sz = size(dopptrans, /dimensions)


        ;context depth image
        flnm = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/context_depth_image.eps'
        !p.font=0			;use postscript fonts
        set_plot, 'ps'
        device, filename= flnm, encapsulated=eps, $
        /helvetica,/isolatin1, landscape=0, color=1
        plot_image, depth_image, title = directories[ddd]+' Depth Image with Circled Detections', ytitle = 'Pixels', xtitle = 'Pixels'
        tvcircle, 3., dopptrans[0,*], dopptrans[1,*], color = 'red'
        device,/close
        set_plot,'x'
        !p.font=-1 



        ;if only one detection
        if (n_elements(sz) eq 1) then begin
            count = temporary(count) + 1
            szst = string(1, format = '(I0)')



            velocity = min(doppdiff.data[dopptrans[0], dopptrans[1]],ind)
            j = array_indices(doppdiff,ind)

            ;convert pixels locations into helioseismic coords
            dtxy = fltarr(2,1)            
            dtxy[0,0] = convert_coord_hmi(dopptrans[0], hmidopp_ind[j], /x, /p2a)
            dtxy[1,0] = convert_coord_hmi(dopptrans[1], hmidopp_ind[j], /y, /p2a)

            if keyword_set(plot) then begin
            ;make plot
            dopp_plot, doppdiff.time, doppdiff.data[dopptrans[0], dopptrans[1]], directories[ddd], coords = dtxy
            endif

        ;if multiple detections
        endif else begin
            count = temporary(count) + sz[1]
            szst = string(sz[1], format = '(I0)')

            ;arrays to contain heliocentric coords and velocities
            dtxy = fltarr(2,sz[1])
            velocity = fltarr(1,sz[1])

            ;iterate through each row in dopptrans for coord conversion to heliocentric
            for k = 0, sz[1] - 1 do begin
                ;grab velocities                
                velocity[k] = min(doppdiff.data[dopptrans[0,k], dopptrans[1,k]],ind)
                j = array_indices(doppdiff, ind)

                ;convert pixels locations into helioseismic coords
                dtxy[0,k] = convert_coord_hmi(dopptrans[0, k], hmidopp_ind[j], /x, /p2a)
                dtxy[1,k] = convert_coord_hmi(dopptrans[1, k], hmidopp_ind[j], /y, /p2a)
    
                if keyword_set(plot) then begin
                ;make plot
                dopp_plot, doppdiff.time, doppdiff.data[dopptrans[0,k], dopptrans[1,k]], directories[ddd], $
                coords = [dtxy[0,k],dtxy[1,k]]
                endif
            endfor
        endelse

        printf,lunl ,szst+' Doppler transients detected
        ;put pixel, heliocentric coords into file
        dopptran = [temporary(dopptrans), temporary(dtxy), temporary(velocity)]
        printf, lun, dopptran 
        free_lun, lun      
    endif
endfor
cnt = string(count, format = '(I0)')
nd = string(nlin, format = '(I0)')
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf, lunl, 'A total of '+cnt+' Doppler transients were detected in '+nd+' directories.'
free_lun, lunl
end

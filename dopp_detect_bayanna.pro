pro dopp_detect_bayanna

dir = '/unsafe/jsr2/project2/20110215/HMI/v/'
restore, dir+'hmi-dopp.sav'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;detection scheme one
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2 point back diff
tmp = hmidopp
sub = coreg_map(tmp,tmp[n_elements(tmp)/2])
doppdiff = diff_map(sub(0),sub(1),/rotate)
for i=1, n_elements(hmidopp) - 2 do begin 
    diff1=diff_map(sub[i],sub[i+1],/rotate) ;backwards difference
;        diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    doppdiff=str_concat(temporary(doppdiff),diff1)    
endfor

;depth image: difference between min and max for each pixel across entire time series
xpix = n_elements(doppdiff[0].data[*,0])
ypix = n_elements(doppdiff[0].data[0,*])
nt = n_elements(doppdiff)
depth_image = fltarr(xpix,ypix)
for i = 0, xpix - 1 do begin 
    for j = 0, ypix - 1 do begin
        mint = min(doppdiff[*].data[i,j])
        maxt = max(doppdiff[*].data[i,j])
        depth_image[i,j] =  maxt - mint
    endfor
endfor

;use depth image to identify regions with velocities larger than 1km/s.... this seems to flag way too many.
a = where(depth_image gt 1000., ind)
b = array_indices(depth_image, a)


;use depth image to identify regions with velocities larger than 3*sigma over mean.... this seems more sensible
IMAGE_STATISTICS, depth_image, MAXIMUM=ma, MINIMUM=mi, MEAN=me, STDDEV=s, SUM_OF_SQUARES=sos, VARIANCE=v
a = where(depth_image gt me + 3*s, ind)
b = array_indices(depth_image, a)
sz = size(b, /dimensions)


;remove background to make pure -ve velocity enhancement
tmp = doppdiff.data
tmp[where(tmp gt 0)] = 0
doppdiff.data = temporary(tmp)


for k = 0, sz[1] - 1 do begin
    ;convert pixels locations into helioseismic coords
    dtxy[0,k] = convert_coord_hmi(dopptrans[0, k], hmidopp_ind[j], /x, /p2a)
    dtxy[1,k] = convert_coord_hmi(dopptrans[1, k], hmidopp_ind[j], /y, /p2a)

    ;make plot
    dopp_plot, doppdiff.time, doppdiff.data[dopptrans[0,k], dopptrans[1,k]], directories[ddd], coords = [dtxy[0,k],dtxy[1,k]], velothresh
endfor


end

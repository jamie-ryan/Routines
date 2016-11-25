pro hmi_dopp_detect, plot = plot
tic
;open and read in file containing data directories
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun


;depth image context plot pamphlet 
depthdir = '/unsafe/jsr2/project2/depth_images/'
texfile = depthdir+'hmi_depth_images.tex'
openw, lunn, texfile, /get_lun, /append
printf,lunn ,'\documentclass[11pt,a4paper]{report}'
printf,lunn ,'%Sets up margins'
printf,lunn ,'\usepackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}'
printf,lunn ,'%package to set up column style page layout'
printf,lunn ,'\usepackage{multicol}'
printf,lunn ,'%calls a maths package for writing equations'
printf,lunn ,'\usepackage{amsmath}'
printf,lunn ,'%package allows the inclusion of graphics files (.eps,.jpeg....etc)'
printf,lunn ,'\usepackage{graphicx}'
printf,lunn ,'%converts eps to pdf'
printf,lunn ,'\usepackage{epstopdf}'
printf,lunn ,'\DeclareGraphicsExtensions{.pdf,.png,.jpg,.eps}'
printf,lunn ,'\begin{document}' 



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
        
    print, 'ddd = ', ddd

    ;save some memory
;    hmidopp = 0
;    doppdiff = 0
;    sub = 0
;    diff1 = 0
;    tmp = 0
;    velocity = 0

    ;log file
    printf,lunl ,'***************************************************************'
    printf,lunl ,'***************************************************************'
    printf,lunl ,'DIRECTORY = '+directories[ddd]

    ;restore hmi-dopp sav file and make directory to contain results and plots
    restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/doppdiff.sav'
    restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/hmi-dopp.sav'

    ;set up and run backwards difference filter
;    tmp = temporary(hmidopp)
;    sub = coreg_map(tmp,tmp[n_elements(tmp)/2])
;    doppdiff = diff_map(sub(0),sub(1),/rotate)
;    print, 'making diff map'
;    for i=1, n_elements(tmp) - 2 do begin 
;        diff1=diff_map(sub[i],sub[i+1],/rotate) ;backwards difference
    ;        diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
;        doppdiff=str_concat(temporary(doppdiff),diff1)    
;    endfor

    ;preflare
    restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/doppdiff_pf.sav'
    ;restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/hmi-dopp.sav'
;    tmp_pf = temporary(hmidopp)
;    sub_pf = coreg_map(tmp_pf,tmp_pf[n_elements(tmp_pf)/2])
;    doppdiff_pf = diff_map(sub_pf(0),sub_pf(1),/rotate)
;    for i=1, n_elements(tmp_pf) - 2 do begin 
;        diff_pf=diff_map(sub_pf[i],sub_pf[i+1],/rotate) ;backwards difference
;    ;        diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
;        doppdiff_pf=str_concat(temporary(doppdiff_pf),diff_pf)    
;    endfor

    ;create depth image: difference between min and max for each pixel across entire time series
    ;used to find locations with greatest doppler shift
    xpix = n_elements(doppdiff[0].data[*,0])
    ypix = n_elements(doppdiff[0].data[0,*])
    nt = n_elements(doppdiff)
    depth_image = fltarr(xpix,ypix)    
    stddev_image = fltarr(xpix,ypix)
    avg_image = fltarr(xpix,ypix)
    thresh_image = fltarr(xpix,ypix)
    print, 'making stddev, avg, thresh and depth image'
    for i = 0, xpix - 1 do begin 
        for j = 0, ypix - 1 do begin
            mint = min(doppdiff[*].data[i,j])
            maxt = max(doppdiff[*].data[i,j])
            mint_pf = min(doppdiff_pf[*].data[i,j])
            maxt_pf = max(doppdiff_pf[*].data[i,j])
            depth_image[i,j] =  abs(maxt) - abs(mint)
            stddev_image[i,j] = stddev(doppdiff_pf[*].data[i,j])
			avg_image[i,j] = avg(doppdiff_pf[*].data[i,j])
            thresh_image[i,j]= avg_image[i,j] + 3*stddev_image[i,j]
        endfor
    endfor
    ;remove differencing artifacts    
    depth_image[*,-1]=0
    depth_image[-1,*]=0
    depth_image[*,0]=0
    depth_image[0,*]=0

    thresh_image[*,-1]=0
    thresh_image[-1,*]=0
    thresh_image[*,0]=0
    thresh_image[0,*]=0

    findtrans_pos = where((depth_image gt thresh_image), ind)
    findtrans_neg = where((depth_image lt -thresh_image), ind)

    if (findtrans_pos[0] ne -1) then loc_pos = array_indices(depth_image,findtrans_pos) else print, 'No positive velocity transients found'
    if (findtrans_neg[0] ne -1) then loc_neg = array_indices(depth_image,findtrans_neg) else print, 'No negative velocity transients found'

    if (findtrans_pos[0] eq -1) and (findtrans_neg[0] eq -1) then begin
    print, 'No Doppler transient were detected during the '+directories[ddd]+' event, moving onto next directory.'
    continue
    endif

    
    ;colours for context image detection circles
	colors = strarr(2)
	colors[0] = 'red'
	colors[1] = 'blue'

	;case select to setup number of detection sweeps, the higher the number, the more sensitive, the more low velocity transients are detected
    ;context eps without detection circles
    print, 'making context image'    
	fdir = '/unsafe/jsr2/project2/'
	flnm = fdir+''+directories[ddd]+'/HMI/v/'+directories[ddd]+'context_depth_image.eps'
	!p.font=0			;use postscript fonts
	set_plot, 'ps'
	device, filename= flnm, encapsulated=eps, $
	/helvetica,/isolatin1, landscape=0, color=1
	plot_image, depth_image, title = directories[ddd]+' Depth Image', ytitle = 'Pixels', xtitle = 'Pixels'
	device,/close
	set_plot,'x'
	!p.font=-1 

    ;context eps with detection circles
	fdir = '/unsafe/jsr2/project2/'
	flnm1 = fdir+''+directories[ddd]+'/HMI/v/'+directories[ddd]+'context_depth_image_with_detections.eps'
	!p.font=0			;use postscript fonts
	set_plot, 'ps'
	device, filename= flnm1, encapsulated=eps, $
	/helvetica,/isolatin1, landscape=0, color=1
	plot_image, depth_image, title = directories[ddd]+' Depth Image with Circled Detections', ytitle = 'Pixels', xtitle = 'Pixels'
    if (findtrans_pos[0] ne -1) then tvcircle, 3., loc_pos[0,*], loc_pos[1,*], color = colors[0]   
    if (findtrans_neg[0] ne -1) then tvcircle, 3., loc_neg[0,*], loc_neg[1,*], color = colors[1]   
	device,/close
	set_plot,'x'
	!p.font=-1 
    print, 'finished making detections context image'

    ;copies context eps files into depth_image dir ready for latex plot pamphlet
    print, 'moving files about, adding lines to hmi_depth_images.tex'
	spawn, 'cp '+flnm+' '+depthdir+''+directories[ddd]+'context_depth_image.eps'
	spawn, 'cp '+flnm1+' '+depthdir+''+directories[ddd]+'context_depth_image_with_detections.eps'
	printf,lunn ,'\includegraphics{'+depthdir+''+directories[ddd]+'context_depth_image.eps}' 
	printf,lunn ,'\includegraphics{'+depthdir+''+directories[ddd]+'context_depth_image_with_detections.eps}' 


    ;open alog file to document locations of dopp trans found in depth image... 
    filename = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/dopp_transient_coords_'+directories[ddd]+'.txt'
    openw, lun, filename, /get_lun, /append

    
    ;how many detections?
    sz_pos = size(loc_pos, /dimensions)
    sz_neg = size(loc_neg, /dimensions)

    ;positive velocities section
    ;if only one detection
    if (n_elements(sz_pos) eq 1) then begin
    print, 'For sz eq 1, Grabbing velocity values, converting pixel locations into heliocentric coordinates'    
        count = temporary(count) + 1
        szst_pos = string(1, format = '(I0)')

        velocity_pos = max(doppdiff.data[loc_pos[0], loc_pos[1]],ind)
        j_pos = array_indices(doppdiff,ind)

        ;convert pixels locations into helioseismic coords
        dtxy_pos = fltarr(2,1)            
        dtxy_pos[0,0] = convert_coord_hmi(loc_pos[0], hmidopp_ind[j], /x, /p2a)
        dtxy_pos[1,0] = convert_coord_hmi(loc_pos[1], hmidopp_ind[j], /y, /p2a)

        if keyword_set(plot) then begin
            print, 'making plots'    
            ;make plot
            dopp_plot, doppdiff.time, doppdiff.data[loc_pos[0], loc_pos[1]], directories[ddd], coords = dtxy_pos
        endif

    ;if multiple detections
    endif else begin
    print, 'For sz ne 1, Grabbing velocity values, converting pixel locations into heliocentric coordinates'    
        count = temporary(count) + sz_pos[1]
        szst_pos = string(sz_pos[1], format = '(I0)')

        ;arrays to contain heliocentric coords and velocities
        dtxy_pos = fltarr(2,sz_pos[1])
        velocity_pos = fltarr(1,sz_pos[1])
        j_pos = fltarr(1,sz_pos[1])

        ;iterate through each row in dopptrans for coord conversion to heliocentric
        for k = 0, sz_pos[1] - 1 do begin
            ;grab velocities                
            velocity_pos[k] = max(doppdiff.data[los_pos[0,k], loc_pos[1,k]],ind)
            ;grab time element of peak velocities
            j_pos[k] = array_indices(doppdiff, ind)

            ;convert pixels locations into helioseismic coords
            dtxy_pos[0,k] = convert_coord_hmi(loc_pos[0, k], hmidopp_ind[j[k]], /x, /p2a)
            dtxy_pos[1,k] = convert_coord_hmi(loc_pos[1, k], hmidopp_ind[j[k]], /y, /p2a)

            if keyword_set(plot) then begin
                ;make plot
            print, 'For sz eq 1, making plot'    
                dopp_plot, doppdiff.time, doppdiff.data[loc_pos[0,k], loc_pos[1,k]], directories[ddd], $
                coords = [dtxy_pos[0,k],dtxy_pos[1,k]]
            endif
        endfor
    endelse

    ;negative velocities section
    if (n_elements(sz_neg) eq 1) then begin
    print, 'For sz eq 1, Grabbing velocity values, converting pixel locations into heliocentric coordinates'    
        count = temporary(count) + 1
        szst_neg = string(1, format = '(I0)')

        velocity_neg = min(doppdiff.data[loc_neg[0], loc_neg[1]],ind)
        j_neg = array_indices(doppdiff,ind)

        ;convert pixels locations into helioseismic coords
        dtxy_neg = fltarr(2,1)            
        dtxy_neg[0,0] = convert_coord_hmi(loc_neg[0], hmidopp_ind[j], /x, /p2a)
        dtxy_neg[1,0] = convert_coord_hmi(loc_neg[1], hmidopp_ind[j], /y, /p2a)

        if keyword_set(plot) then begin
            print, 'making plots'    
            ;make plot
            dopp_plot, doppdiff.time, doppdiff.data[loc_neg[0], loc_neg[1]], directories[ddd], coords = dtxy_neg
        endif

    ;if multiple detections
    endif else begin
    print, 'For sz ne 1, Grabbing velocity values, converting pixel locations into heliocentric coordinates'    
        count = temporary(count) + sz_neg[1]
        szst_neg = string(sz_neg[1], format = '(I0)')

        ;arrays to contain heliocentric coords and velocities
        dtxy_neg = fltarr(2,sz_neg[1])
        velocity_neg = fltarr(1,sz_neg[1])
        j_neg = fltarr(1,sz_neg[1])

        ;iterate through each row in dopptrans for coord conversion to heliocentric
        for k = 0, sz_neg[1] - 1 do begin
            ;grab velocities                
            velocity_neg[k] = min(doppdiff.data[los_neg[0,k], loc_neg[1,k]],ind)
            ;grab time element of peak velocities
            j_neg[k] = array_indices(doppdiff, ind)

            ;convert pixels locations into helioseismic coords
            dtxy_neg[0,k] = convert_coord_hmi(loc_neg[0, k], hmidopp_ind[j[k]], /x, /p2a)
            dtxy_neg[1,k] = convert_coord_hmi(loc_neg[1, k], hmidopp_ind[j[k]], /y, /p2a)

            if keyword_set(plot) then begin
                ;make plot
            print, 'For sz eq 1, making plot'    
                dopp_plot, doppdiff.time, doppdiff.data[loc_neg[0,k], loc_neg[1,k]], directories[ddd], $
                coords = [dtxy_neg[0,k],dtxy_neg[1,k]]
            endif
        endfor
    endelse

    dtxy = [[dtxy_pos],[dtxy_neg]]
    velocity_all = [[velocity_pos],[velocity_neg]]
    dopptrans = [[loc_pos], [loc_neg]]
    print, 'putting dopptrans, heliocoords and velocity into file'    
    printf,lunl ,szst_pos+' positive Doppler transients detected
    printf,lunl ,szst_neg+' negative Doppler transients detected
    ;put pixel, heliocentric coords into file
    dopptran = [temporary(dopptrans), temporary(j), temporary(dtxy), temporary(velocity)]
    printf, lun, dopptran 
    free_lun, lun      
    print, 'copying file to depth image directory'    
    spawn, 'cp '+filename+' '+depthdir+''
;   spawn, 'rm tmp.dat'
;   spawn, 'rm tmp1.dat'
endfor

;tex
print, 'making latex file'    
printf,lunn ,'\end{document}'
free_lun, lunn
spawn, 'cd '+depthdir+'; pdflatex -shell-escape '+texfile+''
spawn, 'cd '+depthdir+'; pdflatex '+texfile+''

;log
cnt = string(count, format = '(I0)')
nd = string(nlin, format = '(I0)')
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf, lunl, 'A total of '+cnt+' Doppler transients were detected in '+nd+' directories.'
free_lun, lunl

;	print, 'Just what do you think you are doing, Dave?'
;	print, 'Look Dave, I can see you are really upset about this. I honestly think you ought to sit down calmly, take a stress pill, and think things over.'
    

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
end

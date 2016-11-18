pro hmi_dopp_detect, depth_image = depth_image, diff_image = diff_image, plot = plot
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
    print, 'making diff map'
    for i=1, n_elements(hmidopp) - 2 do begin 
        diff1=diff_map(sub[i],sub[i+1],/rotate) ;backwards difference
    ;        diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
        doppdiff=str_concat(temporary(doppdiff),diff1)    
    endfor

    if keyword_set(depth_image) then begin
    ;create depth image: difference between min and max for each pixel across entire time series
    ;used to find locations with greatest doppler shift
    xpix = n_elements(doppdiff[0].data[*,0])
    ypix = n_elements(doppdiff[0].data[0,*])
    nt = n_elements(doppdiff)
    depth_image = fltarr(xpix,ypix)
    print, 'making depth image'
    for i = 0, xpix - 1 do begin 
        for j = 0, ypix - 1 do begin
            mint = min(doppdiff[*].data[i,j])
            maxt = max(doppdiff[*].data[i,j])
            depth_image[i,j] =  maxt - mint
        endfor
    endfor
    endif

    ;make log10 image for detection scheme
    img = alog10(depth_image)
    ;find range of values for detection scheme
	maxi = max(img)
	mini = min(img)
    ;set a suitable increment for each detection sweep.... 
    ;add half the difference between max and min to min, then subtract from max and divide by a number which produces a reasonable increment
	sd = (maxi - (mini + ((maxi - mini)/2)))/9

    ;sweep array will contain a 1 if sweep was succeful and a 0 if not
	sweep = fltarr(10)
    ;colours for context image detection circles
	colors = strarr(10)
	colors[0] = 'green'
	colors[1] = 'lime green'
	colors[2] = 'chartreuse'
	colors[3] = 'green yellow'
	colors[4] = 'yellow'
	colors[5] = 'goldenrod'
	colors[6] = 'orange'
	colors[7] = 'orange red'
	colors[8] = 'red'
	colors[9] = 'dark red'

	;case select to setup number of detection sweeps, the higher the number, the more sensitive, the more low velocity transients are detected
    print, 'choosing detection sweep case'
	case 1 of
;		(maxi - 9*sd lt mini) and (maxi - 8*sd gt mini): swp = 8
;		(maxi - 8*sd lt mini) and (maxi - 7*sd gt mini): swp = 7
;		(maxi - 7*sd lt mini) and (maxi - 6*sd gt mini): swp = 6
;		(maxi - 6*sd lt mini) and (maxi - 5*sd gt mini): swp = 5
		(maxi - 5*sd lt mini) and (maxi - 4*sd gt mini): swp = 4
		(maxi - 4*sd lt mini) and (maxi - 3*sd gt mini): swp = 3
		(maxi - 3*sd lt mini) and (maxi - 2*sd gt mini): swp = 2
		(maxi - 2*sd lt mini) and (maxi - 1*sd gt mini): swp = 1
		(maxi - 1*sd lt mini) and (maxi - 0*sd gt mini): swp = 0
		else: swp = 5
	endcase
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

    ;detection sweep loop, stores coordinates in dopptrans, also performs tvcircle on context eps
    sw = string(swp, format = '(I0)')
    print, 'sweeping depth image with '+sw+' thresholding increments'   
	for i = swp, 0, -1 do begin
		thresh = maxi - i*sd
		findtrans = where(img gt thresh, ind)
		if (findtrans[0] gt -1) then begin 
			sweep[i] = 1.
			loc = array_indices(img, findtrans)
			if (i eq swp) then dopptrans = loc else $
			dopptrans = [[dopptrans], [loc]]		
			tvcircle, 3., loc[0,*], loc[1,*], color = colors[i]   
		endif else begin 
		sweep[i] = 0. 
		endelse
	endfor
    
	device,/close
	set_plot,'x'
	!p.font=-1 
    print, 'finished sweeping depth image and making detections context image'

    ;copies context eps files into depth_image dir ready for latex plot pamphlet
    print, 'moving files about, adding lines to hmi_depth_images.tex'
	spawn, 'cp '+flnm+' '+depthdir+''+directories[ddd]+'context_depth_image.eps'
	spawn, 'cp '+flnm1+' '+depthdir+''+directories[ddd]+'context_depth_image_with_detections.eps'
	printf,lunn ,'\includegraphics{'+depthdir+''+directories[ddd]+'context_depth_image.eps}' 
	printf,lunn ,'\includegraphics{'+depthdir+''+directories[ddd]+'context_depth_image_with_detections.eps}' 

    print, 'sorting, grabbing unique values and removing duplicate detections'
    ;sort and remove duplicates from dopptrans
    openw, lll, 'tmp.dat', /get_lun, /append    
    printf, lll, temporary(dopptrans)
    free_lun, lll
    ;get linux (any shell) to do the sorting and identify unique and duplicate coords
    spawn, 'sort tmp.dat | uniq  > tmp1.dat' ;uniques and duplicates
;    spawn, 'sort tmp.dat | uniq -u > tmp1.dat' ;uniques
;    spawn, 'sort tmp.dat | uniq -d >> tmp1.dat' ;duplicates

    ;read sorted and duplicate removed coordinates into array, replacing dopptrans
    print, 'filling array with sorted unique detections'    
    openr, lll, 'tmp1.dat', /get_lun
    nlin =  file_lines('tmp1.dat')
    dopptrans = fltarr(2,nlin)
    readf, lll, dopptrans
    free_lun, lll    

    ;open alog file to document locations of dopp trans found in depth image... 
    filename = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/dopp_transient_coords_'+directories[ddd]+'.txt'
    openw, lun, filename, /get_lun, /append

    ;remove background to make pure -ve velocity enhancement for plotting
;       tmp = doppdiff.data
;       tmp[where(tmp gt 0)] = 0
;       doppdiff.data = temporary(tmp)
    ;convert array elements given by findtrans into array pixel locations
;        dopptrans = array_indices(depth_image, temporary(findtrans))


    ;how many detections?
    sz = size(dopptrans, /dimensions)

    ;if only one detection
    if (n_elements(sz) eq 1) then begin
    print, 'For sz eq 1, Grabbing velocity values, converting pixel locations into heliocentric coordinates'    
        count = temporary(count) + 1
        szst = string(1, format = '(I0)')

        velocity = min(doppdiff.data[dopptrans[0], dopptrans[1]],ind)
        j = array_indices(doppdiff,ind)

        ;convert pixels locations into helioseismic coords
        dtxy = fltarr(2,1)            
        dtxy[0,0] = convert_coord_hmi(dopptrans[0], hmidopp_ind[j], /x, /p2a)
        dtxy[1,0] = convert_coord_hmi(dopptrans[1], hmidopp_ind[j], /y, /p2a)

        if keyword_set(plot) then begin
            print, 'making plots'    
            ;make plot
            dopp_plot, doppdiff.time, doppdiff.data[dopptrans[0], dopptrans[1]], directories[ddd], coords = dtxy
        endif

    ;if multiple detections
    endif else begin
    print, 'For sz ne 1, Grabbing velocity values, converting pixel locations into heliocentric coordinates'    
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
            print, 'For sz eq 1, making plot'    
                dopp_plot, doppdiff.time, doppdiff.data[dopptrans[0,k], dopptrans[1,k]], directories[ddd], $
                coords = [dtxy[0,k],dtxy[1,k]]
            endif
        endfor
    endelse
    print, 'putting dopptrans, heliocoords and velocity into file'    
    printf,lunl ,szst+' Doppler transients detected
    ;put pixel, heliocentric coords into file
    dopptran = [temporary(dopptrans), temporary(dtxy), temporary(velocity)]
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
spawn, 'pdflatex -shell-escape '+texfile+''
spawn, 'pdflatex '+texfile+''

;log
cnt = string(count, format = '(I0)')
nd = string(nlin, format = '(I0)')
printf,lunl ,'***************************************************************'
printf,lunl ,'***************************************************************'
printf, lunl, 'A total of '+cnt+' Doppler transients were detected in '+nd+' directories.'
free_lun, lunl

;	print, 'Just what do you think you are doing, Dave?'
;	print, 'Look Dave, I can see you are really upset about this. I honestly think you ought to sit down calmly, take a stress pill, and think things over.'
    

toc
end

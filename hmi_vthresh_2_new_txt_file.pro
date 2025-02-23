pro hmi_vthresh_2_new_txt_file, sd, text_file = text_file, sav_file = sav_file


sdstr = string(sd, format = '(F0.1)')

;directories for various files
fdir = '/unsafe/jsr2/project2/'
depthdir = fdir+'depth_images/thresh_'+sdstr+'sd/'

flnm = fdir+'directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun



vel_thresh = [-500, -1000, -1500, -2000, -2500, -3000]
nv = n_elements(vel_thresh)

for ddd = 0, nlin - 1 do begin
  datdir = fdir+''+directories[ddd]+'/HMI/'
  vdatdir = datdir+'v/'
  icdatdir = datdir+'ic/'
  restore, icdatdir+'fepmaps.sav'
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;READ IN RESULTS SECTION;;;;;;;;;;;;;;;;;;;;;;;;;;
  if keyword_set(text_file) then begin
    ;read in txt file
    txtfile = depthdir+'dopp_transient_coords_'+directories[ddd]+'.txt'
    openr, lun, txtfile, /get_lun
    txtlin =  file_lines(txtfile)
    dopptran = fltarr(8,txtlin)
    readf, lun, dopptran 
    free_lun, lun
  endif
  if keyword_set(sav_file) then begin
    restore, depthdir+''+directories[ddd]+'-dopptran.sav'
  endif


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;VEL_THRESH SECTION;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;thresholds: v=-1000, v=-1500, v=-2000, v=-2500, v=-3000
  ;dopptran[0,*] = dopptrans[0,*]
  ;dopptran[1,*] = dopptrans[1,*]
  ;dopptran[2,*] = j[*]
  ;dopptran[3,*] = dtxy[0,*]
  ;dopptran[4,*] = dtxy[1,*]
  ;dopptran[5,*] = velocity_all[*]
  ;dopptran[6,*] = avgg[*]
  ;dopptran[7,*] = stdd[*]
  for vvv = 0, nv - 1 do begin
    threshd_elements = where(dopptran[5,*] lt vel_thresh[vvv], ind)
    if (threshd_elements[0] eq -1) then continue else $    
    threshd_locations = array_indices(dopptran[5,*], threshd_elements)
    threshd_locations = reform(threshd_locations[1,*])
    vthresh_size = n_elements(threshd_locations)

    


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;PLOTTING SECTION;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;plot dopptran with tvcircles over differenced dopp and ic data, on the actual time element captured in .txt
    
;    for i = 0, vthresh_size - 1 do begin
;      plotdir = fdir+''+directories[ddd]+'/HMI/v/thresh_'+sdstr+'sd/'
;      plotfile = plotdir+''+directories[ddd]+'context_depth_image_with_dopptran.eps'
;      !p.font=0			;use postscript fonts
;      set_plot, 'ps'
;      device, filename= plotfile, encapsulated=eps, $
;      /helvetica,/isolatin1, landscape=0, color=1
;      plot_image, depth_image, title = directories[ddd]+' Depth Image with Circled dopptran', ytitle = 'Pixels', xtitle = 'Pixels'
;        if (findtrans_pos[0] ne -1) then tvcircle, 3., loc_pos[0,*], loc_pos[1,*], color = colors[0]   
;        if (findtrans_neg[0] ne -1) then tvcircle, 3., loc_neg[0,*], loc_neg[1,*], color = colors[1]   
;      device,/close
;      set_plot,'x'
;      !p.font=-1 
;    endfor

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;OUTPUT TO FILE SECTION;;;;;;;;;;;;;;;;;;;;;;;;
    ;output velocity thresholded data to a txt file
    ;xpix, ypix, t, xarc, yarc, vel, av, stdev, power
    fileout = fltarr(9,vthresh_size)
    ;put xpix, ypix, t, xarc, yarc, vel, av, stdev in array
    fileout[0:7, *] = dopptran[*,threshd_locations[*]]
    for i = 0, vthresh_size - 1 do begin
    ;put power in array
    fileout[8,i] = pmap[dopptran[2,threshd_locations[i]]].data[dopptran[0,threshd_locations[i]],dopptran[1,threshd_locations[i]]]
    endfor
    ;make vel_thresh string
    vtstr = string(abs(vel_thresh[vvv]), format = '(I0)' )
    ;output file
    threshdfile = depthdir+'vthreshd-v'+vtstr+'-dopp_transients_'+directories[ddd]+'.txt'
    openw, lun, threshdfile, /get_lun, /append
 	  printf, lun, fileout
    free_lun, lun
    ;;;;;;;force file into columns
    ;rearrange file contents and put in new tmp file
    spawn, 'fix-dopp-files.sh '+threshdfile+' '+depthdir+'tmp.txt'
    ;rename new file with original filename
    spawn, 'mv '+depthdir+'tmp.txt '+threshdfile
    ;cp new rearranged file into data directory
    spawn, 'cp '+threshdfile+' '+datdir 
    ;save fileout into array, incase it's needed for something else
    save, fileout, filename = datdir+'vthreshd-v'+vtstr+'-dopp_transients_'+directories[ddd]+'.sav'
  endfor
undefine, fmap
undefine, emap
undefine, pmap
undefine, dopptran
undefine, fileout
endfor
end

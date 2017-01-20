pro hmi_vtrhesd_tvcircle

sd = 3.0
sdstr = string(sd, format = '(F0.1)')

fdir = '/unsafe/jsr2/project2/'
flnm = fdir+'directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

vel_thresh = [-500, -1000, -1500, -2000, -2500, -3000]
nv = n_elements(vel_thresh)

depthdir = '/unsafe/jsr2/project2/depth_images/thresh_'+sdstr+'sd/'

for vvv = 0, nv - 1 do begin
  vtstr = string(abs(vel_thresh[vvv]), format = '(I0)' )
  texfilev = depthdir+'doppdiff-vthreshd-v'+vtstr+'.tex'
  texfilevpdf = depthdir+'doppdiff-vthreshd-v'+vtstr+'.pdf'
  openw, lunn, texfilev, /get_lun, /append
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

  texfileic = depthdir+'hmidiff-vthreshd-v'+vtstr+'.tex'
  texfileicpdf = depthdir+'hmidiff-vthreshd-v'+vtstr+'.pdf'    
  openw, lunnn, texfileic, /get_lun, /append
  printf,lunnn ,'\documentclass[11pt,a4paper]{report}'
  printf,lunnn ,'%Sets up margins'
  printf,lunnn ,'\usepackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}'
  printf,lunnn ,'%package to set up column style page layout'
  printf,lunnn ,'\usepackage{multicol}'
  printf,lunnn ,'%calls a maths package for writing equations'
  printf,lunnn ,'\usepackage{amsmath}'
  printf,lunnn ,'%package allows the inclusion of graphics files (.eps,.jpeg....etc)'
  printf,lunnn ,'\usepackage{graphicx}'
  printf,lunnn ,'%converts eps to pdf'
  printf,lunnn ,'\usepackage{epstopdf}'
  printf,lunnn ,'\DeclareGraphicsExtensions{.pdf,.png,.jpg,.eps}'
  printf,lunnn ,'\begin{document}' 
  for ddd = 0, nlin - 1 do begin
    ;differenced Doppler
    restore, fdir+''+directories[ddd]+'/HMI/v/doppdiff.sav'
    restore, fdir+''+directories[ddd]+'/HMI/ic/fepmaps.sav'
    plotdirv = fdir+''+directories[ddd]+'/HMI/v/thresh_'+sdstr+'sd/vthreshd-v'+vtstr+'/'
    plotdiric = fdir+''+directories[ddd]+'/HMI/ic/thresh_'+sdstr+'sd/vthreshd-v'+vtstr+'/'


    checkfile = file_test(fdir+''+directories[ddd]+'/HMI/vthreshd-v'+vtstr+'-dopp_transients_'+directories[ddd]+'.sav')
    if (checkfile eq 0) then continue else $
    restore, fdir+''+directories[ddd]+'/HMI/vthreshd-v'+vtstr+'-dopp_transients_'+directories[ddd]+'.sav'
    doptran = fileout
    undefine, fileout





    ;sort into time order
    sortIndex = Sort( doptran[2,*] )
    for j = 0, n_elements(doptran[*,0]) - 1 do doptran[j, *] = doptran[j, sortIndex]

    ;find unique time values in the form of an index 
    ti = uniq(doptran[2,*])
    for tunq = 0, n_elements(ti) - 1 do begin
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;V

      print, 'making doppdiff context image'
      tt = strmid(doppdiff[doptran[2,ti[tunq]]].time, 12, 8)    
      flnm = plotdirv+'vthreshd-v'+vtstr+'-t-'+tt+'-'+directories[ddd]+'context_doppdiff_map.eps'
      !p.font=0			;use postscript fonts
      set_plot, 'ps'
      device, filename= flnm, encapsulated=eps, $
      /helvetica,/isolatin1, landscape=0, color=1
      plot_map, doppdiff[doptran[2,ti[tunq]]]
      device,/close
      set_plot,'x'
      !p.font=-1 

      ;context eps with detection circles
      flnm1 = plotdirv+'vthreshd-v'+vtstr+'-t-'+tt+'-'+directories[ddd]+'-context_doppdiff_map_with_detections.eps'
      !p.font=0			;use postscript fonts
      set_plot, 'ps'
      device, filename= flnm1, encapsulated=eps, $
      /helvetica,/isolatin1, landscape=0, color=1
      plot_map, doppdiff[doptran[2,ti[tunq]]]
      if (tunq eq 0) then tvcircle, 3., doptran[3,0:ti[tunq]], doptran[4,0:ti[tunq]], color = 'red' else $
      tvcircle, 3., doptran[3,ti[tunq-1]+1:ti[tunq]], doptran[4,ti[tunq-1]+1:ti[tunq]], color = 'red'   
      ;, title = directories[ddd]+' Depth Image with Circled Detections', ytitle = 'Pixels', xtitle = 'Pixels'
      device,/close
      set_plot,'x'
      !p.font=-1 
      print, 'finished making detections doppdiff context image'
      
      
      ;;;;;;;;;;;;;;;;;;;;;;IC


      print, 'making hmidiff context image'
      flnm2 = plotdiric+'vthreshd-v'+vtstr+'-t-'+tt+'-'+directories[ddd]+'context_hmidiff_map.eps'
      !p.font=0			;use postscript fonts
      set_plot, 'ps'
      device, filename= flnm2, encapsulated=eps, $
      /helvetica,/isolatin1, landscape=0, color=1
      plot_map, pmap[doptran[2,ti[tunq]]]
      device,/close
      set_plot,'x'
      !p.font=-1 

      ;context eps with detection circles
      flnm3 = plotdiric+'vthreshd-v'+vtstr+'-t-'+tt+'-'+directories[ddd]+'-context_hmidiff_map_with_detections.eps'
      !p.font=0			;use postscript fonts
      set_plot, 'ps'
      device, filename= flnm3, encapsulated=eps, $
      /helvetica,/isolatin1, landscape=0, color=1
      plot_map, pmap[doptran[2,ti[tunq]]]
      if (tunq eq 0) then tvcircle, 3., doptran[3,0:ti[tunq]], doptran[4,0:ti[tunq]], color = 'red' else $
      tvcircle, 3., doptran[3,ti[tunq-1]+1:ti[tunq]], doptran[4,ti[tunq-1]+1:ti[tunq]], color = 'red'   
      ;, title = directories[ddd]+' Depth Image with Circled Detections', ytitle = 'Pixels', xtitle = 'Pixels'
      device,/close
      set_plot,'x'
      !p.font=-1 
      print, 'finished making detections hmidiff context image'
      
      printf,lunn ,'\includegraphics{'+flnm+'}' 
      printf,lunn ,'\includegraphics{'+flnm1+'}' 

      printf,lunnn ,'\includegraphics{'+flnm2+'}' 
      printf,lunnn ,'\includegraphics{'+flnm3+'}' 
    endfor
  endfor
  print, 'making latex files'    
  printf,lunn ,'\end{document}'
  free_lun, lunn
  spawn, 'cd '+depthdir+'; pdflatex -shell-escape '+texfilev+''
  spawn, 'cd '+depthdir+'; pdflatex '+texfilev+''
;  spawn, 'cp '+texfilevpdf+' /unsafe/jsr2/project2/depth_images/thresh_'+sdstr+'sd/'

  printf,lunnn ,'\end{document}'
  free_lun, lunnn
  spawn, 'cd '+depthdir+'; pdflatex -shell-escape '+texfileic+''
  spawn, 'cd '+depthdir+'; pdflatex '+texfileic+''
;  spawn, 'cp '+texfileicpdf+' /unsafe/jsr2/project2/depth_images/thresh_'+sdstr+'sd/'
endfor
end

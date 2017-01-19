pro hmi_dopp_coord_v

;plot energy curves associated with Doppler transients found by hmi_dopp_detect from energy coonverted HMI IC maps


;read in directories txt file
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

;sd = 3.0+findgen(23)*.5
sd = 3.0

vel_thresh = [-500, -1000, -1500, -2000, -2500, -3000]
nv = n_elements(vel_thresh)

;for s = 0, n_elements(sd) - 1 do begin 
  sdstr = string(sd, format = '(F0.1)')
  depthdir = '/unsafe/jsr2/project2/depth_images/thresh_'+sdstr+'sd/'

  for ddd = 0, nlin - 1 do begin
  restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/doppdiff.sav'
      for vvv = 0, nv - 1 do begin

        ;this will contain all dopp transients with velocities lt -1000 m/s
        vtstr = string(abs(vel_thresh[vvv]), format = '(I0)' )
        thrshsav = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/vthreshd-v'+vtstr+'-dopp_transients_'+directories[ddd]+'.sav'
        checkfile = file_exist(thrshsav)
        if (checkfile eq 0) then continue else $
        restore, thrshsav
        doptrans = fileout
        undefine, fileout
        nline = n_elements(reform(doptrans[0,*]))

      
      vdir = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/thresh_'+sdstr+'sd/vthreshd-v'+vtstr+'/'
      spawn, 'mkdir '+vdir

      ;make plots
      for k = 0, nline - 1 do begin
        dopp_plot, doppdiff.time, doppdiff.data[doptrans[0,k], doptrans[1,k]], vdir, $
        coords = [doptrans[3,k],doptrans[4,k]], sdstr, /vthresh
      endfor 
      undefine, fmap
      undefine, emap
      undefine, pmap
    endfor
  endfor
;endfor
end

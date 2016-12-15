pro hmi_dopp_coord_ic_energies

;plot energy curves associated with Doppler transients found by hmi_dopp_detect from energy coonverted HMI IC maps


;read in directories txt file
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

sd = 3.0+findgen(23)*.5
for s = 0, n_elements(sd) - 1 do begin 
  sdstr = string(sd[s], format = '(F0.1)')
  depthdir = '/unsafe/jsr2/project2/depth_images/thresh_'+sdstr+'sd/'

  for ddd = 0, nlin - 1 do begin

    ;read in doppler transient files containing locations velocities etc
    ;check file exists... returns 0 if it doesn't
    checkfile = file_exist(depthdir+'dopp_transient_coords_'+directories[ddd]+'.txt')
    if (checkfile eq 0) then continue else $
    flnm1 = depthdir+'dopp_transient_coords_'+directories[ddd]+'.txt'
    openr, llun, flnm1, /get_lun
    nline =  file_lines(flnm1)
    doptrans = fltarr(8, nline)
    readf, llun, doptrans 
    free_lun, llun
    icdir = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/ic/'
    savf = icdir+'fepmaps.sav'
    restore, savf
    spawn, 'mkdir '+icdir+'thresh_'+sdstr+'sd/'

    ;make plots
    for k = 0, nline - 1 do begin
      hmi_ic_plot, fmap.time, fmap.data[doptrans[0,k], doptrans[1,k]], $
      directories[ddd], coords = [doptrans[3,k],doptrans[4,k]], sdstr, /flux

      hmi_ic_plot, emap.time, emap.data[doptrans[0,k], doptrans[1,k]], $
      directories[ddd], coords = [doptrans[3,k],doptrans[4,k]], sdstr, /energy
              
      hmi_ic_plot, pmap.time, pmap.data[doptrans[0,k], doptrans[1,k]], $
      directories[ddd], coords = [doptrans[3,k],doptrans[4,k]], sdstr, /power
    endfor 
    undefine, fmap
    undefine, emap
    undefine, pmap
  endfor
endfor
end

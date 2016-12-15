pro hmi_dopp_coord_ic_energies, sd

;plot energy curves associated with Doppler transients found by hmi_dopp_detect from energy coonverted HMI IC maps



flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

sdstr = string(sd, format = '(F0.1)')
depthdir = '/unsafe/jsr2/project2/depth_images/thresh_'+sdstr+'sd/'

for ddd = 0, nlin - 1 do begin



flnm1 = depthdir+'dopp_transient_coords_'+directories[ddd]+'.txt'
;flnm1 = depthdir+'test1.txt'
openr, llun, flnm1, /get_lun
nlin =  file_lines(flnm1)
doptrans = fltarr(8, nlin)
readf, llun, doptrans 
free_lun, llun
icdir = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/ic/'
restore, icdir+'hmihmi-smth-diff.sav'
index2map, diffind, reform(hmifep[2,*,*,*]), pmap


utplot, pmap.time, pmap.data[doptrans[1,0], doptrans[2,0]]


endfor



end

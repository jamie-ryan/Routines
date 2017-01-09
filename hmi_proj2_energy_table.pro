pro hmi_proj2_energy_table

;need to make a very large table containing Dopp velocities, IC energies for all coordinates of interest

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

  ;open latex file
  openw, lun, '/unsafe/jsr2/'+fdate+'/velocity-power-table.tex', /get_lun
  printf, lun, '\begin{table}[h]'
  printf, lun, '\tiny'
  printf, lun, '\centering'
  printf, lun, '\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|}'
  printf, lun, 'Coorinates (x,y) [arcsecs] & $P_{Si IV}$ [erg] & $P_{Mg II}$ [erg] & $P_{Balm}$ [erg] & $P_{Mg II w}$ [erg] & $P_{HMI}$ [erg]\\'
  printf, lun, '\hline'

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

    ;make table
    for k = 0, nline - 1 do begin
        ;something like this
      ;    dopptran[0,*] = dopptrans[0,*] x coord in pixels
      ;    dopptran[1,*] = dopptrans[1,*] y coord in pixels
      ;    dopptran[2,*] = j[*] time element
      ;    dopptran[3,*] = dtxy[0,*] x in heliocentric
      ;    dopptran[4,*] = dtxy[1,*] y in heliocentric
      ;    dopptran[5,*] = velocity_all[*] Doppler transient velocity
      ;    dopptran[6,*] = avgg[*] 
      ;    dopptran[7,*] = stdd[*]

      arcx = string(doptrans[3,k], format = '(F0.2)')
      arcy = string(doptrans[4,k], format = '(F0.2)')
      velocity = string(doptrans[5,k], format = '(F0.2)')
      flux = string(fmap.data[doptrans[0,k], doptrans[1,k]], format = '(E0.2)')
      energy = string(emap.data[doptrans[0,k], doptrans[1,k]], format = '(E0.2)')
      power = string(pmap.data[doptrans[0,k], doptrans[1,k]],format = '(E0.2)')

      printf, lun, arcx+' & '+arcy+' & '+velocity+' & '+flux+' & '+energy+' & '+power+'\\'
    endfor 
    printf, lun, '\end{tabular}'
    printf, lun, '\caption{}\label{}'
    printf, lun, '\end{table}'
    undefine, fmap
    undefine, emap
    undefine, pmap
  endfor
endfor
end

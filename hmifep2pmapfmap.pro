pro hmifep2pmapfmap

flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun


for ddd = 0, nlin -1 do begin
  icdir = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/ic/'
  restore, icdir+'hmihmi-smth-diff.sav'
  index2map, diffind, reform(hmifep[0,*,*,*]), fmap
  index2map, diffind, reform(hmifep[1,*,*,*]), emap
  index2map, diffind, reform(hmifep[2,*,*,*]), pmap
  savf = icdir+'fepmaps.sav' 
  save, fmap, emap, pmap, filename = savf
endfor
end

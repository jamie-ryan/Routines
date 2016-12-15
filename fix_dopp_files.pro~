pro fix_dopp_files

flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

sd = 3.0+findgen(23)*.5
sdtr = string(sd, format = '(f0.1)')


for sdd = 0, n_elements(sdtr) - 1 do begin
    depthdir = '/unsafe/jsr2/project2/depth_images/thresh_'+sdtr[sdd]+'sd/'
    for ddd = 0, nlin - 1 do begin
        ;rearrange file contents and put in new file
        spawn, 'fix-dopp-files.sh '+depthdir+'dopp_transient_coords_'+directories[ddd]+'.txt '+depthdir+'dopp_transient_coords_'+directories[ddd]+'_fixed.txt'
        ;rename new file with original filename
        spawn, 'mv '+depthdir+'dopp_transient_coords_'+directories[ddd]+'_fixed.txt '+depthdir+'dopp_transient_coords_'+directories[ddd]+'.txt'
        ;cp new rearranged file into data directory
    	fdir = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/thresh_'+sdtr+'sd/
        spawn, 'cp '+depthdir+'dopp_transient_coords_'+directories[ddd]+'.txt '+fdir+'dopp_transient_coords_'+directories[ddd]+'.txt'        
    endfor
endfor
end



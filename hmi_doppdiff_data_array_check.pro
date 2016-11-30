pro hmi_doppdiff_data_array_check

flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

for ddd = 0, nlin - 1 do begin
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/doppdiff.sav'
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/doppdiff_pf.sav'
print, directories[ddd]
help, doppdiff.data, doppdiff_pf.data

endfor

20150311                                                                               
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[168, 167, 25]                                        
ddd = 0
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/doppdiff.sav'
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/doppdiff_pf.sav'
doppdiff.data = doppdiff.data[*,0:]





20140329                                                                               
<Expression>    FLOAT     = Array[168, 167, 25]                                        
<Expression>    FLOAT     = Array[168, 167, 25]                                        
20140207                                                                               
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[168, 168, 25]                                        
20140202                                                                               
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[167, 168, 25]                                        
20140107                                                                               
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[167, 168, 25]                                        
201311071428                                                                           
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[168, 168, 25]                                        
201311070339                                                                           
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[167, 168, 25]                                        
20131106                                                                               
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[168, 168, 25]                                        
20130708                                                                               
<Expression>    FLOAT     = Array[168, 167, 25]                                        
<Expression>    FLOAT     = Array[168, 167, 25]                                        
20130217                                                                               
<Expression>    FLOAT     = Array[168, 167, 25]                                        
<Expression>    FLOAT     = Array[167, 167, 25]                                        
20121023                                                                               
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[168, 167, 25]                                        
20120706                                                                               
<Expression>    FLOAT     = Array[168, 167, 23]                                        
<Expression>    FLOAT     = Array[167, 167, 25]                                        
201207051134                                                                           
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[167, 168, 25]                                        
201207050325                                                                           
<Expression>    FLOAT     = Array[168, 168, 25]                                        
<Expression>    FLOAT     = Array[167, 168, 25]                                        
20120704                                                                               
<Expression>    FLOAT     = Array[167, 167, 25]                                        
<Expression>    FLOAT     = Array[167, 167, 25]                                        
20120510
<Expression>    FLOAT     = Array[167, 167, 25]
<Expression>    FLOAT     = Array[167, 167, 25]
20120309
<Expression>    FLOAT     = Array[168, 168, 25]
<Expression>    FLOAT     = Array[168, 168, 25]
20110926
<Expression>    FLOAT     = Array[168, 168, 25]
<Expression>    FLOAT     = Array[168, 167, 25]
20110730
<Expression>    FLOAT     = Array[167, 168, 25]
<Expression>    FLOAT     = Array[168, 167, 25]
20110215
<Expression>    FLOAT     = Array[167, 168, 25]
<Expression>    FLOAT     = Array[167, 168, 25]

;make ref maps
for ddd = 0, nlin - 1 do begin
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/doppdiff.sav'
refmap = doppdiff[12]
save, refmap, filename='/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/refmap.sav'
endfor

directory = '/unsafe/jsr2/project2/20150311/HMI/v/pre-flare/'
files = findfile(directory+'hmi.*.fits')
aia_prep, files,-1, out_ind, out_dat, /despike
index2map, out_ind, out_dat, map
peak_time = '11-Mar-2015 16:22'
rmap=drot_map(map[0],time = peak_time)
for i = 1,  n_elements(map) - 1 do begin
    rmp=drot_map(map[i],time = peak_time)
    rmap = str_concat(temporary(rmap), rmp)
endfor
map = temporary(rmap)
directory = '/unsafe/jsr2/project2/20150311/HMI/v/'
restore, directory+'refmap.sav'
sub_map, map, ref_map = refmap, /preserve, mp 

end

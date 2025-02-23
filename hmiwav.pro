pro hmiwav, rate, multiple

;restore, '/disk/solar3/jsr2/Data/SDO/hmi-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmi-20-02-15.sav'

filename61 = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/61/hmi-high-intenstiy-pixels-frame-61.dat'
filename62 = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/62/hmi-high-intenstiy-pixels-frame-62.dat'
filename63 = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/63/hmi-high-intenstiy-pixels-frame-63.dat'
filename64 = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/64/hmi-high-intenstiy-pixels-frame-64.dat'

;;;;;;;open files 
openr,lun,filename61,/get_lun

;;;count lines in file
nlines61 = file_lines(filename61)

;;;make array to fill with values from the file
h61=intarr(2,nlines61)

;;;read file contents into array
readf,lun,h61

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,filename62,/get_lun

;;;count lines in file
nlines62 = file_lines(filename62)

;;;make array to fill with values from the file
h62=intarr(2,nlines62)

;;;read file contents into array
readf,lun,h62

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

openr,lun,filename63,/get_lun

;;;count lines in file
nlines63 = file_lines(filename63)

;;;make array to fill with values from the file
h63=intarr(2,nlines63)

;;;read file contents into array
readf,lun,h63

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

openr,lun,filename64,/get_lun

;;;count lines in file
nlines64 = file_lines(filename64)

;;;make array to fill with values from the file
h64=intarr(2,nlines64)

;;;read file contents into array
readf,lun,h64

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;make arrays to contain plotting values
nnn = n_elements(sbhmimap)
boxarr61 = fltarr(nnn)
boxarr62 = fltarr(nnn)
boxarr63 = fltarr(nnn)
boxarr64 = fltarr(nnn)
;loop to fill arrays with summed pixel intensity values
for i = 0, nnn-1, 1 do begin
boxarr61[i] = total(sbhmimap[i].data[h61[0,*],h61[1,*]]) 
boxarr62[i] = total(sbhmimap[i].data[h62[0,*],h62[1,*]]) 
boxarr63[i] = total(sbhmimap[i].data[h63[0,*],h63[1,*]]) 
boxarr64[i] = total(sbhmimap[i].data[h64[0,*],h64[1,*]])
endfor

;interpolate
b = (boxarr61+boxarr62+boxarr63+boxarr64)/4
c = findgen(multiple*rate)
a = interpolate(b, c[*])

multist = string(multiple)
ratest = string(rate)
 
filestr = strcompress(multist+'-'+ratest,/remove_all)
;WRITE_WAV, Filename, Data, Rate
WRITE_WAV, '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/audio/hmi-wlf-29-03-14-smpl-'+filestr+'.wav', a, rate
end

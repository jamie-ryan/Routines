pro cross_check

dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'

f = strarr(1,4)
f[0] = '61'
f[1] = '62'
f[2] = '63'
f[3] = '64'

for i = 0, n_elements(f)-1, 1 do begin

;;;find file per loop
ff = strcompress(dir+''+f[i]+'/hmi-high-intenstiy-pixels-frame-'+f[i]+'.dat',/remove_all)
;;;open file per loop
openr,lun,ff,/get_lun
;;;count lines in file
nlines = file_lines(ff)
;;;make array to fill with values from the file
com = 'h'+f[i]+'=intarr(2,nlines)'
exe = execute(com)
;;;read file contents into array
com1 = 'readf,lun,h'+f[i]
exe1 = execute(com1)
;;close file and free up file unit number
free_lun, lun


;;;;;;;;;;;;;;;;;;;;;;
;;cross check files ????

endfor


























fmg = strcompress(dir+''+f[i]+'/iris-mgii*.dat',/remove_all)
fmgw = strcompress(dir+''+f[i]+'/iris-mgiiw*.dat',/remove_all)
fsi = strcompress(dir+''+f[i]+'/iris-siiv*.dat',/remove_all)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fmg,/get_lun

;;;count lines in file
nlinesmg = file_lines(fmg)

;;;make array to fill with values from the file
hmg=intarr(2,nlinesmg)

;;;read file contents into array
readf,lun,hmg

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fmgw,/get_lun

;;;count lines in file
nlinesmgw = file_lines(fmgw)

;;;make array to fill with values from the file
hmgw=intarr(2,nlinesmgw)

;;;read file contents into array
readf,lun,hmgw

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fsi,/get_lun

;;;count lines in file
nlinessi = file_lines(fsi)

;;;make array to fill with values from the file
hsi=intarr(2,nlinessi)

;;;read file contents into array
readf,lun,hsi

;;close file and free up file unit number
free_lun, lun

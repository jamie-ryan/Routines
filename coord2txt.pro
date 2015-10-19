balmerc = coords_array(balmercoords)
nc =10         
balmerc1 = fltarr(2,nc)
balmerc2 = fltarr(2,nc)
balmerc1[0,*] = balmerc[0,0:9]
balmerc1[1,*] = balmerc[1,0:9]
balmerc2[0,*] = balmerc[0,10:19]
balmerc2[1,*] = balmerc[1,10:19]

file = 'balmercoords1.txt'
openw, lun, file, /get_lun
printf, lun, balmerc1
free_lun, lun


file = 'balmercoords2.txt'
openw, lun, file, /get_lun
printf, lun, balmerc2
free_lun, lun

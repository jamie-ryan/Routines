bksia = fltarr(2,6)
bksip = fltarr(2,6)
bkmgp = fltarr(2,6)
bksia[0,0] = 472.74468 ;x
bksia[1,0] = 215.48495 ;y
bksia[0,1] = 517.20386    
bksia[1,1] = 213.44085
bksia[0,2] = 574.43865     
bksia[1,2] = 217.01802
bksia[0,3] = 580.57095    
bksia[1,3] = 327.91044
bksia[0,4] = 522.82513      
bksia[1,4] = 327.39942
bksia[0,5] = 471.72263      
bksia[1,5] = 329.95454

for i = 0, n_elements(bksip[0,*]) - 1 do begin
bksip[0, i] = convert_coord_iris(bksia[0,i], sji_1400_hdr[495], /x, /a2p)
bksip[1, i] = convert_coord_iris(bksia[1,i], sji_1400_hdr[495], /y, /a2p)
bkmgp[0, i] = convert_coord_iris(bksia[0,i], sji_2796_hdr[661], /x, /a2p)
bkmgp[1, i] = convert_coord_iris(bksia[1,i], sji_2796_hdr[661], /y, /a2p)
endfor

dnbksi = total(map1400[495].data[bksip[0,*], bksip[1,*]])/n_elements(bksip[0,*])
dnbkmg = total(submg[661].data[bkmgp[0,*], bkmgp[1,*]])/n_elements(bkmgp[0,*])

iris_radiometric_calibration, dnbksi, wave = 1400., n_pixels = 1., fbksi, ebksi, /sji
iris_radiometric_calibration, dnbkmg, wave = 2796., n_pixels = 1., fbkmg, ebkmg, /sji

;Balmer

wav1 = sp2826.tag00.wvl[39]
wav2 = sp2826.tag00.wvl[44]
w1 = string(wav1, format = '(I0)')
w2 = string(wav2, format = '(I0)')

bkb = 630. ;from heinzel and kleint
dnbkb = total(sp2826.tag0172.int[39:44, 2, bkb])/((44-39)*2)





iris_radiometric_calibration, dnbkb, wave=[wav1,wav2], n_pixels=1, Fbkbalm, Ebkbalm,/sg






dnbkb = fltarr(20)
bkb = 630. ;from heinzel and kleint balmer paper

for i = 0, n_elements(balmercoords1[0,*]) - 1 do begin
   balmerdata[0, 0, i, *] = find_iris_slit_pos(balmercoords1[0, i],sp2826)
   balmerdata[0, 1, i, *] = find_iris_slit_pos(balmercoords1[1, i],sp2826, /y, /a2p)
   balmerdata[1, 0, i, *] = find_iris_slit_pos(balmercoords2[0, i],sp2826)
   balmerdata[1, 1, i, *] = find_iris_slit_pos(balmercoords2[1, i],sp2826, /y, /a2p)
   tmp = fltarr(20)
   for k = 0, 19 do begin
      com = 'tmp[k] = total(sp2826.'+tagarr[129 + k]+'.int[39:44, balmerdata[0, 0, i, 129 + k], bkb])/(44-39)' ;balmer background
      exe = execute(com)
   endfor
   dnbkb = total(tmp)/(20) ;take average
   tmp = fltarr(n_elements(tagarr))
   for j = 0, n_elements(tagarr)-1 do begin
       com = 'tmp[j] = total(sp2826.'+tagarr[j]+'.int[39:44, balmerdata[0, 0, i, j], balmerdata[0, 1, i, j]])/((44-39))' ;include quake area based on my iris spectra calculation
       exe = execute(com)
   endfor
endfor
end


























    tmp = fltarr(n_elements(tagarr))
    for j = 0, n_elements(tagarr)-1 do begin
        com = 'dnbkb[j] = total(sp2826.'+tagarr[j]+'.int[39:44, balmerdata[0, 0, i, j], bkb])/((44-39)*2)' ;balmer background
        exe = execute(com)
        com = 'tmp[j] = total(sp2826.'+tagarr[j]+'.int[39:44, balmerdata[0, 0, i, j], balmerdata[0, 1, i, j]])/((44-39)*2)' ;include quake area based on my iris spectra calculation
        exe = execute(com)
    endfor
    iris_radiometric_calibration, tmp, wave=[wav1,wav2], n_pixels=1, f, e, /sg
    balmerdata[0, 2, i, *] = f
    balmerdata[0, 3, i, *] = e

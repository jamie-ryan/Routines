pro make_energy_sav, area = area

tic
;;restore data sav files
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
;restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/HMI-diff-15-Oct-15.sav'

;;date string
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2

;;directories
dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'

;;;iris spectra fits
fsp = findfile('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
;ffsp = findfile(datdir+'*balmer-high*')
sample = 1


;;;make n for loops
nmg = n_elements(submg) ;nmg = n_elements(submg[17:*])
nmgw = n_elements(diff2832)
nsi = n_elements(map1400) ;nsi = n_elements(map1400[387:*])
nn = n_elements(fsp)
nnn = n_elements(diff)
nrb = 20 ; number of ribbon sample points
nc = nrb/2

;;;old qk pixels...may need
;qkirxa = 519.
;qkirya = 262.

;qkmgxp = 588 
;qkmgyp = 441 
;rbmgxp = 504 
;rbmgyp = 487 

;qksixp = 588 
;qksiyp = 441 
;rbsixp = 511 
;rbsiyp = 485 
qkslitpos = strarr(nn)
qkspypos = strarr(nn)


;;;calculate pixel location from given arcsec coords
;SDO HMI;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;
;quake position
qkxa = 517.2 ;arcsec
qkya = 261.4 ;arcsec
qkxp = convert_coord_hmi(qkxa, diffindex[63],  /x, /a2p)
qkyp = convert_coord_hmi(qkya, diffindex[63],  /y, /a2p)
qksixp = convert_coord_iris(qkxa, sji_1400_hdr[498], /x, /a2p)
qksiyp = convert_coord_iris(qkya, sji_1400_hdr[498], /y, /a2p)
qkmgxp = convert_coord_iris(qkxa, sji_2796_hdr[664], /x, /a2p)
qkmgyp = convert_coord_iris(qkya, sji_2796_hdr[664], /y, /a2p)
qkmgwxp = convert_coord_iris(qkxa, sji_2832_hdr[167], /x, /a2p)
qkmgwyp = convert_coord_iris(qkya, sji_2832_hdr[167], /y, /a2p)
qkslitp = find_iris_slit_pos(qkxa,sp2826)
qkspyp = find_iris_slit_pos(qkya,sp2826, /y, /a2p)


;;;read in coord files for each data set 
;;;(to change coords ammend file, eg, hmicoords1.txt)
;;;coord1.txt = 5 south ribbon + 5 north ribbon coords for frame1 (eg diff[62])
;;;coord2.txt = 5 south ribbon + 5 north ribbon coords for frame2 (eg diff[63])
;;;put coords into array eg, hmicoords1 = fltarr(2,10) 
;;;coords1[*,0:4] = south ribbon 
;;;coords1[*,5:9] = north ribbon
print, 'flag11111111111111111111111111111111111111111111111111'
dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
for i = 1,2 do begin
    ii = string(i, format = '(I0)')
    for k = 0, n_elements(dataset)-1 do begin
        flnm = dataset[k]+'coords'+ii+'.txt' ;eg, flnm=hmicoords1.txt
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        tmp = fltarr(2, nlin)
        readf, lun, tmp
        com = dataset[k]+'coords'+ii+ '= tmp' ;readf,lun,hmg
        exe = execute(com)
        free_lun, lun
    endfor
endfor
print, 'flag222222222222222222222222222222222222222222222222'




;;;Calculate pixel locations for each ribbon sample (arcsecs)

;;;#1 frame at hmi 17:45:31:
;sji_1400_hdr[495], 
;sji_2796_hdr[661]
;sji_2832_hdr[166]
;diffindex[62]
;;;coords1[*,0:4] = south ribbon at #1frame
;;;coords1[*,5:9] = north ribbon at #1frame

;;;#2 frame at hmi 17:46:16:
;sji_1400_hdr[498], 
;sji_2796_hdr[666]
;sji_2832_hdr[167]
;diffindex[63]
;;;coords2[*,0:4] = south ribbon at #2frame
;;;coords2[*,5:9] = north ribbon at #2frame

;exclude balmer from dataset as coord conversion is different
dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi'] 

;;;cycle through dataset
for k = 0, n_elements(dataset)-1 do begin
    ;;;cycle through coords
    for i = 0, nc-1 do begin
        ii = string(i, format = '(I0)')
        iii = string(i+10, format = '(I0)')
        ;;;converions with parameters tailored for each dataset
        ;;;first convert from arcsec to pixel (xp)
        ;;;then assign xp a new dataset dependant name eg, hmirbxp5
        ;;;;;#1 FRAME
        if (k eq 0) then begin
            map = 'sji_1400_hdr[495]' 
            com = 'xp = convert_coord_iris('+dataset[k]+'coords1[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+ii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_iris('+dataset[k]+'coords1[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+ii+' = yp'
            exe = execute(com)
        endif

        if (k eq 1) then begin
            map = 'sji_2796_hdr[661]'
            com = 'xp = convert_coord_iris('+dataset[k]+'coords1[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+ii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_iris('+dataset[k]+'coords1[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+ii+' = yp'
            exe = execute(com)

        endif
;            if (k eq 2) then map = '172' else $
       if (k eq 2) then begin
            com = dataset[k]+'rbxp'+ii+' = fltarr(nn)
            exe = execute(com)
            com = dataset[k]+'rbyp'+ii+' = fltarr(nn)
            exe = execute(com)
            com = 'slit = find_iris_slit_pos(balmercoords1[0,'+ii+'],sp2826)'
            exe = execute(com)
            com = 'yp = find_iris_slit_pos(balmercoords1[0,'+ii+'],sp2826, /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+ii+'[*]  = slit[*]'
            exe = execute(com)
            com = dataset[k]+'rbyp'+ii+'[*] = yp[*]'
            exe = execute(com)
        endif

        if (k eq 3) then begin
            map = 'sji_2832_hdr[166]'
           com = 'xp = convert_coord_iris('+dataset[k]+'coords1[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+ii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_iris('+dataset[k]+'coords1[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+ii+' = yp'
            exe = execute(com)

        endif

        if (k eq 4) then begin
            map = 'diffindex[62]'
            com = 'xp = convert_coord_hmi('+dataset[k]+'coords1[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+ii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_hmi('+dataset[k]+'coords1[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+ii+' = yp'
            exe = execute(com)            
        endif
        
        ;;;SEE DETAILS ABOVE...
        ;;;;;#2 FRAME
        if (k eq 0) then begin
            map = 'sji_1400_hdr[498]'
            com = 'xp = convert_coord_iris('+dataset[k]+'coords2[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+iii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_iris('+dataset[k]+'coords2[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+iii+' = yp'
            exe = execute(com)
        endif

        if (k eq 1) then begin
            map = 'sji_2796_hdr[666]'
           com = 'xp = convert_coord_iris('+dataset[k]+'coords2[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+iii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_iris('+dataset[k]+'coords2[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+iii+' = yp'
            exe = execute(com)
        endif
;            if (k eq 2) then map = '173' else $

        if (k eq 2) then begin
            com = dataset[k]+'rbxp'+iii+' = fltarr(nn)
            exe = execute(com)
            com = dataset[k]+'rbyp'+iii+' = fltarr(nn)
            exe = execute(com)
            com = 'slit = find_iris_slit_pos(balmercoords2[0,'+ii+'],sp2826)'
            exe = execute(com)
            com = 'yp = find_iris_slit_pos(balmercoords2[0,'+ii+'],sp2826, /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+iii+'[*] = slit[*]'
            exe = execute(com)
            com = dataset[k]+'rbyp'+iii+'[*] = yp[*]'
            exe = execute(com)
        endif

        if (k eq 3) then begin
            map = 'sji_2832_hdr[167]'
            com = 'xp = convert_coord_iris('+dataset[k]+'coords2[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+iii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_iris('+dataset[k]+'coords2[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+iii+' = yp'
            exe = execute(com)
        endif
        if (k eq 4) then begin
            map = 'diffindex[63]'
            com = 'xp = convert_coord_hmi('+dataset[k]+'coords2[0,'+ii+'], '+map+',  /x, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbxp'+iii+' = xp'
            exe = execute(com)
            com = 'yp = convert_coord_hmi('+dataset[k]+'coords2[1,'+ii+'], '+map+',  /y, /a2p)'
            exe = execute(com)
            com = dataset[k]+'rbyp'+iii+' = yp'
            exe = execute(com)
        endif
    endfor
endfor


;;;set up single pixel arrays to contain lightcurve data 
qkmg = fltarr(nmg)
qkmgw = fltarr(nmgw)
qksi = fltarr(nsi)
qkbalmer = fltarr(sample*nn)
qkhmi = fltarr(nnn)


;;arrays for qk and multi-ribbon coord max flux and energy
sifmxqk = fltarr(3)
siemxqk = fltarr(3)
sifmx = fltarr(3,nrb) ;fmx[0,*] = time, fmx[1,*] = max
siemx = fltarr(3,nrb)

mgfmxqk = fltarr(3)
mgemxqk = fltarr(3)
mgfmx = fltarr(3,nrb) ;fmx[0,*] = time, fmx[1,*] = max
mgemx = fltarr(3,nrb)

balmerfmxqk = fltarr(3)
balmeremxqk = fltarr(3)
balmerfmx = fltarr(3,nrb) ;fmx[0,*] = time, fmx[1,*] = max
balmeremx = fltarr(3,nrb)

mgwfmxqk = fltarr(3)
mgwemxqk = fltarr(3)
mgwfmx = fltarr(3,nrb) ;fmx[0,*] = time, fmx[1,*] = max
mgwemx = fltarr(3,nrb)

hmifmxqk = fltarr(3)
hmiemxqk = fltarr(3)
hmifmx = fltarr(3,nrb) ;fmx[0,*] = time, fmx[1,*] = max
hmiemx = fltarr(3,nrb)

;;;make time arrays
tsi = map1400.time
tmg = submg.time
tspqk = strarr(sample*nn)
tmgw = map2832.time
thmi = diff.time
print, 'flag6666666666666666666666666666666666666666666666666666666666'

;;;loop to cycle through pixel coords
for j = 0, nrb-1 do begin
;for j = 0, nc-1 do begin
    jj = string(j, format = '(I0)')

    com = 'rbsi'+jj+' = fltarr(nsi)'
    exe = execute(com)
    com = 'rbmg'+jj+' = fltarr(nmg)'
    exe = execute(com)
    com = 'rbbalmer'+jj+' = fltarr(sample*nn)'
    exe = execute(com)
    com = 'rbmgw'+jj+' = fltarr(nmgw)'
    exe = execute(com)
    com = 'tsprb'+jj+' = strarr(sample*nn)'
    exe = execute(com)
    com = 'rbhmi'+jj+' = fltarr(nnn)'
    exe = execute(com)

    ;;;Fill single pixel arrays with intensity data
    ;;;then convert to Flux and Energy 
    ;;;;;;;;;;;;;;;;;;;;;;;;;;SI IV 1400
    for i = 0, nsi-1, 1 do begin
        if (j eq 19) then begin
            qksi[i] = map1400[i].data[qksixp, qksiyp]
        endif
        com = 'in = map1400[i].data[sirbxp'+jj+', sirbyp'+jj+']'
        exe = execute(com)
        com = 'rbsi'+jj+'[i] = in' 
        exe = execute(com)
    endfor
    ;calculate flux and energy
    if (j eq 19) then begin
        iris_radiometric_calibration, qksi, wave = 1400., n_pixels = 1, Fsiqk, Esiqk, /sji                     
    endif    
    com = 'iris_radiometric_calibration, rbsi'+jj+', wave = 1400., n_pixels = 1,Fsirb'+jj+', Esirb'+jj+', /sji'
    exe = execute(com)


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;MG II 2796
    for i = 0, nmg-1, 1 do begin
        if (j eq 19) then begin
            qkmg[i] = submg[i].data[qkmgxp, qkmgyp] ;qkmg[i] = submg[17 + i].data[qkmgxp, qkmgyp]
        endif
    com = 'in = submg[i].data[mgrbxp'+jj+', mgrbyp'+jj+']' 
    exe = execute(com)
    com = 'rbmg'+jj+'[i] = in'
    exe = execute(com)
    endfor
    ;calculate flux and energy
    if (j eq 19) then begin
        iris_radiometric_calibration, qkmg, wave = 2976., n_pixels = 1,Fmgqk, Emgqk, /sji                    
    endif
    com = 'iris_radiometric_calibration, rbmg'+jj+', wave = 2976., n_pixels = 1,Fmgrb'+jj+', Emgrb'+jj+', /sji'
    exe = execute(com)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BALMER

    for i = 0, nn-1, 1 do begin  
        com = 'in = total(sp2826.'+tagarr[i]+'.int[39:44, balmerrbxp'+jj+'[i],balmerrbyp'+jj+'[i]])/((44-39))'
        exe = execute(com)

        com = 'rbbalmer'+jj+'[i] = in'
        exe = execute(com)

        com = 'tsprb'+jj+'[i] = sp2826.'+tagarr[i]+'.time_ccsds[balmerrbxp'+jj+'[i]]'
        exe = execute(com)
        
        if (j eq 19) then begin
            qkslitpos = string(qkslitp[i], format = '(I0)')
            qkspypos = string(qkspyp[i], format = '(I0)')
            com = 'qkbalmer[i] = total(sp2826.'+tagarr[i]+'.int[39:44,'+qkslitpos+','+qkspypos+'])/((44-39))'
            exe = execute(com)
            com = 'tspqk[i] = sp2826.'+tagarr[i]+'.time_ccsds['+qkslitpos+']'
            exe = execute(com)
        endif
    endfor
    ;;calculate flux and energy
    wav1 = sp2826.tag00.wvl[39]
    wav2 = sp2826.tag00.wvl[44]
    w1 = string(wav1, format = '(I0)')
    w2 = string(wav2, format = '(I0)')
    if (j eq 19) then begin
        iris_radiometric_calibration, qkbalmer, wave = [wav1, wav2], n_pixels = 10, Fbalmerqk, Ebalmerqk, /sg
    endif
    com = 'iris_radiometric_calibration,rbbalmer'+jj+',wave=['+w1+','+w2+'],n_pixels=10,Fbalmerrb'+jj+',Ebalmerrb'+jj+',/sg'
    exe = execute(com)


    ;;MGW 2832
    for i = 0, nmgw-1, 1 do begin
        if (j eq 19) then begin
            qkmgw[i] = map2832[i].data[qkmgwxp,qkmgwyp ]  ;559, 441
        endif
        com = 'in = map2832[i].data[mgwrbxp'+jj+', mgwrbyp'+jj+']'
        exe = execute(com)
        com = 'rbmgw'+jj+'[i] = in
        exe = execute(com)
    endfor   

    ;calculate flux and energy
    if (j eq 19) then begin
        iris_radiometric_calibration, qkmgw, wave = 2832., n_pixels = 1,Fmgwqk, Emgwqk, /sji                   
    endif
    com = 'iris_radiometric_calibration, rbmgw'+jj+', wave = 2832., n_pixels = 1,Fmgwrb'+jj+', Emgwrb'+jj+', /sji'
    exe = execute(com)



    ;HMI single pixel
    for i = 0, nnn-1, 1 do begin
        if (j eq 19) then begin
            qkhmi[i] = diff[i].data[qkxp, qkyp]
        endif
    com = 'in = diff[i].data[hmirbxp'+jj+', hmirbyp'+jj+']'
    exe = execute(com)
    com = 'rbhmi'+jj+'[i] = in'
    exe = execute(com)
    endfor

    ;calculate flux and energy
    if (j eq 19) then begin
        hmi_radiometric_calibration, qkhmi, n_pixels = 1, Fhmiqk, Ehmiqk
    endif  
    com = 'hmi_radiometric_calibration, rbhmi'+jj+', n_pixels = 1, Fhmirb'+jj+', Ehmirb'+jj+''
    exe = execute(com)
endfor

dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
tmp = fltarr(2,20)
for k = 0, n_elements(dataset)-1 do begin
    nc = nrb/4
    ncst = string(nc, format = '(I0)')
    for j = 0, nrb-1 do begin
        if (j lt 10) then begin
            if (k eq 0) then map = '495' else $
            if (k eq 1) then map = '661' else $
            if (k eq 2) then map = '172' else $
            if (k eq 3) then map = '166' else $
            if (k eq 4) then map = '62'
;            com = 'tmp = ['+dataset[k]+'coords1, '+dataset[k]+'coords2] 
;            exe = execute(com)
;            cd = tmp[0,j]
            
        endif 
        if (j gt 9) then begin
            if (k eq 0) then map = '498' else $
            if (k eq 1) then map = '666' else $
            if (k eq 2) then map = '173' else $
            if (k eq 3) then map = '167' else $
            if (k eq 4) then map = '63'

        endif
        com = 'tmp[0,0:9] = '+dataset[k]+'coords1[0,*]'
        exe = execute(com)
        com = 'tmp[0,10:*] ='+dataset[k]+'coords2[0,*]'
        exe = execute(com)
        com = 'tmp[1,0:9] = '+dataset[k]+'coords1[1,*]'
        exe = execute(com)
        com = 'tmp[1,10:*] ='+dataset[k]+'coords2[1,*]' 
        exe = execute(com)

        cd = tmp[0,j]

        com = 'mxf = F'+dataset[k]+'rb'+jj+'['+map+']'
        exe = execute(com)
        com = 'mxe = E'+dataset[k]+'rb'+jj+'['+map+']'
        exe = execute(com)
      
        mp = fix(map)
        com = dataset[k]+'fmx[0,'+jj+'] = mp'
        exe = execute(com)
        com = dataset[k]+'fmx[1,'+jj+'] = cd'
        exe = execute(com)
        com = dataset[k]+'fmx[2,'+jj+'] = mxf'
        exe = execute(com)

        com = dataset[k]+'emx[0,'+jj+'] = mp'
        exe = execute(com)
        com = dataset[k]+'emx[1,'+jj+'] = cd'
        exe = execute(com)
        com = dataset[k]+'emx[2,'+jj+'] = mxe'
        exe = execute(com)

 
        if (j eq 8) then begin
        ;find maximum flux and energy
        com = 'qkmxf = F'+dataset[k]+'qk['+map+']'
        exe = execute(com)
        com = 'qkmxe = E'+dataset[k]+'qk['+map+']'
        exe = execute(com)
        mp = fix(map)
        com = dataset[k]+'fmxqk[0] = mp'
        exe = execute(com)
        com = dataset[k]+'fmxqk[1] = qkxa'
        exe = execute(com)
        com = dataset[k]+'fmxqk[2] = qkmxf'

        com = dataset[k]+'emxqk[0] = mp'
        exe = execute(com)
        com = dataset[k]+'emxqk[1] = qkxa'
        exe = execute(com)
        com = dataset[k]+'emxqk[2] = qkmxe'

        endif

        if (j eq 18) then begin
        ;find maximum flux and energy
        com = 'qkmxf = F'+dataset[k]+'qk['+map+']'
        exe = execute(com)
        com = 'qkmxe = E'+dataset[k]+'qk['+map+']'
        exe = execute(com)
        mp = fix(map)
        com = dataset[k]+'fmxqk[0] = mp'
        exe = execute(com)
        com = dataset[k]+'fmxqk[1] = qkxa'
        exe = execute(com)
        com = dataset[k]+'fmxqk[2] = qkmxf'

        com = dataset[k]+'emxqk[0] = mp'
        exe = execute(com)
        com = dataset[k]+'emxqk[1] = qkxa'
        exe = execute(com)
        com = dataset[k]+'emxqk[2] = qkmxe'
        endif
    endfor
endfor




;;;make sav files
save, $
;siiv; for time use tsi
Fsiqk, Esiqk, $
Fsirb0, Esirb0, $
Fsirb1, Esirb1, $
Fsirb2, Esirb2, $
Fsirb3, Esirb3, $
Fsirb4, Esirb4, $
Fsirb5, Esirb5, $
Fsirb6, Esirb6, $
Fsirb7, Esirb7, $
Fsirb8, Esirb8, $
Fsirb9, Esirb9, $
Fsirb10, Esirb10, $
Fsirb11, Esirb11, $
Fsirb12, Esirb12, $
Fsirb13, Esirb13, $
Fsirb14, Esirb14, $
Fsirb15, Esirb15, $
Fsirb16, Esirb16, $
Fsirb17, Esirb17, $
Fsirb18, Esirb18, $
Fsirb19, Esirb19, $
tsi, $
sicoords1, $
sicoords2, $
sifmxqk, $
sifmx, $
siemxqk, $
siemx, $
filename = '29-Mar-2014-energies-iris-siiv-single-pixel-'+date+'.sav'

save, $
;mgii; for time use tmg
Fmgqk, Emgqk, $
Fmgrb0, Emgrb0, $
Fmgrb1, Emgrb1, $
Fmgrb2, Emgrb2, $
Fmgrb3, Emgrb3, $
Fmgrb4, Emgrb4, $
Fmgrb5, Emgrb5, $
Fmgrb6, Emgrb6, $
Fmgrb7, Emgrb7, $
Fmgrb8, Emgrb8, $
Fmgrb9, Emgrb9, $
Fmgrb10, Emgrb10, $
Fmgrb11, Emgrb11, $
Fmgrb12, Emgrb12, $
Fmgrb13, Emgrb13, $
Fmgrb14, Emgrb14, $
Fmgrb15, Emgrb15, $
Fmgrb16, Emgrb16, $
Fmgrb17, Emgrb17, $
Fmgrb18, Emgrb18, $
Fmgrb19, Emgrb19, $
tmg, $
mgcoords1, $
mgcoords2, $
mgfmxqk, $
mgfmx, $
mgemxqk, $
mgemx, $
filename = '29-Mar-2014-energies-iris-mgii-single-pixel-'+date+'.sav'

save, $
;balmer; for time use timearr
Fbalmerqk, Ebalmerqk, $
Fbalmerrb0, Ebalmerrb0, $
Fbalmerrb1, Ebalmerrb1, $
Fbalmerrb2, Ebalmerrb2, $
Fbalmerrb3, Ebalmerrb3, $
Fbalmerrb4, Ebalmerrb4, $
Fbalmerrb5, Ebalmerrb5, $
Fbalmerrb6, Ebalmerrb6, $
Fbalmerrb7, Ebalmerrb7, $
Fbalmerrb8, Ebalmerrb8, $
Fbalmerrb9, Ebalmerrb9, $
Fbalmerrb10, Ebalmerrb10, $
Fbalmerrb11, Ebalmerrb11, $
Fbalmerrb12, Ebalmerrb12, $
Fbalmerrb13, Ebalmerrb13, $
Fbalmerrb14, Ebalmerrb14, $
Fbalmerrb15, Ebalmerrb15, $
Fbalmerrb16, Ebalmerrb16, $
Fbalmerrb17, Ebalmerrb17, $
Fbalmerrb18, Ebalmerrb18, $
Fbalmerrb19, Ebalmerrb19, $
tspqk, $
tsprb0, $
tsprb1, $
tsprb2, $
tsprb3, $
tsprb4, $
tsprb5, $
tsprb6, $
tsprb7, $
tsprb8, $
tsprb9, $
tsprb10, $
tsprb11, $
tsprb12, $
tsprb13, $
tsprb14, $
tsprb15, $
tsprb16, $
tsprb17, $
tsprb18, $
tsprb19, $
balmercoords1, $
balmercoords2, $
balmerfmxqk, $
balmerfmx, $
balmeremxqk, $
balmeremx, $
filename = '29-Mar-2014-energies-iris-balmer-single-pixel-'+date+'.sav'

save, $
;mgw; for time use tmgw
Fmgwqk, Emgwqk, $
Fmgwrb0, Emgwrb0, $
Fmgwrb1, Emgwrb1, $
Fmgwrb2, Emgwrb2, $
Fmgwrb3, Emgwrb3, $
Fmgwrb4, Emgwrb4, $
Fmgwrb5, Emgwrb5, $
Fmgwrb6, Emgwrb6, $
Fmgwrb7, Emgwrb7, $
Fmgwrb8, Emgwrb8, $
Fmgwrb9, Emgwrb9, $
Fmgwrb10, Emgwrb10, $
Fmgwrb11, Emgwrb11, $
Fmgwrb12, Emgwrb12, $
Fmgwrb13, Emgwrb13, $
Fmgwrb14, Emgwrb14, $
Fmgwrb15, Emgwrb15, $
Fmgwrb16, Emgwrb16, $
Fmgwrb17, Emgwrb17, $
Fmgwrb18, Emgwrb18, $
Fmgwrb19, Emgwrb19, $
tmgw, $
mgwcoords1, $
mgwcoords1, $
mgwfmxqk, $
mgwfmx, $
mgwemxqk, $
mgwemx, $
filename = '29-Mar-2014-energies-iris-mgw-single-pixel-'+date+'.sav'

save, $
;hmi; for time use thmi
Fhmiqk, Ehmiqk, $
Fhmirb0, Ehmirb0, $
Fhmirb1, Ehmirb1, $
Fhmirb2, Ehmirb2, $
Fhmirb3, Ehmirb3, $
Fhmirb4, Ehmirb4, $
Fhmirb5, Ehmirb5, $
Fhmirb6, Ehmirb6, $
Fhmirb7, Ehmirb7, $
Fhmirb8, Ehmirb8, $
Fhmirb9, Ehmirb9, $
Fhmirb10, Ehmirb10, $
Fhmirb11, Ehmirb11, $
Fhmirb12, Ehmirb12, $
Fhmirb13, Ehmirb13, $
Fhmirb14, Ehmirb14, $
Fhmirb15, Ehmirb15, $
Fhmirb16, Ehmirb16, $
Fhmirb17, Ehmirb17, $
Fhmirb18, Ehmirb18, $
Fhmirb19, Ehmirb19, $
thmi, $
hmicoords1, $
hmicoords2, $
hmifmxqk, $
hmifmx, $
hmiemxqk, $
hmiemx, $
filename = '29-Mar-2014-energies-hmi-single-pixel-'+date+'.sav'

if keyword_set(area) then begin
    ;;;;high intensity pixel coordinate files
    fmg = findfile(datdir+'*mgii-high*')
    fmgw = findfile(datdir+'*mgiiw-high*')
    fsi = findfile(datdir+'*siiv-high*')
    ff = findfile(datdir+'hmi-high*')

    for j = 0, n_elements(fmg) - 1 do begin
    ;;;;;;;open files 

    openr,lun,fmg[j],/get_lun

    ;;;count lines in file
    nlinesmg = file_lines(fmg[j])

    ;;;make array to fill with values from the file
    hmg=intarr(2,nlinesmg)

    ;;;read file contents into array
    readf,lun,hmg

    ;;close file and free up file unit number
    free_lun, lun
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    openr,lun,fmgw[j],/get_lun

    ;;;count lines in file
    nlinesmgw = file_lines(fmgw[j])

    ;;;make array to fill with values from the file
    hmgw=intarr(2,nlinesmgw)

    ;;;read file contents into array
    readf,lun,hmgw

    ;;close file and free up file unit number
    free_lun, lun
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    openr,lun,fsi[j],/get_lun

    ;;;count lines in file
    nlinessi = file_lines(fsi[j])

    ;;;make array to fill with values from the file
    hsi=intarr(2,nlinessi)

    ;;;read file contents into array
    readf,lun,hsi

    ;;close file and free up file unit number
    free_lun, lun
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    openr,lun,ff[j],/get_lun

    ;;;count lines in file
    nlines = file_lines(ff[j])

    ;;;make array to fill with values from the file
    h=intarr(2,nlines)

    ;;;read file contents into array
    readf,lun,h

    ;;close file and free up file unit number
    free_lun, lun
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    ;;;rhessi;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;;;mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    com = 'boxarrmg'+string(j,format = '(I0)')+' = fltarr(nmg)'
    exe = execute(com)
    ;loop to fill arrays with summed pixel intensity values
    for i = 0, nmg-1, 1 do begin
    ;com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) '
    com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[i].data[hmg[0,*],hmg[1,*]]) '
    exe = execute(com)
    endfor
    ;;;flux and energy of flare area
    com = 'iris_radiometric_calibration,boxarrmg'+string(j,format = '(I0)')+ $
    ', wave = 2796, n_pixels = nlinesmg ,F_area_mgii'+string(j,format = '(I0)')+ $
    ', E_area_mgii'+string(j,format = '(I0)')+' ,/sji'
    exe = execute(com)

    ;;;balmer;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;	for i = 0, nn-1, 1 do begin
    ;		comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
    ;		exet1 = execute(comt)
    ;		comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
    ;		exet = execute(comi)
    ;	endfor


    ;;;mgiiw;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    com = 'boxarrmgw'+string(j,format = '(I0)')+' = fltarr(nmgw)'
    exe = execute(com)
    ;loop to fill arrays with summed pixel intensity values
    for i = 0, nmgw-1, 1 do begin
    com = 'boxarrmgw'+string(j,format = '(I0)')+'[i] = total(diff2832[i].data[hmgw[0,*],hmgw[1,*]])
    exe = execute(com)
    endfor
    ;;;flux and energy of flare area
    com = 'iris_radiometric_calibration,boxarrmgw'+string(j,format = '(I0)')+ $
    ', wave = 2832, n_pixels = nlinesmgw ,F_area_mgiiw'+string(j,format = '(I0)')+ $
    ', E_area_mgiiw'+string(j,format = '(I0)')+' ,/sji'
    exe = execute(com)


    ;;siiv;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;501?

    com = 'boxarrsi'+string(j,format = '(I0)')+' = fltarr(nsi)'
    exe = execute(com)
    ;loop to fill arrays with summed pixel intensity values
    for i = 0, nsi-1, 1 do begin
    ;com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[387 + i].data[hsi[0,*],hsi[1,*]]) '
    com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[i].data[hsi[0,*],hsi[1,*]]) '
    exe = execute(com)
    endfor
    ;;;flux and energy of flare area
    com = 'iris_radiometric_calibration, boxarrsi'+string(j,format = '(I0)')+ $
    ', wave = 1400, n_pixels = nlinessi , F_area_siiv'+string(j,format = '(I0)')+ $
    ', E_area_siiv'+string(j,format = '(I0)')+' ,/sji'

    exe = execute(com)

    ;;hmi continuum;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    com = 'boxarr'+string(j,format = '(I0)')+' = fltarr(nnn)'
    exe = execute(com)
    ;bgarr = fltarr(nnn)
    for i = 0, nnn-1, 1 do begin
    com = 'boxarr'+string(j,format = '(I0)')+'[i] = total(diff[i].data[h[0,*],h[1,*]])'
    exe = execute(com) 
    endfor
    ;;;;;intensity of flare area in erg/s.cm^2.sr
    com = 'hmi_radiometric_calibration, boxarr'+string(j,format = '(I0)')+ $
    ', n_pixels = nlines, F_area_hmi'+string(j,format = '(I0)')+ $
    ', E_area_hmi'+string(j,format = '(I0)')+''
    exe = execute(com)
    endfor


    ;HMI quake area array...eventually calculate iris quake energy based on solid angle relationship found by trumpet.pro
    qkarea = fltarr(nnn)
    ;based on the four iris pixels (4*0.1667") flagged by quake_area.pro.....more detailed version needed
    ;assuming 2 iris pixels relate to the radius of a circular quake impact, 
    ;but 0.505/0.1667 = 3 therefore 3 iris pixels equal one hmi pixel, which sets minimum resolution
    ;iris_quake_radius = 2*(0.1667*7.5e5)  
    ;iris_quake_area = !pi*quake_radius^2 
    for i= 0, nnn-1 do begin
    qkarea[i] = diff[i].data[qkxp, qkyp] + $
    diff[i].data[qkxp, qkyp + 1] + $
    diff[i].data[qkxp - 1, qkyp + 1] + $
    diff[i].data[qkxp - 1, qkyp] + $
    diff[i].data[qkxp - 1, qkyp - 1] + $
    diff[i].data[qkxp, qkyp - 1] + $
    diff[i].data[qkxp + 1, qkyp - 1] + $
    diff[i].data[qkxp + 1, qkyp] + $
    diff[i].data[qkxp + 1, qkyp + 1]
    endfor
    hmi_radiometric_calibration, qkarea, n_pixels = 9, Fqk_9px_area, Eqk_9px_area



;;;make .sav file

    save, $
    ;iris flare area siiv
    F_area_siiv0, E_area_siiv0, $
    F_area_siiv1, E_area_siiv1, $
    F_area_siiv2, E_area_siiv2, $
    F_area_siiv3, E_area_siiv3, $
    tsi, $
    filename = '29-Mar-2014-energies-iris-siiv-area-'+date+'.sav'

    save, $
    ;iris flare area mgii
    F_area_mgii0, E_area_mgii0, $
    F_area_mgii1, E_area_mgii1, $
    F_area_mgii2, E_area_mgii2, $
    F_area_mgii3, E_area_mgii3, $
    tmg, $
    filename = '29-Mar-2014-energies-iris-mgii-area-'+date+'.sav'

    save, $
    ;iris flare area mgw
    F_area_mgiiw0, E_area_mgiiw0, $
    F_area_mgiiw1, E_area_mgiiw1, $
    F_area_mgiiw2, E_area_mgiiw2, $
    F_area_mgiiw3, E_area_mgiiw3, $
    tmgw, $
    filename = '29-Mar-2014-energies-iris-mgw-area-'+date+'.sav'

    save, $
    ;hmi flare area
    F_area_hmi0, E_area_hmi0, $
    F_area_hmi1, E_area_hmi1, $
    F_area_hmi2, E_area_hmi2, $
    F_area_hmi3, E_area_hmi3, $
    thmi, $
    filename = '29-Mar-2014-energies-hmi-area-'+date+'.sav'

    save, $
    ;quake area
    Fqk_9px_area, Eqk_9px_area, $
    thmi, $
    filename = '29-Mar-2014-energies-hmi-qkarea-'+date+'.sav'
endif
toc
end

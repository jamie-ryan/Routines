pro irispectra, tag
;irispectra, 173

restore, '/disk/solar3/jsr2/Data/SDO/sp2796-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2814-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2832-Apr28-2015.sav'

tag = string(tag,format = '(I0)')
tag = strcompress('tag0'+tag, /remove_all)
;tag0173.time_ccsds[3] = 17:46:04

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'

lambda1 = 2832
lambda2 = 2826
lambda3 = 2814
lambda4 = 2796
lambda1 = string(lambda1, format ='(I0)' )
lambda2 = string(lambda2, format ='(I0)' )
lambda3 = string(lambda3, format ='(I0)' )
lambda4 = string(lambda4, format ='(I0)' )

;nnn1 = n_elements(sp2796.tag00.wvl)
;nnn2 = n_elements(sp2814.tag00.wvl)
;nnn3 = n_elements(sp2826.tag00.wvl)
;nnn4 = n_elements(sp2832.tag00.wvl)
com = 'nnn1 = n_elements(sp2796.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn2 = n_elements(sp2814.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn3 = n_elements(sp2826.'+tag+'.wvl)'
exe = execute(com)
com = 'nnn4 = n_elements(sp2832.'+tag+'.wvl)'
exe = execute(com)

nnn = nnn1 + nnn2 + nnn3 + nnn4

spectra = dblarr(2,nnn)

;spectra[0,0:nnn1-1] = sp2796.tag00.wvl[*]
;spectra[0,nnn1:nnn1 + nnn2-1] = sp2814.tag00.wvl[*]
;spectra[0,nnn1 + nnn2:nnn1 + nnn2 + nnn3-1] = sp2826.tag00.wvl[*]
;spectra[0,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.tag00.wvl[*]
com = 'spectra[0,0:nnn1-1] = sp2796.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1 + nnn2:nnn1 + nnn2 + nnn3-1] = sp2826.'+tag+'.wvl[*]'
exe = execute(com)
com = 'spectra[0,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.wvl[*]'
exe = execute(com)


;;;;quake

;spectra[1,0:nnn1-1] = sp2796.tag00.int[*,3,435]
;spectra[1,nnn1:nnn1 + nnn2-1] = sp2814.tag00.int[*,3,435]
;spectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.tag00.int[*,3,435]
;spectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.tag00.int[*,3,435]
com = 'spectra[1,0:nnn1-1] = sp2796.'+tag+'.int[*,3,435]'
exe = execute(com)
com = 'spectra[1,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.int[*,3,435]'
exe = execute(com)
com = 'spectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.'+tag+'.int[*,3,435]'
exe = execute(com)
com = 'spectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.int[*,3,435]'
exe = execute(com)





;mx = max(spectra[0:*])
;mn = min(spectra[0:0])
spectra[WHERE(spectra lT 0, /NULL)] = 0



lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-spectra-2790-2830-quake.eps',/remove_all)
lcfile = lcq
;angstrom = '!6!sA!r!u!9 %!6!n'
titl = 'IRIS-SPECTRA-QUAKE-'+sp2832.tag0173.time_ccsds[3]
ytitl = '[DN Pixel!E-1!N]'
xtitl = 'Wavelength'+angstrom
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;mx - 10 cuts wavelength off at 2830
plot, spectra[0,*],spectra[1,*], ytitle = ytitl, xtitle = xtitl, title = titl, xr = [2796,2830]
device, /close
set_plot, mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;RIBBON

rbspectra = dblarr(2,nnn)
rbspectra[0,*] = spectra[0,*]
;spectra[1,0:nnn1-1] = sp2796.tag00.int[*,3,489]
;spectra[1,nnn1:nnn1 + nnn2-1] = sp2814.tag00.int[*,3,489]
;spectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.tag00.int[*,3,489]
;spectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.tag00.int[*,3,489]

com = 'rbspectra[1,0:nnn1-1] = sp2796.'+tag+'.int[*,0,485.5]'
exe = execute(com)
com = 'rbspectra[1,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.int[*,0,485.5]'
exe = execute(com)
com = 'rbspectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.'+tag+'.int[*,0,485.5]'
exe = execute(com)
com = 'rbspectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.int[*,0,485.5]'
exe = execute(com)


;mx = max(spectra[0:*])
;mn = min(spectra[0:0])
rbspectra[WHERE(rbspectra lT 0, /NULL)] = 0



lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-spectra-2790-2830-ribbon.eps',/remove_all)
lcfile = lcq
;angstrom = '!6!sA!r!u!9 %!6!n'
titl  = 'IRIS-SPECTRA-RIBBON-'+sp2832.tag0173.time_ccsds[3]
ytitl = '[DN Pixel!E-1!N]'
xtitl = 'Wavelength'+angstrom
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;mx - 10 cuts wavelength off at 2830
plot, rbspectra[0,*],rbspectra[1,*],  ytitle = ytitl, xtitle = xtitl, title = titl, xr = [2796,2830]
device, /close
set_plot, mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;Non-flare region


;spectra[1,0:nnn1-1] = sp2796.tag00.int[*,3,489]
;spectra[1,nnn1:nnn1 + nnn2-1] = sp2814.tag00.int[*,3,489]
;spectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.tag00.int[*,3,489]
;spectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.tag00.int[*,3,489]

nfspectra = dblarr(2,nnn)
nfspectra[0,*] = spectra[0,*]

com = 'nfspectra[1,0:nnn1-1] = sp2796.'+tag+'.int[*,3,20]'
exe = execute(com)
com = 'nfspectra[1,nnn1:nnn1 + nnn2-1] = sp2814.'+tag+'.int[*,3,20]'
exe = execute(com)
com = 'nfspectra[1,nnn1 + nnn2:nnn1+ nnn2 + nnn3-1] = sp2826.'+tag+'.int[*,3,20]'
exe = execute(com)
com = 'nfspectra[1,nnn1 +nnn2 + nnn3:nnn1 + nnn2 + nnn3 + nnn4-1] = sp2832.'+tag+'.int[*,3,20]'
exe = execute(com)


;mx = max(nfspectra[0:*])
;mn = min(nfspectra[0:0])
nfspectra[WHERE(nfspectra lT 0, /NULL)] = 0



lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-spectra-2790-2830-no-flare.eps',/remove_all)
lcfile = lcq
;angstrom = '!6!sA!r!u!9 %!6!n'
titl =  'IRIS-SPECTRA-NON-FLARE-'+sp2832.tag0173.time_ccsds[3]
ytitl = '[DN Pixel!E-1!N]'
xtitl = 'Wavelength'+angstrom
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;mx - 10 cuts wavelength off at 2830
plot, nfspectra[0,*],nfspectra[1,*], ytitle = ytitl, xtitle = xtitl, title = titl, xr = [2796,2830] 
device, /close
set_plot, mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;overplots


lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-spectra-2790-2830.eps',/remove_all)
lcfile = lcq
;angstrom = '!6!sA!r!u!9 %!6!n'
titl =  'IRIS-SPECTRA-'+sp2832.tag0173.time_ccsds[3]
ytitl = '[DN Pixel!E-1!N]'
xtitl = 'Wavelength'+angstrom
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;mx - 10 cuts wavelength off at 2830
plot, spectra[0,*],spectra[1,*], ytitle = ytitl, xtitle = xtitl, title = titl, xr = [2796,2830];, linestyle = 0 
loadct, 3
oplot, rbspectra[0,*],rbspectra[1,*],  color = 150;, linestyle = 1
loadct, 1
oplot, nfspectra[0,*],nfspectra[1,*],  color = 150; , linestyle = 3
device, /close
set_plot, mydevice


end

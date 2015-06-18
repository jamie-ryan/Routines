pro irislc,hmiframe ,mgframe, siframe, quake
;set quake = 1 to plot quake and ribbon plots

;irislc, 61, 159, 495, 1
;irislc, 62, 161, 496
;irislc, 63, 164, 498
;irislc, 64, 166, 500

restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'


hmi = string(hmiframe)
mg = string(mgframe)
si = string(siframe)

fmg = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+hmi+'/iris-mgii-high-intenstiy-pixels-frame-'+mg+'.dat',/remove_all)
fsi = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+hmi+'/iris-siiv-high-intenstiy-pixels-frame-'+si+'.dat',/remove_all)

filenamemg = fmg
filenamesi = fsi
;;;;;;;open files 
openr,lun,filenamemg,/get_lun

;;;count lines in file
nlinesmg = file_lines(filenamemg)

;;;make array to fill with values from the file
hmg=intarr(2,nlinesmg)

;;;read file contents into array
readf,lun,hmg

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,filenamesi,/get_lun

;;;count lines in file
nlinessi = file_lines(filenamesi)

;;;make array to fill with values from the file
hsi=intarr(2,nlinessi)

;;;read file contents into array
readf,lun,hsi

;;close file and free up file unit number
free_lun, lun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;make arrays to contain plotting values
nmg = n_elements(submg[17:*])
boxarrmg = fltarr(nmg)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmg-1, 1 do begin
boxarrmg[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) 
endfor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;501?
nsi = n_elements(map1400[387:*])
boxarrsi = fltarr(nsi)
;loop to fill arrays with summed pixel intensity values
for i = 0, nsi-1, 1 do begin
boxarrsi[i] = total(map1400[387 + i].data[hsi[0,*],hsi[1,*]]) 
endfor

iminmg = fltarr(nmg)
iminsi = fltarr(nsi)
iminmg[*] = total(boxarrmg[0:95])/(96*nlinesmg)
iminsi[*] = total(boxarrsi[0:71])/(72*nlinessi)


iminmgpac = iminmg[*]*nlinesmg
imaxmg = boxarrmg[mgframe-17]
pixareacontrastmg = ((imaxmg-iminmgpac[0])/iminmgpac[0])
pixareacontrastmgstr = string(pixareacontrastmg, format = '(f0.2)')
paconmgstr = strcompress(pixareacontrastmgstr, /remove_all)

iminsipac = iminsi[*]*nlinessi
imaxsi = boxarrsi[siframe-387]
pixareacontrastsi = ((imaxsi-iminsipac[0])/iminsipac[0])
pixareacontrastsistr = string(pixareacontrastsi, format = '(f0.2)')
paconsistr = strcompress(pixareacontrastsistr, /remove_all)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;Relative Energy Calculation
;area = fltarr[1]
;1 steradian = 4.25e10 arcseconds
;area[0] = (((nlines61 + nlines62 + nlines63 + nlines64)/4)*(hmiindex[0].cdelt1*hmiindex[0].cdelt1))/4.25e10
;passbandwidth = 7.6e-9
;relativepower = !dpi*relativeinc*area[0]*passbandwidth

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if (quake eq 1) then begin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Sarah's quake and ribbon coordinates ;qk location?: x = 506, y = 264
qkxa = 519;506;517
qkya = 262;264;264 
rbxa = 511
rbya = 272

;;;pixels to arcsecs
;qkxa = (submgindex[0].cdelt1)*(qkxp - submgindex[0].crpix1 + 1)
;;;convert arcsecs to pixels
qkmgxp = (qkxa/submgindex[0].cdelt1) + submgindex[0].crpix1 - 1
qkmgyp = (qkya/submgindex[0].cdelt2) + submgindex[0].crpix2 - 1
rbmgxp = (rbxa/submgindex[0].cdelt1) + submgindex[0].crpix1 - 1
rbmgyp = (rbya/submgindex[0].cdelt2) + submgindex[0].crpix2 - 1
;print,qkmgxp,qkmgyp,rbmgxp,rbmgyp

qksixp = (qkxa/map1400index[0].cdelt1) + map1400index[0].crpix1 - 1
qksiyp = (qkya/map1400index[0].cdelt2) + map1400index[0].crpix2 - 1
rbsixp = (rbxa/map1400index[0].cdelt1) + map1400index[0].crpix1 - 1
rbsiyp = (rbya/map1400index[0].cdelt2) + map1400index[0].crpix2 - 1
;print,qksixp,qksiyp,rbsixp,rbsiyp



qkmgmax = fltarr(nmg)
rbmgmax = fltarr(nmg)
qkmgcontrast = fltarr(nmg)
rbmgcontrast = fltarr(nmg)


qksimax = fltarr(nsi)
rbsimax = fltarr(nsi)
qksicontrast = fltarr(nsi)
rbsicontrast = fltarr(nsi)

;;;CHECK!!!

;;;

;;mg loop
for i = 0, nmg-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgmax[i] = submg[17 + i].data[qkmgxp, qkmgyp]
;qkimax[i] = sbhmimap[i].data[qkxp, qkyp]
qkmgcontrast[i] = (qkmgmax[i] - iminmg[0])/iminmg[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgmax[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;rbimax[i] = sbhmimap[i].data[rbxp, rbyp]
rbmgcontrast[i] = (rbmgmax[i] - iminmg[0])/iminmg[0]
endfor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;si loop
for i = 0, nsi-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qksimax[i] = map1400[387 + i].data[qksixp, qksiyp]
;qkimax[i] = sbhmimap[i].data[qkxp, qkyp]
qksicontrast[i] = (qksimax[i] - iminsi[0])/iminsi[0]
;;calculate contrast value for ribbon pixel on all frames to save time
rbsimax[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;rbimax[i] = sbhmimap[i].data[rbxp, rbyp]
rbsicontrast[i] = (rbsimax[i] - iminsi[0])/iminsi[0]
endfor





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;LIGHT CURVES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;QUAKE; mgii ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mx = max(qkmgmax)
mn = min(qkmgmax)
mxx = mx + 0.001*mx
mnn = mn - 0.2*mn
;yr = [mnn, mxx]


qkmgareacon = max(qkmgcontrast)
quakemgloccontraststr = string(qkmgareacon, format = '(f0.2)')
qkmgconstr = strcompress(quakemgloccontraststr, /remove_all)

lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-mgii-lc-quake-location.eps',/remove_all)
lcfile = lcq
angstrom = '!6!sA!r!u!9 %!6!n'
titl =  strcompress('IRIS-2796'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;alog10(qkmgmax)
;qkmgmax
utplot,submg[100:*].time, submg[100:*].data[qkmgxp, qkmgyp], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz, yr = [mnn, mxx], /ylog
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+qkmgconstr, /norm
device,/close
set_plot,mydevice

;QUAKE; siiv ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mx = max(qksimax)
mn = min(qksimax)
mxx = mx + 0.001*mx
mnn = mn - 0.2*mn
;yr = [mnn, mxx]


qksiareacon = max(qksicontrast)
quakesiloccontraststr = string(qksiareacon, format = '(f0.2)')
qksiconstr = strcompress(quakesiloccontraststr, /remove_all)

lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-siiv-lc-quake-location.eps',/remove_all)
lcfile = lcq
angstrom = '!6!sA!r!u!9 %!6!n'
titl =  strcompress('IRIS-1400'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;qksimax
utplot,map1400[450:*].time, map1400[450:*].data[qksixp, qksiyp], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz, yr = [mnn, mxx], /ylog
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+qksiconstr, /norm
device,/close
set_plot,mydevice


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;RIBBON; mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mx = max(rbmgmax)
mn = min(rbmgmax)
mxx = mx + 0.001*mx
mnn = mn - 0.2*mn
;yr = [mnn, mxx]

rbmgareacon = max(rbmgcontrast)
ribbonmgloccontraststr = string(rbmgareacon, format = '(f0.2)')
rbmgconstr = strcompress(ribbonmgloccontraststr, /remove_all)

lcr = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-mgii-lc-ribbon-location.eps',/remove_all)
lcfile = lcr
angstrom = '!6!sA!r!u!9 %!6!n'
titl =  strcompress('IRIS-2796'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;rbmgmax
utplot,submg[100:*].time, submg[100:*].data[rbmgxp, rbmgyp], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz, yr = [mnn, mxx], /ylog
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+rbmgconstr, /norm
device,/close
set_plot,mydevice



;RIBBON; siiv;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mx = max(rbsimax)
mn = min(rbsimax)
mxx = mx + 0.001*mx
mnn = mn - 0.2*mn
;yr = [mnn, mxx]
rbsiareacon = max(rbsicontrast)
ribbonsiloccontraststr = string(rbsiareacon, format = '(f0.2)')
rbsiconstr = strcompress(ribbonsiloccontraststr, /remove_all)

lcr = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-siiv-lc-ribbon-location.eps',/remove_all)
lcfile = lcr
angstrom = '!6!sA!r!u!9 %!6!n'
titl =  strcompress('IRIS-1400'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1
;rbsimax
utplot,map1400[450:*].time, map1400[450:*].data[rbsixp, rbsiyp], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz, yr = [mnn, mxx], /ylog
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+rbsiconstr, /norm
device,/close
set_plot,mydevice

endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;FRAME SPECIFIC PIXEL AREA PLOTS
;;;;;;;;;;mg plot
mx = max(boxarrmg)
mn = min(boxarrmg)
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
lcfmg = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+hmi+'/iris-lc-mgII-'+mg+'.eps',/remove_all)
lcfile = lcfmg
angstrom = '!6!sA!r!u!9 %!6!n'
titlmg =  strcompress('IRIS-2796'+angstrom+'-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

utplot,submg[17:*].time, boxarrmg, linestyle = 0, title = titlmg, ytitle = ytitl,xmargin = [12,3], yr = [mnn, mxx],/ynoz
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconmgstr, /norm
device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;si plot
mx = max(boxarrsi)
mn = min(boxarrsi)
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
lcfsi = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+hmi+'/iris-lc-siIV'+si+'.eps',/remove_all)
lcfile = lcfsi

titlsi =  strcompress('IRIS-1400'+angstrom+'-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

utplot,map1400[387:*].time, boxarrsi, linestyle = 0, title = titlsi, ytitle = ytitl,xmargin = [12,3], yr = [mnn, mxx],/ynoz
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconsistr, /norm
device,/close
set_plot,mydevice
end

;Calculates energies pre pixel, then sums over area associated with flaring region
;to run:  iris_energy, 1400, 2796, 2832
;see http://iris.lmsal.com/itn26/calibration.html for details on Flux calculation
;
;see Documents/Spacecraft-Data-Guides/IRIS/ISO196 iris_missio_final.pdf pg 14 for instrument characteristics
;
;
;
;
;need line energies from paper http://articles.adsabs.harvard.edu/cgi-bin/nph-iarticle_query?1954ApJ...119..590W&amp;data_type=PDF_HIGH&amp;whole_paper=YES&amp;type=PRINTER&amp;filetype=.pdf
pro iris_energy, sj1, sj2, sj3

restore, 'iris-16-03-15.sav'
restore, 'SJ2832.sav'

hmi = strarr(4)
hmi[0] = '61'
hmi[1] = '62'
hmi[2] = '63'
hmi[3] = '64'

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
;;;constants
h = 6.626e-34 ;planck's constant
c = 2.998e8;speed of light
lambda2 = 1.4e-7;m;1400 ;angstroms;central wavelength
lambda3 = 2.796e-7;m;2796;central wavelength
lambda4 = 2.832e-7;m;2832;central wavelength

;photon energies
E2jou = (h*c)/lambda2
E2 = E2jou/1e-7 ;convert to erg...1 erg = 1e-7 J
E3jou = (h*c)/lambda3
E3 = E3jou/1e-7
E4jou = (h*c)/lambda4
E4 = E4jou/1e-7

pixxy = 0.16635000*(!pi/(180.*3600.*6. )) 

;spectral scale pixel in angstroms....nuv = 2796, 2832.....fuv = 1330, 1400
pixnuv = 25.6e-3
pixfuv = 12.8e-3


texp = 8.0000496
Wslit = !pi/(180.*3600.*3.)


;sj 1400 si IV FUV
if (sj1 eq 1400) then begin
f= '/iris-siiv-high-intenstiy-pixels-frame-'

si = intarr(4)
si[0] = 495
si[1] = 496
si[2] = 498
si[3] = 500

openw, unit, '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris_energies_siiv.dat', /get_lun, /append
printf, unit, 'flux[cgs]','energy[cgs]'
;Ftotsi = fltarr(2,4)
;Etotsi = fltarr(2,4)
Fsicgs = fltarr(1,4)
Esicgs = fltarr(1,4)
for j = 0,3,1 do begin

sist = string(si[j], format = '(I0)')

fsi = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+hmi[j]+''+f+''+sist+'.dat',/remove_all)

openr,lun,fsi,/get_lun

;;;count lines in file
nlinessi = file_lines(fsi)

;;;make array to fill with values from the file
hsi=intarr(2,nlinessi)

;;;read file contents into array
readf,lun,hsi

;;close file and free up file unit number
free_lun, lun



iresp = iris_get_response('2014-03-29T14:10:17.030',version='003') ; gets radiometric calibration for SJ data

A =  iresp.AREA_SJI[1];effective area
pixlambda = pixfuv;size of spectral pixel in angstroms

;Fdn = fltarr(nlinessi)
;Fcgs = fltarr(nlinessi)
;Ecgs = fltarr(nlinessi)

Fsicgs[0,j] = total((map1400[si[j]].data[hsi[0,*],hsi[1,*]])*((E2*iresp.DN2PHOT_SJI[1])/(A*pixxy*pixlambda*texp*wslit)))
;Fcgs[1,j] = map1400[si[j]].time
Esicgs[0,j] = Fsicgs[0,j]*(nlinessi*(A*pixxy*pixlambda*texp*wslit))
;Esicgs[0,j] = Fsicgs*(A*pixxy*pixlambda*texp*wslit)


;Ecgs[1,j] = map1400[si[j]].time
	;for i = 0, nlinessi-1, 1 do begin
	;;;;;;Fdn[i] = 
	;Fcgs[i] = (map1400[si].data[hsi[0,i],hsi[1,i]])*((E2*iresp.DN2PHOT_SJI[1])/(A*pixxy*pixlambda*texp*wslit)) ; flux in cgs units, where Fdn is flux in DNs per pixel
	;Ecgs[i] = Fcgs[i]*(A*pixxy*pixlambda*texp*wslit)
	;endfor
;Ftotsi[0,j] = map1400[si[j]].time
;Ftotsi[1,j] = total(Fcgs)
;Etotsi[0,j] = map1400[si].time
;Etotsi[1,j] = total(Ecgs)

printf, unit, Fsicgs,Esicgs

endfor
free_lun, unit


;;;;;;;;;;;;;;;;;;;;;;;;plots '[DN Pixel!E-1!N]'
mydevice=!d.name
set_plot,'ps'
device,filename= dir+'Fsiiv-vs-t.eps',/portrait,/encapsulated, decomposed=0,color=1

utplot, map1400[si[*]].time, Fsicgs , title = '1400'+angstrom+' Flux as a Function of Time', ytitle = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
;xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconsistr, /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename= dir+'Esiiv-vs-t.eps',/portrait,/encapsulated, decomposed=0,color=1

utplot, map1400[si[*]].time, Esicgs , title = '1400'+angstrom+' Energy as a Function of Time', ytitle = '[erg s!E-1!N]'
;xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconsistr, /norm
device,/close
set_plot,mydevice

endif



;sj 2796 mg II h/k NUV
if (sj2 eq 2796) then begin
f= '/iris-mgii-high-intenstiy-pixels-frame-'

mg = intarr(4)
mg[0] = 159
mg[1] = 161
mg[2] = 164
mg[3] = 166

openw, unit, '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris_energies_mgii.dat', /get_lun, /append
printf, unit, 'flux[cgs]','energy[cgs]'
Fmgcgs = fltarr(1,4)
Emgcgs = fltarr(1,4)
;Ftotmg = fltarr(2,4)
;Etotmg = fltarr(2,4)
for j = 0,3,1 do begin

mgst = string(mg[j], format = '(I0)')


fmg = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+hmi[j]+''+f+''+mgst+'.dat',/remove_all)

openr,lun,fmg,/get_lun

;;;count lines in file
nlinesmg = file_lines(fmg)

;;;make array to fill with values from the file
hmg=intarr(2,nlinesmg)

;;;read file contents into array
readf,lun,hmg

;;close file and free up file unit number
free_lun, lun


iresp = iris_get_response('2014-03-29T14:10:17.030',version='003') ; gets radiometric calibration for SJ data

A = iresp.AREA_SJI[2] ;effective area
pixlambda = pixnuv;size of spectral pixel in angstroms

;Fcgs = Fdn*((E2*iresp.DN2PHOT_SG)/(A*pixxy*pixlambda*texp*wslit)) ; flux in cgs units, where Fdn is flux in DNs per pixel


;Fdn = fltarr(nlinesmg)

Fmgcgs[0,j] = total((submg[mg[j]].data[hmg[0,*],hmg[1,*]])*((E3*iresp.DN2PHOT_SJI[2])/(A*pixxy*pixlambda*texp*wslit)))
;Fcgs[1,j] = map1400[si[j]].time
Emgcgs[0,j] = Fmgcgs[0,j]*(nlinesmg*(A*pixxy*pixlambda*texp*wslit))
	;for i = 0, nlinesmg-1, 1 do begin
	;Fdn[i] = submg[mg].data[hmg[0,i],hmg[1,i]]
	;Fcgs[i] = (submg[mg].data[hmg[0,i],hmg[1,i]])*((E3*iresp.DN2PHOT_SJI[3])/(A*pixxy*pixlambda*texp*wslit)) ; flux in cgs units, where Fdn is flux in DNs per pixel
	;Ecgs[i] = Fcgs[i]*(A*pixxy*pixlambda*texp*wslit)
	;endfor


;Ftotmg[0,j] = submg[mg].time
;Ftotmg[1,j] = total(Fcgs)
;Etotmg[0,j] = submg[mg].time
;Etotmg[1,j] = total(Ecgs)


printf, unit, 'Mg II '+mgst+' Ftot[cgs]=',Fmgcgs
printf, unit, 'Mg II '+mgst+' Etot[cgs]=',Emgcgs

endfor
free_lun, unit

;;;;;;;;;;;;;;;;;;;;;;;;plots '[DN Pixel!E-1!N]'
mydevice=!d.name
set_plot,'ps'
device,filename= dir+'Fmgii-vs-t.eps',/portrait,/encapsulated, decomposed=0,color=1

utplot,submg[mg[*]].time, Fmgcgs, title = '2796'+angstrom+' Flux as a Function of Time', ytitle = '[erg s!E-1!N]'
;xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconsistr, /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename= dir+'Emgii-vs-t.eps',/portrait,/encapsulated, decomposed=0,color=1

utplot, submg[mg[*]].time, Emgcgs , title = '2796'+angstrom+' Energy as a Function of Time', ytitle = '[erg s!E-1!N]'
;xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconsistr, /norm
device,/close
set_plot,mydevice


endif



;sj 2832 mg II wing
if (sj3 eq 2832) then begin
f= '/iris-mgiiw-high-intenstiy-pixels-frame-' 

mgw = intarr(4)
mgw[0] = 166
mgw[1] = 167
mgw[2] = 168
mgw[3] = 169

openw, unit, '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris_energies_mgiiw.dat', /get_lun, /append
printf, unit, 'flux[cgs]','energy[cgs]'
Fmgwcgs = fltarr(1,4)
Emgwcgs = fltarr(1,4)
;Ftotmgw = fltarr(2,4)
;Etotmgw = fltarr(2,4)
for j = 0,3,1 do begin

mgwst = string(mgw[j], format = '(I0)')


fmgiiw = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'+hmi[j]+''+f+''+mgwst+'.dat',/remove_all)

openr,lun,fmgiiw,/get_lun

;;;count lines in file
nlinesmgiiw = file_lines(fmgiiw)

;;;make array to fill with values from the file
hmgiiw = intarr(2,nlinesmgiiw)

;;;read file contents into array
readf,lun,hmgiiw

;;close file and free up file unit number
free_lun, lun


iresp = iris_get_response('2014-03-29T14:10:17.030',version='003') ; gets radiometric calibration for SJ data

A = iresp.AREA_SJI[3] ;effective area
pixlambda = pixnuv;size of spectral pixel in angstroms


;Fcgs = Fdn*((E4*iresp.DN2PHOT_SG)/(A*pixxy*pixlambda*texp*wslit)) ; flux in cgs units, where Fdn is flux in DNs per pixel

;Fdn = fltarr(nlinesmgiiw)
Fmgwcgs[0,j] = total((map2832[mgw[j]].data[hmgiiw[0,*],hmgiiw[1,*]])*((E4*iresp.DN2PHOT_SJI[3])/(A*pixxy*pixlambda*texp*wslit)))
;Fcgs[1,j] = map1400[si[j]].time
Emgwcgs[0,j] = Fmgwcgs[0,j]*(nlinesmgiiw*(A*pixxy*pixlambda*texp*wslit))
	;for i = 0, nlinesmg-1, 1 do begin
	;;Fdn[i] = map2832[mgw].data[hmgiiw[0,i],hmgiiw[1,i]]
	;Fcgs[i] = (map2832[mgw].data[hmgiiw[0,i],hmgiiw[1,i]])*((E4*iresp.DN2PHOT_SJI[3])/(A*pixxy*pixlambda*texp*wslit)) ; flux in cgs units, where Fdn is flux in DNs per pixel
	;Ecgs[i] = Fcgs[i]*(A*pixxy*pixlambda*texp*wslit)
	;endfor



;Ftotmgw[0,j] = map2832[mgw].time
;Ftotmgw[1,j] = total(Fcgs)
;Etotmgw[0,j] = map2832[mgw].time
;Etotmgw[1,j] = total(Ecgs)

printf, unit, Fmgwcgs,Emgwcgs

endfor
free_lun, unit
;;;;;;;;;;;;;;;;;;;;;;;;plots '[DN Pixel!E-1!N]'
mydevice=!d.name
set_plot,'ps'
device,filename= dir+'Fmgiiw-vs-t.eps',/portrait,/encapsulated, decomposed=0,color=1

utplot,map2832[mgw[*]].time, Fmgwcgs, title = '2832'+angstrom+' Flux as a Function of Time', ytitle = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
;xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconsistr, /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename= dir+'Emgiiw-vs-t.eps',/portrait,/encapsulated, decomposed=0,color=1

utplot,map2832[mgw[*]].time, Emgwcgs, title = '2832'+angstrom+' Energy as a Function of Time', ytitle = '[erg s!E-1!N]'
;xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+paconsistr, /norm
device,/close
set_plot,mydevice
endif





;;;;;;;;;;;;;;;;;;;;;;;;plots '[DN Pixel!E-1!N]'
E = fltarr(3, 4) ;HEt[0,*] = height, HEt[1,*] = height ;;;;
F = fltarr(3,4)
H = fltarr(3)
t = [0., 8., 16., 24.] ;submg[mg[*]].time
H = findgen(3)+1


E[2,*] =  Esicgs[0,*]
E[1,*] =  Emgcgs[0,*]
E[0,*] =  Emgwcgs[0,*]

F[2,*] =  Fsicgs[0,*]
F[1,*] =  Fmgcgs[0,*]
F[0,*] =  Fmgwcgs[0,*]

;;;;;try different array setup
;het = fltarr(3,12)

;;;height
;het[0,0:3] = 3.
;het[0,4:7] = 2.
;het[0,8:11] = 1.

;;;energy
;het[1,0:3] = Esicgs[0,0:3]
;het[1,4:7] = Emgcgs[0,0:3]
;het[1,8:11] = Emgwcgs[0,0:3]

;;;time
;het[2,0:3] = t[*];submg[mg[*]].time
;het[2,4:7] = t[*];submg[mg[*]].time
;het[2,8:11] = t[*];submg[mg[*]].time


;save, Fsicgs, Fmgcgs, Fmgwcgs, Esicgs, Emgcgs, Emgwcgs, het, filename = 'iris_energy.sav'
save, Fsicgs, Fmgcgs, Fmgwcgs, Esicgs, Emgcgs, Emgwcgs,F,E,H,t, filename = 'iris_energy.sav'
;mydevice=!d.name
;set_plot,'ps'
;device,filename=dir+'Energy-map-H-vs-t.eps',/portrait,/encapsulated, decomposed=0,color=1

;plot_image , E
;device,/close
;set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'EHt-3Dplot.eps',/portrait,/encapsulated, decomposed=0,color=1
;p = plot3d(het[0,*],het[1,*],het[2,*])
pe = plot3d(E, t, H)
device,/close
set_plot,mydevice


mydevice=!d.name
set_plot,'ps'
device,filename=dir+'FHt-3Dplot.eps',/portrait,/encapsulated, decomposed=0,color=1
;p = plot3d(het[0,*],het[1,*],het[2,*])
pf = plot3d(F, t, H, /sym_filled,axis_style=2,/perspective,$
shadow_color="deep sky blue",xy_shadow=1,yz_shadow=1,xz_shadow=1,$
xtitle='Flux [erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]', $
ytitle='Time [s]', ztitle='Height [Arbitrary]')
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;another idea

evsh = fltarr(2,3)


evsh[0,0] = Esicgs[0]
evsh[0,1] = Emgcgs[0]
evsh[0,2] = Emgwcgs[0]

evsh[1,0] = 3.
evsh[1,1] = 2.
evsh[1,2] = 1.

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'Et0vsH.eps',/portrait,/encapsulated, decomposed=0,color=1

plot, evsh[1,*], evsh[0,*], /ylog

device,/close
set_plot,mydevice


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
evsh[0,0] = Esicgs[1]
evsh[0,1] = Emgcgs[1]
evsh[0,2] = Emgwcgs[1]

evsh[1,0] = 3.
evsh[1,1] = 2.
evsh[1,2] = 1.

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'Et1vsH.eps',/portrait,/encapsulated, decomposed=0,color=1

plot, evsh[1,*], evsh[0,*], /ylog

device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
evsh[0,0] = Esicgs[2]
evsh[0,1] = Emgcgs[2]
evsh[0,2] = Emgwcgs[2]

evsh[1,0] = 3.
evsh[1,1] = 2.
evsh[1,2] = 1.

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'Et2vsH.eps',/portrait,/encapsulated, decomposed=0,color=1

plot, evsh[1,*], evsh[0,*], /ylog

device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
evsh[0,0] = Esicgs[3]
evsh[0,1] = Emgcgs[3]
evsh[0,2] = Emgwcgs[3]

evsh[1,0] = 3.
evsh[1,1] = 2.
evsh[1,2] = 1.

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'Et3vsH.eps',/portrait,/encapsulated, decomposed=0,color=1

plot, evsh[1,*], evsh[0,*], /ylog

device,/close
set_plot,mydevice




end


pro irisbalmer
;load.sav file containing spectra structures 
lambda = 2826
lambda = string(lambda, format ='(I0)' )

;restore, 'sp2796-Apr28-2015.sav'
;restore, 'sp2814-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
;restore, 'sp2832-Apr28-2015.sav'

;spectral range

;flare location

;lambda1 = 2832
;lambda2 = 2826
;lambda3 = 2814
;lambda4 = 2796
;lambda1 = string(lambda1, format ='(I0)' )
;lambda2 = string(lambda2, format ='(I0)' )
;lambda3 = string(lambda3, format ='(I0)' )
;lambda4 = string(lambda4, format ='(I0)' )

f = iris_files('../IRIS/*raster*.fits')
nnn = n_elements(f)
sample = 1 ;2  ; 2 = slit positions covering required location
;nt = n_elements(sp2796.tag00.time_ccsds)
;nt = n_elements(sp2796.tag00.time_ccsds)/2
;ntst = string(nt, format ='(I0)' )
;ntt = nnn*nt

boxarr = fltarr(sample*nnn)
bboxarr = fltarr(sample*nnn)
timearr = strarr(sample*nnn)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;delvar, f


;;;plot spectra (intensity vs lambda) for quake and ribbon locations
;;;block increase over entire wavelength range = continuum
;;;peaks = emission
;;;troughs = absorption
;plot, sp2832.tag00.wvl, sp2832.tag00.int[*,4,423]
;oplot, sp2832.tag01.wvl, sp2832.tag01.int[*,4,423]
;oplot, sp2832.tag010.wvl, sp2832.tag010.int[*,4,423]
;qkxa = 519;517
;qkya = 262;264 
;rbxa = 511
;rbya = 272




;;;plot spectra intensity vs time
;;;Structure:  tag0* = time 
;;;int float array[lambda, y, x]
;;;therefore need to sample, eg,  sp2832.tag0[i].int[lambdarange, xslitposition,  yflare]
;xslitposition[#] = time_ccsds[#] = solar_x[#]...therefore can check solar_x to find correct 
;location in arcseconds then propagate element number through to time and x 
;utplot, sp2826.tag00.time_ccsds[3:4], sp2826.tag00.int[lambdarange , 3:4, yflare]
;lambdarange = heinzel and kleint defined = 2825.7 to 2825.8
;which equates to lambdarange = 39 : 44 
;plot, sp2826.tag00.wvl[39:44], sp2826.tag00.int[39:44,4,435]


;LOOP 1
;for i = 0, nnn-1, 1 do begin

;fill timearr with times relating to each tag timearr[i*8:i*8+(8-1)]
;comt1 = 'timearr[i*'+ntst+':i*'+ntst+'+'+ntst+'-1] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[*]'
;exet1 = execute(comt1)
	
;fill boxarr with intensity data for each tag: sp2832.tag00.int[75,*,440]
;comi = 'boxarr[i*'+ntst+':i*'+ntst+'+'+ntst+'-1] = sp'+lambda1+'.'+tagarr[i]+'.int['+xst+',*,'+yst+']'
;exet = execute(comi)


;endfor

;LOOP 2
;for i = 0, nnn-1, 1 do begin

;fill timearr with times relating to each tag timearr[i*8:i*8+(8-1)]
;ii = string(i,format='(I0)') ;;;
;iii = string(nt-1,format='(I0)')
;comt1 = 'timearr[i*'+ntst+':i*'+ntst+'+'+ntst+'-1] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[*]'

;take times when slit is in same position, i.e, 0 and 4....check
;comt = 'timearr[i*2] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[0]'
;comtt = 'timearr[i*2+2-1] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[4]'
;exet1 = execute(comt)
;exett = execute(comtt)
	
;fill boxarr with intensity data for each tag: sp2832.tag00.int[75,*,440]
;comi = 'boxarr[i*2] = sp'+lambda1+'.'+tagarr[i]+'.int[75,0,440]'
;comii = 'boxarr[i*2+2-1] = sp'+lambda1+'.'+tagarr[i]+'.int[75,4,440]'
;exet = execute(comi)
;exeii = execute(comii)

;endfor

;qk location from sbsbegmap6?: x = 506, y = 264
;Pixel locations for balmer plots calculated using 
;qkmgxp = (qkxa/submgindex[0].cdelt1) + submgindex[0].crpix1 - 1
;qkmgyp = (qkya/submgindex[0].cdelt2) + submgindex[0].crpix2 - 1
;rbmgxp = (rbxa/submgindex[0].cdelt1) + submgindex[0].crpix1 - 1
;rbmgyp = (rbya/submgindex[0].cdelt2) + submgindex[0].crpix2 - 1
;print,qkmgxp,qkmgyp,rbmgxp,rbmgyp
;qkxp0 = 512.697      
;qkyp0 = 441.086      
;rbxp0 = 542.754 
;rbyp0 = 489.178

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;QUAKE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LOOP 3
for i = 0, nnn-1, 1 do begin

;fill timearr with times relating to each tag timearr[i*8:i*8+(8-1)]
;ii = string(i,format='(I0)') ;;;
;iii = string(nt-1,format='(I0)')
;comt1 = 'timearr[i*'+ntst+':i*'+ntst+'+'+ntst+'-1] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[*]'

;take times when slit is in same position, i.e, 0 and 4....check
comt = 'timearr[i] = sp'+lambda+'.'+tagarr[i]+'.time_ccsds[3]'
exet1 = execute(comt)
;comtt = 'timearr[i+1] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[4]'
	
;fill boxarr with intensity data for each tag: sp2826.tag00.int[75,*,440]
;comi = 'boxarr[i] = sp'+lambda1+'.'+tagarr[i]+'.int[39:44,4,435]'
;;;works!!!;comi = 'boxarr[i] = total(sp'+lambda1+'.'+tagarr[i]+'.int[39:44,3,435])/(44-39)'

;sarah says 435 = boxarr
;my code says 429 = bboxarr
comi = 'boxarr[i] = total(sp'+lambda+'.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
ccomi = 'bboxarr[i] = total(sp'+lambda+'.'+tagarr[i]+'.int[39:44,3:4,441])/((44-39)*2)'
;ccomi = 'bboxarr[i] = total(sp'+lambda+'.'+tagarr[i]+'.int[39:44,3:4,429])/((44-39)*2)' ; didn't show flare
;comii= 'boxarr[i+1] = total(sp'+lambda1+'.'+tagarr[i]+'.int[39:44,4,435])/(44-39)'
exet = execute(comi)
eexet = execute(ccomi)

endfor

;;contrasts
imin = fltarr(sample*nnn)
iimin = fltarr(sample*nnn)

imin[*] = total(boxarr[20:60])/(40)
iimin[*] = total(bboxarr[20:60])/(40)

imax = max(boxarr)
iimax = max(bboxarr)

qkcontrast = ((imax-imin[0])/imin[0])
qqkcontrast = ((iimax-iimin[0])/iimin[0])

qkcontrastr = string(qkcontrast, format = '(f0.2)')
qqkcontrastr = string(qqkcontrast, format = '(f0.2)')

qkconstr = strcompress(qkcontrastr, /remove_all)
qqkconstr = strcompress(qqkcontrastr, /remove_all)


;utplot, timearr[130:*], boxarr[130:*]
;utplot, timearr[1091:*], boxarr[1091:*]
;utplot, timearr[1300:*], boxarr[1300:*]


;;;;plots
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;y=435

mx = max(boxarr[140:*])
mn = min(boxarr[140:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn

lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-balmer-quake-y-435.eps',/remove_all)
lcfile = lcq
angstrom = '!6!sA!r!u!9 %!6!n'
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-X=3to4-Y=435-QK-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

utplot,timearr[140:*], boxarr[140:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx]
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+qkconstr, /norm
device,/close
set_plot,mydevice

;;;;;;;;;;;y=429

mx = max(bboxarr[140:*])
mn = min(bboxarr[140:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn

lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-balmer-quake-y-441.eps',/remove_all)
lcfile = lcq
angstrom = '!6!sA!r!u!9 %!6!n'
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-X=3to4-Y=441-QK-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

utplot,timearr[140:*], bboxarr[140:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz,yr = [mnn, mxx]
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+qqkconstr, /norm
device,/close
set_plot,mydevice


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;RIBBON;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
for i = 0, nnn-1, 1 do begin

;fill timearr with times relating to each tag timearr[i*8:i*8+(8-1)]
;ii = string(i,format='(I0)') ;;;
;iii = string(nt-1,format='(I0)')
;comt1 = 'timearr[i*'+ntst+':i*'+ntst+'+'+ntst+'-1] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[*]'

;take times when slit is in same position, i.e, 0 and 4....check
comt = 'timearr[i] = sp'+lambda+'.'+tagarr[i]+'.time_ccsds[3]'
exet1 = execute(comt)
;comtt = 'timearr[i+1] = sp'+lambda1+'.'+tagarr[i]+'.time_ccsds[4]'
	
;fill boxarr with intensity data for each tag: sp2826.tag00.int[75,*,440]
;comi = 'boxarr[i] = sp'+lambda1+'.'+tagarr[i]+'.int[39:44,4,435]'
;;;works!!!;comi = 'boxarr[i] = total(sp'+lambda1+'.'+tagarr[i]+'.int[39:44,3,435])/(44-39)'
comi = 'boxarr[i] = total(sp'+lambda+'.'+tagarr[i]+'.int[39:44,3:4,489])/((44-39)*2)'
;comii= 'boxarr[i+1] = total(sp'+lambda1+'.'+tagarr[i]+'.int[39:44,4,435])/(44-39)'
exet = execute(comi)


endfor

;;contrasts
imin = fltarr(sample*nnn)
imin[*] = total(boxarr[20:60])/(40)
imax = max(boxarr)


rbcontrast = ((imax-imin[0])/imin[0])
rbcontrastr = string(rbcontrast, format = '(f0.2)')
rbconstr = strcompress(rbcontrastr, /remove_all)



;utplot, timearr[130:*], boxarr[130:*]
;utplot, timearr[1091:*], boxarr[1091:*]
;utplot, timearr[1300:*], boxarr[1300:*]


;;;;plots
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;y = 489

mx = max(boxarr[140:*])
mn = min(boxarr[140:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn


lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-balmer-ribbon-y-489.eps',/remove_all)
lcfile = lcq
angstrom = '!6!sA!r!u!9 %!6!n'
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-X=3to4-Y=489-RB-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'

mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

utplot,timearr[140:*], boxarr[140:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz, yr = [mnn, mxx]
xyouts, 0.2, 0.9, 'Max Intensity Contrast = '+rbconstr, /norm
device,/close
set_plot,mydevice

end

pro plotty

restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'

fsp = iris_files('../IRIS/*raster*.fits')
nn = n_elements(fsp)
sample = 1

spboxarr = fltarr(sample*nn)

timearr = strarr(sample*nn)
rbboxarr = fltarr(sample*nn)
;sp quake
for i = 0, nn-1, 1 do begin
comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
exet1 = execute(comt)
comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'

exet = execute(comi)

endfor
;sp ribbon
for i = 0, nn-1, 1 do begin
;comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
;exet1 = execute(comt)
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,487])/((44-39)*2)'
comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,488])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,489])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,490])/((44-39)*2)'
;comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,491])/((44-39)*2)'
exet = execute(comi)
endfor

spimin = fltarr(sample*nn)
spimin[*] = total(spboxarr[20:60])/(40)
spimax = max(spboxarr)
rbimax = max(rbboxarr)

spqkcontrast = ((spimax-spimin[0])/spimin[0])
sprbcontrast = ((rbimax-spimin[0])/spimin[0])

spqkcontrastr = string(spqkcontrast, format = '(f0.2)')
sprbcontrastr = string(sprbcontrast, format = '(f0.2)')

spqkconstr = strcompress(spqkcontrastr, /remove_all)
sprbconstr = strcompress(sprbcontrastr, /remove_all)

lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/plotty-test.eps',/remove_all)
angstrom = '!6!sA!r!u!9 %!6!n'

mydevice=!d.name
set_plot,'ps'
device,filename=lcq,/portrait,/encapsulated, decomposed=0,color=1, SET_CHARACTER_SIZE=[110,200]
!P.MULTI = [0, 1, 4]

mx = max(spboxarr[140:*])
mn = min(spboxarr[140:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,timearr[157:*], spboxarr[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx], pos = [0.35,0.06,0.55,0.24]
loadct,3
oplot, [1420,1420],[-9000,7000],color=150,thick=1
xyouts, 0.36, 0.22, 'Max Intensity Contrast = '+spqkconstr, /norm , charsize = 0.6

mx = max(spboxarr[140:*])
mn = min(spboxarr[140:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-QUAKE-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,timearr[157:*], spboxarr[157:*], linestyle = 0, title = titl, ytitle = ytitl,xmargin = [12,3],/ynoz ,yr = [mnn, mxx], pos = [0.35,0.78,0.55,0.96]
loadct,3
oplot, [1420,1420],[-9000,7000],color=150,thick=1
xyouts, 0.36, 0.94, 'Max Intensity Contrast = '+spqkconstr, /norm , charsize = 0.6

mx = max(rbboxarr[140:*])
mn = min(rbboxarr[140:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,timearr[157:*], rbboxarr[157:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  pos = [0.35,0.54,0.55,0.72],yr = [mnn, mxx] ;,/ylog
loadct,3
oplot, [1420,1420],[10,70000],color=150,thick=1
xyouts, 0.36, 0.70, 'Max Intensity Contrast = '+sprbconstr, /norm , charsize = 0.6

mx = max(rbboxarr[140:*])
mn = min(rbboxarr[140:*])
mxx = mx + 0.05*mx
mnn = mn - 0.05*mn
titl =  strcompress('IRIS-2825.7-2825.8'+angstrom+'-RIBBON-LOCATION-INTENSITY' ,/remove_all)
ytitl = '[DN Pixel!E-1!N]'
utplot,timearr[157:*], rbboxarr[157:*], linestyle = 0, title = titl, ytitle = ytitl,/ynoz,  pos = [0.35,0.30,0.55,0.48],yr = [mnn, mxx] ;,/ylog
loadct,3
oplot, [1420,1420],[10,70000],color=150,thick=1
xyouts, 0.36, 0.46, 'Max Intensity Contrast = '+sprbconstr, /norm , charsize = 0.6





device,/close
set_plot,mydevice
end


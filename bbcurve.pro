;Make bb curve for 
;
;wave0 = starting wavelength
;temp = central temp
;radius = radius of star...sun = 7.0e8m = 7.0e10cm
;distance = distance to observer from emission source...sdo = 36.0e6m = 36.0e8cm
pro bbcurve, wave0, temp, radius, distance

wave = wave0 + findgen(200)*100
bbflux = planck(wave,temp)
flux = bbflux*radius^2/distance^2
a = fltarr(26)
a[*] = 6170
mx = max(wave)
mn = min(wave)
mxx = 2.0e4
mnn = 1.0e3
t = string(temp)
tt = strcompress(t+'K',/remove_all)
lcfile = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/BB-Curve-'+tt+'.eps'
titl =  strcompress('Blackbody-Curve-T='+tt ,/remove_all)
angstrom = '!6!sA!r!u!9 %!6!n'
ytitl = 'Flux [erg cm!E-2!N s!E-1!N ' +angstrom+'!E-1!N]'
xtitl = 'Wavelength ['+angstrom+']'
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

plot,wave,flux,title = titl, ytitle = ytitl,xtitle = xtitl, xmargin = [9,4], xrange = [mnn,mxx]
oplot, a, flux, linestyle = 1
xyouts, 0.38, 0.2, '6173 '+angstrom, /norm
device,/close
set_plot,mydevice

end

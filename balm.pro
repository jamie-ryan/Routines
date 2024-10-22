pro balm
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-Balmer-Continuum.eps',/encapsulated, decomposed=0,color=1, bits=8
plot, sp2826.tag0173.wvl[25:60], sp2826.tag0173.int[25:60,3,435], $
/xst, $
title = 'Balmer Continuum Sample', $
ytitle = 'Relative Intensity [DN Pixel!e-1!n]', $
xtitle = 'Wavelength ['+angstrom+']', $
xmargin = [12,3]
vert_line, 2825.7, 1
vert_line, 2825.8, 1
device,/close
set_plot,mydevice
end

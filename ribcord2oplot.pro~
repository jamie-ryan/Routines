pro ribcord2oplot, date

;plots multicoloured crosses over ribbon coords
;;;si ribbon Coord-oplots

;restore,'29-Mar-2014-energies-iris-siiv-single-pixel-Oct24-2015.sav'
;restore,'29-Mar-2014-energies-iris-mgii-single-pixel-Oct24-2015.sav'
;restore,'29-Mar-2014-energies-iris-balmer-single-pixel-Oct24-2015.sav'
;restore,'29-Mar-2014-energies-iris-mgw-single-pixel-Oct24-2015.sav'
;restore, '29-Mar-2014-energies-hmi-single-pixel-Oct24-2015.sav'
restore, '/unsafe/jsr2/'+date+'-2015/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+date+'-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/HMI-diff-15-Oct-15.sav'

nrb = 20 ; number ribbon coords
time_frames = 2 
npt = 1 + (nrb/time_frames)

iradius = 3.;iris qk radius in pixels
sradius = 1.;sdo qk radius in pixels

sub_map, map1400, ssi, xrange = [480., 540.], yrange = [240., 300.]
sub_map, submg, smg, xrange = [450., 550.], yrange = [200., 300.]
sub_map, diff2832, smgw, xrange = [475., 575.], yrange = [230., 280.]
sub_map, diff, shmi, xrange = [485., 535.], yrange = [250., 275.]

sicoords1 = fltarr(2, npt)
sicoords2 = fltarr(2, npt)
sicoords1[0,*] = reform(sidata[0, 0, *, 0])
sicoords1[1,*] = reform(sidata[0, 1, *, 0])
sicoords2[0,*] = reform(sidata[1, 0, *, 0])
sicoords2[1,*] = reform(sidata[1, 1, *, 0])
mgcoords1 = fltarr(2, npt)
mgcoords2 = fltarr(2, npt)
mgcoords1[0,*] = reform(mgdata[0, 0, *, 0])
mgcoords1[1,*] = reform(mgdata[0, 1, *, 0])
mgcoords2[0,*] = reform(mgdata[1, 0, *, 0])
mgcoords2[1,*] = reform(mgdata[1, 1, *, 0])
balmercoords1 = fltarr(2, npt)
balmercoords2 = fltarr(2, npt)
balmercoords1[0,*] = reform(balmerdata[0, 0, *, 0])
balmercoords1[1,*] = reform(balmerdata[0, 1, *, 0])
balmercoords2[0,*] = reform(balmerdata[1, 0, *, 0])
balmercoords2[1,*] = reform(balmerdata[1, 1, *, 0])
mgwcoords1 = fltarr(2, npt)
mgwcoords2 = fltarr(2, npt)
mgwcoords1[0,*] = reform(mgwdata[0, 0, *, 0])
mgwcoords1[1,*] = reform(mgwdata[0, 1, *, 0])
mgwcoords2[0,*] = reform(mgwdata[1, 0, *, 0])
mgwcoords2[1,*] = reform(mgwdata[1, 1, *, 0])
hmicoords1 = fltarr(2, npt)
hmicoords2 = fltarr(2, npt)
hmicoords1[0,*] = reform(hmidata[0, 0, *, 0])
hmicoords1[1,*] = reform(hmidata[0, 1, *, 0])
hmicoords2[0,*] = reform(hmidata[1, 0, *, 0])
hmicoords2[1,*] = reform(hmidata[1, 1, *, 0])


mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-SI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
plot_map, ssi[494], dmin = 0, dmax = 5000
oplot_ribbon_coords, sicoords1, iradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-SI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, ssi[498], dmin = 0, dmax = 5000
oplot_ribbon_coords, sicoords2, iradius, /box
device,/close
set_plot,mydevice


;;;mg ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-MG-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
plot_map, smg[664], dmin = 0, dmax = 5000
oplot_ribbon_coords, mgcoords1, iradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-MG-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, smg[666], dmin = 0, dmax = 5000
oplot_ribbon_coords, mgcoords2, iradius, /box
device,/close
set_plot,mydevice


;;;mgw ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-MGW-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
plot_map, smgw[166], dmin = 0, dmax = 3000
oplot_ribbon_coords, mgwcoords1, iradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-MGW-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, smgw[167], dmin = 0, dmax = 3000
oplot_ribbon_coords, mgwcoords2, iradius, /box
device,/close
set_plot,mydevice



;;;hmi ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-HMI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
plot_map, shmi[62], dmin = 0, dmax = 2000
oplot_ribbon_coords, hmicoords1, sradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-HMI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, shmi[63], dmin = 0, dmax = 2000
oplot_ribbon_coords, hmicoords2, sradius, /box
device,/close
set_plot,mydevice
end

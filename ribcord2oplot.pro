pro ribcord2oplot

;plots multicoloured crosses over ribbon coords
;;;si ribbon coord oplots

restore,'29-Mar-2014-energies-iris-siiv-single-pixel-Oct23-2015.sav'
restore,'29-Mar-2014-energies-iris-mgii-single-pixel-Oct23-2015.sav'
restore,'29-Mar-2014-energies-iris-balmer-single-pixel-Oct23-2015.sav'
restore,'29-Mar-2014-energies-iris-mgw-single-pixel-Oct23-2015.sav'
restore, '29-Mar-2014-energies-hmi-single-pixel-Oct23-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/HMI-diff-15-Oct-15.sav'


mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-SI-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
plot_map, map1400[495], dmin = 0, dmax = 5000
oplot_ribbon_coords, sicoords1, 1.
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-SI-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
loadct, 3
plot_map, map1400[495], dmin = 0, dmax = 5000
oplot_ribbon_coords, sicoords2, 1.
device,/close
set_plot,mydevice


;;;mg ribbon coord oplots
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-MG-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
plot_map, submg[664], dmin = 0, dmax = 5000
oplot_ribbon_coords, mgcoords1, 1.
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-MG-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
loadct, 3
plot_map, submg[666], dmin = 0, dmax = 5000
oplot_ribbon_coords, mgcoords2, 1.
device,/close
set_plot,mydevice


;;;mgw ribbon coord oplots
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-MGW-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
plot_map, diff2832[166], dmin = 0, dmax = 3000
oplot_ribbon_coords, mgwcoords1, 1.
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-MGW-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
loadct, 3
plot_map, diff2832[167], dmin = 0, dmax = 3000
oplot_ribbon_coords, mgwcoords2, 1.
device,/close
set_plot,mydevice



;;;hmi ribbon coord oplots
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-HMI-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
plot_map, diff[62], dmin = 0, dmax = 2000
oplot_ribbon_coords, hmicoords1, 1.
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-HMI-Ribbon-Coord oplot.eps',/portrait,/encapsulated, decomposed=0,color=1
loadct, 3
plot_map, diff[62], dmin = 0, dmax = 2000
oplot_ribbon_coords, hmicoords2, 1.
device,/close
set_plot,mydevice
end

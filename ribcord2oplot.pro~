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
dir = '/unsafe/jsr2/'+date+'-2015/'
nrb = 20 ; number ribbon coords
time_frames = 2 
npt = 1 + (nrb/time_frames)

iradius = 3.* 0.167;iris qk radius in pixels
sradius = 1. * 0.505;sdo qk radius in pixels

sub_map, map1400, ssi, xrange = [460., 560.], yrange = [220., 320.]
sub_map, submg, smg, xrange = [460., 560.], yrange = [220., 320.]
sub_map, diff2832, smgw, xrange = [470., 560.], yrange = [220., 310.]
sub_map, diff, shmi, xrange = [490., 540.], yrange = [240., 290.]



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

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-45-SI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct,3
plot_map, ssi[494], /log
oplot_ribbon_coords, sicoords1, iradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-46-SI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, ssi[498],  /log
oplot_ribbon_coords, sicoords2, iradius, /box
device,/close
set_plot,mydevice


;;;mg ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-45-MG-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct,3
plot_map, smg[664], /log
oplot_ribbon_coords, mgcoords1, iradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-46-MG-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, smg[666], /log
oplot_ribbon_coords, mgcoords2, iradius, /box
device,/close
set_plot,mydevice


;;;mgw ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-45-MGW-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct,3
plot_map, smgw[166], dmin = 0, dmax = 3000
oplot_ribbon_coords, mgwcoords1, iradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-46-MGW-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, smgw[167], dmin = 0, dmax = 3000
oplot_ribbon_coords, mgwcoords2, iradius, /box
device,/close
set_plot,mydevice



;;;hmi ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-45-HMI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct,3
plot_map, shmi[62], dmin = 0, dmax = 2000
oplot_ribbon_coords, hmicoords1, sradius, /box
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-17-46-HMI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 3
plot_map, shmi[63], dmin = 0, dmax = 2000
oplot_ribbon_coords, hmicoords2, sradius, /box
device,/close
set_plot,mydevice
end

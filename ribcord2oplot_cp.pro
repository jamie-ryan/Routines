pro ribcord2oplot_cp, date

;plots multicoloured crosses over ribbon coords

restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
;restore, '/unsafe/jsr2/'+date+'/hmifullfilt-'+date+'.sav'
;restore, '/unsafe/jsr2/Feb7-2016/hmifullfilt-Feb7-2016.sav'
restore, '/unsafe/jsr2/Sep21-2016/hmi_smth_diff.sav'
dir = '/unsafe/jsr2/'+date+'/'

nrb = 6 ; number ribbon coords

;instrument specific radius (not including central pixel)
iradius = 4.* 0.167;iris qk radius in arcseconds 
sradius = 1. * 0.505;sdo qk radius in arcseconds

sub_map, map1400, ssi, xrange = [460., 560.], yrange = [220., 320.]
sub_map, submg, smg, xrange = [460., 560.], yrange = [220., 320.]
sub_map, diff2832, smgw, xrange = [470., 560.], yrange = [220., 310.]
sub_map, hmidiff, shmi, xrange = [490., 540.], yrange = [240., 290.]



dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coordsfinal.txt' ;eg, flnm=hmicoords1.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor
sicoords = balmercoords
mgcoords = balmercoords
mgwcoords = balmercoords
hmicoords = balmercoords

;;;si ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-Si_IV-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 0
;plot_map, ssi[498],  /log
plot_map, ssi[497],  /log
oplot_ribbon_coords, sicoords, iradius, /box;, /set_2
device,/close
set_plot,mydevice


;;;mg ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-MG_II-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 0
plot_map, smg[662], /log
;plot_map, smg[663], /log
oplot_ribbon_coords, mgcoords, iradius, /box;, /set_2
device,/close
set_plot,mydevice


;;;mgw ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-MG_IIw-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 0
plot_map, smgw[166], dmin = 0, dmax = 3000
oplot_ribbon_coords, mgwcoords, iradius, /box;, /set_2
device,/close
set_plot,mydevice



;;;hmi ribbon Coord-oplots
mydevice=!d.name
set_plot,'ps'
device,filename=dir+'29-Mar-14-HMI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
loadct, 0
;plot_map, shmi[63], dmin = 0, dmax = 2000
plot_map, shmi[62], dmin = 0, dmax = 2000
oplot_ribbon_coords, hmicoords, sradius, /box;, /set_2
device,/close
set_plot,mydevice
end

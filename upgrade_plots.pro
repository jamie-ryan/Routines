pro upgrade_plots



restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'

;hmi and mg2832: unfiltered and diff filtered
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-diff-examples.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
!P.MULTI=[0, 2, 2, 0, 1]
loadct,3
plot_map, sbhmimap[63], Title = 'HMI No Filter'
plot_map,diff[63] ,dmin = 0, dmax = 2000,Title = 'HMI Filtered'
plot_map,map2832[167] ,dmin = 0, dmax = 2000,Title = 'IRIS SJ No Filter'
plot_map, diff2832[167],dmin = 0, dmax = 1000,Title = 'IRIS SJ Filtered'
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct,0
;ribbon coord oplots
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

sub_map, map1400, ssi, xrange = [480., 540.], yrange = [240., 300.]
sub_map, submg, smg, xrange = [480., 540.], yrange = [240., 300.]
sub_map, diff2832, smgw, xrange = [480., 540.], yrange = [240., 300.]
sub_map, diff, shmi, xrange = [480., 540.], yrange = [240., 300.]

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-SI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
!P.MULTI=[0, 2, 1, 0, 1]
loadct,3
plot_map, ssi[494],dmin = 0, dmax = 1000, title = 'Si IV 17:45 Ribbon Samples'
oplot_ribbon_coords, sicoords1, 2
loadct,3
plot_map, ssi[498],dmin = 0, dmax = 1000 ,title = 'Si IV 17:46 Ribbon Samples'
oplot_ribbon_coords, sicoords2, 2
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-MG-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
!P.MULTI=[0, 2, 1, 0, 1]
loadct,3
plot_map, smg[661], dmin = 0, dmax = 5000, title = 'Mg II 17:45 Ribbon Samples'
oplot_ribbon_coords, mgcoords1, 2
loadct,3
plot_map, smg[664],dmin = 0, dmax = 5000,title = 'Mg II 17:46 Ribbon Samples'
oplot_ribbon_coords, mgcoords2, 2
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-MGW-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
!P.MULTI=[0, 2, 1, 0, 1]
loadct,3
plot_map, smgw[166],dmin = 0, dmax = 1000, title = 'Mg II wing 17:45 Ribbon Samples'
oplot_ribbon_coords, mgwcoords1, 2
loadct,3
plot_map, smgw[167],dmin = 0, dmax = 500, title = 'Mg II wing 17:46 Ribbon Samples'
oplot_ribbon_coords, mgwcoords2, 2
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-HMI-Ribbon-Coord-oplot.eps',/portrait,/encapsulated, decomposed=0,color=1, bits=8
!P.MULTI=[0, 2, 1, 0, 1]
loadct,3
plot_map, shmi[62] ,dmin = 0, dmax = 3000, title = 'HMI 17:45 Ribbon Samples'
oplot_ribbon_coords, hmicoords1, 2
loadct,3
plot_map, shmi[63] ,dmin = 0, dmax = 3000, title = 'HMI 17:46 Ribbon Samples'
oplot_ribbon_coords, hmicoords2, 2
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!p.multi = 0
;;balmer continuum spectrum 2825.7 and 2825.8
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-Balmer-Continuum.eps',/landscape,/encapsulated, decomposed=0,color=1, bits=8
plot, sp2826.tag0173.wvl[25:60], sp2826.tag0173.int[25:60,3,435], /xst, title = 'Balmer Continuum Sample', ytitle = 'Relative Intensity [DN Pixel!e-1!n]', xtitle = 'Wavelength ['+angstrom+']'
vert_line, 2825.7, 1
vert_line, 2825.8, 1
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end

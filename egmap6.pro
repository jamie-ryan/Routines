pro egmap6
;The egression data are located: /disk/solar8/sam/29mar14 already. The file is called egmap6_arcsec_masked_lev1.sav
restore,'/disk/solar8/sam/29mar14/egmap6_arcsec_masked_lev1.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmi-16-05-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'

;plot map
lcf = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/diffegmap6.eps',/remove_all)
lcfile = lcf

;titlsi =  strcompress('EGRESSION-MAP' ,/remove_all)
;ytitl = '[DN Pixel!E-1!N]'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;diff
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

;You need to correct for differential rotation, so if you use this command it should do both that, and give you reasonable levels:
;you will get lots of contours, but the most prominent is the quake.
;plot_map,egmap6, /drot
plot_map, diff[64], dmin = -10, dmax = 5000 
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 255

device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;make sbdiff
xa0 = 478
ya0 = 242
xaf = 544
yaf = 278
sub_map, diff, xr=[xa0,xaf], yr=[ya0,yaf], sbdiff


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sbdiff map
lcf = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/sbdiffegmap6.eps',/remove_all)
lcfile = lcf

;titlsi =  strcompress('EGRESSION-MAP' ,/remove_all)
;ytitl = '[DN Pixel!E-1!N]'
mydevice=!d.name
set_plot,'ps'
device,filename=lcfile,/portrait,/encapsulated, decomposed=0,color=1

;plot_map,sbegmap6,/drot
plot_map, sbdiff[64], dmin = -10, dmax = 5000
plot_map,sbegmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 255

device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;hmi unprocessed
plot_map, sbhmimap[64]
plot_map,sbegmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 255


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;mgII
loadct,3
plot_map, submg[166], dmin = 0, dmax = 2000, title = 'IRIS SJ Chromosphere'
plot_map,sbegmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 255

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end

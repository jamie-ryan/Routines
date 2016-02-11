pro sunquake_context_plots

;detailed sunquake analysis


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;restore save files;;;;;;;;;;;;;;;;;;
restore, '/unsafe/jsr2/iris-16-03-15.sav'
;restore, '/unsafe/jsr2/'+date+'/hmifullfilt-'+date+'.sav'
restore, '/unsafe/jsr2/Feb7-2016/hmifullfilt-Feb7-2016.sav'
date = 'Feb10-2016'
restore, '/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav'
restore, '/disk/solar8/sam/29mar14/egmap6_arcsec_masked_lev1.sav'
restore, '/disk/solar3/jsr2/Data/SDO/he_fe_hxr_egress_maps.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmap50.sav'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;locate wl kernel over sunquake
plot_map, map1400[496] ;17:45:31
linecolors ;activate coloured lines in oplot

plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 

;oplot a cross over sunquake location
oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0

plot_map, submg[661] ;17:45:31
linecolors ;activate coloured lines in oplot

plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 

;oplot a cross over sunquake location
oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0

plot_map, hmidiff[62] ;17:45:31
linecolors ;activate coloured lines in oplot
;oplot a cross over sunquake location
oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;ZOOMED (same as sarah's paper);;;;;;;;;;
;;;make sub map of sunquake region;;;;;
sub_map, map1400, ssib, xrange = [450., 590.], yrange = [240.,340.]  
sub_map, submg, smgb, xrange = [450., 590.], yrange = [240.,340.]  
sub_map, diff2832, smgwb, xrange = [450., 590.], yrange = [240.,340.]  
sub_map, hmidiff, shmib, xrange = [450., 590.], yrange = [240.,340.]  

!p.multi = [0,2,2]
loadct, 0
;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, ssib[498] ;17:46:21 directly over quake in egmap6
linecolors ;activate coloured lines in oplot
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
;xyouts, , , charsize = 0.3, 'IRIS Si IV', /norm
;oplot a cross over sunquake location
;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, smgb[663] ;17:46:04  directly over quake in egmap6
linecolors ;activate coloured lines in oplot
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
;xyouts, , , charsize = 0.3, 'IRIS Mg II', /norm
;oplot a cross over sunquake location
;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MGW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, smgwb[166] ;17:45:55 directly over quake in egmap6
linecolors ;activate coloured lines in oplot
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
;xyouts, , , charsize = 0.3, 'IRIS Mg II wing', /norm
;oplot a cross over sunquake location
;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, shmib[63] ;17:46:16  directly over quake in egmap6
linecolors ;activate coloured lines in oplot
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
;xyouts, , , charsize = 0.3, 'SDO HMI Fe ??', /norm
;oplot a cross over sunquake location
;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
!p.multi = [0,1,1]

;;;;;;;;;;;;SUPER ZOOMED;;;;;;;;;;
;;;make sub map of sunquake region;;;;;
sub_map, map1400, ssi, xrange = [514., 524.], yrange = [257.,267.]
sub_map, submg, smg, xrange = [514., 524.], yrange = [257.,267.]
sub_map, diff2832, smgw, xrange = [514., 524.], yrange = [257.,267.]
sub_map, hmidiff, shmi, xrange = [514., 524.], yrange = [257.,267.]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;locate wl kernel over zoomed sunquake
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, ssi[496] ;17:45:31
linecolors ;activate coloured lines in oplot

plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 

;oplot a cross over sunquake location
oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, smg[663] ;17:46:  directly over quake in egmap6
linecolors ;activate coloured lines in oplot

plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 

;oplot a cross over sunquake location
oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MGW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, smgw[166] ;17:45:31
linecolors ;activate coloured lines in oplot

plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 

;oplot a cross over sunquake location
oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;HMI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, shmi[62] ;17:45:31
linecolors ;activate coloured lines in oplot

plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 

;oplot a cross over sunquake location
oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





end

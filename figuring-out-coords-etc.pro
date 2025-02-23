;IDL> print, t_x_pos[*, 23]
;2014-03-29T17:45:36 2014-03-29T17:45:45 2014-03-29T17:45:55 2014-03-29T17:46:04 2014-03-29T17:46:13 2014-03-29T17:46:23 2014-03-29T17:46:32 2014-03-29T17:46:41   
;IDL> print, iris_x_pos[*, 23]
;512.183      514.179      516.174      518.219      520.215      522.212      524.256      526.252
;south ribbon based on 40% contour starts at 517" and extends east until 527"
;518.219      520.215      522.212      524.256      526.252
;262.0        262.0        262.0        265.0        263.81753


;hmicoords.txt
518.219         262.00000
520.215         263.00000
522.212         262.00000
522.212         265.00000
524.256         265.00000
526.252         263.81753



restore, '/unsafe/jsr2/iris-16-03-15.sav'                                                         
restore, '/unsafe/jsr2/Feb12-2016/hmifullfilt-Feb12-2016.sav'                  
restore, '/unsafe/jsr2/Feb13-2016/balm_data-Feb13-2016.sav'                    
restore, '/disk/solar3/jsr2/Data/SDO/he_fe_hxr_egress_maps.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmap50.sav

dataset = ['hmi']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coords.txt' ;eg, flnm=hmicoords.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor


sub_map, hmidiff, shmi, xrange = [504., 534.], yrange = [257.,277.]
sub_map, diff2832, smgw, xrange = [504., 534.], yrange = [257.,277.]
sub_map, submg, smg, xrange = [504., 534.], yrange = [257.,277.]
sub_map, map1400, ssi, xrange = [504., 534.], yrange = [257.,277.]

sub_map, hmidiff, shmi, xrange = [504., 534.], yrange = [257.,277.]

sub_map, hmidiff, shmib, xrange = [490., 540.], yrange = [240.,290.]

iradius = 4.* 0.167;iris qk radius in arcseconds 
sradius = 1. * 0.505;sdo qk radius in arcseconds

;colours


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;HMI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;show hmi sub map, with ribbon contours and sunquake contour.
loadct, 0
window,0
plot_map, shmi[62]
linecolors ;activate coloured lines in oplot
plot_map, shmi[62], /over, /percent, levels = [40, 50, 60, 70, 80]
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
oplot_ribbon_coords, hmicoords, sradius, /cross
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot_map, shmib[62]
linecolors ;activate coloured lines in oplot
plot_map, shmib[62], /over, /percent, levels = [40, 50, 60, 70, 80]
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
oplot_ribbon_coords, hmicoords, sradius, /cross


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MGW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 0
window, 1
plot_map, smgw[166]
linecolors ;activate coloured lines in oplot
plot_map, shmi[62],/drot, /over, /percent, levels = [40, 50, 60, 70, 80]
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
oplot_ribbon_coords, hmicoords, iradius, /cross
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 0
window, 2
plot_map, smgw[166]
linecolors ;activate coloured lines in oplot
plot_map, shmi[62],/drot, /over, /percent, levels = [40, 50, 60, 70, 80]
plot_map,segmap6,/over,levels=[1.2,1.5,2,2.4], color = 10, thick = 1 
oplot_ribbon_coords, hmicoords, iradius, /cross
loadct, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 0
window, 2
plot_map, smg[662]
linecolors ;activate coloured lines in oplot
plot_map, shmi[62],/drot, /over, /percent, levels = [40, 50, 60, 70, 80]
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
oplot_ribbon_coords, hmicoords, iradius, /cross
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 0
window, 3
plot_map, ssi[497]
linecolors ;activate coloured lines in oplot
plot_map, shmi[62],/drot, /over, /percent, levels = [40, 50, 60, 70, 80]
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
oplot_ribbon_coords, hmicoords, iradius, /cross
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;loadct, 3
!p.thick=3 ;data
!x.thick=2 ;x axis
!y.thick=2 ;y axis
flnm = '/unsafe/jsr2/'+date+'/H&K_slit4_y447_replica_without_preflare_subtract.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
cs=1 	;charcter size

utplot, times[3,*], balmdat_bk_subtracted[3,447,*], ytitle = 'DN', $
title = 'H&K slit = 4 y = 447 replica, without preflare subtract', $
timerange = '29-Mar-14 '+['17:30:00','17:53:00']


device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 	







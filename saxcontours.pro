pro saxcontours
;sax = sunspots, acoustic, xray
;The variable hmap has the 25-50 keV emission, and hmap50 is 50-100 keV. The image times will be in the time array. You can plot them like any other map structure.


;restore,'hmi-20-02-15.sav' 
;restore,'iris-20-02-15.sav' 
;restore, 'hmi-16-03-15.sav'
;restore, '/disk/solar8/sam/29mar14/sji_mgii_saub.sav'
;restore, '/disk/solar8/sam/29mar14/sji_1400map.sav'

restore, '/disk/solar8/sam/29mar14/egmap6_arcsec_masked_lev1.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmi-16-05-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/he_fe_hxr_egress_maps.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmap50.sav'
restore, '/disk/solar3/jsr2/Data/SDO/SJ2832.sav'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'

;map2index,diff , dindex, difftmp
;#61
;xx0 = 148.69038
;xxf = 190.55605
;yy0 = 114.96064
;yyf = 134.7516
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,61] lt 689, /NULL)] = 0
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,61] gt 700, /NULL)] = 0
;difftmp[0:xx0,*,61] = 0
;difftmp[xxf:*,*,61] = 0
;difftmp[xx0:xxf,yyf:*,61] = 0
;difftmp[xx0:xxf, 0:yy0,61] = 0

;#62
;xx0 = 127.16363
;xxf = 179.09696
;yy0 = 103.99830
;yyf = 140.73163
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,62] lt 1799, /NULL)] = 0
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,62] gt 3000, /NULL)] = 0
;difftmp[0:xx0,*,62] = 0
;difftmp[xxf:*,*,62] = 0
;difftmp[xx0:xxf,yyf:*,62] = 0
;difftmp[xx0:xxf, 0:yy0,62] = 0

;#63
;xx0 = 17
;xxf = 85
;yy0 = 64
;yyf = 107
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,63] lt 1799, /NULL)] = 0
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,63] gt 2000, /NULL)] = 0
;difftmp[0:xx0,*,63] = 0
;difftmp[xxf:*,*,63] = 0
;difftmp[xx0:xxf,yyf:*,63] = 0
;difftmp[xx0:xxf, 0:yy0,63] = 0

;#64
;xx0 = 160.86949
;xxf = 184.46651
;yy0 = 105.06512
;yyf = 123.33377
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,64] lt 999, /NULL)] = 0
;difftmp[WHERE(difftmp[xx0:xxf,yy0:yyf,64] gt 3300, /NULL)] = 0
;difftmp[0:xx0,*,64] = 0
;difftmp[xxf:*,*,64] = 0
;difftmp[xx0:xxf,yyf:*,64] = 0
;difftmp[xx0:xxf, 0:yy0,64] = 0

;index2map, dindex, difftmp, difftmpmap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;CONTEXT CONTOUR PLOTS
;;;RHESSI, ACOUSTIC POWER AND SUNSPOT CONTOURS
;
;Plot #1
;17:44:48

mydevice=!d.name
set_plot,'ps'
device,filename='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/hmi-contours.eps',/portrait,/encapsulated, $
decomposed=0,color=1, bits = 8		
;!P.MULTI = [0, 2, 1]

;;;HMI, no processing, no sunspot contours
loadct,3 ;red = intensity map
plot_map, sbhmimap[63], title = 'SDO HMI 6173'+angstrom
loadct,0 ;prism
plot_map, hmap[0], /over, /drot, color = 0, thick = 1 ;soft xray 20-25keV = black
loadct,6 ;prism
plot_map, hmap50[0], /over, /drot, color = 123, thick = 1 ;hard xray 50-100keV = green
loadct,6 ;prism
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 170, thick = 1 ;acoustic power = blue
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


mydevice=!d.name
set_plot,'ps'
device,filename='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-mgiiw-contours.eps',/portrait,/encapsulated, $
decomposed=0,color=1, bits = 8


;;;IRIS 2832, no processing, no sunspot contours
loadct,3 ;red = intensity map
plot_map, map2832[168],/log, title = 'IRIS SJI 2832'+angstrom
loadct,0 ;prism
plot_map, hmap[0], /over, /drot, color = 0, thick = 1 ;soft xray 20-25keV 
loadct,6 ;prism 
plot_map, hmap50[0], /over, /drot, color = 123, thick = 1 ;hard xray 50-100keV $
loadct,6 ;prism
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 170, thick = 1 
device,/close
set_plot,mydevice




;;;;;;;;;;;;;;;;;;
mydevice=!d.name
set_plot,'ps'
device,filename='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/diff-contours.eps',/portrait,/encapsulated, $
decomposed=0,color=1, bits = 8				

;;;HMI diff
loadct, 3 ; intensity
;plot_map, difftmpmap[63], dmin = 1800, dmax = 2000, title = 'SDO HMI Difference'
plot_map, diff[63], dmin =2000, dmax = 16000 ;, title = 'HMI Photosphere Difference'
loadct,0 ;red-purple
plot_map, hmap[0], /over, /drot, color = 200, thick = 1 ;soft xray 20-25keV = grey
loadct,6 ;prism
plot_map, hmap50[0], /over, /drot, color = 123, thick = 1 ;hard xray 50-100keV = green
loadct,4 ;greyscale 
plot_map, sbhmimap[63], /over, levels = [15000,30000], color = 255, thick = 1 ;sunspots = white
loadct,6 ;prism
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 170, thick = 1 ;acoustic power = blue

device,/close
set_plot,mydevice



;;;;;;;;;;;;;;;;;
mydevice=!d.name
set_plot,'ps'
device,filename='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-mgii-contours.eps',/portrait,/encapsulated, $
decomposed=0,color=1, bits = 8				

;;;mgII
loadct,3 ; intensity
plot_map, submg[164], /log , title = 'IRIS SJ 2796'+angstrom
loadct,0 ;blue/green/red/yellow = xray 20-25keV
plot_map, hmap[0], /over, /drot, color = 255 , thick = 1 ;soft xray 20-25keV = white
loadct,6 ;prism
plot_map, hmap50[0], /over, /drot, color = 123 , thick = 1 ;hard xray 50-100keV = green
loadct,4 ;greyscale 
plot_map, sbhmimap[63], /over, levels = [15000,30000] , color = 255, thick = 1 ;sunspots = white
loadct,6 ;prism
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 170 , thick = 1 ;acoustic power = blue

device,/close
set_plot,mydevice

;;;;;;;;;;;;;;;
mydevice=!d.name
set_plot,'ps'
device,filename='/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-siiv-contours.eps',/portrait,/encapsulated, $
decomposed=0,color=1, bits = 8				


;;;siIV
loadct,3 ; intensity
plot_map, map1400[498], /log , title = 'IRIS SJ 1400'+angstrom
loadct,0 ;blue/green/red/yellow = xray 20-25keV
plot_map, hmap[0], /over, /drot, color = 200 , thick = 1 ;soft xray 20-25keV = grey
loadct,6 ;prism
plot_map, hmap50[0], /over, /drot, color = 123 , thick = 1 ;hard xray 50-100keV = green
loadct,4 ;greyscale 
plot_map, sbhmimap[63], /over, levels = [15000,30000] , color = 255, thick = 1 ;sunspots = yellow
loadct,6 ;prism
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 170 , thick = 1;acoustic power = blue

;xyouts, 0.25, 0.38, 'Sunspot Contours', /norm, color = 255
device,/close
set_plot,mydevice


end

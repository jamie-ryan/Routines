pro mgii_context_plot, date
restore, '/disk/solar8/sam/29mar14/egmap6_arcsec_masked_lev1.sav'
restore, '/disk/solar3/jsr2/Data/SDO/he_fe_hxr_egress_maps.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmap50.sav'
restore, '/unsafe/jsr2/iris-16-03-15.sav'
;restore, '/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav'

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

;sub_map, submg, smgb, xrange = [450., 590.], yrange = [240.,340.]
sub_map, submg, smgbig, xrange = [490., 530.], yrange = [250.,290.]
sub_map, submg, smgsmall, xrange = [515., 527.], yrange = [259.,271.]

;oplot_ribbon_coords

iradius = 2

;!p.thick=1 ;data
;!x.thick=1 ;x axis
;!y.thick=1 ;y axis
;!p.font=0
!p.multi = [0,2,1]			;use postscript fonts
flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-MGII-Sunquake-Context-Plots-xx-Zoom.eps'
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
landscape=0, decomposed=0, color=1, bits=8
cs=1 	;charcter size


ctload, 3, /reverse
;PLOT 1) SMGBIG
plot_map, smgbig[663], dmin = 0 , dmax = 17000  ;;17:46:04  directly over quake in egmap6
linecolors ;activate coloured lines in oplot
; INDEX NUMBER   COLOR PRODUCED (if use default colors)
; 	0		black
;	1		maroon
;	2               red
;	3		pink
;	4		orange
;	5		yellow
;	6		olive
;	7		green
;	8		dark green
;	9		cyan
;	10		blue
;	11		dark blue
;	12              magenta
;	13              purple
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 9 ;cyan sunquake
plot_map, hmap[0], /over, /drot, color = 7, levels = [0.8], /percent ;green hard xray 20-25keV
plot_map, hmap50[0], /over, /drot, color = 2, levels = [0.8], /percent ;blue hard xray 50-100keV
;this box relates to smgsmall
oplot, [515., 527.], [259., 259.], color = 11
oplot, [515., 515.], [259., 271.], color = 11
oplot, [515., 527.], [271., 271.], color = 11
oplot, [527., 527.], [259., 271.], color = 11
;inverse colour table :D
ctload, 3, /reverse
;PLOT 2) SMGSMALL
plot_map, smgsmall[663], dmin = 0 , dmax = 17000;;17:46:04  directly over quake in egmap6
linecolors ;activate coloured lines in oplot
plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 9 ;cyan sunquake
XYouts, 520.2, 261.9, 'SQ', COLOR=FSC_Color('red'), ALIGN=0.5, CHARSIZE=0.65
;plot_map, hmap[0], /over, /drot, color = 4 ;orange hard xray 20-25keV 
;plot_map, hmap50[0], /over, /drot, color = 2 ;red hard xray 50-100keV 
oplot_ribbon_coords, balmercoords, iradius, /cross
loadct, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 		
end

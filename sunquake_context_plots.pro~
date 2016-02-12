pro sunquake_context_plots, date, qksource1 = qksource1, qksource2 = qksource2, no = no, 1x = 1x, 2x = 2x

;no = default map size in sav file
;1x = 1X zoom
;2x = 2x zoom 

;detailed sunquake context plots including sunquake egression and hxr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;restore save files;;;;;;;;;;;;;;;;;;
restore, '/unsafe/jsr2/iris-16-03-15.sav'
;restore, '/unsafe/jsr2/'+date+'/hmifullfilt-'+date+'.sav'
restore, '/unsafe/jsr2/Feb11-2016/hmifullfilt-Feb11-2016.sav'
date = 'Feb10-2016'
restore, '/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav'
restore, '/disk/solar8/sam/29mar14/egmap6_arcsec_masked_lev1.sav'
restore, '/disk/solar3/jsr2/Data/SDO/he_fe_hxr_egress_maps.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmap50.sav'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if keyword_set(qksource1) then begin
    if keyword_set(no) then begin
        ;;;;;;;;;;;;;PLOT EPS
        ;;;need to attch to each plot for eps
        loadct, 3
        !p.thick=3 ;data
        !x.thick=2 ;x axis
        !y.thick=2 ;y axis
        flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-Sunquake-Context-Plots-No-Zoom.eps'
        !p.font=0			;use postscript fonts
        set_plot, 'ps'
        device, filename= flnm, encapsulated=eps, $
        /helvetica,/isolatin1, landscape=0, color=1
        cs=1 	;charcter size


        ;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, map1400[498] ;;17:46:21 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV = black
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV = green
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0


        ;MG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, submg[663] ;;17:46:04  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0

        ;MGW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, diff2832[166] ;;17:45:55 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV = black
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV = green
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0

        ;HMI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, hmidiff[63] ;17:46:16  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV = black
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV = green
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        device,/close
        set_plot,'x'
        !p.font=-1 			;go back to default (Vector Hershey fonts)
        loadct,0 			;go back to default greyscale color table
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;PLOT END;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        !p.multi = [0,1,1]
    endif

    ;--------------------------------------------------------------
    if keyword_set(1x) then begin
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;ZOOMED (same as sarah's paper);;;;;;;;;;
        ;;;make sub map of sunquake region;;;;;
        sub_map, map1400, ssib, xrange = [450., 590.], yrange = [240.,340.]  
        sub_map, submg, smgb, xrange = [450., 590.], yrange = [240.,340.]  
        sub_map, diff2832, smgwb, xrange = [450., 590.], yrange = [240.,340.]  
        sub_map, hmidiff, shmib, xrange = [450., 590.], yrange = [240.,340.]  
        ;;;;;;;;PLOT EPS
        loadct, 3
        !p.thick=3 ;data
        !x.thick=2 ;x axis
        !y.thick=2 ;y axis
        !p.multi = [0,2,2] ;plot 4 maps on same page
        !p.font=0			;use postscript fonts
        flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-Sunquake-Context-Plots-2X-Zoom.eps'
        set_plot, 'ps'
        device, filename= flnm, encapsulated=eps, $
        /helvetica,/isolatin1, landscape=0, color=1
        cs=1 	;charcter size


        ;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, ssib[498] ;17:46:21 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
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
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
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
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
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
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;xyouts, , , charsize = 0.3, 'SDO HMI Fe I', /norm
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        device,/close
        set_plot,'x'
        !p.font=-1 			;go back to default (Vector Hershey fonts)
        loadct,0 			;go back to default greyscale color table
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;END OF PLOT;;;;;;;;;;;;;;;;;;
        !p.multi = [0,1,1]
    endif




    if keyword_set(2x) then begin
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
        loadct, 3
        !p.thick=3 ;data
        !x.thick=2 ;x axis
        !y.thick=2 ;y axis
        !p.multi = [0,2,2] ;plot 4 maps on same page
        !p.font=0			;use postscript fonts
        flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-Sunquake-Context-Plots-3X-Zoom.eps'
        set_plot, 'ps'
        device, filename= flnm, encapsulated=eps, $
        /helvetica,/isolatin1, landscape=0, color=1
        cs=1 	;charcter size

        ;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, ssi[498] ;17:46:21 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;MG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, smg[663] ;17:46:04  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;MGW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, smgw[166] ;17:45:55 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;HMI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, shmi[63] ;17:46:16  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        device,/close
        set_plot,'x'
        !p.font=-1 			;go back to default (Vector Hershey fonts)
        loadct,0 			;go back to default greyscale color table
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;END OF PLOT;;;;;;;;;;;;;;;;;;
        !p.multi = [0,1,1]
    endif
endif
if keyword_set(qksource2) then begin
;same again for source 2
    if keyword_set(no) then begin
        ;;;;;;;;;;;;;PLOT EPS
        ;;;need to attch to each plot for eps
        loadct, 3
        !p.thick=3 ;data
        !x.thick=2 ;x axis
        !y.thick=2 ;y axis
        flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-Sunquake-Context-Plots-No-Zoom.eps'
        !p.font=0			;use postscript fonts
        set_plot, 'ps'
        device, filename= flnm, encapsulated=eps, $
        /helvetica,/isolatin1, landscape=0, color=1
        cs=1 	;charcter size


        ;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, map1400[498] ;;17:46:21 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV = black
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV = green
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0


        ;MG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, submg[663] ;;17:46:04  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0

        ;MGW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, diff2832[166] ;;17:45:55 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV = black
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV = green
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0

        ;HMI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, hmidiff[63] ;17:46:16  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV = black
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV = green
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        device,/close
        set_plot,'x'
        !p.font=-1 			;go back to default (Vector Hershey fonts)
        loadct,0 			;go back to default greyscale color table
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;PLOT END;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    !p.multi = [0,1,1]
    endif

    ;--------------------------------------------------------------
    if keyword_set(1x) then begin
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;ZOOMED (same as sarah's paper);;;;;;;;;;
        ;;;make sub map of sunquake region;;;;;
        sub_map, map1400, ssib, xrange = [450., 590.], yrange = [240.,340.]  
        sub_map, submg, smgb, xrange = [450., 590.], yrange = [240.,340.]  
        sub_map, diff2832, smgwb, xrange = [450., 590.], yrange = [240.,340.]  
        sub_map, hmidiff, shmib, xrange = [450., 590.], yrange = [240.,340.]  
        ;;;;;;;;PLOT EPS
        loadct, 3
        !p.thick=3 ;data
        !x.thick=2 ;x axis
        !y.thick=2 ;y axis
        !p.multi = [0,2,2] ;plot 4 maps on same page
        !p.font=0			;use postscript fonts
        flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-Sunquake-Context-Plots-2X-Zoom.eps'
        set_plot, 'ps'
        device, filename= flnm, encapsulated=eps, $
        /helvetica,/isolatin1, landscape=0, color=1
        cs=1 	;charcter size


        ;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, ssib[498] ;17:46:21 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
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
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
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
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
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
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;xyouts, , , charsize = 0.3, 'SDO HMI Fe ??', /norm
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        device,/close
        set_plot,'x'
        !p.font=-1 			;go back to default (Vector Hershey fonts)
        loadct,0 			;go back to default greyscale color table
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;END OF PLOT;;;;;;;;;;;;;;;;;;
    !p.multi = [0,1,1]    
    endif





    if keyword_set(2x) then begin
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
        loadct, 3
        !p.thick=3 ;data
        !x.thick=2 ;x axis
        !y.thick=2 ;y axis
        !p.multi = [0,2,2] ;plot 4 maps on same page
        !p.font=0			;use postscript fonts
        flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-Sunquake-Context-Plots-3X-Zoom.eps'
        set_plot, 'ps'
        device, filename= flnm, encapsulated=eps, $
        /helvetica,/isolatin1, landscape=0, color=1
        cs=1 	;charcter size

        ;SI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, ssi[498] ;17:46:21 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;MG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, smg[663] ;17:46:04  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;MGW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, smgw[166] ;17:45:55 directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ;HMI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        plot_map, shmi[63] ;17:46:16  directly over quake in egmap6
        linecolors ;activate coloured lines in oplot
        plot_map,egmap6,/over,levels=[1.2,1.5,2,2.4],/drot, color = 10, thick = 1 
        plot_map, hmap[0], /over, /drot, color = 15, thick = 1 ;soft xray 20-25keV 
        plot_map, hmap50[0], /over, /drot, color = 12, thick = 1 ;hard xray 50-100keV 
        ;oplot a cross over sunquake location
        ;oplot, [521.5,516.5], [259.5, 264.5], color =3, thick = 2
        ;oplot, [516.5,521.5], [259.5, 264.5], color =3, thick = 2
        loadct, 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        device,/close
        set_plot,'x'
        !p.font=-1 			;go back to default (Vector Hershey fonts)
        loadct,0 			;go back to default greyscale color table
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;END OF PLOT;;;;;;;;;;;;;;;;;;
        !p.multi = [0,1,1]
    endif
endif


end

pro justladder
;###TO DO
;1)split ribbon energy distribution plots to see x-axis values
;2)ribbon energy distribution plots, sort x-axis title positioning
;3)sort red dotted line...why is it b&w?



restore,'29-Mar-2014-energies-iris-siiv-single-pixel-Oct23-2015.sav'
restore,'29-Mar-2014-energies-iris-mgii-single-pixel-Oct23-2015.sav'
restore,'29-Mar-2014-energies-iris-balmer-single-pixel-Oct23-2015.sav'
restore,'29-Mar-2014-energies-iris-mgw-single-pixel-Oct23-2015.sav'
restore, '29-Mar-2014-energies-hmi-single-pixel-Oct23-2015.sav'

npix = 10
frame = 2
sidata = fltarr(frame,npix,n_elements(tsi))
mgdata = fltarr(frame,npix,n_elements(tmg))
balmerdata = fltarr(frame,npix,n_elements(tspqk))
mgwdata = fltarr(frame,npix,n_elements(tmgw))
hmidata = fltarr(frame,npix,n_elements(thmi))

;fill arrays
for x = 0, 9 do begin
    xy = string(x, format = '(I0)')
    com = 'sidata[0,x,*] = esirb'+xy
    exe = execute(com)
    com = 'mgdata[0,x,*] = emgrb'+xy
    exe = execute(com)
    com = 'balmerdata[0,x,*] = ebalmerrb'+xy
    exe = execute(com)
    com = 'mgwdata[0,x,*] = emgwrb'+xy
    exe = execute(com)
    com = 'hmidata[0,x,*] = ehmirb'+xy
    exe = execute(com)
       print, 'flag1'
endfor
for x = 10, 19  do begin
    xy = string(x, format = '(I0)')
    com = 'sidata[1,x-10,*] = esirb'+xy
    exe = execute(com)
    com = 'mgdata[1,x-10,*] = emgrb'+xy
    exe = execute(com)
    com = 'balmerdata[1,x-10,*] = ebalmerrb'+xy
    exe = execute(com)
    com = 'mgwdata[1,x-10,*] = emgwrb'+xy
    exe = execute(com)
    com = 'hmidata[1,x-10,*] = ehmirb'+xy
    exe = execute(com)
       print, 'flag2'
endfor

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]' 
;;;make plots
plot_pos_calc, n_plots = 5, xpos, ypos
base = '29-Mar-14 17:26:00'
sec = 19.*60. ;location in seconds for vertical line...17:45 - 17:26 = 19 mins...19mins*60secs
for j = 0, frame-1 do begin
    for i = 0, npix-1 do begin
        ;make filename
        jj = string(j+1, format = '(I0)')
        ii = string(i+1, format = '(I0)')
        fff = '29-Mar-14-Ribbon-Position-'+ii+'-Frame-'+jj+'-Energy-Ladder.eps'


        mydevice=!d.name
        set_plot,'ps'
        ;device,filename=fff,/portrait,/encapsulated, decomposed=0,color=1, bits = 8
        device,filename=fff,/portrait,/encapsulated, decomposed=0,/color, bits = 8
        o = 4
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Ribbon-Energy' ,/remove_all)
        ytitl = energy
        utplot, tsi[447:*], sidata[j,i,447:*], $ 
        base, $
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
        linestyle = 0, $
        ycharsize = 0.65, $
        xcharsize = 0.65, $
        xstyle = 8, $
        ytitle = ytitl, $
        /nolabel, $
        ytickname=[' '], $
        yticks = 2, $
        XTICKFORMAT="(A1)", $
        /ynoz, $
        ;/ylog, $
        xmargin = [12,3], $
        position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]]
        loadct,3
        vert_line,sec,1, color = 100
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

        o = 3
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        utplot, tmg[595:*], mgdata[j,i,597:*], $ ;583
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
        linestyle = 0, $
        ycharsize = 0.65, $
        xcharsize = 0.65, $
        xstyle = 8, $
        ytitle = ytitl, $
        /nolabel, $
        ytickname=[' '], $
        yticks = 2, $
        XTICKFORMAT="(A1)", $
        /ynoz, $
        ;/ylog, $
        xmargin = [12,3], $
        position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
        /NoErase
        loadct,3
        vert_line,sec,1, color = 100
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

        o = 2
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        utplot, tspqk[12:*], balmerdata[j,i,12:*], $
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
        linestyle = 0, $
        ycharsize = 0.65, $
        xcharsize = 0.65, $
        xstyle = 8, $
        ytitle = ytitl, $
        /nolabel, $
        yticks = 2, $
        ytickname=[' '], $
        XTICKFORMAT="(A1)", $
        /ynoz, $
        ;/ylog, $
        xmargin = [12,3], $
        position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
        /NoErase
        loadct,3
        vert_line,sec,1, color = 100
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

        o = 1
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        utplot, tmgw[150:*], mgwdata[j,i,150:*], $
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
        linestyle = 0, $
        ycharsize = 0.65, $
        xcharsize = 0.65, $
        xstyle = 8, $
        ytitle = ytitl, $
        /nolabel, $
        yticks = 2, $
        ytickname=[' '], $
        XTICKFORMAT="(A1)", $
        /ynoz, $
        ;/ylog, $
        xmargin = [12,3], $
        position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
        /NoErase
        loadct,3
        vert_line,sec,1, color = 100
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

        o = 0
        xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        utplot, thmi[36:78], hmidata[j,i,36:78], $
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
        linestyle = 0, $
        ycharsize = 0.65, $
        xcharsize = 0.65, $
        xstyle = 8, $
        yticks = 2, $
        ytickname=[' '], $
        ytitle = ytitl, $
        /ynoz, $
        ;/ylog, $
        xmargin = [12,3], $
        position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
        /NoErase
        loadct,3
        vert_line,sec,1, color = 100
        loadct,0
        xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
        device,/close
        set_plot,mydevice
    endfor
endfor

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-Quake-Energy-Ladder.eps',/portrait,/encapsulated, decomposed=0,color=1
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Quake-Energy' ,/remove_all)
ytitl = energy
utplot, tsi[447:*], esiqk[447:*], $ 
base, $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]]
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
utplot, tmg[595:*], emgqk[597:*], $ ;583
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
utplot, tspqk[12:*], ebalmerqk[12:*], $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
utplot, tmgw[150:*], emgwqk[150:*], $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
utplot, thmi[36:78], ehmiqk[36:78], $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-South-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color=1
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-17:45-South-Ribbon-Energy-Distribution' ,/remove_all)
ytitl = energy
xtitl = 'Ribbon Length [arcsec]'
plot, siemx[1,0:4], siemx[2,0:4], $ 
;base, $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]]

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,0:4], mgemx[2,0:4], $ 
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,0:4], balmeremx[2,0:4], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,0:4], mgwemx[2,0:4], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,0:4], hmiemx[2,0:4], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-North-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color=1
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-17:45-North-Ribbon-Energy-Distribution' ,/remove_all)
ytitl = energy
xtitl = 'Ribbon Length [arcsec]'
plot, siemx[1,5:9], siemx[2,5:9], $ 
;base, $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]]

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,5:9], mgemx[2,5:9], $ 
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,5:9], balmeremx[2,5:9], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,5:9], mgwemx[2,5:9], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,5:9], hmiemx[2,5:9], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-South-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color=1
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-17:46-South-Ribbon-Energy-Distribution' ,/remove_all)
ytitl = energy
xtitl = 'Ribbon Length [arcsec]'
plot, siemx[1,10:14], siemx[2,10:14], $ 
;base, $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]]

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,10:14], mgemx[2,10:14], $ 
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,10:14], balmeremx[2,10:14], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,10:14], mgwemx[2,10:14], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,10:14], hmiemx[2,10:14], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-North-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color=1
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-17:46-North-Ribbon-Energy-Distribution' ,/remove_all)
ytitl = energy
xtitl = 'Ribbon Length [arcsec]'
plot, siemx[1,15:19], siemx[2,15:19], $ 
;base, $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]]

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,15:19], mgemx[2,15:19], $ 
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,15:19], balmeremx[2,15:19], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,15:19], mgwemx[2,15:19], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,15:19], hmiemx[2,15:19], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.65, $
xcharsize = 0.65, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice





end
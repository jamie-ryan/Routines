;BALMEREMX       FLOAT     = Array[3, 20]
BALMEREMXQK

siemxqk
mgemxqk
balmeremxqk
mgwemxqk
hmiemxqk

siemx
mgemx
balmeremx
mgwemx
hmiemx

plot_pos_calc, n_plots = 5, xpos, ypos
base = '29-Mar-14 17:26:00'
sec = 19.*60. ;location in seconds for vertical line...17:45 - 17:26 = 19 mins...19mins*60secs
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Ribbon-Energy' ,/remove_all)
ytitl = energy
utplot, siemx[], siemx[], $ 
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
utplot, mgemx[], mgemx[], $ ;583
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
utplot, balmeremx[], balmeremx[], $
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
utplot, mgwemx[], mgwemx[], $
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
utplot, hmiemx[], hmiemx[], $
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


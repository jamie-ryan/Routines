pro ribbon_energy_dist_ladder

restore,'29-Mar-2014-energies-iris-siiv-single-pixel-Oct27-2015.sav'
restore,'29-Mar-2014-energies-iris-mgii-single-pixel-Oct27-2015.sav'
restore,'29-Mar-2014-energies-iris-balmer-single-pixel-Oct27-2015.sav'
restore,'29-Mar-2014-energies-iris-mgw-single-pixel-Oct27-2015.sav'
restore, '29-Mar-2014-energies-hmi-single-pixel-Oct27-2015.sav'

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'
npix = 10
frame = 2
offset = 0.03
plot_pos_calc, n_plots = 5, xpos, ypos
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-South-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
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
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
;ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o], xpos[1], ypos[1,o]]
xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 1400 '+angstrom, /norm
;y2 = AXIS('Y', location ='right', TITLE =  'IRIS SJ 1400 ',major = 0, minor = 0)
;AXIS,YAXIS=1, charsize = 0.4, YTITLE =  'IRIS SJ 1400 ',major = 0, minor = 0

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,0:4], mgemx[2,0:4], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,0:4], balmeremx[2,0:4], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.98*xyx, 1.015*xyy, charsize = 0.4, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,0:4], mgwemx[2,0:4], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,0:4], hmiemx[2,0:4], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.4, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-45-North-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
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
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]]

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,5:9], mgemx[2,5:9], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,5:9], balmeremx[2,5:9], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.98*xyx, 1.015*xyy, charsize = 0.4, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,5:9], mgwemx[2,5:9], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,5:9], hmiemx[2,5:9], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.4, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-South-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
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
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]]

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,10:14], mgemx[2,10:14], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,10:14], balmeremx[2,10:14], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.98*xyx, 1.015*xyy, charsize = 0.4, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,10:14], mgwemx[2,10:14], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,10:14], hmiemx[2,10:14], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.4, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-17-46-North-Ribbon-Energy-Distribution-Ladder.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
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
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]]

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgemx[1,15:19], mgemx[2,15:19], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
ytickname=[' '], $
yticks = 2, $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, balmeremx[1,15:19], balmeremx[2,15:19], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.98*xyx, 1.015*xyy, charsize = 0.4, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, mgwemx[1,15:19], mgwemx[2,15:19], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
ytitle = ytitl, $
xtitle = xtitl, $
;/nolabel, $
yticks = 2, $
ytickname=[' '], $
;XTICKFORMAT="(A1)", $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, xyx, xyy, charsize = 0.4, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
plot, hmiemx[1,15:19], hmiemx[2,15:19], $
;timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.35, $
xcharsize = 0.35, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
xtitle = xtitl, $
/ynoz, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],offset+ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase

xyouts, 0.92*xyx, xyy, charsize = 0.4, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end

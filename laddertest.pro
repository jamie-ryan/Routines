IF KEYWORD_SET(ps) THEN BEGIN
;-------
;setup for postscript or eps output
;-------
    !p.font=0			;use postscript fonts
    set_plot, 'ps'
    @symbols_ps_kc		;load string symbols and greek letters for Postscript
    device, filename='template'+ext, encapsulated=eps, $
    /helvetica,/isolatin1, landscape=0, color=1
    device, xsize=8.89, ysize=8.89		;SQUARE one panel, one column figure 
   ;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
    cs=1 	;charcter size
ENDIF ELSE BEGIN
;-------
;set up for display to screen
;-------
    device, Decomposed=0 		;make colors work for 24-bit display
    black=white 			;exchange colors to work with default black background
    @symbols_kc 			;load string symbols and greek letters for Hershey
    cs=2 				;charcter size
ENDELSE

;-------
;make lines thick
;-------
!p.thick=2 ;data
!x.thick=1 ;x axis
!y.thick=1 ;y axis
for i = 0, 7 do begin
window, i & slitp = i


o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
title = 'Energy Curves'
ytitl = energy
linecolors
utplot, tsi[*], sidata[3, slitp, *], /nodata, $ 
base, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
;        psym = -2, $ 
linestyle = 0, $
ycharsize = 0.55, $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]]
outplot, tsi[*], sidata[3, slitp, *]
loadct,3
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.5, 'IRIS SJ 1400 '+angstrom+' Coord: 4', /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, tmg[612:*], mgdata[3, slitp, 612:*], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.55 , $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
outplot, tmg[612:*], mgdata[3, slitp, 612:*]
loadct,3
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.5, 'IRIS SJ 2796 '+angstrom+' Coord: 4', /norm

o = 2
;mn = 0.8*min(balmerdata[3, i, *])
;mx = 1.5*max(balmerdata[3, i, *])
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, times[slitp, *], balmerdata[3, slitp, *], $
/nodata, $
;    yrange = [mn, mx], $
/yst, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.55 , $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
outplot, times[slitp, *], balmerdata[3, slitp, *]
loadct,3
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, 0.1*xyy, charsize = 0.5, 'IRIS SG Balm Coord: 4', /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors        
utplot, tmgw[*], mgwdata[3, slitp, *], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.55 , $
xcharsize = 0.65, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $ 
/NoErase
outplot, tmgw[*], mgwdata[3, slitp, *]
loadct,3
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.5, 'IRIS SJ 2832 '+angstrom+' Coord: 4', /norm

o = 0
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, thmi[*], hmidata[3, slitp, *], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.55 , $
xcharsize = 0.65, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
outplot, thmi[*], hmidata[3, slitp, *]
loadct,3
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.5, 'SDO HMI Coord: 4', /norm
IF KEYWORD_SET(ps) THEN BEGIN
 device,/close
 set_plot,'x'
 !p.font=-1 			;go back to default (Vector Hershey fonts)
ENDIF

	;go back to default greyscale color table

endfor
loadct,0 		


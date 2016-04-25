

col = 2
linecolors
utplot, times[0, 10:*], balmerdata[4, balmermaxi[1], 10:*], $
/nodata, $
;    yrange = [mn, mx], $
/yst, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.70 , $
xcharsize = 0.75, $
xstyle = 8, $
ytitle = ytitl, $
/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
;/ylog, $
xmargin = [12,3], $
;position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
;for i = 0, n_elements(sidata[4, *, 458]) - 1 do begin
i = 0 ;sunquake location
outplot, times[i, 10:*], balmerdata[4, i, 10:*],color = col + 2*i, linestyle = 0
;endfor
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Balmer Continuum', /norm


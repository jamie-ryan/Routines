pro powerladder, date

restore, '/unsafe/jsr2/'+date+'/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+date+'.sav'

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
power = '[erg s!E-1!N]'

A_sqk = 2.6e16 ;cm^2

;;make coordinate strings
dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coords.txt' ;eg, flnm=hmicoords1.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor





;;;make plots
plot_pos_calc, n_plots = 5, xpos, ypos




;-------
;set up for display to screen
;-------
;    device, Decomposed=0 		;make colors work for 24-bit display
;    black=white 			;exchange colors to work with default black background
;    @symbols_kc 			;load string symbols and greek letters for Hershey
;    cs=2 				;charcter size


;-------
;make lines thick
;-------
!p.thick=1 ;data
!x.thick=2 ;x axis
!y.thick=2 ;y axis
for i = 0, n_elements(sidata[3, *, 458]) - 1 do begin
;-------
;setup for postscript or eps output
;-------

    flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-A_sqk-Power-Ladder.eps'
    !p.font=0			;use postscript fonts
    set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
    device, filename= flnm, encapsulated=eps, $
    /helvetica,/isolatin1, landscape=0, color=1
    ;device, xsize=8.89, ysize=8.89		;SQUARE one panel, one column figure 
   ;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
    cs=1 	;charcter size



;i = 3
col = 2 ;dark red
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
title = 'Power Curves'
;ytitl = power
linecolors
utplot, tsi[458:*], sidata[3, 0, 458:*]*A_sqk, /nodata, $ 
;base, $
;timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
;        psym = -2, $ 
linestyle = 0, $
ycharsize = 0.70, $
xcharsize = 0.75, $
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
;heliocentric coordinate srings
ii = string(i+1, format = '(I0)')
xx = string(balmercoords[0,i], format='(f0.2)')
yy = string(balmercoords[1,i], format='(f0.2)')
for i = 0, n_elements(sidata[3, *, 458]) - 1 do begin
outplot, tsi[458:*], sidata[3, i, 458:*]*A_sqk, color = col + 2*i, linestyle = i
endfor
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx*0.9, xyy*1.1, charsize = 0.5, 'Power Radiated From Region Comparable to Sunquake Area', /norm
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Si IV', /norm
o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = power
linecolors
utplot, tmg[611:*], mgdata[3, 0, 611:*]*A_sqk, $
/nodata, $
;timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.70 , $
xcharsize = 0.75, $
xstyle = 8, $
;ytitle = ytitl, $
/nolabel, $
ytickname=[' '], $
yticks = 2, $
XTICKFORMAT="(A1)", $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
for i = 0, n_elements(sidata[3, *, 458]) - 1 do begin
outplot, tmg[611:*], mgdata[3, i, 611:*]*A_sqk, color = col + 2*i, linestyle = i
endfor
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Mg II', /norm

o = 2
;mn = 0.8*min(balmerdata[3, i, *])
;mx = 1.5*max(balmerdata[3, i, *])
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = power
linecolors
utplot, times[0, 10:*], balmerdata[3, 0, 10:*]*A_sqk, $
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
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
for i = 0, n_elements(sidata[3, *, 458]) - 1 do begin
outplot, times[i, 10:*], balmerdata[3, i, 10:*]*A_sqk, color = col + 2*i, linestyle = i
endfor
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Balmer Continuum', /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = power
linecolors        
utplot, tmgw[153:*], mgwdata[3, 0, 153:*]*A_sqk, $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.70 , $
xcharsize = 0.75, $
xstyle = 8, $
;ytitle = ytitl, $
/nolabel, $
yticks = 2, $
ytickname=[' '], $
XTICKFORMAT="(A1)", $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $ 
/NoErase
for i = 0, n_elements(sidata[3, *, 458]) - 1 do begin
outplot, tmgw[153:*], mgwdata[3, 0, 153:*]*A_sqk, color = 2*col + i, linestyle = i
endfor
;loadct,34
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Mg II wing', /norm

o = 0
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = power
linecolors
utplot, thmi[41:74], hmidata[3, 0, 41:74]*A_sqk, $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.70 , $
xcharsize = 0.75, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
;ytitle = ytitl, $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
for i = 0, n_elements(sidata[3, *, 458]) - 1 do begin
outplot, thmi[41:74], hmidata[3, i, 41:74]*A_sqk, color = 2*col + i, linestyle = i
endfor
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'HMI Continuum', /norm
device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 			;go back to default greyscale color table
endfor

end

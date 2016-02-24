pro laddertest, date

dir = '/unsafe/jsr2/'+date+'/'
restore, dir+'29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+date+'.sav'

npix = 6
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'


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
!p.thick=3 ;data
!x.thick=2 ;x axis
!y.thick=2 ;y axis
for i = 0, n_elements(sidata[3, *, 458]) - 1 do begin
;-------
;setup for postscript or eps output
;-------
    ii = string(i+1, format = '(I0)')
    flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-Ribbon-Area-'+ii+'-Energy-Ladder.eps'
    !p.font=0			;use postscript fonts
    set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
    device, filename= flnm, encapsulated=eps, $
    /helvetica,/isolatin1, landscape=0, color=1
    ;device, xsize=8.89, ysize=8.89		;SQUARE one panel, one column figure 
   ;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
    cs=1 	;charcter size

;heliocentric coordinate srings

xx = string(balmercoords[0,i], format='(f0.2)')
yy = string(balmercoords[0,i], format='(f0.2)')


;i = 3
col = 2 ;dark red
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
title = 'Energy Curves'
ytitl = energy
linecolors
utplot, tsi[458:*], sidata[3, i, 458:*], /nodata, $ 
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
outplot, tsi[458:*], sidata[3, i, 458:*], color = col
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*0.98, charsize = 0.5, 'Si IV Coord: '+ii, /norm
xyouts, xyx, xyy*1.03, charsize = 0.5, 'Energy Curves From Coords '+xx+'",'+yy+'"', /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, tmg[611:*], mgdata[3, i, 611:*], $
/nodata, $
;timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.70 , $
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
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
outplot, tmg[611:*], mgdata[3, i, 611:*], color = col
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Mg II Coord: '+ii, /norm

o = 2
;mn = 0.8*min(balmerdata[3, i, *])
;mx = 1.5*max(balmerdata[3, i, *])
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, times[i, 10:*], balmerdata[3, i, 10:*], $
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
outplot, times[i, 10:*], balmerdata[3, i, 10:*], color = col
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Balmer Coord: '+ii, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors        
utplot, tmgw[153:*], mgwdata[3, i, 153:*], $
/nodata, $
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
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $ 
/NoErase
outplot, tmgw[153:*], mgwdata[3, i, 153:*], color = col
;loadct,34
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Mg II wing Coord: '+ii, /norm

o = 0
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.80) ;y0 plus 90% of yrange
;        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, thmi[41:74], hmidata[3, i, 41:74], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
linestyle = 0, $
ycharsize = 0.70 , $
xcharsize = 0.75, $
xstyle = 8, $
yticks = 2, $
ytickname=[' '], $
ytitle = ytitl, $
/ynozero, $
;/ylog, $
xmargin = [12,3], $
position = [xpos[0],ypos[0,o],xpos[1], ypos[1,o]], $
/NoErase
outplot, thmi[41:74], hmidata[3, i, 41:74], color = col
;loadct,3
;vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy*1.01, charsize = 0.5, 'Fe I Coord: '+ii, /norm
device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 			;go back to default greyscale color table
endfor

end

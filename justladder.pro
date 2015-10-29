pro justladder

restore,'29-Mar-2014-energies-iris-siiv-single-pixel-Oct29-2015.sav'
restore,'29-Mar-2014-energies-iris-mgii-single-pixel-Oct29-2015.sav'
restore,'29-Mar-2014-energies-iris-balmer-single-pixel-Oct29-2015.sav'
restore,'29-Mar-2014-energies-iris-mgw-single-pixel-Oct29-2015.sav'
restore, '29-Mar-2014-energies-hmi-single-pixel-Oct29-2015.sav'
restore, '29-Mar-2014-energies-hmi-qkarea-Oct29-2015.sav'

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

dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
for i = 1,2 do begin
    ii = string(i, format = '(I0)')
    for k = 0, n_elements(dataset)-1 do begin
        flnm = dataset[k]+'coords'+ii+'.txt' ;eg, flnm=hmicoords1.txt
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        tmp = fltarr(2, nlin)
        readf, lun, tmp
        com = dataset[k]+'coords'+ii+ '= tmp' ;readf,lun,hmg
        exe = execute(com)
        free_lun, lun
    endfor
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

        ;used hmi coords as reference point
        if (j eq 0) then xx = string(hmicoords1[0,i], format = '(I0)') else $
        xx = string(hmicoords2[0,i], format = '(I0)')
        if (j eq 0) then yy = string(hmicoords1[1,i], format = '(I0)') else $
        yy = string(hmicoords2[1,i], format = '(I0)')

        ;used hmi coords as reference point
        fff = '29-Mar-14-Ribbon-xyPosition-'+xx+'-'+yy+'-Frame-'+jj+'-Energy-Ladder.eps'
        mydevice=!d.name
        set_plot,'ps'
        ;device,filename=fff,/portrait,/encapsulated, decomposed=0,color = 1  , bits=8, bits = 8
        device,filename=fff,/portrait,/encapsulated, decomposed=0,color = 1, bits = 8
        o = 4
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Ribbon-Energy' ,/remove_all)
        ytitl = energy
        utplot, tsi[447:*], sidata[j,i,447:*], $
        base, $
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
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
        position = [xpos[0],ypos[0,o]*1.01,xpos[1], ypos[1,o]], $
        /NoErase
        loadct,3
        vert_line,sec,1, color = 100
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

        o = 2
        mn = 0.8*min(balmerdata[j,i,155:*])
        mx = 1.5*max(balmerdata[j,i,155:*])
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        utplot, tspqk, balmerdata[j,i,*], $
        yrange = [mn, mx], $
        /yst, $
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
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
device,filename='29-Mar-14-Quake-Energy-Ladder.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Quake-Energy' ,/remove_all)
ytitl = energy
utplot, tsi[447:*], esiqk[447:*], $
base, $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
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
device,filename='29-Mar-14-hQuake-Energy-Ladder.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl =  strcompress('29-Mar-14-Quake-Energy' ,/remove_all)
ytitl = energy
utplot, tsi[447:*], esiqk[447:*], $
base, $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
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
utplot, thmi[36:78], hehmiqk[36:78], $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
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
loadct,3
vert_line,sec,1, color = 100
loadct,0
xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;make latex table file
openw, lun, 'energy-table.tex', /get_lun
printf, lun, '\begin{table}[H]'
printf, lun, '\centering'
printf, lun, '\begin{tabular}{|c|c|c|c|}'
printf, lun, 'Time & Sunquake Coords (x,y)  & E_{Si IV} & E_{Mg II} & E_{Balm} & E_{Mg II w} & E_{HMI} & E_{area}\\'
printf, lun, '\hline'
printf, lun, '17:45 & 518.5, 264.0 & esiqk[495] & emgqk[661] & ebalmerqk[173] & emgwqk[166] & ehmiqk[62] & Eqk_13px_area[62]\\'
printf, lun, '17:46 & 518.5*, 264.0* & esiqk[498] & emgqk[664] & ebalmerqk[174] & emgwqk[167] & ehmiqk[63] & Eqk_13px_area[63]\\'
printf, lun, '\end{tabular}'
printf, lun, '\caption{Pixel coordinates in arcsecs and Energies in ergs at 17:45 and 17:46 for the sunquake pixel and area. *coordinates are the central pixel of a 13 pixel sunquake area}\label{qkenergytab}'
printf, lun, '\end{table}'
for j = 0, frame-1 do begin
  for i = 0, npix-1 do begin

    if (j eq 0) && (i eq 0) then begin
    printf, lun, '\begin{table}[H]'
      printf, lun, '\centering'
      printf, lun, '\begin{tabular}{|c|c|c|c|}'
      printf, lun, 'Time & Si IV (x,y) & E_{Si IV} & Mg II (x,y) & E_{Mg II} & Balm (x,y) & E_{Balm} & Mg II w (x,y) & E_{Mg II w} & HMI (x,y) & E_{HMI}\\'
      printf, lun, '\hline'
    endif


    if (j eq 0) then begin
      sixx = string(sicoords1[0,i], format = '(I0)')
      siyy = string(sicoords1[1,i], format = '(I0)')
      mgxx = string(mgcoords1[0,i], format = '(I0)')
      mgyy = string(mgcoords1[1,i], format = '(I0)')
      balmxx = string(balmercoords1[0,i], format = '(I0)')
      balmyy = string(balmercoords1[1,i], format = '(I0)')
      mgwxx = string(mgwcoords1[0,i], format = '(I0)')
      mgwyy = string(mgwcoords1[1,i], format = '(I0)')
      xx = string(hmicoords1[0,i], format = '(I0)')
      yy = string(hmicoords1[1,i], format = '(I0)')

      si = string(sidata[j,i,495], format = '(I0)')
      mg = string(mgdata[j,i,661], format = '(I0)')
      balm = string(balmerdata[j,i,173], format = '(I0)')
      hmi = string(hmidata[j,i,62], format = '(I0)')
      mgw = string(mgwdata[j,i,166], format = '(I0)')
      ;fltarr(frame,npix,n_elements(tsi))
      printf, lun, '17:45, '+sixx+','+siyy+' & '+si+' & '+mgxx+','+mgyy+' & '+mg+' & '+balmxx+','+balmyy+' & '+balm+' & '+mgwxx+','+mgwyy+' & '+mgw+' & '+xx+','+yy+' & '+hmi+'\\'
    endif

    if (j eq 1) then begin
      sixx = string(sicoords2[0,i], format = '(I0)')
      siyy = string(sicoords2[1,i], format = '(I0)')
      mgxx = string(mgcoords2[0,i], format = '(I0)')
      mgyy = string(mgcoords2[1,i], format = '(I0)')
      balmxx = string(balmercoords2[0,i], format = '(I0)')
      balmyy = string(balmercoords2[1,i], format = '(I0)')
      mgwxx = string(mgwcoords2[0,i], format = '(I0)')
      mgwyy = string(mgwcoords2[1,i], format = '(I0)')
      xx = string(hmicoords2[0,i], format = '(I0)')
      yy = string(hmicoords2[1,i], format = '(I0)')

      si = string(sidata[j,i,498], format = '(I0)')
      mg = string(mgdata[j,i,664], format = '(I0)')
      balm = string(balmerdata[j,i,174], format = '(I0)')
      mgw = string(mgwdata[j,i,167], format = '(I0)')
      hmi = string(hmidata[j,i,63], format = '(I0)')
      ;fltarr(frame,npix,n_elements(tsi))
      printf, lun, '17:46, '+sixx+','+siyy+' & '+si+' & '+mgxx+','+mgyy+' & '+mg+' & '+balmxx+','+balmyy+' & '+balm+' & '+mgwxx+','+mgwyy+' & '+mgw+' & '+xx+','+yy+' & '+hmi+'\\'
    endif

    if (j eq 1) && (i eq npix-1) then begin
      printf, lun, '\end{tabular}'
      printf, lun, '\caption{Coordinates and Energies at 17:45 and 17:46 for ribbon sample locations.}\label{ribenergytab}'
      printf, lun, '\end{table}'
    endif

;;;maybe include a 3d ribbon energy profile (x,y,E)?
;;;or 2d (x,E)...could demo many coords.

  endfor
endfor
free_lun, lun

plot_pos_calc, n_plots = 1, xpos, ypos
base = '29-Mar-14 17:26:00'
sec = 19.*60.
;qkarea plot
mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-Quake-Area-Energy.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
utplot, thmi[38:78], Eqk_13px_area[38:78], $
timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
linestyle = 0, $
ycharsize = 0.55 , $
xcharsize = 0.65, $
;xstyle = 8, $
title = '13 HMI Pixel Quake Area Energy', $
ytitle = energy, $
;/nolabel, $
;yticks = 2, $
;ytickname=[' '], $
;XTICKFORMAT="(A1)", $
;/ynozero, $
;/ylog, $
xmargin = [12,3]
; loadct,3
; vert_line,sec,1, color = 100
; loadct,0
;xyouts, 0.2, 0.8, charsize = 0.7, 'HMI Continuum '+angstrom, /norm
device,/close
set_plot,mydevice

end

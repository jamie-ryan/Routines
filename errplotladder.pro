pro errplotladder

; oploterror, [ x,] y, [xerr], yerr,
;            [ /NOHAT, HATLENGTH= , ERRTHICK =, ERRSTYLE=, ERRCOLOR =,
;              /LOBAR, /HIBAR, NSKIP = , NSUM = , /ADDCMD, ... OPLOT keywords ] 
;
;
;sierr = fltarr(time_frames, fande, npt, n_elements(tsi))
; for f: oploterror, sidata[j, 2, i, 447:*], sierr[j, 0, i, *]
; for e: oploterror, sidata[j, 3, i, 447:*], sierr[j, 1, i, *]

;mgerr = fltarr(time_frames, fande, npt, n_elements(tmg))
;balmererr = fltarr(time_frames, fande, npt, n_elements(tagarr))
;mgwerr = fltarr(time_frames, fande, npt, n_elements(tmgw))
;hmierr = fltarr(time_frames, fande, npt, n_elements(thmi))


restore, '29-Mar-2014-bk-subtracted-iris-hmi-area-energies-Dec4-2015.sav'

npix = 10
frame = 2

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
        fff = '29-Mar-14-Ribbon-xyPosition-'+xx+'-'+yy+'-Frame-'+jj+'-Area-Energy-Ladder.eps'
        jjj = string(j+1, format = '(I0)')
        titl = '29-Mar-14-Ribbon--Energy-hmicoords'+jjj+'-'+xx+'-'+yy
        mydevice=!d.name
        set_plot,'ps'
        ;device,filename=fff,/portrait,/encapsulated, decomposed=0,color = 1  , bits=8, bits = 8
        device,filename=fff,/portrait,/encapsulated, decomposed=0,color = 1, bits = 8
        
        o = 4
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        title = titl
        ytitl = energy
        linecolors
        utplot, tsi[447:*], sidata[j, 3, i, 447:*], $ ;sidata[time_frame, e, coord, t]
        base, $
        timerange = '29-Mar-14 '+['17:26:00','17:55:00'], $
        psym = -2, $ 
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
        vert_line,sec,1, color = 2
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

        o = 3
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        linecolors
        utplot, tmg[595:*], mgdata[j, 3, i, 595:*], $ ;583
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
        vert_line,sec,1, color = 2
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

        o = 2
        mn = 0.8*min(balmerdata[j, 3, i, 155:*])
        mx = 1.5*max(balmerdata[j, 3, i, 155:*])
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        linecolors
        utplot, tbalm[j, i, *], balmerdata[j, 3, i, *], $ ;tbalm[1, i, j]
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
        vert_line,sec,1, color = 2
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

        o = 1
        xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        linecolors        
        utplot, tmgw[150:*], mgwdata[j, 3, i, 150:*], $
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
        vert_line,sec,1, color = 2
        loadct,0
        xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

        o = 0
        xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
        xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
        titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
        ytitl = energy
        linecolors
        utplot, thmi[36:78], hmidata[j, 3, i, 36:78], $
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
        vert_line,sec,1, color = 2
        loadct,0
        xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
        device,/close
        set_plot,mydevice
    endfor
endfor

mydevice=!d.name
set_plot,'ps'
device,filename='29-Mar-14-Quake-Area-Energy-Ladder.eps',/portrait,/encapsulated, decomposed=0,color = 1  , bits=8
o = 4
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
titl = '29-Mar-14-Sunquake-Location-Energy-coords-518.5-264.0'
ytitl = energy
linecolors
utplot, tsi[447:*], sidata[0, 3, npix, 447:*], $
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
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 1400 '+angstrom, /norm

o = 3
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, tmg[597:*], mgdata[0, 3, npix, 597:*], $ ;583
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
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2796 '+angstrom, /norm

o = 2
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, tbalm[0, npix, 12:*], balmerdata[0, 3, npix, 12:*], $
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
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SG Balmer '+angstrom, /norm

o = 1
xyx = xpos[0] + 0.1*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, tmgw[150:*], mgwdata[0, 3, npix, 150:*], $
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
vert_line,sec,1, color = 2
loadct,0
xyouts, xyx, xyy, charsize = 0.7, 'IRIS SJ 2832 '+angstrom, /norm

o = 0
xyx = xpos[0] + 0.2*((xpos[1] - xpos[0])/2) ;middle of xrange
xyy = ypos[0,o] + ((ypos[1, o] - ypos[0, o])*0.85) ;y0 plus 90% of yrange
;titl =  strcompress('29-Mar-14-Flare-Flux' ,/remove_all)
ytitl = energy
linecolors
utplot, thmi[36:78], hmidata[0, 3, npix, 36:78], $
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
vert_line,sec,1, color = 2
loadct,0
xyouts, 0.92*xyx, xyy, charsize = 0.7, 'SDO HMI Continuum', /norm
device,/close
set_plot,mydevice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openw, lun, 'bk-energy-table.tex', /get_lun
printf, lun, '\begin{table}'
printf, lun, '\centering'
printf, lun, '\begin{tabular}{|c|c|c|}'
printf, lun, 'Si IV & Mg II & Balmer Continuum \\'
printf, lun, '\hline'
bksi = string(dnbksi, format = '(E0.2)')
bkmg = string(dnbkmg, format = '(E0.2)')
bkb = string(dnbkb, format = '(E0.2)')
printf, lun, ''+bksi+' & '+bkmg+' & '+bkb+'\\'
printf, lun, '\end{tabular}'
printf, lun, '\caption{Background radiation values in DN for IRIS Si IV, Mg II and Balmer continuum. }\label{bktab}'
printf, lun, '\end{table}'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;make latex table file
openw, lun, 'area-energy-table.tex', /get_lun
printf, lun, '\begin{table}'
printf, lun, '\centering'
printf, lun, '\begin{tabular}{|c|c|c|c|c|c|c|c|}'
printf, lun, 'Time UT & Sunquake Coords x",y"  & $E_{Si IV}$ & $E_{Mg II}$ & $E_{Balm}$ & $E_{Mg II w}$ & $E_{HMI}$ \\'
printf, lun, '\hline'

siq = string(sidata[0, 3, npix, 495], format = '(E0.2)')
mgq = string(mgdata[0, 3, npix, 661], format = '(E0.2)')
balmq = string(balmerdata[0, 3, npix, 173], format = '(E0.2)')
mgwq = string(mgwdata[0, 3, npix, 166], format = '(E0.2)')
hmiq = string(hmidata[0, 3, npix, 62], format = '(E0.2)')

printf, lun, '17:45 & 518.5, 264.0 & '+siq+' & '+mgq+' & '+balmq+' & '+mgwq+' & '+hmiq+'\\'

siq = string(sidata[0, 3, npix, 498], format = '(E0.2)')
mgq = string(mgdata[0, 3, npix, 664], format = '(E0.2)')
balmq = string(balmerdata[0, 3, npix, 174], format = '(E0.2)')
mgwq = string(mgwdata[0, 3, npix, 167], format = '(E0.2)')
hmiq = string(hmidata[0, 3, npix, 63], format = '(E0.2)')

printf, lun, '17:46 & 518.5, 264.0 & '+siq+' & '+mgq+' & '+balmq+' & '+mgwq+' & '+hmiq+'\\'
printf, lun, '\end{tabular}'
printf, lun, '\caption{Pixel coordinates in arcsecs and Energies in ergs at 17:45 and 17:46 for the sunquake pixel and area. *coordinates are the central pixel of a 13 pixel sunquake area}\label{qkenergytab}'
printf, lun, '\end{table}'

for j = 0, frame-1 do begin
  for i = 0, npix-1 do begin

    if (j eq 0) && (i eq 0) then begin
      printf, lun, '\begin{sidewaystable}[h]'
      printf, lun, '\tiny'
      printf, lun, '\centering'
      printf, lun, '\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|}'
      printf, lun, 'Time & Si Coords (x,y) & $E_{Si IV}$ & Mg Coords(x,y) & $E_{Mg II}$ & Balm Coords(x,y) & $E_{Balm}$ & Mgw Coords (x,y) & $E_{Mg II w}$ & HMI Coords (x,y) & $E_{HMI}$\\'
      printf, lun, '\hline'
    endif


    if (j eq 0) then begin
      sixx = string(sicoords1[0,i], format = '(F0.2)')
      siyy = string(sicoords1[1,i], format = '(F0.2)')
      sixy = sixx+', '+siyy
      mgxx = string(mgcoords1[0,i], format = '(F0.2)')
      mgyy = string(mgcoords1[1,i], format = '(F0.2)')
      mgxy = mgxx+', '+mgyy
      balmxx = string(balmercoords1[0,i], format = '(F0.2)')
      balmyy = string(balmercoords1[1,i], format = '(F0.2)')
      balmxy = balmxx+', '+balmyy
      mgwxx = string(mgwcoords1[0,i], format = '(F0.2)')
      mgwyy = string(mgwcoords1[1,i], format = '(F0.2)')
      mgwxy = mgwxx+', '+mgwyy
      xx = string(hmicoords1[0,i], format = '(F0.2)')
      yy = string(hmicoords1[1,i], format = '(F0.2)')
      xy = xx+', '+yy

      si = string(sidata[j,3,i,495], format = '(E0.2)')
      mg = string(mgdata[j,3,i,661], format = '(E0.2)')
      balm = string(balmerdata[j,3,i,173], format = '(E0.2)')
      hmi = string(hmidata[j,3,i,62], format = '(E0.2)')
      mgw = string(mgwdata[j,3,i,166], format = '(E0.2)')
      ;fltarr(frame,npix,n_elements(tsi))
      printf, lun, '17:45 & '+sixy+' & '+si+' & '+mgxy+' & '+mg+' & '+balmxy+' & '+balm+' & '+mgwxy+' & '+mgw+' & '+xy+' & '+hmi+'\\'
    endif

    if (j eq 1) then begin
      sixx = string(sicoords2[0,i], format = '(F0.2)')
      siyy = string(sicoords2[1,i], format = '(F0.2)')
      sixy = sixx+', '+siyy
      mgxx = string(mgcoords2[0,i], format = '(F0.2)')
      mgyy = string(mgcoords2[1,i], format = '(F0.2)')
      mgxy = mgxx+', '+mgyy
      balmxx = string(balmercoords2[0,i], format = '(F0.2)')
      balmyy = string(balmercoords2[1,i], format = '(F0.2)')
      balmxy = balmxx+', '+balmyy
      mgwxx = string(mgwcoords2[0,i], format = '(F0.2)')
      mgwyy = string(mgwcoords2[1,i], format = '(F0.2)')
      mgwxy = mgwxx+', '+mgwyy
      xx = string(hmicoords2[0,i], format = '(F0.2)')
      yy = string(hmicoords2[1,i], format = '(F0.2)')
      xy = xx+', '+yy

      si = string(sidata[j, 3, i, 498], format ='(E0.2)')
      mg = string(mgdata[j, 3, i, 664], format ='(E0.2)')
      balm = string(balmerdata[j, 3, i, 174], format = '(E0.2)')
      mgw = string(mgwdata[j, 3, i, 167], format ='(E0.2)')
      hmi = string(hmidata[j, 3, i, 63], format ='(E0.2)')
      ;fltarr(frame,npix,n_elements(tsi))
      printf, lun, '17:46 & '+sixy+' & '+si+' & '+mgxy+' & '+mg+' & '+balmxy+' & '+balm+' & '+mgwxy+' & '+mgw+' & '+xy+' & '+hmi+'\\'
    endif

    if (j eq 1) && (i eq npix-1) then begin
      printf, lun, '\end{tabular}'
      printf, lun, '\caption{Coordinates and Energies at 17:45 and 17:46 for ribbon sample locations. Energies are calculated from pixel locations associated with an area comparable to that of the sunquake impact.}\label{ribenergytab}'
      printf, lun, '\end{sidewaystable}'
    endif
  endfor
endfor
free_lun, lun
end

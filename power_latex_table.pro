pro power_latex_table, fdate
fil = '/unsafe/jsr2/'+fdate+'/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+fdate+'.sav'
restore, fil

ncoords = n_elements(sidata[0,*,0])


dataset = ['si', 'hmi']
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



;;;;make latex table file
openw, lun, '/unsafe/jsr2/'+fdate+'/power-table.tex', /get_lun

for i = 0, ncoords-1 do begin

    if (i eq 0) then begin
        printf, lun, '\begin{sidewaystable}[h]'
        printf, lun, '\tiny'
        printf, lun, '\centering'
        printf, lun, '\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|}'
        printf, lun, 'Coorinates (x,y) [arcsecs] & $P_{Si IV}$ [erg] & $P_{Mg II}$ [erg] & $P_{Balm}$ [erg] & $P_{Mg II w}$ [erg] & $P_{HMI}$ [erg]\\'
        printf, lun, '\hline'
    endif


    sixx = string(sicoords[0,i], format = '(F0.2)')
    siyy = string(sicoords[1,i], format = '(F0.2)')
    sixy = sixx+', '+siyy
    xx = string(hmicoords[0,i], format = '(F0.2)')
    yy = string(hmicoords[1,i], format = '(F0.2)')
    xy = xx+', '+yy

    si = string(max(sidata[4, i, 458:*]), format = '(E0.2)')
    mg = string(max(mgdata[4, i, 611:*]), format = '(E0.2)')
    balm = string(max(balmerdata[4, i, 10:*]), format = '(E0.2)')
    hmi = string(max(hmidata[4, i, 55:74]), format = '(E0.2)')
    mgw = string(max(mgwdata[4, i, 153:*]), format = '(E0.2)')

    printf, lun, sixy+' & '+si+' & '+mg+' & '+balm+' & '+mgw+' & '+hmi+'\\'
    if (i eq ncoords -1) then begin
    printf, lun, '\end{tabular}'
    printf, lun, '\caption{Power values are the maximum emitted during the flare impulsive phase, 17:44 to 17:48 for ribbon sample locations 1 to 6 (see table \ref{coordtab}).}\label{ribpowertab}'
    printf, lun, '\end{sidewaystable}'
    endif
endfor
free_lun, lun
end

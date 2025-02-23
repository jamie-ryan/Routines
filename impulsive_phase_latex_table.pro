pro impulsive_phase_latex_table, fdate

restore, '/unsafe/jsr2/'+fdate+'/29-Mar-2014-integrated-energies-'+fdate+'.sav'

ncoords = n_elements(si_eimp)


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
openw, lun, '/unsafe/jsr2/'+fdate+'/area-energy-table.tex', /get_lun

for i = 0, ncoords-1 do begin

    if (i eq 0) then begin
        printf, lun, '\begin{sidewaystable}[h]'
        printf, lun, '\tiny'
        printf, lun, '\centering'
        printf, lun, '\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|}'
        printf, lun, 'Coorinates (x,y) [arcsecs] & $E_{Si IV}$ [erg] & $E_{Mg II}$ [erg] & $E_{Balm}$ [erg] & $E_{Mg II w}$ [erg] & $E_{HMI}$ [erg]\\'
        printf, lun, '\hline'
    endif


    sixx = string(sicoords[0,i], format = '(F0.2)')
    siyy = string(sicoords[1,i], format = '(F0.2)')
    sixy = sixx+', '+siyy
    xx = string(hmicoords[0,i], format = '(F0.2)')
    yy = string(hmicoords[1,i], format = '(F0.2)')
    xy = xx+', '+yy

    si = string(si_eimp[i], format = '(E0.2)')
    mg = string(mg_eimp[i], format = '(E0.2)')
    balm = string(balmer_eimp[i], format = '(E0.2)')
    hmi = string(hmi_eimp[i], format = '(E0.2)')
    mgw = string(mgw_eimp[i], format = '(E0.2)')

    printf, lun, sixy+' & '+si+' & '+mg+' & '+balm+' & '+mgw+' & '+hmi+'\\'
    if (i eq ncoords -1) then begin
    printf, lun, '\end{tabular}'
    printf, lun, '\caption{Energies integrated over the flare impulsive phase, 17:44 to 17:48 for ribbon sample locations 1 to 6 (see table \ref{}). Energies are calculated by multiplying time integrated flux by the sunquake impact area.}\label{ribenergytab}'
    printf, lun, '\end{sidewaystable}'
    endif
endfor
free_lun, lun
end

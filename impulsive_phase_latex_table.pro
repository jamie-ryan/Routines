pro impulsive_phase_latex_table

restore, '/unsafe/jsr2/'+fdate+'/29-Mar-2014-integrated-energies-'+fdate+'.sav'

npix = 8

;;;;make latex table file
openw, lun, dir+'area-energy-table.tex', /get_lun

for i = 0, npix-1 do begin

    if (i eq 0) then begin
        printf, lun, '\begin{sidewaystable}[h]'
        printf, lun, '\tiny'
        printf, lun, '\centering'
        printf, lun, '\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|}'
        printf, lun, 'Coorinates (x,y) [arcsecs] & $E_{Si IV}$ & & $E_{Mg II}$ & $E_{Balm}$ & $E_{Mg II w}$ & $E_{HMI}$\\'
        printf, lun, '\hline'
    endif


    sixx = string(sicoords[0,i], format = '(F0.2)')
    siyy = string(sicoords[1,i], format = '(F0.2)')
    xx = string(hmicoords[0,i], format = '(F0.2)')
    yy = string(hmicoords[1,i], format = '(F0.2)')
    xy = xx+', '+yy

    si = string(si_eimp[i], format = '(E0.2)')
    mg = string(mg_eimp[i], format = '(E0.2)')
    balm = string(balmer_eimp[i], format = '(E0.2)')
    hmi = string(hmi_eimp[i], format = '(E0.2)')
    mgw = string(mgw_eimp[i], format = '(E0.2)')

    printf, lun, '+sixy+' & '+si+' & '+mg+' & '+balm+' & '+mgw+' & '+hmi+'\\'

    printf, lun, '\end{tabular}'
    printf, lun, '\caption{Coordinates and Energies integrated over the flare impulsive phase, 17:44 to 17:48 for ribbon sample locations. Energies are calculated from pixel locations associated with an area comparable to that of the sunquake impact.}\label{ribenergytab}'
    printf, lun, '\end{sidewaystable}'
endfor
free_lun, lun
end

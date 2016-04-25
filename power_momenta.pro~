pro power_momenta, fdate
;fdate = 'Apr25-2016'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;SUNQUAKE;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
asqk = 2.6e16 ;cm^2
powsqk = 1.3e26 ;erg/s
strpsqk = string(powsqk, format = '(F0.2)')
;;;Sunquake momentum
rho = 1.0e-8 ;g/cm^3 photospheric plasma density
l = 2*sqrt(asqk/!pi)  ; =1.82e8 ;cm sunquake diameter
v = [1.0e6, 8.0e8] ;cm/s [photospheric soundspeed,sunquake wave speed] 
momsqk = rho*(l^3)*v ;upper and lower estimate of sunquake momentum 
strmsqk = string(momsqk[0], format = '(F0.2)')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;PARTICLE BEAM;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
tau = 100. ;secs
powelec = 1.0e28 ;erg/s
strpelec = string(powelec, format = '(F0.2)')
me = !const.me*1.e3 ;g
mp = !const.mp*1.e3 ;g
momelec = tau*sqrt(2*me)*powelec ;g.cm/s
momprot = momelec*sqrt(mp/me) ;g.cm/s
strmelec = string(momelec, format = '(F0.2)')
strmprot = string(momprot, format = '(F0.2)')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;RADIATIVE BACKWARMING;;;;;;;;;;;;;;;;;;;;;;; 
restore, '/unsafe/jsr2/'+fdate+'/29-Mar-2014-integrated-energies-'+fdate+'.sav'
c = !const.c*1.e2
E = balmer_eimp[0]
momrad = E/c
strmrad = string(momrad, format = '(F0.2)')

powrad = max(balmerdata[4,0,*]) ;power emitted from A = asqk over sunquake location
strprad = string(powrad, format = '(F0.2)')

save, /variables, filename = '/unsafe/jsr2/'+fdate+'/power-momenta-'+fdate+'.sav


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;LATEX TABLES;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;make latex table file
openw, lun, '/unsafe/jsr2/'+fdate+'/power-momentum-table.tex', /get_lun

printf, lun, '\begin{sidewaystable}[h]'
printf, lun, '\tiny'
printf, lun, '\centering'
printf, lun, '\begin{tabular}{|c|c|c|}'
printf, lun, 'Process & Momentum [g cm s$^{-1}$] & Power [erg s$^{-1}$] \\'
printf, lun, '\hline'

;    printf, lun, sixy+' & '+si+' & '+mg+' & '+balm+' & '+mgw+' & '+hmi+'\\'
printf, lun, 'Sunquake & '+strmsqk+' & '+strpsqk+'\\'
printf, lun, 'Nonthermal Electron Beam & '+strmelec+' & '+strpelec+'\\'
printf, lun, 'Nonthermal Proton Beam & '+strmprot+' & '+strpelec+'\\'
printf, lun, 'Radiative Backwarming & '+strmrad+' & '+strprad+'\\'



printf, lun, '\end{tabular}'
printf, lun, '\caption{Calculated power and momentum values for the sunquake, nonthermal particle beam (both electron and proton) and radiative backwarming over the sunquake area.}\label{ribenergytab}'
printf, lun, '\end{sidewaystable}'
free_lun, lun




end

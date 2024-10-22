pro power_momenta, fdate
;fdate = 'Apr25-2016'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;SUNQUAKE;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
asqk = 2.6e16 ;cm^2
powsqk = 1.3e26 ;erg/s
strpsqk = string(powsqk, format = '(E0.2)')
;;;Sunquake momentum
rho = 1.0e-8 ;g/cm^3 photospheric plasma density
l = 2*sqrt(asqk/!pi)  ; =1.82e8 ;cm sunquake diameter
v = [1.0e6, 8.0e8] ;cm/s [photospheric soundspeed,sunquake wave speed] 
momsqk = rho*(l^3)*v ;upper and lower estimate of sunquake momentum 
strmsqk = string(momsqk[0], format = '(E0.2)')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;PARTICLE BEAM;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;abeam = 6.61e16 ;cm^2 based on 90% 50-100kev hxr contour size
;tau = 100. ;secs
;powelec = 1.0e28 ;erg/s emitted from an area abeam
;strpelec = string(powelec, format = '(E0.2)')
;me = !const.me*1.e3 ;g
;mp = !const.mp*1.e3 ;g
;n_e = 1.e35 ;n_e = n_p
;ve = 1.21e8 ;cm/s electron velocity
;strne = string(n_e, format = '(E0.2)')
;electron
;momelec = tau*sqrt(2*me)*powelec ;g.cm/s 
;momelec = (powelec*tau)/(ve) ;g.cm/s
;momebeam = n_e*momelec ;g.cm/s
;proton
;momprot = momelec*sqrt(mp/me) ;g.cm/s
;mompbeam = n_e*momprot ;g.cm/s
;strings
;strmelec = string(momelec, format = '(E0.2)')
;strmprot = string(momprot, format = '(E0.2)')
;strmeb = string(momebeam, format = '(E0.2)')
;strmpb = string(mompbeam, format = '(E0.2)')
dir = '/unsafe/jsr2/rhessi-spectra-Sep14-2016/'
savfimg = dir+'29_mar_14_imaging_hxr_energies_momenta.sav
savffd = dir+'29_mar_14_fulldisc_hxr_energies_momenta.sav'
restore, savfimg
restore, savffd


enst = string(p_north[*], format = '(e0.2)')
penst = string(pe_north[*], format = '(e0.2)')
ppnst = string(pp_north, format = '(e0.2)')
esst = string(p_south, format = '(e0.2)')
pesst = string(pe_south, format = '(e0.2)')
ppsst = string(pp_south, format = '(e0.2)')
efdst = string(p_fulldisc, format = '(e0.2)')
pefdst = string(pe_fulldisc, format = '(e0.2)')
ppfdst = string(pp_fulldisc, format = '(e0.2)')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;RADIATIVE BACKWARMING;;;;;;;;;;;;;;;;;;;;;;; 
;restore, '/unsafe/jsr2/'+fdate+'/29-Mar-2014-integrated-energies-'+fdate+'.sav'
restore, '/unsafe/jsr2/'+fdate+'/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+fdate+'.sav'
c = !const.c*1.e2 ;cm/s
;E = balmer_eimp[0] ;erg
;momrad = E/c
;strmrad = string(momrad, format = '(E0.2)')
radbk = strarr(6, 3)

;energy emitted from A = asqk over sunquake location
;radbk[0,0] = string(balmerdata[3,0,23], format = '(E0.2)') ;sq1
;radbk[0,1] = string(balmerdata[3,0,23], format = '(E0.2)') ;sq1
;radbk[0,2] = string(balmerdata[3,0,24], format = '(E0.2)') ;sq1
;radbk[1,0] = string(balmerdata[3,1,23], format = '(E0.2)') ;sq2
;radbk[1,1] = string(balmerdata[3,1,23], format = '(E0.2)') ;sq2
;radbk[1,2] = string(balmerdata[3,1,24], format = '(E0.2)') ;sq2
;radbk[2,0] = string(balmerdata[3,5,23], format = '(E0.2)') ;north
;radbk[2,1] = string(balmerdata[3,5,23], format = '(E0.2)') ;north
;radbk[2,2] = string(balmerdata[3,5,24], format = '(E0.2)') ;north
;momentum
;radbkmom = strarr(3,3) 
;radbkmom[0,0] = string(balmerdata[3,0,23]/c, format = '(E0.2)') ;sq1
;radbkmom[0,1] = string(balmerdata[3,0,23]/c, format = '(E0.2)') ;sq1
;radbkmom[0,2] = string(balmerdata[3,0,24]/c, format = '(E0.2)') ;sq1
;radbkmom[1,0] = string(balmerdata[3,1,23]/c, format = '(E0.2)') ;sq2
;radbkmom[1,1] = string(balmerdata[3,1,23]/c, format = '(E0.2)') ;sq2
;radbkmom[1,2] = string(balmerdata[3,1,24]/c, format = '(E0.2)') ;sq2
;radbkmom[2,0] = string(balmerdata[3,5,23]/c, format = '(E0.2)') ;north
;radbkmom[2,1] = string(balmerdata[3,5,23]/c, format = '(E0.2)') ;north
;radbkmom[2,2] = string(balmerdata[3,5,24]/c, format = '(E0.2)') ;north


;power emitted from A = asqk over sunquake location
radbk[0,0] = string(balmerdata[4,0,23], format = '(E0.2)') ;sq1
radbk[0,1] = string(balmerdata[4,0,23], format = '(E0.2)') ;sq1
radbk[0,2] = string(balmerdata[4,0,24], format = '(E0.2)') ;sq1
radbk[1,0] = string(balmerdata[4,1,23], format = '(E0.2)') ;sq2
radbk[1,1] = string(balmerdata[4,1,23], format = '(E0.2)') ;sq2
radbk[1,2] = string(balmerdata[4,1,24], format = '(E0.2)') ;sq2
radbk[2,0] = string(balmerdata[4,5,23], format = '(E0.2)') ;north
radbk[2,1] = string(balmerdata[4,5,23], format = '(E0.2)') ;north
radbk[2,2] = string(balmerdata[4,5,24], format = '(E0.2)') ;north

radbk[3,0] = string(balmerdata[4,2,23], format = '(E0.2)') ;sq1
radbk[3,1] = string(balmerdata[4,2,23], format = '(E0.2)') ;sq1
radbk[3,2] = string(balmerdata[4,2,24], format = '(E0.2)') ;sq1
radbk[4,0] = string(balmerdata[4,3,23], format = '(E0.2)') ;sq2
radbk[4,1] = string(balmerdata[4,3,23], format = '(E0.2)') ;sq2
radbk[4,2] = string(balmerdata[4,3,24], format = '(E0.2)') ;sq2
radbk[5,0] = string(balmerdata[4,4,23], format = '(E0.2)') ;north
radbk[5,1] = string(balmerdata[4,4,23], format = '(E0.2)') ;north
radbk[5,2] = string(balmerdata[4,4,24], format = '(E0.2)') ;north
;momentum
radbkmom = strarr(6,3) 
radbkmom[0,0] = string(balmerdata[4,0,23]/c, format = '(E0.2)') ;sq1
radbkmom[0,1] = string(balmerdata[4,0,23]/c, format = '(E0.2)') ;sq1
radbkmom[0,2] = string(balmerdata[4,0,24]/c, format = '(E0.2)') ;sq1
radbkmom[1,0] = string(balmerdata[4,1,23]/c, format = '(E0.2)') ;sq2
radbkmom[1,1] = string(balmerdata[4,1,23]/c, format = '(E0.2)') ;sq2
radbkmom[1,2] = string(balmerdata[4,1,24]/c, format = '(E0.2)') ;sq2
radbkmom[2,0] = string(balmerdata[4,5,23]/c, format = '(E0.2)') ;north
radbkmom[2,1] = string(balmerdata[4,5,23]/c, format = '(E0.2)') ;north
radbkmom[2,2] = string(balmerdata[4,5,24]/c, format = '(E0.2)') ;north

radbkmom[3,0] = string(balmerdata[4,2,23]/c, format = '(E0.2)') ;south3
radbkmom[3,1] = string(balmerdata[4,2,23]/c, format = '(E0.2)') ;
radbkmom[3,2] = string(balmerdata[4,2,24]/c, format = '(E0.2)') ;
radbkmom[4,0] = string(balmerdata[4,3,23]/c, format = '(E0.2)') ;south4
radbkmom[4,1] = string(balmerdata[4,3,23]/c, format = '(E0.2)') ;
radbkmom[4,2] = string(balmerdata[4,3,24]/c, format = '(E0.2)') ;
radbkmom[5,0] = string(balmerdata[4,4,23]/c, format = '(E0.2)') ;south5
radbkmom[5,1] = string(balmerdata[4,4,23]/c, format = '(E0.2)') ;
radbkmom[5,2] = string(balmerdata[4,4,24]/c, format = '(E0.2)') ;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;LATEX TABLES;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;make latex table file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openw, lun, '/unsafe/jsr2/'+fdate+'/power-momentum-table.tex', /get_lun

printf, lun, '\begin{sidewaystable}[h]'
printf, lun, '\tiny'
printf, lun, '\centering'
printf, lun, '\begin{tabular}{|c|c|c|c|}'
printf, lun, '\hline'
printf, lun, 'Time Interval & Process  & Energy [erg] & Momentum [g cm s$^{-1}$] \\'
printf, lun, '\hline'
printf, lun, ''+time_ints[0]+' & Full Disc Spec 10 - 90 keV HXR & '+efdst[0]+' & '+pefdst[0]+' \\'
printf, lun, ' & North Ribbon Img Spec 10 - 90 keV HXR & '+enst[0]+' & '+penst[0]+' \\'
printf, lun, ' & South Ribbon Img Spec 10 - 90 keV HXR & '+esst[0]+' & '+pesst[0]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming QK Location 1 & '+radbk[0,0]+' & '+radbkmom[0,0]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming QK Location 2 & '+radbk[1,0]+' & '+radbkmom[1,0]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 3 & '+radbk[3,0]+' & '+radbkmom[3,0]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 4 & '+radbk[4,0]+' & '+radbkmom[4,0]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 5 & '+radbk[5,0]+' & '+radbkmom[5,0]+' \\'
printf, lun, ' & North Ribbon Radiative Backwarming Location 6 & '+radbk[2,0]+' & '+radbkmom[2,0]+' \\'
printf, lun, '\hline'
printf, lun, ''+time_ints[1]+' & Full Disc Spec 10 - 90 keV HXR & '+efdst[1]+' & '+pefdst[1]+' \\'
printf, lun, ' & North Ribbon Img Spec 10 - 90 keV HXR & '+enst[1]+' & '+penst[1]+' \\'
printf, lun, ' & South Ribbon Img Spec 10 - 90 keV HXR & '+esst[1]+' & '+pesst[1]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming QK Location 1 & '+radbk[0,1]+' & '+radbkmom[0,1]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming QK Location 2 & '+radbk[1,1]+' & '+radbkmom[1,1]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 3 & '+radbk[3,1]+' & '+radbkmom[3,1]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 4 & '+radbk[4,1]+' & '+radbkmom[4,1]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 5 & '+radbk[5,1]+' & '+radbkmom[5,1]+' \\'
printf, lun, ' & North Ribbon Radiative Backwarming Location 6 & '+radbk[2,1]+' & '+radbkmom[2,1]+' \\'
printf, lun, '\hline'
printf, lun, ''+time_ints[2]+' & Full Disc Spec 10 - 90 keV HXR & '+efdst[2]+' & '+pefdst[2]+' \\'
printf, lun, ' & North Ribbon Img Spec 10 - 90 keV HXR & '+enst[2]+' & '+penst[2]+' \\'
printf, lun, ' & South Ribbon Img Spec 10 - 90 keV HXR & '+esst[2]+' & '+pesst[2]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming QK Location 1 & '+radbk[0,2]+' & '+radbkmom[0,2]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming QK Location 2 & '+radbk[1,2]+' & '+radbkmom[1,2]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 3 & '+radbk[3,2]+' & '+radbkmom[3,2]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 4 & '+radbk[4,2]+' & '+radbkmom[4,2]+' \\'
printf, lun, ' & South Ribbon Radiative Backwarming Location 5 & '+radbk[5,2]+' & '+radbkmom[5,2]+' \\'
printf, lun, ' & North Ribbon Radiative Backwarming Location 6 & '+radbk[2,2]+' & '+radbkmom[2,2]+' \\'
printf, lun, '\hline'
printf, lun, '29 Mar 2014 17:46 & Sunquake & '+strpsqk+' & '+strmsqk+' \\'
printf, lun, '\hline'
printf, lun, '\end{tabular}'
printf, lun, '\caption{Energy and momentum values calculated for full disc nonthermal hard x-rays; nonthermal hard x-rays associated with electron beams for each spatially resolved footpoint; radiative backwarming over the sunquake areas and in the northern ribbon; the sunquake. QK locations 1 and 2 refer to coordinates 518.5, 264.0 and 519.0, 262.0 respectively. These coordinates are quoted in Judge et al 2014 and Matthews et al 2015.}\label{ribenergytab}'
printf, lun, '\end{sidewaystable}'
free_lun, lun

;;;;;;;;;;;;old table
;openw, lun, '/unsafe/jsr2/'+fdate+'/power-momentum-table.tex', /get_lun

;printf, lun, '\begin{sidewaystable}[h]'
;printf, lun, '\tiny'
;printf, lun, '\centering'
;printf, lun, '\begin{tabular}{|c|c|c|}'
;printf, lun, 'Process & Momentum [g cm s$^{-1}$] & Power [erg s$^{-1}$] \\'
;printf, lun, '\hline'

;    printf, lun, sixy+' & '+si+' & '+mg+' & '+balm+' & '+mgw+' & '+hmi+'\\'
;printf, lun, 'Sunquake & '+strmsqk+' & '+strpsqk+'\\'
;printf, lun, 'Nonthermal Electron Beam & '+strmelec+' & '+strpelec+'\\'
;printf, lun, 'Nonthermal Proton Beam & '+strmprot+' & '+strpelec+'\\'
;printf, lun, 'Nonthermal Electron Beam & '+strmeb+' & '+strpelec+'\\'
;printf, lun, 'Nonthermal Proton Beam & '+strmpb+' & '+strpelec+'\\'
;printf, lun, 'Radiative Backwarming & '+strmrad+' & '+strprad+'\\'

;printf, lun, '\end{tabular}'
;printf, lun, '\caption{Calculated power and momentum values for the sunquake, single nonthermal particles, nonthermal particle beams (both electron and proton) and radiative backwarming over the sunquake area. Assuming the plasma ;has the same number of electrons and protons, then nonthermal beam momenta are calculated by multiplying single particle values by the number of electrons, n_e = '+strne+'.}\label{ribenergytab}'
;printf, lun, '\end{sidewaystable}'
;free_lun, lun















end

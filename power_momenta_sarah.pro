
openw, lun, '/unsafe/jsr2/Oct10-2016/hxr-energy-table.tex', /get_lun
printf, lun, '\begin{table}[h]'
printf, lun, '\tiny'
printf, lun, '\centering'
printf, lun, '\begin{tabular}{|c|c|c|}'
printf, lun, '\hline'
printf, lun, 'HXR Data & Total Energy [erg] & Momentum \\'
printf, lun, '\hline'
printf, lun, 'HXR Full disc & $8.42{\times}10^{29}$ & 6.95868{\times}10^{23} \\'
printf, lun, '\hline'
printf, lun, 'HXR North Ribbon & $6.35{\times}10^{27}$ & 5.24793{\times}10^{21} \\'
printf, lun, '\hline'
printf, lun, 'HXR South Ribbon & $2.48{\times}10^{28}$ & 2.05289{\times}10^{22} \\'
printf, lun, '\hline'
printf, lun, '\end{tabular}'
printf, lun, '\caption{Energy and momentum values calculated for full disc and spatially resolved nonthermal hard x-rays.}\label{hxrenergytab}'
printf, lun, '\end{table}'


restore, '/unsafe/jsr2/Oct10-2016/29-Mar-2014-integrated-energies-Oct10-2016.sav'

c = !const.c*1.e2 ;cm/s
;E = balmer_eimp[0] ;erg
;momrad = E/c
;strmrad = string(momrad, format = '(E0.2)')
radbk = strarr(5, 6)
;radbk[0,0] = string(data[3,0,] + data[3,0,] + data[3,0,], format = '(E0.2)')
;radbk[0,1] = string(data[3,1,] + data[3,0,] + data[3,0,], format = '(E0.2)')
;radbk[0,2] = string(data[3,2,] + data[3,0,] + data[3,0,], format = '(E0.2)')
;radbk[0,3] = string(data[3,3,] + data[3,0,] + data[3,0,], format = '(E0.2)')
;radbk[0,4] = string(data[3,4,] + data[3,0,] + data[3,0,], format = '(E0.2)')
;radbk[0,5] = string(data[3,5,] + data[3,0,] + data[3,0,], format = '(E0.2)')
radbk[0,0] = string(si_eimp[0], format = '(E0.2)')
radbk[0,1] = string(si_eimp[1], format = '(E0.2)')
radbk[0,2] = string(si_eimp[2], format = '(E0.2)')
radbk[0,3] = string(si_eimp[3], format = '(E0.2)')
radbk[0,4] = string(si_eimp[4], format = '(E0.2)')
radbk[0,5] = string(si_eimp[5], format = '(E0.2)')

radbk[1,0] = string(mg_eimp[0], format = '(E0.2)')
radbk[1,1] = string(mg_eimp[1], format = '(E0.2)')
radbk[1,2] = string(mg_eimp[2], format = '(E0.2)')
radbk[1,3] = string(mg_eimp[3], format = '(E0.2)')
radbk[1,4] = string(mg_eimp[4], format = '(E0.2)')
radbk[1,5] = string(mg_eimp[5], format = '(E0.2)')

radbk[2,0] = string(balmer_eimp[0], format = '(E0.2)')
radbk[2,1] = string(balmer_eimp[1], format = '(E0.2)')
radbk[2,2] = string(balmer_eimp[2], format = '(E0.2)')
radbk[2,3] = string(balmer_eimp[3], format = '(E0.2)')
radbk[2,4] = string(balmer_eimp[4], format = '(E0.2)')
radbk[2,5] = string(balmer_eimp[5], format = '(E0.2)')

radbk[3,0] = string(mgw_eimp[0], format = '(E0.2)')
radbk[3,1] = string(mgw_eimp[1], format = '(E0.2)')
radbk[3,2] = string(mgw_eimp[2], format = '(E0.2)')
radbk[3,3] = string(mgw_eimp[3], format = '(E0.2)')
radbk[3,4] = string(mgw_eimp[4], format = '(E0.2)')
radbk[3,5] = string(mgw_eimp[5], format = '(E0.2)')

radbk[4,0] = string(hmi_eimp[0], format = '(E0.2)')
radbk[4,1] = string(hmi_eimp[1], format = '(E0.2)')
radbk[4,2] = string(hmi_eimp[2], format = '(E0.2)')
radbk[4,3] = string(hmi_eimp[3], format = '(E0.2)')
radbk[4,4] = string(hmi_eimp[4], format = '(E0.2)')
radbk[4,5] = string(hmi_eimp[5], format = '(E0.2)')

openw, lun, '/unsafe/jsr2/Oct10-2016/iris-hmi-energy-table.tex', /get_lun
printf, lun, '\begin{sidewaystable}[h]'
printf, lun, '\tiny'
printf, lun, '\centering'
printf, lun, '\begin{tabular}{|c|c|c|c|c|c|c|}'
printf, lun, '\hline'
printf, lun, 'Data Set & Coord 1 & 2 & 3 & 4 & 5 & 6 \\'
printf, lun, '\hline'
printf, lun, 'IRIS Si IV Total Energy & '+radbk[0,0]+' & '+radbk[0,1]+' & '+radbk[0,2]+' & '+radbk[0,3]+' & '+radbk[0,4]+' & '+radbk[0,5]+'  \\'
printf, lun, '\hline'
printf, lun, 'IRIS Mg II Total Energy & '+radbk[1,0]+' & '+radbk[1,1]+' & '+radbk[1,2]+' & '+radbk[1,3]+' & '+radbk[1,4]+' & '+radbk[1,5]+'  \\'
printf, lun, '\hline'
printf, lun, 'IRIS Balmer Continuum Total Energy & '+radbk[2,0]+' & '+radbk[2,1]+' & '+radbk[2,2]+' & '+radbk[2,3]+' & '+radbk[2,4]+' & '+radbk[2,5]+'  \\'
printf, lun, '\hline'
printf, lun, 'IRIS Mg II wing Total Energy & '+radbk[3,0]+' & '+radbk[3,1]+' & '+radbk[3,2]+' & '+radbk[3,3]+' & '+radbk[3,4]+' & '+radbk[3,5]+'  \\'
printf, lun, '\hline'
printf, lun, 'SDO HMI Continuum Total Energy & '+radbk[4,0]+' & '+radbk[4,1]+' & '+radbk[4,2]+' & '+radbk[4,3]+' & '+radbk[4,4]+' & '+radbk[4,5]+'  \\'
printf, lun, '\hline'
printf, lun, '\end{tabular}'
printf, lun, '\caption{Total energy values [erg] integrated over the impulsive phase of the flare (17:46 to 17:48) for IRIS and HMI data sets. }\label{ribenergytab}'
printf, lun, '\end{sidewaystable}'
free_lun, lun

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
;radbk[0,0] = string(balmerdata[4,0,23]+balmerdata[4,0,23]+balmerdata[4,0,24], format = '(E0.2)') ;sq1
;radbk[0,1] = string(balmerdata[4,0,23], format = '(E0.2)') ;sq1
;radbk[0,2] = string(balmerdata[4,0,24], format = '(E0.2)') ;sq1
;radbk[1,0] = string(balmerdata[4,1,23], format = '(E0.2)') ;sq2
;radbk[1,1] = string(balmerdata[4,1,23], format = '(E0.2)') ;sq2
;radbk[1,2] = string(balmerdata[4,1,24], format = '(E0.2)') ;sq2
;radbk[2,0] = string(balmerdata[4,5,23], format = '(E0.2)') ;north
;radbk[2,1] = string(balmerdata[4,5,23], format = '(E0.2)') ;north
;radbk[2,2] = string(balmerdata[4,5,24], format = '(E0.2)') ;north

;radbk[3,0] = string(balmerdata[4,2,23], format = '(E0.2)') ;sq1
;radbk[3,1] = string(balmerdata[4,2,23], format = '(E0.2)') ;sq1
;radbk[3,2] = string(balmerdata[4,2,24], format = '(E0.2)') ;sq1
;radbk[4,0] = string(balmerdata[4,3,23], format = '(E0.2)') ;sq2
;radbk[4,1] = string(balmerdata[4,3,23], format = '(E0.2)') ;sq2
;radbk[4,2] = string(balmerdata[4,3,24], format = '(E0.2)') ;sq2
;radbk[5,0] = string(balmerdata[4,4,23], format = '(E0.2)') ;north
;radbk[5,1] = string(balmerdata[4,4,23], format = '(E0.2)') ;north
;radbk[5,2] = string(balmerdata[4,4,24], format = '(E0.2)') ;north
;momentum

;radbkmom = strarr(6,3) 
;radbkmom[0,0] = string(balmerdata[4,0,23]/c, format = '(E0.2)') ;sq1
;radbkmom[0,1] = string(balmerdata[4,0,23]/c, format = '(E0.2)') ;sq1
;radbkmom[0,2] = string(balmerdata[4,0,24]/c, format = '(E0.2)') ;sq1
;radbkmom[1,0] = string(balmerdata[4,1,23]/c, format = '(E0.2)') ;sq2
;radbkmom[1,1] = string(balmerdata[4,1,23]/c, format = '(E0.2)') ;sq2
;radbkmom[1,2] = string(balmerdata[4,1,24]/c, format = '(E0.2)') ;sq2
;radbkmom[2,0] = string(balmerdata[4,5,23]/c, format = '(E0.2)') ;north
;radbkmom[2,1] = string(balmerdata[4,5,23]/c, format = '(E0.2)') ;north
;radbkmom[2,2] = string(balmerdata[4,5,24]/c, format = '(E0.2)') ;north

;radbkmom[3,0] = string(balmerdata[4,2,23]/c, format = '(E0.2)') ;south3
;radbkmom[3,1] = string(balmerdata[4,2,23]/c, format = '(E0.2)') ;
;radbkmom[3,2] = string(balmerdata[4,2,24]/c, format = '(E0.2)') ;
;radbkmom[4,0] = string(balmerdata[4,3,23]/c, format = '(E0.2)') ;south4
;radbkmom[4,1] = string(balmerdata[4,3,23]/c, format = '(E0.2)') ;
;radbkmom[4,2] = string(balmerdata[4,3,24]/c, format = '(E0.2)') ;
;radbkmom[5,0] = string(balmerdata[4,4,23]/c, format = '(E0.2)') ;south5
;radbkmom[5,1] = string(balmerdata[4,4,23]/c, format = '(E0.2)') ;
;radbkmom[5,2] = string(balmerdata[4,4,24]/c, format = '(E0.2)') ;


\begin{sidewaystable}[h]
\tiny
\centering
\begin{tabular}{|c|c|c|c|c|c|c|}
\hline
Data Set & Coord 1 & 2 & 3 & 4 & 5 & 6 \\
\hline
Si IV & & & & & &  \\
\hline
Mg II & & & & & &  \\
\hline
Balmer Continuum & & & & & &  \\
\hline
Mg II wing & & & & & &  \\
\hline
HMI Continuum & & & & & &  \\
\hline
\end{tabular}
\caption{Energy and momentum values calculated for full disc nonthermal hard x-rays; nonthermal hard x-rays associated with electron beams for each spatially resolved footpoint; radiative backwarming over the sunquake areas and in the northern ribbon; the sunquake. QK locations 1 and 2 refer to coordinates 518.5, 264.0 and 519.0, 262.0 respectively. These coordinates are quoted in Judge et al 2014 and Matthews et al 2015.}\label{ribenergytab}
\end{sidewaystable}


Time Interval & Process  & Energy [erg] & Momentum [g cm s$^{-1}$] \\
\hline
29-Mar-2014 17:46:18 to 17:46:34 & Full Disc Spec 10 - 90 keV HXR & 3.00e+29 & 2.48e+23 \\
 & North Ribbon Img Spec 10 - 90 keV HXR & 2.54e+27 & 2.10e+21 \\
 & South Ribbon Img Spec 10 - 90 keV HXR & 7.46e+27 & 6.16e+21 \\
 & South Ribbon Radiative Backwarming QK Location 1 & 1.67E+27 & 5.56E+16 \\
 & South Ribbon Radiative Backwarming QK Location 2 & 1.92E+27 & 6.41E+16 \\
 & South Ribbon Radiative Backwarming Location 3 & 1.46E+27 & 4.87E+16 \\
 & South Ribbon Radiative Backwarming Location 4 & 9.80E+26 & 3.27E+16 \\
 & South Ribbon Radiative Backwarming Location 5 & 7.31E+26 & 2.44E+16 \\
 & North Ribbon Radiative Backwarming Location 6 & 7.76E+26 & 2.59E+16 \\
\hline
29-Mar-2014 17:46:50 to 17:47:06 & Full Disc Spec 10 - 90 keV HXR & 2.56e+29 & 2.11e+23 \\
 & North Ribbon Img Spec 10 - 90 keV HXR & 2.35e+27 & 1.94e+21 \\
 & South Ribbon Img Spec 10 - 90 keV HXR & 6.68e+27 & 5.52e+21 \\
 & South Ribbon Radiative Backwarming QK Location 1 & 1.67E+27 & 5.56E+16 \\
 & South Ribbon Radiative Backwarming QK Location 2 & 1.92E+27 & 6.41E+16 \\
 & South Ribbon Radiative Backwarming Location 3 & 1.46E+27 & 4.87E+16 \\
 & South Ribbon Radiative Backwarming Location 4 & 9.80E+26 & 3.27E+16 \\
 & South Ribbon Radiative Backwarming Location 5 & 7.31E+26 & 2.44E+16 \\
 & North Ribbon Radiative Backwarming Location 6 & 7.76E+26 & 2.59E+16 \\
\hline
29-Mar-2014 17:47:06 to 17:47:20 & Full Disc Spec 10 - 90 keV HXR & 2.86e+29 & 2.36e+23 \\
 & North Ribbon Img Spec 10 - 90 keV HXR & 1.46e+27 & 1.21e+21 \\
 & South Ribbon Img Spec 10 - 90 keV HXR & 1.07e+28 & 8.86e+21 \\
 & South Ribbon Radiative Backwarming QK Location 1 & 1.16E+27 & 3.86E+16 \\
 & South Ribbon Radiative Backwarming QK Location 2 & 6.80E+26 & 2.27E+16 \\
 & South Ribbon Radiative Backwarming Location 3 & 1.04E+27 & 3.45E+16 \\
 & South Ribbon Radiative Backwarming Location 4 & 8.33E+26 & 2.78E+16 \\
 & South Ribbon Radiative Backwarming Location 5 & 5.58E+26 & 1.86E+16 \\
 & North Ribbon Radiative Backwarming Location 6 & 5.43E+26 & 1.81E+16 \\
\hline
29 Mar 2014 17:46 & Sunquake & 1.30E+26 & 6.02E+22 \\
\hline
\end{tabular}
\caption{Energy and momentum values calculated for full disc nonthermal hard x-rays; nonthermal hard x-rays associated with electron beams for each spatially resolved footpoint; radiative backwarming over the sunquake areas and in the northern ribbon; the sunquake. QK locations 1 and 2 refer to coordinates 518.5, 264.0 and 519.0, 262.0 respectively. These coordinates are quoted in Judge et al 2014 and Matthews et al 2015.}\label{ribenergytab}
\end{sidewaystable}

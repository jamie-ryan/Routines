pro rhessi_plots, outdir

restore, outdir+'spec-lightcurve-array.sav'

A_sqk = 2.6e16 ;cm^2



;;;spectra
xtitl = 'Energy keV'
ytitl = 'Counts DN/s'
plot, A_sqk*spectra[*,0,1], xtitle=xtitl, ytitle=ytitl


;;;lightcurves
utplot, time_intervals[0,*], A_sqk*spectra[0,0,*], ytitle=ytitl

end

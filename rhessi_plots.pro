pro rhessi_plots, outdir

;;;spectra
xtitl = 'Energy keV'
ytitl = 'Counts DN/s'
plot, spectra[*,0,1], xtitle=xtitl, ytitle=ytitl


;;;lightcurves
utplot, time_intervals[0,*], spectra[0,0,*], ytitle=ytitl

end

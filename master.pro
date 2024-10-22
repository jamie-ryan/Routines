pro master
tic
;mesa
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
datstr = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+datstr

;datstr = 'Jan20-2016'

;iris_remap
;hmi_full_filt, /process;;;;;;old
;hmi_process_filter, /process, ;/log ;;;;first time processing, uncomment /log for log smooth filter
;hmi_process_filter, process = process, restore_sav = restore_sav, savf = savf, log = log, difffilt = difffilt, bksub = bksub
hmi_process_filter, /restore_sav, savf = '/unsafe/jsr2/Sep21-2016/hmi_mp.sav', /difffilt ;;;secondtime round, if processed sav exists

;balm_simple, datstr
balm_sarah, date
;balm_data, datstr, /single_pixel
;iris_raster_lightcurve ; depends on sav from balm_dat
iris_hmi_energy, datstr, /single_pixel ;depends on sav from iris_raster_lightcurve


;;;context plots
;ribcord2oplot_cp, datstr;, /tables
;mgii_context_plot, datstr
hmi_context_plot, datstr
;sunquake_context_plots, /qksource1, /no, /xzoom, /xxzoom
;plot_energy_dist, datstr


;ladder plots...... fluxladder1, datstr, /altdir, altdirstr = 'bksub-results'
fluxladder2, datstr
energyladde2, datstr
powerladder2, datstr

;rhessi after full disc or imaging spectroscopy in ospex
rhessi_IMAGING_SPECTRA_nth_energy_calculations_29_mar_14 ;contains nth_energy.pro, nth_momentum_e.pro, nth_momentum_p.pro 
rhessi_FULLDISC_SPECTRA_nth_energy_calculations_29_mar_14  ;contains nth_energy.pro, nth_momentum_e.pro, nth_momentum_p.pro 
power_momenta, datstr ;produces power-momentum-table.tex
power_latex_table, fdate 
intimpulse3_cp, datstr
impulsive_phase_latex_table, datstr


toc
end


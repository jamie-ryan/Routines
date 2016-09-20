pro master
tic
;mesa
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
datstr = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+datstr

;datstr = 'Jan20-2016'

;iris_remap
;hmi_full_filt, /process
;balm_data, datstr, /single_pixel
;iris_raster_lightcurve ; depends on sav from balm_dat
iris_hmi_energy, datstr, /single_pixel ;depends on sav from iris_raster_lightcurve


d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
datstr = d1+'-'+d2

fluxladder1, datstr
energyladder, datstr
powerladder, datstr
power_latex_table, fdate
intimpulse3_cp, datstr
impulsive_phase_latex_table, datstr
power_momenta, datstr 

;ribcord2oplot_cp, datstr;, /tables
;mgii_context_plot, datstr

;sunquake_context_plots, /qksource1, /no, /xzoom, /xxzoom
;plot_energy_dist, datstr
toc
end


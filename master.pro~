pro master
;mesa
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date_today = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+date_today

;date_today = 'Jan20-2016'

;iris_remap
;hmi_full_filt, /process
;balm_bk, date_today
balm_data, date_today, /single_pixel
;mesa_cp, date_today
iris_hmi_energy, date_today, /single_pixel

;mes2ladder, date_today
;mes2ladder_cp, date_today
laddertest, date_today
ribcord2oplot_cp, date_today;, /tables
intimpulse3_cp, date_today
;sunquake_context_plots, /qksource1, /no, /xzoom, /xxzoom
;plot_energy_dist, date_today
end


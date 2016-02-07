pro master
;mesa
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date_today = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+date_today

;date_today = 'Jan20-2016'

;balm_bk, date_today
balm_data, date_today
;mesa_cp, date_today
iris_hmi_energy, date_today

mes2ladder, date_today
ribcord2oplot_cp, date_today
intimpulse3, date_today
plot_energy_dist, date_today
end


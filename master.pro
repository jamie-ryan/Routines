pro master
;mesa
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+date

balm_bk, date
mesa_cp, date
mes2ladder, date
ribcord2oplot_cp, date
impulse, date, /plot
end


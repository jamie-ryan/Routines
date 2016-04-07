pro hmi-unfiltered, date_today
files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')
f = files[47:71] ;17:35 - 1753
flong = files[35:*] ;17:26 - 17:59
;aia_prep, f,-1, hmiindex, hmidata, /despike
aia_prep, flong,-1, hmiindex, hmidata, /despike
index2map, hmiindex, hmidata, hmimp
sub_map, hmimp, xr=[405,590], yr=[190,372], shmi
save, /variables, filename = '/unsafe/jsr2/hmifullfilt-all-arrays-'+date_today+'.sav'
end

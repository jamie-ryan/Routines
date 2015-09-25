pro aiadata, wave, ind, dat

wave = string(wave, format ='(I0)'))
t1 =string(t1, format ='(I0)'))
t2 = string(t2, format ='(I0)'))
files = findfile('/disk/solar3/jsr2/SDO/aia.lev1.'+wave+'A*')
aia_prep,files,-1,ind,dat,/uncomp_delete,/norm, /despike


end

pro aiadata, wave, ind, dat

wave = string(wave, format ='(I0)')
files = findfile('aia.lev1.'+wave+'A*')
aia_prep,files,-1,ind,dat,/uncomp_delete,/norm, /despike


end

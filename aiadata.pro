pro aiadata, wave, ind, dat

if (wave eq 'magnetogram') then wave = wave else wave = string(wave, format ='(I0)')
if (wave eq 'dopplergram') then wave = wave else wave = string(wave, format ='(I0)')
if (wave eq 'intensity') then wave = wave else wave = string(wave, format ='(I0)')
files = findfile('aia.lev1.'+wave+'A*')
aia_prep,files,-1,ind,dat,/uncomp_delete,/norm, /despike


end

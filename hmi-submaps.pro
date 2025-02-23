pro hmi-submaps


restore, '/unsafe/jsr2/Feb12-2016/hmifullfilt-Feb12-2016.sav'
restore, '/unsafe/jsr2/hmifullfilt-all-arrays-Apr5-2016.sav'

;shminf stands for sub hmi not filtered
sub_map, hmimp, xr=[490,570], yr=[220,300], shminf 

hmi =  hmidiff[35: 79]
;shminf stands for sub hmi difference filtered
sub_map, hmi, xr=[490,570], yr=[220,300], shmidf

save, shminf, shmidf, filename = 'hmi-submaps-for-movies.sav'

map2png, 'HMI_Cont_z', shminf, 3
map2png, 'HMI_Cont_Diff_z', shmidf, 3


end

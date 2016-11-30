

files = findfile(dir+'hmi.*.fits')
aia_prep, temporary(files),-1, out_ind, out_dat, /despike
index2map, temporary(out_ind), temporary(out_dat), map
sub_map, temporary(map), xr=[submap_range[0] - 50.,submap_range[0] + 50.], yr=[submap_range[1] - 50.,submap_range[1] + 50.], mp 
fnm = dir+'/hmi_mp.sav'
save, mp, filename = fnm
hmidopp = mp
map2index, mp, hmidopp_ind, hmidopp_dat
savff = dir+'/hmi-dopp.sav'
save, hmidopp,hmidopp_ind, hmidopp_dat, filename = savff


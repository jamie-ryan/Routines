pro iris-hmi-submaps

restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/unsafe/jsr2/Feb7-2016/hmifullfilt-Feb7-2016.sav'


sub_map, map1400, ssi, xrange = [460., 560.], yrange = [220., 320.]
sub_map, submg, smg, xrange = [460., 560.], yrange = [220., 320.]
sub_map, diff2832, smgw, xrange = [470., 560.], yrange = [220., 310.]
sub_map, hmidiff, shmi, xrange = [490., 540.], yrange = [240., 290.]

save, ssi, smg, smgw, shmi, filename = 'iris-hmi-submaps-for-mp4.sav'

end

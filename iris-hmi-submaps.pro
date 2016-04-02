pro iris-hmi-submaps

restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/unsafe/jsr2/Feb7-2016/hmifullfilt-Feb7-2016.sav'




sub_map, map1400[473:516], ssi, xrange = [460., 560.], yrange = [220., 320.]
;a = 0
;a = alog10(ssi.data)
;ssi.data = a
loadct, 1
write_movie_map_mp4, ssi, dmin = -100, dmax = 2000, outfile='29-03-2014-uvf-map1400.mp4'
loadct,0


sub_map, submg[630:687], smg, xrange = [460., 560.], yrange = [220., 320.]
;a = 0
;a = alog10(smg.data)
;smg.data = a
loadct, 3
write_movie_map_mp4, smg, dmin = -100, dmax = 2000, outfile='29-03-2014-uvf-submg.mp4'
loadct,0


sub_map, diff2832[158:*], smgw, xrange = [490., 540.], yrange = [240., 290.], dmin = -100, dmax = 1000
loadct, 8
write_movie_map_mp4, smgw, outfile='29-03-2014-wlf-diff2832.mp4'
loadct,0

;17:35:46.600' - 17:53:16.600
sub_map, hmidiff[50:73], shmi, xrange = [490., 540.], yrange = [240., 290.], dmin = 0, dmax = 5000
loadct, 55
write_movie_map_mp4, shmi, outfile='29-03-2014-wlf-hmidiff.mp4'
loadct,0
save, ssi, smg, smgw, shmi, filename = 'iris-hmi-submaps-for-mp4.sav'

end

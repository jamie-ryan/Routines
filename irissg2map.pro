pro irissg2map


f = iris_files(path='/unsafe/jsr2/IRIS/old/')
restore, '/unsafe/jsr2/Mar18-2016/balm_data-Mar18-2016.sav'

d = iris_obj(f[0])
hdr = d->gethdr(iext, /struct)
index2map,hdr, dat_bk_subtract_exp_weighted[*, *, 0], sgmap



for i = 1, n_elements(f) - 1 do begin
d = iris_obj(f[i])
hdr = d->gethdr(iext, /struct)
index2map,hdr, dat_bk_subtract_exp_weighted[*, *, i], sgmap1
sgmap1.xc = hdr.xcen
sgmap1.yc = hdr.ycen
sgmap1.dx = hdr.fovx / 8
sgmap1.dy = hdr.fovy / 1093
sgmap = str_concat(sgmap, sgmap1)
endfor


plot_map, sgmap, position=[0.1,0.1,0.9, 0.9]
save,   ,'/unsafe/jsr2/29-mar-14-iris-sg-maps.sav'

end

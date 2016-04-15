pro irissg2map


f = iris_files(path='/unsafe/jsr2/IRIS/old/')
restore, 'unsafe/jsr2/Mar18-2016/balm_data-Mar18-2016'
for i = 0
d = iris_obj(f[i])
hdr = d->gethdr(iext, /struct)
index2map,hdr, dat_bk_subtract_exp_weighted[*, *, i], sgmap

sgmap.xc = hdr.xcen
sgmap.yc = hdr.ycen

sgmap.dx = hdr.fovx / 8
sgmap.dy = hdr.fovy / 1093

plot_map, sgmap, position=[0.1,0.1,0.9, 0.9]

sgmap = str_concat(sgmap, sgmap)
endfor

save,   ,'/unsafe/jsr2/29-mar-14-iris-sg-maps.sav'

end

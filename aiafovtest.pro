pro 

xp0 = 2830
xpf = 2980
yp0 = 2425
ypf = 2565


xa0 = (xp0-ind[0].crpix1+1)*ind[0].cdelt1
xaf = (xpf-ind[0].crpix1+1)*ind[0].cdelt1
ya0 = (yp0-ind[0].crpix2+1)*ind[0].cdelt2
yaf = (ypf-ind[0].crpix2+1)*ind[0].cdelt2
xa0 = string(xa0,format = '(I0)')
xaf = string(xaf,format = '(I0)')
ya0 = string(ya0,format = '(I0)')
yaf = string(yaf,format = '(I0)')
com = 'sub_map, map'+wavstr+', xr=['+xa0+','+xaf+'], yr=['+ya0+','+yaf+'], sbmap'+wavstr
exe = execute(com)

;plot_image, dat[xp0:xpf, yp0:ypf, *]
;wavstr = string(wave, format = '(I0)')
;com = 'index2map, ind, dat, map'+wavstr
;exe = execute(com)


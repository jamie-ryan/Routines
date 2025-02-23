pro hmisanity

;calculate energy associated with kerr and fletcher event
srch = vso_search('2011/02/15 01:50', '2011/02/15 02:00', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

files = findfile('hmi.ic_*')
aia_prep, files,-1, ind, dat, /despike
index2map, ind, dat, icmap
sub_map, icmap, xr=[160.,260], yr=[-260.,-180.], sbmap

map2index, sbmap, sbind,sbdat 


;kerr and fletcher filter
logdat = alog10(sbdat)
smthdat = smooth(sbdat,10)
filtdat = logdat - smthdat


;;;edge find filters...experiment with filtering!
rob = roberts(sbdat)
sob = sobel(sbdat)
prew = prewitt(sbdat)
shftdiff = shift_diff(sbdat)
edgdog = edge_dog(sbdat)
lap = laplacian(sbdat)
emb = emboss(sbdat)

index2map, sbind, filtdat, filtmap 

sub = coreg_map(filtmap,filtmap[30]) ;with filtering
;sub = coreg_map(sbmap, sbmap[1]) ;no filtering
diff=diff_map(sub(1),sub(0),/rotate)

iii = n_elements(files)
for i=1, iii-1, 1 do begin
diff1=diff_map(sub(i),sub(i-2),/rotate)
;diff1=diff_map(sub(i),sub(0),/rotate)
diff=str_concat(diff,diff1)
endfor
map2index,diff, diffi, diffd

arrayn = n_elements(diff)
intarray = fltarr(arrayn)
for i = 0, arrayn - 1 do begin                                  
intarray[i] = total(diff[i].data[*,*])                  
endfor                                

n = n_elements(diff[0].data[*,0])*n_elements(diff[0].data[0,*])
hmi_radiometric_calibration, intarray, n_pixels = n, f,e

utplot, diff[20:25].time, intarray[20:25]
utplot, diff[20:25].time, f[20:25]
utplot, diff[20:25].time, e[20:25]

end

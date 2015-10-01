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


;edge find filters...experiment with filtering!
rob = roberts(sbdat[*,*,27])
sob = sobel(sbdat[*,*,27])
prew = prewitt(sbdat[*,*,27])
shftdiff = shift_diff(sbdat[*,*,27])
edgdog = edge_dog(sbdat[*,*,27])
lap = laplacian(sbdat[*,*,27])
emb = emboss(sbdat[*,*,27])


index2map, sbind, filtdat, filtmap 


sub = coreg_map(filtmap,filtmap(30))
diff=diff_map(sub(1),sub(0),/rotate)

iii = n_elements(files)
for i=1, iii-1, 1 do begin
diff1=diff_map(sub(i),sub(i-2),/rotate)
;diff1=diff_map(sub(i),sub(0),/rotate)
diff=str_concat(diff,diff1)
endfor
map2index,diff, diffi, diffd

end

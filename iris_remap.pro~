pro iris_remap

;;;load main data sav files
restore, 'SJI_1400-17-Jul-2015.sav'
restore, 'SJI_2796-17-Jul-2015.sav'
restore, 'SJI_2832-17-Jul-2015.sav'

;;;make maps; map names relate to those used by lcseries.pro and saxcontour.pro
index2map, SJI_1400_hdr, SJI_1400_dat, map1400
index2map, SJI_2796_hdr, SJI_2796_dat, submg 
index2map, SJI_2832_hdr, SJI_2832_dat, map2832


;;;;put map2832 through difference filter
sub = coreg_map(map2832,map2832(40))
diff=diff_map(sub(1),sub(0),/rotate)
n = n_elements(map2832)
	for i=1,n-1,1 do begin
	diff1=diff_map(sub(i),sub(i-1),/rotate)
	diff=str_concat(diff,diff1)
	endfor

diff2832 = diff


;;;save headers and maps ready for lcseries
save,SJI_1400_hdr, SJI_2796_hdr, SJI_2832_hdr, map1400, submg, map2832, diff2832, filename = 'iris-16-03-15.sav' 

end

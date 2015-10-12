pro whereBALMERpix
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'

spboxarr = fltarr(5,1,1093) ;or fltarr(5,2,1093)
nn = n_elements(tagarr)
	for i = 0, nn-1, 1 do begin
		comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
		exet1 = execute(comt)
		comi = 'spboxarr[*] = sp2826.'+tagarr[i]+'.int[39:44,3:4,*]'
		exet = execute(comi)
	endfor


end

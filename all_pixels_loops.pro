;;;mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

boxarrmg = fltarr(nmg)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmg-1, 1 do begin

	if (i lt 643) then begin

		f = datdir+'iris-mgii-high-intenstiy-pixels-frame-159.dat' ;~17:44:46
		;;;;;;;open file 
		openr,lun,f,/get_lun

		;;;count lines in file
		nlinesmg = file_lines(f)

		;;;make array to fill with values from the file
		hmg=intarr(2,nlinesmg)

		;;;read file contents into array
		readf,lun,hmg

		;;close file and free up file unit number
		free_lun, lun
	endif

	if ((i gt 642) && (i lt 645)) then begin
		f = datdir+'iris-mgii-high-intenstiy-pixels-frame-161.dat' ;~17:45:31
		;;;;;;;open file 
		openr,lun,f,/get_lun

		;;;count lines in file
		nlinesmg = file_lines(f)

		;;;make array to fill with values from the file
		hmg=intarr(2,nlinesmg)

		;;;read file contents into array
		readf,lun,hmg

		;;close file and free up file unit number
		free_lun, lun
	endif

	if ((i gt 644) && (i lt 648)) then begin
		f = datdir+'iris-mgii-high-intenstiy-pixels-frame-164.dat' ;~17:46:16
		;;;;;;;open file 
		openr,lun,f,/get_lun

		;;;count lines in file
		nlinesmg = file_lines(f)

		;;;make array to fill with values from the file
		hmg=intarr(2,nlinesmg)

		;;;read file contents into array
		readf,lun,hmg

		;;close file and free up file unit number
		free_lun, lun
	endif

	if (i gt 647) then begin
		f = datdir+'iris-mgii-high-intenstiy-pixels-frame-166.dat' ;~17:47:01
		;;;;;;;open file 
		openr,lun,f,/get_lun

		;;;count lines in file
		nlinesmg = file_lines(f)

		;;;make array to fill with values from the file
		hmg=intarr(2,nlinesmg)

		;;;read file contents into array
		readf,lun,hmg

		;;close file and free up file unit number
		free_lun, lun
	endif

	boxarrmg = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) '
endfor

;;;flux and energy of flare area
iris_radiometric_calibration,boxarrmg, wave = 2796, n_pixels = nlinesmg ,F_area_mgii, E_area_mgii ,/sji



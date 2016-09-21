pro vso_project2_data

;see /unsafe/jsr2/project2 directory for downloaded files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;X2.1 flare 2015/03/11 16:11 to 16:22

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;HMI
;HMI Continuum
srch = vso_search('2015/03/11 16:11', '2015/03/11 16:29', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Magnetogram
srch = vso_search('2015/03/11 16:11', '2015/03/11 16:29', instr = 'hmi',physobs = 'LOS_magnetic_field', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2015/03/11 16:11', '2015/03/11 16:29', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IRIS, rasters, 1330, 1400, 2832
;downloaded via the iris website

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
end
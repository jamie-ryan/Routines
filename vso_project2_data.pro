pro vso_project2_data



;a = vso_get( vso_search( date='2004.1.1', inst='eit' ) )

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;HMI Dopplergram
srch = vso_search('2014/03/29 17:37', '2014/03/29 17:57', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2014/02/07 10:18', '2014/02/07 10:38', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Magnetogram
srch = vso_search('2014/02/07 10:18', '2014/02/07 10:38', instr = 'hmi',physobs = 'LOS_magnetic_field', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2014/02/07 10:18', '2014/02/07 10:38', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;HMI Continuum
srch = vso_search('2014/02/02 06:23', '2014/02/02 06:43', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Magnetogram
srch = vso_search('2014/02/02 06:23', '2014/02/02 06:43', instr = 'hmi',physobs = 'LOS_magnetic_field', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2014/02/02 06:23', '2014/02/02 06:43', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2014/01/07 10:06', '2014/01/07 10:26', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Magnetogram
srch = vso_search('2014/01/07 10:06', '2014/01/07 10:26', instr = 'hmi',physobs = 'LOS_magnetic_field', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2014/01/07 10:06', '2014/01/07 10:26', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2013/11/07 14:18', '2013/11/07 14:38', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2013/11/07 14:18', '2013/11/07 14:38', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2013/11/07 03:29', '2013/11/07 03:49', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2013/11/07 03:29', '2013/11/07 03:49', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2013/11/06 13:38', '2013/11/06 13:58', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2013/11/06 13:38', '2013/11/06 13:58', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2013/07/08 01:12', '2013/07/08 01:32', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2013/07/08 01:12', '2013/07/08 01:32', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2013/02/13 15:40', '2013/02/13 16:00', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2013/02/13 15:40', '2013/02/13 16:00', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2012/10/23 03:07', '2012/10/23 03:27', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2012/10/23 03:07', '2012/10/23 03:27', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2012/07/06 01:29', '2012/07/06 01:49', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2012/07/06 01:29', '2012/07/06 01:49', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2012/07/05 11:34', '2012/07/05 11:54', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2012/07/05 11:34', '2012/07/05 11:54', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;HMI Continuum
srch = vso_search('2012/07/05 03:25', '2012/07/05 03:45', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2012/07/05 03:25', '2012/07/05 03:45', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2012/07/04 09:44', '2012/07/04 10:04', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2012/07/04 09:44', '2012/07/04 10:04', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;HMI Continuum
srch = vso_search('2012/05/10 04:07', '2012/05/10 04:27', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2012/05/10 04:07', '2012/05/10 04:27', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;HMI Continuum
srch = vso_search('2012/05/09 03:24', '2012/05/09 03:44', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2012/05/09 03:24', '2012/05/09 03:44', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;HMI Continuum
srch = vso_search('2011/09/26 04:57', '2011/09/26 05:17', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2011/09/26 04:57', '2011/09/26 05:17', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;HMI Continuum
srch = vso_search('2011/07/30 01:59', '2011/07/30 02:19', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2011/07/30 01:59', '2011/07/30 02:19', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;HMI Continuum
srch = vso_search('2011/02/15 01:45', '2011/02/15 02:05', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2011/02/15 01:45', '2011/02/15 02:05', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IRIS, rasters, 1330, 1400, 2832
;downloaded via the iris website

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
end

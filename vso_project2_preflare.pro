





;HMI Dopplergram
srch = vso_search('2011/02/14 01:10', '2011/02/14 01:18', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Continuum
;srch = vso_search('2011/02/14 01:10', '2011/02/14 01:18', instr = 'hmi',physobs = 'intensity', sample = 10 )
;dat = vso_get(srch, /rice, site = 'NSO')


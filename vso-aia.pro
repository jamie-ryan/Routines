pro vso_aia
;FROM JACK
;eg0 = vso_search(‘2011/09/07 22:42’, ‘2011/09/07 22:45’, instr=‘aia’,wave='193’,sample=10)
; finds fits files for the required criteria
; start/end date/time, instrument, wavelength, cadence

;eg1 = vso_get(eg0,/rice,site=‘NSO’)
; downloads found files to current directory
; compression, source

;131 Å
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'aia',wave = '131', sample = 10 )
dat = vso_get(srch131, /rice, site = 'NSO')

;094 Å
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'aia',wave = '094', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;335 Å
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'aia',wave = '335', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;211 Å
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'aia',wave = '211', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;193 Å
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'aia',wave = '193', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;171 Å
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'aia',wave = '171', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Continuum
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'hmi',physobs = 'intensity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Magnetogram
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'hmi',physobs = 'LOS_magnetic_field', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

;HMI Dopplergram
srch = vso_search('2014/03/29 17:30', '2014/03/29 18:00', instr = 'hmi',physobs = 'LOS_velocity', sample = 10 )
dat = vso_get(srch, /rice, site = 'NSO')

end

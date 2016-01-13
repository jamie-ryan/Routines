;;download SOT data sets (put in seperate directories; CaIIH; red; blue; green)
;ca II H
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='3969', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')

;red
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='6684', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')

;blue
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='4504', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')

;green
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='5550', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')

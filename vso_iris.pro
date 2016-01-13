vso_iris

srch = vso_search('2014/03/29 17:46','2014/03/29 17:48', instr = 'iris')
dat = vso_get(srch, /rice, site = 'NSO')

end

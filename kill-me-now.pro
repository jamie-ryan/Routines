for ddd = 0, nlin -1 do begin
restore, fdir+''+directories[ddd]+'/HMI/v/doppdiff.sav'
restore, fdir+''+directories[ddd]+'/HMI/ic/fepmaps.sav'
print,directories[ddd]+' doppdiff = ', n_elements(doppdiff)
print, directories[ddd]+' pmap = ', n_elements(pmap)
endfor


20150311 doppdiff =           25
20150311 pmap =           24
20140329 doppdiff =           25
20140329 pmap =           27
20140207 doppdiff =           25
20140207 pmap =           26
20140202 doppdiff =           25
20140202 pmap =           26
20140107 doppdiff =           25
20140107 pmap =           27
201311071428 doppdiff =           25
201311071428 pmap =           27
201311070339 doppdiff =           25
201311070339 pmap =           26
20131106 doppdiff =           25
20131106 pmap =           26
20130708 doppdiff =           25
20130708 pmap =           26
20130217 doppdiff =           25
20130217 pmap =           27
20121023 doppdiff =           25
20121023 pmap =           27
20120706 doppdiff =           23
20120706 pmap =           25
201207051134 doppdiff =           25
201207051134 pmap =           26
201207050325 doppdiff =           25
201207050325 pmap =           27
20120704 doppdiff =           25
20120704 pmap =           27
20120510 doppdiff =           25
20120510 pmap =           27
20120309 doppdiff =           25
20120309 pmap =           27
20110926 doppdiff =           25
20110926 pmap =           26
20110730 doppdiff =           25
20110730 pmap =           27
20110215 doppdiff =           25
20110215 pmap =           27


restore, '/disk/solar8/sam/29mar14/sji_mgii_saub.sav'
restore, '/disk/solar8/sam/29mar14/sji_1400map.sav'


map2index, submg, submgindex, submgdata
map2index, map1400, map1400index, map1400data
;submgdata = submg.data
;map1400data = map1400.data

lowresmg = CONGRID(submgdata,306,304,n_elements(submgdata[0,0,*]))
lowres1400 = CONGRID(map1400data,306,304,n_elements(map1400data[0,0,*]))


save, /comm, /variables, filename='iris-16-03-15.sav'

; SBHMIMAP= Array[306, 304, 80]

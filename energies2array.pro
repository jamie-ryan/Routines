pro energies2array
restore,'29-Mar-2014-energies-iris-siiv-single-pixel-Oct21-2015.sav'
restore,'29-Mar-2014-energies-iris-mgii-single-pixel-Oct21-2015.sav'
restore,'29-Mar-2014-energies-iris-balmer-single-pixel-Oct21-2015.sav'
restore,'29-Mar-2014-energies-iris-mgw-single-pixel-Oct21-2015.sav'
restore, '29-Mar-2014-energies-hmi-single-pixel-Oct21-2015.sav'


;alldata = fltarr(c,f,t,d) 
;c = ribbon energy sample = 5 south ribbon + 5 north ribbon = 10 per frame (20 in total) 
;f = frame = sample points are based on ribbons in two frames = 2
;t = time = 160 elements of time string
;d = dataset = 5...0=si,1=mg,3=balmer,4=mgw,5=hmi

alldata = fltarr(10, 2, 160, 5)

;make t the same n_elements for each data set
; help, tsi[358:*]
;<Expression>    STRING    = Array[160]
; help, tmg[530:*]
;<Expression>    STRING    = Array[160]
; help, tsprb0[20:*]              
;<Expression>    STRING    = Array[160]
; help,tmgw[13:*]
;<Expression>    STRING    = Array[160]
; help, thmi
;<Expression>    STRING    = Array[160]
alldata = fltarr(10, 2, 160, 5)

;set datasets
alldata[*,*,*,0] = 'si'
alldata[*,*,*,1] = 'mg'
alldata[*,*,*,2] = 'balmer'
alldata[*,*,*,3] = 'mgw'
alldata[*,*,*,4] = 'hmi'

;fill times
for t = 0, 159 do begin
    alldata[*,*,t,0] = tsi[t]
    alldata[*,*,t,1] = tmg[t]
    alldata[*,*,t,2] = tbalmer[t]
    alldata[*,*,t,3] = tmgw[t]
    alldata[*,*,t,4] = thmi[t]
endfor

;frame loop
for y = 0, 1 do begin
    ;ribbon sample loop
    for x = 0, 9 do begin
        if (y eq 0) then xy = string(x, format = '(I0)') else xy = string(x + 10, format = '(I0)')
        xy = string(x+1)
        com = 'sidata[x,y,*] = esirb'+xy
        exe = execute(com)
        com = 'mgdata[x,y,*] = emgrb'+xy
        exe = execute(com)
        com = 'balmerdata[x,y,*] = ebalmerrb'+xy
        exe = execute(com)
        com = 'mgwdata[x,y,*] = emgwrb'+xy
        exe = execute(com)
        com = 'hmidata[x,y,*] = ehmirb'+xy
        exe = execute(com)
    endfor
endfor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

sidata = fltarr(2,10,n_elements(tsi))
mgdata = fltarr(2,10,n_elements(tmg))
balmerdata = fltarr(2,10,n_elements(tspqk))
mgwdata = fltarr(2,10,n_elements(tmgw))
hmidata = fltarr(2,10,n_elements(hmi))
  
;frame loop
;for y = 0, 1 do begin
    ;ribbon sample loop
    for x = 0, 9 do begin
        xy = string(x, format = '(I0)')
        com = 'sidata[0,x,*] = esirb'+xy
        exe = execute(com)
        com = 'mgdata[0,x,*] = emgrb'+xy
        exe = execute(com)
        com = 'balmerdata[0,x,*] = ebalmerrb'+xy
        exe = execute(com)
        com = 'mgwdata[0,x,*] = emgwrb'+xy
        exe = execute(com)
        com = 'hmidata[0,x,*] = ehmirb'+xy
        exe = execute(com)
           print, 'flag1'
    endfor
    for x = 10, 19  do begin
        xy = string(x, format = '(I0)')
        com = 'sidata[1,x-10,*] = esirb'+xy
        exe = execute(com)
        com = 'mgdata[1,x-10,*] = emgrb'+xy
        exe = execute(com)
        com = 'balmerdata[1,x-10,*] = ebalmerrb'+xy
        exe = execute(com)
        com = 'mgwdata[1,x-10,*] = emgwrb'+xy
        exe = execute(com)
        com = 'hmidata[1,x-10,*] = ehmirb'+xy
        exe = execute(com)
           print, 'flag2'
    endfor

;endfor





s1 = {energy, name:'si,'mg','balmer','mgw','hmi',energy:sidata,mgdata,balmerdata,mgwdata,hmidata,time:tsi,tmg,tspqk,tmgw,thmi} 

;if (i lt nnn-1) then begin
if (i gt 1) then begin
;comstructstr = comstructstr+','+tagarr[i]+','+dataarr[i]
comstructstr = comstructstr+','+tagarr[i]+':'+dataarr[i]
endif

if (i eq nnn-1) then begin
;comstructstr = comstructstr+','+tagarr[i]+','+dataarr[i]+')'
;comstructstr = comstructstr+')'
;comstructstr = comstructstr+','+tagarr[i]+':'+dataarr[i]+'}'
comstructstr = comstructstr+'}'
exe = execute(comstructstr)
endif

endfor
sp0tmp = {tag00:t0[*,*,*]}
com = 'sp'+lambda+'= create_struct(sp0tmp, s1)'
exe = execute(com)

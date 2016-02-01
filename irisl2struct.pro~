pro irisl2struct, lambda

;lambda = 2832, 2826, 2814, 2796
;lambda = 2832
lambda = string(lambda, format ='(I0)' )
;x = string(x, format = '(I0)' ) 
;y = string(y, format = '(I0)' )


;f = iris_files('../IRIS/*raster*.fits')
f = iris_files(path='/unsafe/jsr2/IRIS')
nnn = n_elements(f)
tagarr = strarr(nnn)
dataarr = strarr(nnn)


for i = 0, nnn-1, 1 do begin
ii = string(i, Format='(I0)')
tagarr[i] =  'tag0'+ii+'
;tagarr[i] = "'"+tagarr[i]+"'"
dataarr[i] = 't'+ii+'[*,*,*]'
com = 't'+ii+' = iris_getwindata(f['+ii+'],'+lambda+')'
exe = execute(com)
endfor


;make structures and inherit annoying tag00 :P
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
for i = 0, nnn-1, 1 do begin
ii = string(i, Format='(I0)')
if (i eq 0) then begin
name = "'big'"
;comstructstr = 'sp'+lambda+' = create_struct('+tagarr[i]+','+dataarr[i]
;comstructstr = 'sp'+lambda+'tmp = create_struct('+name+', "''",'
;comstructstr = 's1 = {'+tagarr[i]+':'+dataarr[i]
comstructstr = 's1 = {'
endif

if (i eq 1) then begin
;comstructstr = comstructstr+''+tagarr[i]+','+dataarr[i]
comstructstr = comstructstr+''+tagarr[i]+':'+dataarr[i]
endif

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;free up memory
;delvar, sp0tmp
;delvar, tagarr 
;delvar, dataarr

structname = 'sp'+lambda
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
filnm = strcompress(structname+'-'+d1+'-'+d2+'.sav', /remove_all)
com = 'save, sp'+lambda+',tagarr, filename = filnm'
exe = execute(com)
 
end

;for i = 0, nnn-1, 1 do begin
;ii = string(i, Format='(I0)')

;if (i eq 0) then begin
;comdelstr = 'delvar, t'+ii
;endif

;if (i gt 0) then begin
;comdelstr =  comdelstr+',delvar, t'+ii
;endif

;if (i eq nnn-1) then begin
;exe = execute(comdel)
;endif
;endfor



;structure syntax: sp2832 = CREATE_STRUCT('A',wd28320[*,*,*], 'B', wd28321[*,*,*])

;plot, wd+lambda+''+ii+'.wvl, wd28320.int[*,4,460]'
;oplot, wd283210.wvl, wd283210.int[*,4,460]
;plot, sp2832.a.wvl, sp2832.a.int[*,4,460]
;oplot, sp2832.b.wvl, sp2832.b.int[*,4,460]

;plotcom = 'plot, wd'+lambda+''+ii+'.wvl, wd'+lambda+''+ii+'.int[*,'+x+','+y+']'
;exe = execute(plotcom)

;plotcom = 'oplot, wd'+lambda+''+ii+'.wvl, wd'+lambda+''+ii+'.int[*,'+x+','+y+']' 
;exe = execute(plotcom)


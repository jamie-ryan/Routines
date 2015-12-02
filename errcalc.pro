function errcalc, array, q

;array must contain each variable and it's associted error
;array = fltarr(2, n)
;q = the value requiring an associated error

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;DIVISION AND MULTIPLICATION;;;;;;;;;;;;;;;;
;if q is the product and quotient, 
;   q = (x*...*z)/(u*...*w)
;then, 
;   deltq/q = sqrt((deltx/x)^2)+...+(deltz/z)^2+(deltu/u)^2)+...+(deltw/w)^2) 
;or deltq/q = ((deltx/x)^2)+...+(deltz/z)^2+(deltu/u)^2)+...+(deltw/w)^2)^(1/2)
;is the associated fractional uncertainty

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;ADDITION AND SUBTRACTION;;;;;;;;;;;;;;;;;;;
;if q is the....will eventually expand this function 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IDL> PRINT, SIZE(FINDGEN(10, 20))
;IDL prints:
;   2   10   20   4   200
;the array has 2 dimensions, equal to 10 and 20, a type code of 4, and 200 elements total
sz = size(array) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;
;error stop
if (sz[0] gt 2) then begin 
print, 'Array has too many dimensions for me to comprehend maaaaaaan...'
stop
endif
;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;so need to follow BODMAS
;BRACKETS
;1) (deltx/x)^2)
;2) sum = (deltx/x)^2)+...+(deltz/z)^2+(deltu/u)^2)+...+(deltw/w)^2
;3) deltq = sqrt(a)*q
;;;;;;;;;;;;;;;;;;;;;
;1)
delt = fltarr(sz[0])
for i = 0, sz[1] - 1 do begin
    delt[i] = (array[0,i]/array[1,i])^2
endfor
;2) 
sum = total(delt)
;3)
deltq = sqrt(sum)*q 
;;;;;;;;;;;;;;;;;;;;
return, q
end

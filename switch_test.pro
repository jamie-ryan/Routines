; SWITCH x OF
;      1: PRINT, 'one'
;      2: PRINT, 'two'
;      3: PRINT, 'three'
wave = [2825.0, 2825.1]
;wave = 1400.          
x = n_elements(wave)                                                              
case x of         
1: begin
b = 2
c = 5
d = b*c
end
2: begin
b = 1
c = 3
d = b*c
end
endcase


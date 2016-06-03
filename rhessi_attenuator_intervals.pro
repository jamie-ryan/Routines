a = where(time_intervals_secjan1979[0,*] eq atten.start_times[0], inda) 

b = where(time_intervals_secjan1979[1,*] eq atten.end_times[0], indb)

 print, time_intervals_secjan1979[0,inda], atten.end_times[0]
 print, time_intervals_secjan1979[1,indb], atten.end_times[0]

print, atten.start_times[*], atten.end_times[*]
   1.1121182e+09   1.1121183e+09   1.1121184e+09   1.1121186e+09
   1.1121183e+09   1.1121184e+09   1.1121186e+09   1.1121187e+09

atten_start_str = anytim(atten.start_times ,/yoh)
atten_end_str = anytim(atten.end_times ,/yoh)

print ,atten_start_str,atten_end_str
29-Mar-14 17:44:00.000 29-Mar-14 17:44:32.000 29-Mar-14 17:46:00.000 29-Mar-14 17:50:00.000
29-Mar-14 17:44:32.000 29-Mar-14 17:46:00.000 29-Mar-14 17:50:00.000 29-Mar-14 17:51:56.000


print, time_intervals_secjan1979                                           
   1.1121182e+09   1.1121183e+09                                                
   1.1121183e+09   1.1121183e+09                                                
   1.1121183e+09   1.1121183e+09                                                
   1.1121183e+09   1.1121183e+09                                                
   1.1121183e+09   1.1121183e+09                                                
   1.1121183e+09   1.1121184e+09                                                
   1.1121184e+09   1.1121184e+09                                                
   1.1121184e+09   1.1121184e+09                                                
   1.1121184e+09   1.1121184e+09                                                
   1.1121184e+09   1.1121184e+09
   1.1121184e+09   1.1121185e+09
   1.1121185e+09   1.1121185e+09
   1.1121185e+09   1.1121185e+09
   1.1121185e+09   1.1121185e+09
   1.1121185e+09   1.1121185e+09
   1.1121185e+09   1.1121186e+09
   1.1121186e+09   1.1121186e+09
   1.1121186e+09   1.1121186e+09
   1.1121186e+09   1.1121186e+09
   1.1121186e+09   1.1121186e+09
   1.1121186e+09   1.1121187e+09
   1.1121187e+09   1.1121187e+09
   1.1121187e+09   1.1121187e+09
   1.1121187e+09   1.1121187e+09

;this is a good method
zero = atten.start_times[0]                                                           
attenst0 = atten.start_times - zero                                                   
print, attenst0                                                                       
       0.0000000       32.000000       120.00000       360.00000    
attened0 = atten.end_times - zero
print, attened0
       32.000000       120.00000       360.00000       476.00000

ti0 = time_intervals_secjan1979 - zero                                                
print, ti0                                                                            
       0.0000000       20.000000                                                           
       20.000000       40.000000                                                           
       40.000000       60.000000                                                           
       60.000000       80.000000                                                           
       80.000000       99.000000                                                           
       99.000000       120.00000                                                           
       120.00000       139.00000                                                           
       139.00000       160.00000                                                           
       160.00000       180.00000                                                           
       180.00000       199.00000
       199.00000       220.00000
       220.00000       240.00000
       240.00000       260.00000
       260.00000       279.00000
       279.00000       300.00000
       300.00000       320.00000
       320.00000       339.00000
       339.00000       360.00000
       360.00000       380.00000
       380.00000       399.00000
       399.00000       420.00000
       420.00000       440.00000
       440.00000       459.00000
       459.00000       480.00000

ti0 = time_intervals_secjan1979 - zero   
increment = 20.
maxt = ti0[*, -1]

for i = 0, n_elements(attened0) -1 do begin
    print, i
    ws = where(ti0[0,*] lt attened0[i], ind)
    wws = array_indices(ti0[0,*], ws)
    ;last element in wws is closest to attenuator change
    ;a = ti0[0,wws[1,-1]]

    we = where(ti0[1,*] gt attened0[i], ind)
    wwe = array_indices(ti0[1,*], we)
    ;first element in wwe is closest to attenuator change
    ;b = ti0[1,wwe[1,0]]
    timebuff = 3.
    ti0[1,wwe[1,0]] = attened0[i] - timebuff
    ti0[0,wwe[1,0] + 1] = ti0[1,wwe[1,0]]
    ti0[1,wwe[1,0] + 1] = ti0[1,wwe[1,0]] + 2*timebuff 
    ti0[*, wwe[1,0] + 2 : -1] =  ti0[*, wwe[1,0]+ 2 : -1] - (ti0[0,wwe[1,0] + 2] - ti0[1,wwe[1,0] + 1]) 
    arrayextra = ceil(abs(maxt[1, -1] - max(ti0[1,*]))/increment)
        if (arrayextra gt 0.) then begin   
            tmp = fltarr(2, n_elements(ti0[0,*]) + arrayextra)
            tmp[0, 0:n_elements(ti0[0,*])-1] = ti0[0,*]
            tmp[1, 0:n_elements(ti0[0,*])-1] = ti0[1,*]
            for j = 0, arrayextra - 1 do begin
                print, n_elements(ti0[0,*]) - 1 + j
                tmp[0, n_elements(ti0[0,*]) + j] = tmp[1,n_elements(ti0[0,*]) - 1 + j]
                tmp[1, n_elements(ti0[0,*]) + j] = tmp[1,n_elements(ti0[1,*]) - 1 + j] + increment
            endfor
            ti0 = tmp
            tmp = 0
        endif
endfor













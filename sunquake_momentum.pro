pro sunquake_momentum

asqk = 2.6e16 ;cm^2
powsqk = 1.3e26 ;erg/s
strpsqk = string(powsqk, format = '(E0.2)')
;;;Sunquake momentum
rho = 1.0e-8 ;g/cm^3 photospheric plasma density
l = 2*sqrt(asqk/!pi)  ; =1.82e8 ;cm sunquake diameter
v = [1.0e6, 8.0e8] ;cm/s [photospheric soundspeed,sunquake wave speed] 
momsqk = rho*(l^3)*v ;upper and lower estimate of sunquake momentum 
strmsqk = string(momsqk[0], format = '(E0.2)')

end

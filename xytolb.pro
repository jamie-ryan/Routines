pro xytolb,x,y,l,b,radius,bangle,roll,inverse=inverse

if n_elements(bangle) eq 0 then bangle=0.
if n_elements(roll) eq 0 then roll=0.
if n_elements(radius) eq 0 then radius=960.

sector=!dtor/3600.             ;-- arcsecs to radians
semi=radius*sector             ;-- solar radius in radians
b0=double(bangle*!dtor)        ;-- bangle in radians

cosb0 = cos(b0) & sinb0 = sin(b0)

;-- convert cartesian to heliographic coordinates

if not keyword_set(inverse) then begin

 if (n_elements(x) eq 0) or (n_elements(y) eq 0) then $
   message,'please enter (x,y) coordinates'

 theta=atan(-x,y)-roll*!dtor    ;-- position angle of points on Sun (+N & +W)
 cos_theta=cos(-theta)
 sin_theta=sin(-theta)
 rho1=sqrt(x^2 + y^2)*sector      ;-- radius vector of points viewed from earth
 arg=(-1 > (rho1/semi) < 1)
 rho= asin(arg)-rho1             ;-- radius vector of points on Sun
 cos_rho=cos(rho) & sin_rho=sin(rho)
 sin_b=sinb0*cos_rho+cosb0*sin_rho*cos_theta
 b=asin(-1 > sin_b < 1)
 sin_l=sin_rho*sin_theta/cos(b)
 l=asin(-1 > sin_l < 1)

;-- heliographic coordinates in degrees

 b=!radeg*b & l=!radeg*l

;-- flag spurious points (not ready yet)

; bad=where( (rho1/semi gt 1.) or (abs(b) gt 90.) or (abs(l) gt 90.),num)
; if num gt 0 then begin b(bad)=bangle & l(bad)=0. & endif

endif else begin          ;do inverse transformation

 if (n_elements(l) eq 0) or (n_elements(b) eq 0) then $
   message,'please enter (l,b) coordinates'

 b=b*!dtor & l=l*!dtor
 cos_b=cos(b) & sin_b=sin(b)        
 cos_l=cos(l) & sin_l=sin(l)

 cos_rho=sin_b*sinb0 + cos_b*cosb0*cos_l
 rho=acos(cos_rho) & sin_rho=sin(rho) 
 cos_pos=(sin_b-sinb0*cos_rho)/cosb0/sin_rho
 sin_pos=cos_b*sin_l/sin_rho
 pos=-atan(sin_pos,cos_pos)      ;define +N & +W
 rot=-(pos+!dtor*roll)           ;add in roll

;-- apparent heliocentric radius vector (radians)

 rho1=sin_rho/(1./semi - cos_rho)   

;-- flag points that are not on solar disk 

 remove=where( ((rho1 gt semi) or (rho1 lt 0.)),count) 
 if count gt 0 then rho1(remove)=semi

;-- cartesian coordinates in arcsecs

 x=rho1*sin(rot)/sector & y=rho1*cos(rot)/sector

endelse

return & end


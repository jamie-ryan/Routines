;+
; NAME:
;            SOLRAD
; PURPOSE:
;            compute solar radius  (arcsecs) and bangle (radians)
; CATEGORY:
;            utility
; CALLING SEQUENCE:
;            r=solrad(secs79,b0,p)
; INPUTS:
;            secs79 = secs since 0 hrs UT on 1/1/79
; OUTPUTS:
;            r = solar radius (arc secs)
; OPTIONAL OUTPUT PARAMETERS:
;            b0,p = solar b and p angles (radians)
; MODIFICATION HISTORY:
;            written by GLS (ARC)
;            modified by DMZ (ARC Aug'90)
;-

function solrad,secs79,b0,p   ;return solar radius and B angle

;-- define constants used in the determination of solar radius and B0 (tilt)

period = 365.2596	; Orbital period of the earth
c0 = 0.03368     	; Associated with the eccentricity of earth's orbit
c1 = 16.068	        ; Amplitude of variation of solar diameter as measured
			;   from within earth's atmosphere
c2 = 16.044     	; Same as c1 but for outside earth's atmosphere
c3 = - 4.23986	        ; Phase shift in earth's orbit
c4 = 0.126536	        ; Constant angle (rad)
r0 = 961.452      	; Zeroth order radius inside earth's atmosphere
r1 = 959.874    	; Zeroth order radius outside earth's atmosphere

;-- compute solar radius, B0, P (position angle)

twopi=2.*!pi & secs_per_day=24.*3600. & days79=secs79/secs_per_day
angle0 = (days79-3.5)*twopi/period
angle1 = angle0 + c0*sin(angle0)	; Adjust angle for earth's 
					;   eccentricity
angle2 = angle1 + c3			; Adjust phase
r_inside = r0 + c1*cos(angle1)		; Solar radius measured inside
					;   earth's atmosphere
r = r1 + c2*cos(angle1)			; Solar radius measured outside
					;   earth's atmosphere
b0 = asin(sin(c4)*cos(angle2))		; B0
p =  atan(tan(c4)*sin(angle2))		; Position angle

return,r
end


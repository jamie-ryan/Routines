pro pmode_remove_test, y

;make sin wave for testing
x = 4*!pi/1000 * findgen(1000)
y = sin(x)
yabs = abs(y) ;everything positive
dy = deriv(yabs) ;will intersect zero at turning points (peaks and troughs)
find_min_max_turning_points = where(dy eq 0., ind) ;locate turning points
min_max_turnpoints = array_indices(dy, find_min_max_turning_points) ;locate turning points
dy2 = deriv(dy) ;find continuous gradients intersecting zero
find_cross_zero = where(dy2[*] gt 0., ind) ;finds regions where sin wave (y) crosses zero
cross_zero = array_indices(dy2, find_cross_zero) ;give array locations
;;;;works perfectly for sin, cos etc.... not working on real data... think again!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 1
;Find first peak or trough p1
;is value larger or smaller than next value?

r =  y[0] - y[1] 
if (r lt 0.) then pos = 1 else pos = -1 ;if r is negative then data must be positive gradient
;next need to keep checking each value along until the gradient reaches aturning point.... grab the indices of the turn location.... represents a peak 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 2
;look for next turning point p2



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 3
;does t between p1 and p2 approx equal 2.5mins?



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step4
;If no: Find next turning point p3... does t between p1 and p3 approx equal 2.5 mins?





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 5
;If no: does t between p1 and p3 approx equal 5 mins?



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 6
;If no: Find next turning point p4... does t between p1 and p4 approx equal 2.5 mins?



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 5
;If no: does t between p1 and p4 approx equal 5 mins?



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 6
;If no: Find next turning point p5... does t between p1 and p5 approx equal 5 mins?
;If no: return to Step 1



;If yes: Find next turning point p3... does t between p2 and p3 approx equal 2.5 mins?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Step 4
;If yes: calculate the difference between max and min contained within p1 to p3... is it less than 3*stddev?
;if no: return to Step 1
;if yes: set data between p1 and p3 to /null




end

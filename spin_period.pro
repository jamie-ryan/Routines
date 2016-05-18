function spin_period, img_obj

;The aspect solution object can be retrieved from the image object via
asp_obj=img_obj->get(/obj,class='hsi_aspect_solution')
;or created for a time interval via
;asp_obj = hsi_aspect_solution(obs_time_interval='21-apr-2002 ' + ['00:45', '00:46'])

;Once you have an aspect solution object (called asp_obj)  the following works:
;asp_obj -> plot     ; this is the same plot as above starting from the image object
;asp_obj -> plot, /plot_triangle
;spin_axes = asp_obj -> get_spin_axis() ; one pair of x,y coords per rotation
;spin_axis = asp_obj -> get_spin_axis(/average, spin_period=spin_period) print,spin_period
;asp_data = asp_obj->getdata()

;The asp_data structure returned by the call to getdata is described in the RHESSI Aspect Solution Users Guide.
;How can I find the spin axis and spin period?

;See the previous question and use:
spin_axes = asp_obj -> get_spin_axis() ; one pair of x,y coords per rotation
spin_axis = asp_obj -> get_spin_axis(/average, spin_period=spin_period) 
print,spin_period

return, spin_period
end

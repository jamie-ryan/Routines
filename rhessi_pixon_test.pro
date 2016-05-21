pro rhessi_pixon_test
search_network, /enable   
obj = hsi_image()
obj-> set, /pixon_noplot 
obj-> set, image_algorithm= 'PIXON'
obj-> set, time_bin_def= [1.00000, 2.00000, 4.00000, 4.00000, 8.00000, 16.0000, 32.0000, $
         64.0000, 64.0000]                                                                        
obj-> set, time_bin_min= 512L                                                             
obj-> set, im_energy_binning = [10.D, 100.D]
obj-> set, im_time_interval= [ '29-Mar-2014 17:44:00.000', '29-Mar-2014 17:44:30.000' ]

;array method
;this starts the processing...do I need??
data = obj-> getdata()

;map method
ffit = 'tmp.fit'
obj-> set, im_out_fits_filename = ffit
obj->fitswrite
;;;fits files to maps section
;fits2map, ffit
obj-> set, im_input_fits = ffit
hsi_fits2map, ffit, rhessimap
    

end

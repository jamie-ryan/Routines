; OSPEX script created Fri Oct  2 17:39:14 2015 by OSPEX writescript method.                 
;                                                                                            
;  Call this script with the keyword argument, obj=obj to return the                         
;  OSPEX object reference for use at the command line as well as in the GUI.                 
;  For example:                                                                              
;     ospex_script_2_oct_2015, obj=obj                                                       
;                                                                                            
;  Note that this script simply sets parameters in the OSPEX object as they                  
;  were when you wrote the script, and optionally restores fit results.                      
;  To make OSPEX do anything in this script, you need to add some action commands.           
;  For instance, the command                                                                 
;     obj -> dofit, /all                                                                     
;  would tell OSPEX to do fits in all your fit time intervals.                               
;  See the OSPEX methods section in the OSPEX documentation at                               
;  http://hesperia.gsfc.nasa.gov/ssw/packages/spex/doc/ospex_explanation.htm                 
;  for a complete list of methods and their arguments.                                       
;                                                                                            
pro ospex_script_2_oct_2015, obj=obj                                                         
if not is_class(obj,'SPEX',/quiet) then obj = ospex()                                        
obj-> set, $                                                                                 
 spex_specfile= '/unsafe/jsr2/hsi_spectrum_20140329_173000.fits'            
obj-> set, spex_drmfile= '/unsafe/jsr2/hsi_srm_20140329_173000.fits'        
obj-> set, spex_source_angle= 36.7633                                                        
obj-> set, spex_source_xy= [511.494, 261.736]                                                
obj-> set, spex_fit_manual= 2                                                                
obj-> set, spex_erange= [10.000000D, 100.00000D]                                             
obj-> set, spex_fit_time_interval= [['29-Mar-2014 17:44:24.000', $                           
 '29-Mar-2014 17:44:28.000'], ['29-Mar-2014 17:44:28.000', '29-Mar-2014 17:44:32.000'], $    
 ['29-Mar-2014 17:44:36.000', '29-Mar-2014 17:44:40.000'], ['29-Mar-2014 17:44:40.000', $    
 '29-Mar-2014 17:44:44.000'], ['29-Mar-2014 17:44:44.000', '29-Mar-2014 17:44:48.000'], $    
 ['29-Mar-2014 17:44:48.000', '29-Mar-2014 17:44:52.000'], ['29-Mar-2014 17:44:52.000', $    
 '29-Mar-2014 17:44:56.000'], ['29-Mar-2014 17:44:56.000', '29-Mar-2014 17:45:00.000'], $    
 ['29-Mar-2014 17:45:00.000', '29-Mar-2014 17:45:04.000'], ['29-Mar-2014 17:45:04.000', $    
 '29-Mar-2014 17:45:08.000'], ['29-Mar-2014 17:45:08.000', '29-Mar-2014 17:45:12.000'], $    
 ['29-Mar-2014 17:45:12.000', '29-Mar-2014 17:45:16.000'], ['29-Mar-2014 17:45:16.000', $    
 '29-Mar-2014 17:45:20.000'], ['29-Mar-2014 17:45:20.000', '29-Mar-2014 17:45:24.000'], $    
 ['29-Mar-2014 17:45:24.000', '29-Mar-2014 17:45:28.000'], ['29-Mar-2014 17:45:28.000', $    
 '29-Mar-2014 17:45:32.000'], ['29-Mar-2014 17:45:32.000', '29-Mar-2014 17:45:36.000'], $    
 ['29-Mar-2014 17:45:36.000', '29-Mar-2014 17:45:40.000'], ['29-Mar-2014 17:45:40.000', $    
 '29-Mar-2014 17:45:44.000'], ['29-Mar-2014 17:45:44.000', '29-Mar-2014 17:45:48.000'], $    
 ['29-Mar-2014 17:45:48.000', '29-Mar-2014 17:45:52.000'], ['29-Mar-2014 17:45:52.000', $    
 '29-Mar-2014 17:45:56.000'], ['29-Mar-2014 17:46:00.000', '29-Mar-2014 17:46:04.000'], $    
 ['29-Mar-2014 17:46:04.000', '29-Mar-2014 17:46:08.000'], ['29-Mar-2014 17:46:08.000', $    
 '29-Mar-2014 17:46:12.000'], ['29-Mar-2014 17:46:12.000', '29-Mar-2014 17:46:16.000'], $    
 ['29-Mar-2014 17:46:16.000', '29-Mar-2014 17:46:20.000'], ['29-Mar-2014 17:46:20.000', $    
 '29-Mar-2014 17:46:24.000'], ['29-Mar-2014 17:46:24.000', '29-Mar-2014 17:46:28.000'], $    
 ['29-Mar-2014 17:46:28.000', '29-Mar-2014 17:46:32.000'], ['29-Mar-2014 17:46:32.000', $    
 '29-Mar-2014 17:46:36.000'], ['29-Mar-2014 17:46:36.000', '29-Mar-2014 17:46:40.000'], $    
 ['29-Mar-2014 17:46:40.000', '29-Mar-2014 17:46:44.000'], ['29-Mar-2014 17:46:44.000', $    
 '29-Mar-2014 17:46:48.000'], ['29-Mar-2014 17:46:48.000', '29-Mar-2014 17:46:52.000'], $    
 ['29-Mar-2014 17:46:52.000', '29-Mar-2014 17:46:56.000'], ['29-Mar-2014 17:46:56.000', $    
 '29-Mar-2014 17:47:00.000'], ['29-Mar-2014 17:47:00.000', '29-Mar-2014 17:47:04.000'], $    
 ['29-Mar-2014 17:47:04.000', '29-Mar-2014 17:47:08.000'], ['29-Mar-2014 17:47:08.000', $    
 '29-Mar-2014 17:47:12.000'], ['29-Mar-2014 17:47:12.000', '29-Mar-2014 17:47:16.000'], $    
 ['29-Mar-2014 17:47:16.000', '29-Mar-2014 17:47:20.000'], ['29-Mar-2014 17:47:20.000', $    
 '29-Mar-2014 17:47:24.000'], ['29-Mar-2014 17:47:24.000', '29-Mar-2014 17:47:28.000'], $    
 ['29-Mar-2014 17:47:28.000', '29-Mar-2014 17:47:32.000'], ['29-Mar-2014 17:47:32.000', $    
 '29-Mar-2014 17:47:36.000'], ['29-Mar-2014 17:47:36.000', '29-Mar-2014 17:47:40.000'], $    
 ['29-Mar-2014 17:47:40.000', '29-Mar-2014 17:47:44.000'], ['29-Mar-2014 17:47:44.000', $    
 '29-Mar-2014 17:47:48.000'], ['29-Mar-2014 17:47:48.000', '29-Mar-2014 17:47:52.000'], $    
 ['29-Mar-2014 17:47:52.000', '29-Mar-2014 17:47:56.000'], ['29-Mar-2014 17:47:56.000', $    
 '29-Mar-2014 17:48:00.000'], ['29-Mar-2014 17:48:00.000', '29-Mar-2014 17:48:04.000'], $    
 ['29-Mar-2014 17:48:04.000', '29-Mar-2014 17:48:08.000'], ['29-Mar-2014 17:48:08.000', $    
 '29-Mar-2014 17:48:12.000'], ['29-Mar-2014 17:48:12.000', '29-Mar-2014 17:48:16.000'], $    
 ['29-Mar-2014 17:48:16.000', '29-Mar-2014 17:48:20.000'], ['29-Mar-2014 17:48:20.000', $    
 '29-Mar-2014 17:48:24.000'], ['29-Mar-2014 17:48:24.000', '29-Mar-2014 17:48:28.000']]      
obj-> set, spex_bk_time_interval=['29-Mar-2014 18:14:56.000', '29-Mar-2014 18:15:56.000']    
obj-> set, mcurvefit_itmax= 100L                                                             
obj-> set, fit_function= 'vth+thick2'                                                        
obj-> set, fit_comp_params= [4.99690, 1.43419, 2.36477, 23.4806, 12.1236, 41.3885, 3.92593, $
 20.4765, 146527.]                                                                           
obj-> set, fit_comp_minima= [1.00000e-20, 0.500000, 0.0100000, 1.00000e-10, 1.10000, $       
 1.00000, 1.10000, 1.00000, 100.000]                                                         
obj-> set, fit_comp_maxima= [1.00000e+20, 8.00000, 10.0000, 1.00000e+10, 20.0000, 100000., $ 
 20.0000, 1000.00, 1.00000e+07]                                                              
obj-> set, fit_comp_free_mask= [1B, 1B, 1B, 1B, 1B, 1B, 1B, 1B, 1B]                          
obj-> set, fit_comp_spectrum= ['full', '']                                                   
obj-> set, fit_comp_model= ['chianti', '']                                                   
obj-> set, spex_autoplot_bksub= 0                                                            
obj-> set, spex_autoplot_overlay_back= 0                                                     
obj-> set, spex_autoplot_photons= 1                                                          
obj-> set, spex_autoplot_units= 'Flux'                                                       
obj-> set, spex_fitcomp_plot_units= 'Flux'                                                   
obj-> set, spex_fitcomp_plot_photons= 1                                                      
obj-> set, spex_eband= [[3.00000, 6.00000], [6.00000, 12.0000], [12.0000, 25.0000], $        
 [25.0000, 50.0000], [50.0000, 100.000], [100.000, 300.000]]                                 
obj-> set, spex_tband= [['29-Mar-2014 17:30:00.000', '29-Mar-2014 17:44:47.000'], $          
 ['29-Mar-2014 17:44:47.000', '29-Mar-2014 17:59:34.000'], ['29-Mar-2014 17:59:34.000', $    
 '29-Mar-2014 18:14:21.000'], ['29-Mar-2014 18:14:21.000', '29-Mar-2014 18:29:08.000']]      
obj -> restorefit, file='/unsafe/jsr2/ospex_results_2_oct_2015.fits'        
end

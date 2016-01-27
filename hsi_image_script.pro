; hsi_image script - created Wed Jan 27 13:17:11 2016 by hsi_params2script                
; Includes all control parameters.                                                        
;                                                                                         
; Note: This script simply sets control parameters in the hsi_image object as they        
;  were when you wrote the script.  To make the object do anything in this script,        
;  you need to add some action commands.                                                  
;  For instance, the command                                                              
;   image= obj -> getdata()                                                               
; would tell the object to generate the image.                                            
;                                                                                         
; For a complete list of control parameters look at the tables in                         
; http://hesperia.gsfc.nasa.gov/ssw/hessi/doc/hsi_params_all.htm                          
;                                                                                         
; There are several ways to use this script (substitute the name of your                  
; script for hsi_xx_script in the examples below):                                        
;                                                                                         
; A. Execute it as a batch file via @hsi_xx_script                                        
; or                                                                                      
; B. Compile and execute it as a main program by:                                         
;    1. Uncomment the "end" line                                                          
;    2. .run hsi_xx_script    (or click Compile, then Execute in the IDLDE)               
;    3. Use .GO to restart at the beginning of the script                                 
; or                                                                                      
; C. Compile and run it as a procedure by:                                                
;    1. Uncomment the "pro" and "end" lines.                                              
;    2. .run hsi_xx_script    (or click Compile in the IDLDE)                             
;    3. hsi_xx_script, obj=obj                                                            
;                                                                                         
; Once you have run the script (via one of those 3 methods), you will have an             
; hsi_image object called obj that is set up as it was when you wrote the script.         
; You can proceed using obj from the command line or the hessi GUI.  To use               
; it in the GUI, type                                                                     
;   hessi,obj                                                                             
;                                                                                         
;                                                                                         
; To run this script as a procedure, uncomment the "pro" line and                         
; the last line (the "end" line).                                                         
;pro hsi_image_script, obj=obj                                                            
;                                                                                         
obj = hsi_image()                                                                         
obj-> set, cbe_digital_quality= 0.950000                                                  
obj-> set, cbe_powers_of_two= 1L                                                          
obj-> set, cull_frac= 0.500000                                                            
obj-> set, decimation_correct= 1                                                          
obj-> set, rear_decimation_correct= 0                                                     
obj-> set, det_index_mask= [0B, 0B, 0B, 1B, 1B, 1B, 1B, 1B, 0B]                           
obj-> set, flatfield= 1                                                                   
obj-> set, front_segment= 1B                                                              
obj-> set, im_energy_binning= [10.000000D, 100.00000D]                                    
obj-> set, im_time_interval= ['29-Mar-2014 17:47:18.000', '29-Mar-2014 17:47:22.000']     
obj-> set, image_algorithm= 'Clean'                                                       
obj-> set, image_dim= [64, 64]                                                            
obj-> set, modpat_skip= 1                                                                 
obj-> set, natural_weighting= 1                                                           
obj-> set, pixel_size= [4.00000, 4.00000]                                                 
obj-> set, rear_segment= 0B                                                               
obj-> set, smoothing_time= 0.500000                                                       
obj-> set, taper= 0.00000                                                                 
obj-> set, time_bin_def= [1.00000, 2.00000, 4.00000, 4.00000, 8.00000, 16.0000, 32.0000, $
 64.0000, 64.0000]                                                                        
obj-> set, time_bin_min= 1024L                                                            
obj-> set, cbe_time_bin_floor= [0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L]                       
obj-> set, uniform_weighting= 0                                                           
obj-> set, use_auto_time_bin= 1L                                                          
obj-> set, use_cull= 1                                                                    
obj-> set, use_flare_xyoffset= 1                                                          
obj-> set, use_flux_var= 1L                                                               
obj-> set, use_local_average= 0B                                                          
obj-> set, use_rate= 1                                                                    
obj-> set, use_phz_stacker= 0L                                                            
obj-> set, phz_n_phase_bins= 12L                                                          
obj-> set, phz_n_roll_bins_min= [6L, 6L, 6L, 6L, 6L, 6L, 6L, 6L, 6L]                      
obj-> set, phz_n_roll_bins_max= [64L, 64L, 64L, 64L, 64L, 64L, 64L, 64L, 64L]             
obj-> set, phz_n_roll_bins_control= [0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L]                  
obj-> set, phz_radius= 60.0000                                                            
obj-> set, phz_report_roll_bins= 0                                                        
obj-> set, profile_show_plot= 0                                                           
obj-> set, profile_plot_rate= 1                                                           
obj-> set, profile_plot_resid= 0                                                          
obj-> set, mc_ntrials= 0                                                                  
obj-> set, mc_show_plot= 0                                                                
obj-> set, clean_niter= 100                                                               
obj-> set, clean_negative_max_test= 1                                                     
obj-> set, clean_no_chi2= 1                                                               
obj-> set, clean_show_maps= 1                                                             
obj-> set, clean_show_n_maps= 1                                                           
obj-> set, clean_show_chi= 1                                                              
obj-> set, clean_show_n_chi= 1                                                            
obj-> set, clean_chi_sq_crit= -1.00000                                                    
obj-> set, clean_frac= 0.0500000                                                          
obj-> set, clean_more_iter= 0                                                             
obj-> set, clean_mark_box= 0                                                              
obj-> set, clean_progress_bar= 1                                                          
obj-> set, full_info= 0B                                                                  
obj-> set, clean_box= 0                                                                   
obj-> set, clean_cw_nop= 0                                                                
obj-> set, clean_cw_list= 0                                                               
obj-> set, clean_regress_combine= 0                                                       
obj-> set, clean_beam_width_factor= 1.00000                                               
obj-> set, nvis_min= 10                                                                   
obj-> set, nvis_min= 10                                                                   
obj-> set, vis_chi2lim= 1.00000e+09                                                       
obj-> set, vis_edit= 1B                                                                   
obj-> set, vis_conjugate= 1B                                                              
obj-> set, vis_normalize= 1B                                                              
obj-> set, vis_input_fits= ''                                                             
obj-> set, vis_out_filename= ''                                                           
obj-> set, vis_plotfit= 0B                                                                
obj-> set, vis_type= 'photon'                                                             
obj-> set, vis_photon2el= 2                                                               
                                                                                          
; Uncomment any of the following lines to take the action on obj                          
; Note: these are just examples.  There are many more options.                            
;data = obj-> getdata()    ; retrieve the last image made                                 
;data = obj-> getdata(use_single=0)  ; retrieve all images in cube                        
;obj-> plot               ; plot the last image                                           
;obj-> plotman            ; plot the last image in plotman                                
;obj-> plotman, /choose   ; choose which image(s) in cube to plot in plotman              
;                                                                                         
; To run this script as a main program or procedure, uncomment the "end" line below.      
; (To run as a procedure also uncomment the "pro" line above.)                            
;end                                                                                      

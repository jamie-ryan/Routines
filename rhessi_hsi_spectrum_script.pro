; hsi_spectrum script - created Mon Sep 21 16:21:48 2015 by hsi_params2script                
; Includes all control parameters.                                                           
;                                                                                            
; Note: This script simply sets control parameters in the hsi_spectrum object as they        
;  were when you wrote the script.  To make the object do anything in this script,           
;  you need to add some action commands.                                                     
;  For instance, the command                                                                 
;   spectrum= obj -> getdata()                                                               
; would tell the object to generate the spectrum.                                            
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
; hsi_spectrum object called obj that is set up as it was when you wrote the script.         
; You can proceed using obj from the command line or the hessi GUI.  To use                  
; it in the GUI, type                                                                        
;   hessi,obj                                                                                
;                                                                                            
;                                                                                            
; To run this script as a procedure, uncomment the "pro" line and                            
; the last line (the "end" line).                                                            
;pro hsi_spectrum_script, obj=obj                                                            
;                                                                                            
obj = hsi_spectrum()                                                                         
obj-> set, decimation_correct= 1                                                             
obj-> set, rear_decimation_correct= 0                                                        
obj-> set, obs_time_interval= ['29-Mar-2014 17:25:28.000', '29-Mar-2014 18:24:36.000']       
obj-> set, pileup_correct= 0                                                                 
obj-> set, seg_index_mask= [1B, 0B, 1B, 1B, 1B, 1B, 0B, 1B, 1B, 0B, 0B, 0B, 0B, 0B, 0B, 0B, $
 0B, 0B]                                                                                     
obj-> set, sp_chan_binning= 0                                                                
obj-> set, sp_chan_max= 0                                                                    
obj-> set, sp_chan_min= 0                                                                    
obj-> set, sp_data_unit= 'Flux'                                                              
obj-> set, sp_energy_binning= 14                                                             
obj-> set, sp_semi_calibrated= 0B                                                            
obj-> set, sp_time_interval= 4                                                               
obj-> set, sum_flag= 1                                                                       
obj-> set, time_range= [0.0000000D, 3548.0000D]                                              
obj-> set, use_flare_xyoffset= 1                                                             
obj-> set, sum_coincidence= 0                                                                


;Additional lines to create spectrum.fits and srm.fits files
obj->filewrite, /fits, /buildsrm, srmfile = 'hsi_srm_20140329_0001.fits', $
specfile = 'hsi_spectrum_20140329_0001.fits', all_simplify = 0, /create
                                                                                             
; Uncomment any of the following lines to take the action on obj                             
; Note: these are just examples.  There are many more options.                               
;data = obj->getdata()    ; retrieve the spectrum data                                       
;obj-> plot               ; plot the spectrum                                                
;obj-> plotman            ; plot the spectrum in plotman                                     
;obj-> plot, /pl_time     ; plot the time history                                            
;obj-> plotman, pl_time   ; plot the time history in plotman                                 
;                                                                                            
; To run this script as a main program or procedure, uncomment the "end" line below.         
; (To run as a procedure also uncomment the "pro" line above.)                               
;end                                                                                         

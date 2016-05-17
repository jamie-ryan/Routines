; hsi_image script - created Wed Jan 27 13:44:32 2016 by hsi_params2script                
; Includes only parameters changed from default settings.                                 
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
pro hsi_many_image_script                                                          

search_network, /enable                                                                                         
obj = hsi_image()                                                                         
obj-> set, im_energy_binning= [10.000000D, 100.00000D]                                    

;obj-> set, im_time_interval= [ ['29-Mar-2014 17:44:00.000', '29-Mar-2014 17:44:30.000'], $
;['29-Mar-2014 17:44:30.000', '29-Mar-2014 17:45:00.000'], $
;['29-Mar-2014 17:45:00.000', '29-Mar-2014 17:45:30.000'], $ 
;['29-Mar-2014 17:45:30.000', '29-Mar-2014 17:46:00.000'], $
;['29-Mar-2014 17:46:00.000', '29-Mar-2014 17:46:30.000'], $
;['29-Mar-2014 17:46:30.000', '29-Mar-2014 17:47:00.000'], $ 
;['29-Mar-2014 17:47:00.000', '29-Mar-2014 17:47:30.000']] 

;;;number of images or time intervals
nt = 7                                
time_intervals = strarr(2,nt)
time_intervals[*,0] =  ['29-Mar-2014 17:44:00.000', '29-Mar-2014 17:44:30.000']
time_intervals[*,1] =  ['29-Mar-2014 17:44:30.000', '29-Mar-2014 17:45:00.000']
time_intervals[*,2] =  ['29-Mar-2014 17:45:00.000', '29-Mar-2014 17:45:30.000']
time_intervals[*,3] =  ['29-Mar-2014 17:45:30.000', '29-Mar-2014 17:46:00.000']
time_intervals[*,4] =  ['29-Mar-2014 17:46:00.000', '29-Mar-2014 17:46:30.000']
time_intervals[*,5] =  ['29-Mar-2014 17:46:30.000', '29-Mar-2014 17:47:00.000']
time_intervals[*,6] =  ['29-Mar-2014 17:47:00.000', '29-Mar-2014 17:47:30.000']

;loop through each time interval
for i = 0, nt-1 do begin
    ;choose time interval
    obj-> set, im_time_interval= [ [time_intervals[0, i], [time_intervals[1, i]] ]

    ;;;set image construction algorithm
    ;obj-> set, image_algorithm= 'Back Projection'
    ;obj-> set, image_algorithm= 'CLEAN' 
    ;obj-> set, image_algorithm= 'PIXON' 
    ;obj-> set, image_algorithm= 'MEM_NJIT' 
    obj-> set, image_algorithm= 'FORWARDFIT'
    ;obj-> set, image_algorithm= 'VIS_FWDFIT'              

    obj-> set, time_bin_def= [1.00000, 2.00000, 4.00000, 4.00000, 8.00000, 16.0000, 32.0000, $
     64.0000, 64.0000]                                                                        
    obj-> set, time_bin_min= 512L                                                             
                                                                                              
    ; Uncomment any of the following lines to take the action on obj                          
    ; Note: these are just examples.  There are many more options.                            
    data = obj-> getdata()    ; retrieve the last image made                                 
    ;data = obj-> getdata(use_single=0)  ; retrieve all images in cube
    time_interval = time_intervals[*,i]
    ii = string(i, format = '(I0)')
    fil = 'rhessi_image_'+ii+'.sav'
    save, obj,  data, time_interval, filename = fil                         
    obj-> plot               ; plot the last image                                           
    ;obj-> plotman            ; plot the last image in plotman                                
    obj-> plotman, /choose   ; choose which image(s) in cube to plot in plotman              
    ;                                                                                         
endfor
; To run this script as a main program or procedure, uncomment the "end" line below.      
; (To run as a procedure also uncomment the "pro" line above.)                            
end                                                                                      

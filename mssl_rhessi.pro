pro mssl_rhessi
;http://www.mssl.ucl.ac.uk/surf/guides/hag/hag_sec2.html#tth_sEc2.5.2
search_network, /enable ;allows sswidl to search rhessi data
obs_summ = obj_new('hsi_obs_summary')  ; creating an instance of the class
time_interval ='29-Mar-14 '+['17:35:28','18:14:36'] ;sets time interval
counts = obs_summ -> getdata(obs_time_interval=time_interval) ;finds flare data
text = obs_summ -> list() ;shows detailed table of counts at times  

o_img = hsi_image()
qkxa = 517.2
qkya = 261.4
position = [qkxa,qkya] 
im = o_img -> getdata(obs_time=time_interval,     ; overall interval 
                      time_range=[600,780],       ; start, stop seconds from
                                                  ; start of overall interval
                      xyoffset=position           ; center for reconstruction
                      image_algorithm='clean')    ; reconstruction algorithm,
                                                  ; back-projection by default
im = o_img -> getdata(obs_time=time_interval, time_range=[600,780],xyoffset=position, image_algorithm='clean')  
o_img -> plot                                   ; plot the image  
end

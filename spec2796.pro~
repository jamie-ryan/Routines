pro spec2796, tag

;spec2796, 173

restore, '/disk/solar3/jsr2/Data/SDO/sp2796-Apr28-2015.sav'                    
tag = 173                                                                      
tag = string(tag,format = '(I0)')                                              
tag = strcompress('tag0'+tag, /remove_all)                                     
com = 'nnn1 = n_elements(sp2796.'+tag+'.wvl)'                                  
exe = execute(com)                                                             
nnn = nnn1                                                                     
spectra = dblarr(2,nnn)                                                        
com = 'spectra[0,*] = sp2796.'+tag+'.wvl[*]'                                   
exe = execute(com)                                                             
com = 'spectra[1,*] = sp2796.'+tag+'.int[*,3,435]'                             
exe = execute(com)                                                             
spectra[WHERE(spectra lT 0, /NULL)] = 0                                        
rbspectra = dblarr(2,nnn)                                                      
rbspectra[0,*] = spectra[0,*]                                                  
com = 'rbspectra[1,*] = sp2796.'+tag+'.int[*,0,485.5]'                         
exe = execute(com)                                                             
rbspectra[WHERE(rbspectra lT 0, /NULL)] = 0                                    
nfspectra = dblarr(2,nnn)                                                      
nfspectra[0,*] = spectra[0,*]                                                  
com = 'nfspectra[1,*] = sp2796.'+tag+'.int[*,3,20]'                            
exe = execute(com)                                                             
nfspectra[WHERE(nfspectra lT 0, /NULL)] = 0                                    
lcq = strcompress('/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/iris-spec-triplet.eps' ,/remove_all)
titl =  'IRIS-SPECTRA-'+sp2796.tag0173.time_ccsds[3]                                                 
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'                                                                      
xtitl = 'Wavelength'+angstrom
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
xtitl = 'Wavelength'+angstrom
mydevice=!d.name
set_plot,'ps'
device,filename=lcq,/portrait,/encapsulated, decomposed=0,color=1
plot, spectra[0,*],spectra[1,*], ytitle = ytitl, xtitle = xtitl, title = titl, xr = [2790,2807.5]
loadct, 3
oplot, rbspectra[0,*],rbspectra[1,*],  color = 150
loadct, 1
oplot, nfspectra[0,*],nfspectra[1,*],  color = 150
device, /close
set_plot, mydevice

end

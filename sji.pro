pro sji


dir = '../IRIS/' ; data dir
f = iris_files(dir+'*SJI*') ; finds all SJI files in dir
n = n_elements(f) 

	for i = 0, n-1, 1 do begin
	;ii = string(i, format = '(I0)')	
	read_iris_l2, f[i], index, data ; reads in fits files
	;exe = execute(com) ; executes above command


	

	id = strmid(f[i],43, 8) ;isolates eg SJI_1400. 43 is first character location 
				;8 is the number of characters after starting point
				;could also use index.TDESC1
	
	;;;name index and data array
	hdr = id+'_hdr' ; makes header name
	dat = id+'_dat' ; makes data array name
	com = hdr+'=index'
	exe = execute(com)
	com = dat+'=data'
	exe = execute(com)

;	d = iris_load(f[i])
;	com = id+'_hdr = d->gethdr(/struct)' ; header
;	exe = execute(com)
;	com = id+'_dat = d->getvar()' ;  slit-jaw data
;	exe = execute(com)
;	times = d->ti2utc() ; observation times




	;;;make sav file
	mth = strmid(systime(),4,3) ;grabs month string
	day = strmid(systime(),8,2) ; grabs day string
	yr = strmid(systime(),20,4) ;grabs year
	date = '-'+day+'-'+mth+'-'+yr ; makes date string
	sav = id+''+date+'.sav'
	com = 'save, '+hdr+', '+dat+', filename = sav' ; makes save file for data set
	exe = execute(com)
	endfor
end

;IDL> help,d,/obj                                                                                   
;** Object class IRIS_SJI, 0 direct superclasses, 15 known methods                                  
;   Known Function Methods:                                                                         
;      IRIS_SJI::DESCALE_ARRAY                                                                      
;      IRIS_SJI::GETHDR                                                                             
;      IRIS_SJI::GETINFO                                                                            
;      IRIS_SJI::GETNAXIS1                                                                          
;      IRIS_SJI::GETNAXIS2                                                                          
;      IRIS_SJI::GETNEXP                                                                            
;      IRIS_SJI::GETNRASTER                                                                         
;      IRIS_SJI::GETSTARTOBS                                                                        
;      IRIS_SJI::GETTIME                                                                            
;      IRIS_SJI::GETVAR                                                                             
;      IRIS_SJI::INIT                                                                               
;      IRIS_SJI::TI2TAI                                                                             
;      IRIS_SJI::TI2UTC                                                                             
;   Known Procedure Methods:                                                                        
;      IRIS_SJI::READ                                                                               
;      IRIS_SJI::READ_SJI           


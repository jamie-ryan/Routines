pro rhessi_imfits2map
search_network, /enable                                                                                         
obj = hsi_image()          

dir = '/unsafe/jsr2/rhessi-spectra-Aug4-2016/'

files = ['energy-3-to-10/increments-1keV/timg-12sec/PIXON/rhessi-imgs-energy-3-to-10-time-29-Mar-14-1744to1752.fits', $ 
'energy-10-to-20/increments-1keV/timg-12sec/PIXON/rhessi-imgs-energy-10-to-20-time-29-Mar-14-1744to1752.fits', $ 
'energy-20-to-30/increments-1keV/timg-12sec/PIXON/rhessi-imgs-energy-20-to-30-time-29-Mar-14-1744to1752.fits', $ 
'energy-30-to-40/increments-5keV/timg-12sec/PIXON/rhessi-imgs-energy-30-to-40-time-29-Mar-14-1744to1752.fits', $
'energy-40-to-50/increments-5keV/timg-12sec/PIXON/rhessi-imgs-energy-40-to-50-time-29-Mar-14-1744to1752.fits', $
'energy-50-to-60/increments-5keV/timg-12sec/PIXON/rhessi-imgs-energy-50-to-60-time-29-Mar-14-1744to1752.fits', $ 
'energy-60-to-70/increments-5keV/timg-12sec/PIXON/rhessi-imgs-energy-60-to-70-time-29-Mar-14-1744to1752.fits', $ 
'energy-70-to-80/increments-5keV/timg-12sec/PIXON/rhessi-imgs-energy-70-to-80-time-29-Mar-14-1744to1752.fits', $ 
'energy-80-to-90/increments-5keV/timg-12sec/PIXON/rhessi-imgs-energy-80-to-90-time-29-Mar-14-1744to1752.fits', $ 
'energy-90-to-100/increments-5keV/timg-12sec/PIXON/rhessi-imgs-energy-90-to-100-time-29-Mar-14-1744to1752.fits', $ 
'energy-100-to-160/increments-15keV/timg-12sec/PIXON/rhessi-imgs-energy-100-to-160-time-29-Mar-14-1744to1752.fits'] 

maps = ['m3to10', $ 
'm10to20', $ 
'm20to30', $ 
'm30to40', $
'm40to50', $
'm50to60', $ 
'm60to70', $ 
'm70to80', $ 
'm80to90', $ 
'm90to100', $ 
'm100to160'] 
       
  
for i = 0, n_elements(files) - 1 do begin
;;;fits files to maps section
;fits2map, ffit
obj-> set, im_input_fits = files[i]
hsi_fits2map, dir+files[i], map
com = maps[i]+'= map'
exe = execute(com)
endfor
end

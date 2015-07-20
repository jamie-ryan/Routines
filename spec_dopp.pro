pro dopp, wavf, intf, wave0

;;;find max intensity location in spectra array
peak =  max(intf, ind)

;;;use max intensity location to find central wavelength
;need to convert to true indices if want to use in full spectral range
centroid = wavf[ind]

if (centroid gt wave0) then shift = centroid - wave0 else shift = wave0 - centroid 


return, shift

end

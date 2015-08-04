
file = '../IRIS/*173*'
f = iris_files(file)
d = iris_load(f)
d->show_lines

for i = 8, 5 do begin
ii = string(i, format = '(I0)')
com = 'wav'+ii+' = d->getlam('+ii+')'
exe = execute(com)

set_plot,'z'
		fileplot = filename + string(i, format ='(I1)' ) + '.png'
		plot, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
	        oplot, [width[0],width[0]], [max(qkspectra[1,(inc)*i:inc*(i+1)-1]),max(qkspectra[1,(inc)*i:inc*(i+1)-1])]
		image = tvread(TRUE=3)
		image = transpose(image, [2,0,1])
		write_png, fileplot, image
		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
set_plot,'x'




set_plot,'z'
		fileplot = filename + string(k, format ='(I1)' ) + '.png'
		plot, spectra[0,(inc)*k:inc*(k+1)-1], spectra[1,(inc)*k:inc*(k+1)-1]
	        oplot, [width[0],width[0]], [max(spectra[1,(inc)*k:inc*(k+1)-1]),max(spectra[1,(inc)*k:inc*(k+1)-1])]
		image = tvread(TRUE=3)
		image = transpose(image, [2,0,1])
		write_png, fileplot, image
set_plot,'x'

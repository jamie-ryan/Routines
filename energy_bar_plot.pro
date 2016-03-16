pro energy_bar_plot, fdate
restore, '/unsafe/jsr2/'+fdate+'/29-Mar-2014-integrated-energies-structure'+fdate+'.sav'
;dataset = ['HXR', 'Si IV', 'Mg II', 'Balm Cont', 'Mg II wing', 'HMI Cont']
dataset = [1,2,3,4,5,6]
a = tag_names(integrated_energies)
;assuming tag names are DESCRIPTION TSTART TEND RHESSI SI_IV MG_II BALMER MGW HMI
nset = n_elements(a) - 3 ;i.e, RHESSI SI_IV MG_II BALMER MGW HMI
ncoords = n_elements(integrated_energies.si_iv.eimp)
energyset = fltarr(nset, ncoords)
energy = 'Integrated Energy [erg cm!E-2!N]'
for i = 0, ncoords - 1 do begin
energyset[0, i] = integrated_energies.rhessi.eimp
energyset[1, i] = integrated_energies.si_iv.eimp[i]
energyset[2, i] = integrated_energies.mg_ii.eimp[i]
energyset[3, i] = integrated_energies.balmer.eimp[i]
energyset[4, i] = integrated_energies.mgw.eimp[i]
energyset[5, i] = integrated_energies.hmi.eimp[i]

rangemax = max(energyset[*,i]) + 0.05*max(energyset[*,i])

b1 = BARPLOT(dataset, energyset[*,i], INDEX=0, NBARS=2, $

   FILL_COLOR='green', YRANGE=[0, rangemax], YMINOR=0, $

   YTITLE= energy, XTITLE='Data Set', $

   TITLE = 'Solar Flare Emission Energies Integrated Over The Impulsive Phase')
endfor


end

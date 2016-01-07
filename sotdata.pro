

;;;Use Hinode SOT data to sanity check HMI energy code.
;;;Based on the data analysis by Kerr & Fletcher 2014, they used:
;;;SOT Broadband Filter Imager (BFI), 3 continuum channels (RGB)

;;;vso search and download sot data.
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59', instr = 'sot', physical_observable=intensity)
dat = vso_get(srch, /rice, site = 'NSO')







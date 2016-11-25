    print, 'sorting, grabbing unique values and removing duplicate detections'
    ;sort and remove duplicates from dopptrans
    openw, lll, 'tmp.dat', /get_lun, /append    
    printf, lll, temporary(dopptrans)
    free_lun, lll
    ;get linux (any shell) to do the sorting and identify unique and duplicate coords
    spawn, 'sort tmp.dat | uniq  > tmp1.dat' ;uniques and duplicates
;    spawn, 'sort tmp.dat | uniq -u > tmp1.dat' ;uniques
;    spawn, 'sort tmp.dat | uniq -d >> tmp1.dat' ;duplicates

    ;read sorted and duplicate removed coordinates into array, replacing dopptrans
    print, 'filling array with sorted unique detections'    
    openr, lll, 'tmp1.dat', /get_lun
    nlin =  file_lines('tmp1.dat')
    dopptrans = fltarr(2,nlin)
    readf, lll, dopptrans
    free_lun, lll    


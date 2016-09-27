function nth_momentum_e, e_nth, fitparams, tau, timg, abeam

powelec = e_nth/timg
me = !const.me*1.e3 ;g
mp = !const.mp*1.e3 ;g
n_e = fitparams[0]*1.0e35 ;n_e = n_p
ve = 1.21e8 ;cm/s electron velocity
momelec = (powelec*tau)/(ve) ;g.cm/s
return, momelec
end

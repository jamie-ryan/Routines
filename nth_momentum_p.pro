function nth_momentum_p, pe
me = !const.me*1.e3 ;g
mp = !const.mp*1.e3 ;g

pp = pe*sqrt(mp/me) ;g.cm/s
return, pp
end

pro time_elapsed
tic



;Time elapsed
tsec_total = toc()
thr = tsec_total/60./60.
thr_remainder = thr - fix(thr)
tmin = thr_remainder * 60.
tmin_remainder = tmin - fix(tmin)
tsec = tmin_remainder * 60.

thr = string(thr, format = '(I0)')
tmin = string(tmin, format = '(I0)')
if (tsec lt 0.01) then tsec = string(tsec, format = '(E0.2)') else $
tsec = string(tsec, format = '(F0.2)')
print, 'Time elapsed: '+thr+' hours, '+tmin+' minutes and '+tsec+' seconds.
end

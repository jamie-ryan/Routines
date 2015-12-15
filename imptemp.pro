pro imptemp
restore, 'Dec9-2015/29-Mar-14-impulsive-phase-Dec9.sav'

siav = total(eimpsi[*, 0: 9])/20
mgav = total(eimpmg[*, 0: 9])/20
balmav = total(eimpbalm[*, 0: 9])/20
mgwav = total(eimpmgw[*, 0: 9])/20
hmiav = total(eimphmi[*, 0: 9])/20

sisunqk = eimpsi[0, 10]
mgsunqk = eimpmg[0, 10]
balmsunqk = eimpbalm[0, 10]
mgwsunqk = eimpmgw[0, 10]
hmisunqk = eimphmi[0, 10]
end

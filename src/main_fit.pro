function main_fit, x, p, ygal=ygal, emline=emline, l=l

; Opretter en powerlaw kurve ud fra formlen y = k * x^a
k = p[0] & a = p[1]
ypow = k * x^a

; Justerer bidraget fra galaksen
i1 = where(x ge l[0])  &  i2 = where(x ge l[1])
gal = mean(ygal[i1[0]:i2[0]])
pow = mean(ypow[i1[0]:i2[0]])
rgalpow = p[2]
ygal1 = ygal / gal * pow * rgalpow

; Adderer powerlaw'en og galaksen
y = ygal1 + ypow

nemlines = n_elements(emline)
; Opretter den første emissionlinje
if nemlines ge 1 then begin
   yemline1 = addemline(x, p[3], p[4], p[5], emline[0])
   y += yemline1
endif

; Opretter den anden emissionlinje og lægger den til spektret
if nemlines ge 2 then begin
   yemline2 = addemline(x, p[6], p[7], p[8], emline[1])
   y += yemline2
endif
 
; Opretter den tredje emissionlinje og lægger den til spektret
if nemlines ge 3 then begin
   yemline3 = addemline(x, p[9], p[10], p[11], emline[2])
   y += yemline3
endif

; Opretter den fjerde emissionlinje og lægger den til spektret
if nemlines ge 4 then begin
   yemline4 = addemline(x, p[12], p[13], p[14], emline[3])
   y += yemline4
endif

; Opretter den femte emissionlinje og lægger den til spektret
if nemlines ge 5 then begin
   yemline5 = addemline(x, p[15], p[16], p[17], emline[4])
   y += yemline5
endif

; Returnerer resultatet
return, y
end

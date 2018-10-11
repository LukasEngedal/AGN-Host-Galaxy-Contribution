function simdata_iter, h, dx, ygal, header, l, emline, SN, z, s, k, a, rgalpow, $
                       my1, sigma1, remline1, my2, sigma2, remline2, my3, sigma3, remline3, $
                       my4, sigma4, remline4, my5, sigma5, remline5

nemlines = n_elements(emline)

; Opretter de ønskede x-værdier
m = (h[1] - h[0]) / dx + 1
x0 = findgen(m) * dx + h[0]

; Udregner galaksens flux og x-værdier
mgal = sxpar(header, 'naxis1')
x0gal = sxpar(header, 'crval1')
dxgal = sxpar(header, 'cdelt1')
xgal0 = findgen(mgal) * dxgal + x0gal

; Interpolerer galaksen til de ønskede x-værdier
linterp, xgal0, ygal, x0, ygal2, MISSING = 0

; Opretter en powerlaw kurve ud fra formlen y = k * x^a
ypow = k * x0^a

; Tilføjer galakse flux
y0 = addgal(x0, ypow, ygal2, rgalpow, l)

if nemlines ge 1 then begin
   ; Opretter den første emissionslinje
   yemline1 = addemline(x0, my1, sigma1, remline1, emline[0])
   y0 += yemline1
endif

if nemlines ge 2 then begin
   ; Opretter den anden emissionlinje
   yemline2 = addemline(x0, my2, sigma2, remline2, emline[1])
   y0 += yemline2
endif

if nemlines ge 3 then begin
   ; Opretter den tredje emissionlinje
   yemline3 = addemline(x0, my3, sigma3, remline3, emline[2])
   y0 += yemline3
endif

if nemlines ge 4 then begin
   ; Opretter den tredje emissionlinje
   yemline4 = addemline(x0, my4, sigma4, remline4, emline[3])
   y0 += yemline4
endif

if nemlines ge 5 then begin
   ; Opretter den tredje emissionlinje
   yemline5 = addemline(x0, my5, sigma5, remline5, emline[4])
   y0 += yemline5
endif

; Tilføjer støj ud fra det givne S/N-forhold
y1 = addnoise(y0, 0, SN+10, s)
SN1 = determsnr(y1)
y = addnoise(y1, SN1, SN, s+1)

; Tilpasser x-værdierne i tilfælde af at der er angivet en rødforskydning
x = x0 * (1. + z)

; Indlæser strukturen data skal gemmes i
n = n_elements(y)
result = simdata_iter_init(n, nemlines)

; Gemmer data over i result
result.x0 = x[0]
result.dx = x[1] - x[0]
result.z = z
result.flux = y
result.k = k
result.a = a
result.rgalpow = rgalpow
result.SN = SN
result.emline = emline
result.l = l

if nemlines ge 1 then begin
   result.my1 = my1
   result.sigma1 = sigma1
   result.remline1 = remline1
endif

if nemlines ge 2 then begin
   result.my2 = my2
   result.sigma2 = sigma2
   result.remline2 = remline2
endif

if nemlines ge 3 then begin
   result.my3 = my3
   result.sigma3 = sigma3
   result.remline3 = remline3
endif

if nemlines ge 4 then begin
   result.my4 = my4
   result.sigma4 = sigma4
   result.remline4 = remline4
endif

if nemlines ge 5 then begin
   result.my5 = my5
   result.sigma5 = sigma5
   result.remline5 = remline5
endif

; Returnerer resultatet
return, result
end

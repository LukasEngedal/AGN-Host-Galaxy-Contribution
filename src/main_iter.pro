pro main_iter, data, parinfo, result0, result, m, SN2, dx1, rgalpow1, emline, highemlinerest, ygal0, header2, debug=debug

; Udpakker data
y = data.flux
n = n_elements(y)
x0 = data.x0
dx = data.dx
x = findgen(n) * dx + x0
l = data.l
SN0 = data.SN
nemlines = n_elements(emline)

; Justerer rødforskydningen
ymax = max(y)
imax = where(y eq ymax)
xmax = float(x[imax[0]])
z = xmax / highemlinerest - 1
x1 = x / (z + 1)

; Indlæser galaksens x-værdier
mgal = sxpar(header2,'NAXIS1')
x0gal = sxpar(header2,'CRVAL1')
dxgal = sxpar(header2,'CDELT1')
xgal = findgen(mgal) * dxgal + x0gal

; Tilpasser parinfo
parinfo[0].step *= dx1/dx
parinfo[0].value *= dx1/dx
if nemlines ge 1 then begin
   parinfo[5].step *= dx1/dx
   parinfo[5].value *= dx1/dx
endif
if nemlines ge 2 then begin 
   parinfo[8].step *= dx1/dx
   parinfo[8].value *= dx1/dx
endif
if nemlines ge 3 then begin
   parinfo[11].step *= dx1/dx
   parinfo[11].value *= dx1/dx
endif
if nemlines ge 4 then begin
   parinfo[14].step *= dx1/dx
   parinfo[14].value *= dx1/dx
endif
if nemlines ge 5 then begin
   parinfo[17].step *= dx1/dx
   parinfo[17].value *= dx1/dx
endif

; Opretter arrays
kfit = make_array(m, /DOUBLE)
afit = make_array(m, /DOUBLE)
rgalpowfit = make_array(m, /DOUBLE)
rgalpowfiterr = make_array(m, /DOUBLE)
y5100fit = make_array(m, /DOUBLE)
niterfit = make_array(m, /DOUBLE)
if nemlines ge 1 then begin
   my1fit = make_array(m, /DOUBLE)
   sigma1fit = make_array(m, /DOUBLE)
   remline1fit = make_array(m, /DOUBLE)
endif
if nemlines ge 2 then begin
   my2fit = make_array(m, /DOUBLE)
   sigma2fit = make_array(m, /DOUBLE)
   remline2fit = make_array(m, /DOUBLE)
endif
if nemlines ge 3 then begin
   my3fit = make_array(m, /DOUBLE)
   sigma3fit = make_array(m, /DOUBLE)
   remline3fit = make_array(m, /DOUBLE)
endif
if nemlines ge 4 then begin
   my4fit = make_array(m, /DOUBLE)
   sigma4fit = make_array(m, /DOUBLE)
   remline4fit = make_array(m, /DOUBLE)
endif
if nemlines ge 5 then begin
   my5fit = make_array(m, /DOUBLE)
   sigma5fit = make_array(m, /DOUBLE)
   remline5fit = make_array(m, /DOUBLE)
endif

; Tilpasser galaksen til x-værdierne
linterp, xgal, ygal0, x1, ygal1

; Tilføjer galakse flux
y1 = addgal(x1, y, ygal1, rgalpow1, l)

; Degraderer data
degrade, x1, y1, dx1, x2, y2
if SN0 eq 0 then SN1 = 0
if SN0 ne 0 then begin
   if dx ne dx1 then SN1 = determsnr(y1)
   if dx eq dx1 then SN1 = SN0
endif

; Tilpasser galaksen til de nye x-værdier
linterp, xgal, ygal0, x2, ygal2

; Kører de m iterationer
for i = 0, m-1 do begin
   j = i
   
   ; Tilføjer støj
   y3 = addnoise(y2, SN1, SN2, j)
   err = y3 / SN2
  
   ; Kører data igennem mpfitfun første gang
   p1 = mpfitfun('main_fit', x2, y3, err, functargs={ygal: ygal2, emline: emline, l: l}, $
                  parinfo=parinfo, perror=perror, niter=niter1, maxiter = 100, /QUIET)
   
   ; Justerer parinfo efter hvad mpfitfun fandt første gang
   parinfo2 = parinfo
   main_adjustparinfo, parinfo2, p1, nemlines
   
   ; Kører data igennem mpfitfun anden gang 
   p2 = mpfitfun('main_fit', x2, y3, err, functargs={ygal: ygal2, emline: emline, l: l}, $
                  parinfo=parinfo2, perror=perror, niter=niter2, maxiter = 100, /QUIET)   
   
   ; Udpakker p2
   kfit[i]      = p2[0]   &  afit[i]      = p2[1]   &  rgalpowfit[i] = p2[2]
   if nemlines ge 1 then begin
      my1fit[i] = p2[3]   &  sigma1fit[i] = p2[4]   &  remline1fit[i] = p2[5]
   endif
   if nemlines ge 2 then begin
      my2fit[i] = p2[6]   &  sigma2fit[i] = p2[7]   &  remline2fit[i] = p2[8]
   endif
   if nemlines ge 3 then begin
      my3fit[i] = p2[9]   &  sigma3fit[i] = p2[10]  &  remline3fit[i] = p2[11]
   endif
   if nemlines ge 4 then begin
      my4fit[i] = p2[12]  &  sigma4fit[i] = p2[13]  &  remline4fit[i] = p2[14]
   endif
   if nemlines ge 5 then begin
      my5fit[i] = p2[15]  &  sigma5fit[i] = p2[16]  &  remline5fit[i] = p2[17]
   endif
   niterfit[i]  = niter1 + niter2
endfor

if keyword_set(debug) then begin
   ; Udregner mean af de forskellige parametrer
   p = make_array(3+3*nemlines, /DOUBLE)
   p[0]    = mean(kfit)    &   p[1] = mean(afit)        &   p[2] = mean(rgalpowfit)
   if nemlines ge 1 then begin
      p[3] = mean(my1fit)  &   p[4] = mean(sigma1fit)   &   p[5] = mean(remline1fit)
   endif
   if nemlines ge 2 then begin
      p[6] = mean(my2fit)  &   p[7] = mean(sigma2fit)   &   p[8] = mean(remline2fit)
   endif
   if nemlines ge 3 then begin
      p[9] = mean(my3fit)  &   p[10] = mean(sigma3fit)  &   p[11] = mean(remline3fit)
   endif
   if nemlines ge 4 then begin
      p[12] = mean(my4fit)  &   p[13] = mean(sigma4fit)  &   p[14] = mean(remline4fit)
   endif
   if nemlines ge 5 then begin
      p[15] = mean(my5fit)  &   p[16] = mean(sigma5fit)  &   p[17] = mean(remline5fit)
   endif
endif
nitermean = mean(niterfit)

; Printer
if keyword_set(debug) then begin
   print, 'kfit            = ', p[0]
   print, 'afit            = ', p[1]
   print, 'rgalpowfit      = ', p[2]
   if nemlines ge 1 then begin
      print, 'my1fit          = ', p[3]
      print, 'sigma1fit       = ', p[4]
      print, 'remline1fit     = ', p[5]
   endif
   if nemlines ge 2 then begin
      print, 'my2fit          = ', p[6]
      print, 'sigma2fit       = ', p[7]
      print, 'remline2fit     = ', p[8]
   endif
   if nemlines ge 3 then begin
      print, 'my3fit          = ', p[9]
      print, 'sigma3fit       = ', p[10]
      print, 'remline3fit     = ', p[11]
   endif
   if nemlines ge 4 then begin
      print, 'my4fit          = ', p[12]
      print, 'sigma4fit       = ', p[13]
      print, 'remline4fit     = ', p[14]
   endif
   if nemlines ge 5 then begin
      print, 'my5fit          = ', p[15]
      print, 'sigma5fit       = ', p[16]
      print, 'remline5fit     = ', p[17]
   endif
endif
print, 'Avg number of MPFIT iterations       = ', nitermean

if keyword_set(debug) then begin
   ; Udregner fittet med henblik på plot
   yfit = main_fit(x2, p, ygal=ygal2, emline=emline, l=l)
   
   ; Indlæser farver
   device, decomposed = 0 
   col=getcolor(/load)
   WINDOW, 0, XSIZE=800, YSIZE=500

   ; Plotter
   plot, x2, y3, /nodata, background = col.white, col=col.black
   oplot, x2, y3, col=col.blue
   oplot, x2, yfit, thick = 2, col=col.red
endif

; Opretter og udfylder result
result = result0
result.x0 = x2[0]
result.dx = x2[1] - x2[0]
result.flux = y3
result.rgalpow = rgalpow1
result.kfit = kfit
result.afit = afit
result.rgalpowfit = rgalpowfit
result.meanniterfit = nitermean
result.SN = SN2
result.l = l
result.emline = emline
result.niter = m
result.z = z

if nemlines ge 1 then begin
   result.my1fit = my1fit
   result.sigma1fit = sigma1fit
   result.remline1fit = remline1fit
endif

if nemlines ge 2 then begin
   result.my2fit = my2fit
   result.sigma2fit = sigma2fit
   result.remline2fit = remline2fit
endif

if nemlines ge 3 then begin
   result.my3fit = my3fit
   result.sigma3fit = sigma3fit
   result.remline3fit = remline3fit
endif

if nemlines ge 4 then begin
   result.my4fit = my4fit
   result.sigma4fit = sigma4fit
   result.remline4fit = remline4fit
endif

if nemlines ge 5 then begin
   result.my5fit = my5fit
   result.sigma5fit = sigma5fit
   result.remline5fit = remline5fit
endif

end

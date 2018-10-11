function addemline, x, my, sigma, remline, type

if type eq 0 then begin
   n = n_elements(x)
   blank = make_array(n)
   return, blank
endif

if type eq 1 then begin
   ; Beregner gaussfunktionen ud fra de givne my, sigma og remline
   upper_limit = my + sigma * 10.
   lower_limit = my - sigma * 10.
   mask = (x lt upper_limit) and (x gt lower_limit)
   gauss = mask * 1. / (sigma * sqrt(2.*!dpi)) * exp(-(x - my)^2 / (2. * sigma^2)*mask)
   ygauss = gauss * remline
   return, ygauss
endif

if type eq 2 then begin
   ; Beregner Lorentz funktionen ud fra de givne my, sigma og remline
   upper_limit = my + sigma * 10.
   lower_limit = my - sigma * 10.
   mask = (x lt upper_limit) and (x gt lower_limit)   
   lorentz = 1 / !dpi * 0.5 * sigma / ((x - my)^2 + (0.5 * sigma)^2) * mask
   ylorentz = lorentz * remline
   return, ylorentz
endif

end

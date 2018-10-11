pro main, data0, pathname, filename, set, parinfo, SN1, dx1, rgalpow1, emline, highemlinerest, m, debug=debug

; Indlæser galaksen
ygal = mrdfits('/home/lukas/Bachelorprojekt/Uge7/data/gal.fits', 0, header2, /SILENT)

nSN = n_elements(SN1)
ndx = n_elements(dx1)
nrgalpow = n_elements(rgalpow1)
n = n_elements(data0[0].flux)
nemlines = n_elements(emline)

; Putter data igennem MPFITFUN
count2 = 0
niter = nSN*ndx*nrgalpow
;print, n, m, nSN, ndx, nrgalpow, nemlines
result0 = main_iter_init(n, m, nSN, ndx, nrgalpow, nemlines)
data1 = make_array(niter/ndx, VALUE = result0)
for i=0, ndx-1 do begin
   count = 0
   for j=0, nSN-1 do begin
      for k=0, nrgalpow-1 do begin
         ; Starter stopuret
         t0 = SYSTIME(/SECONDS)	
         
         ; Udregner de m fit
         main_iter, data0, parinfo, result0, result, m, SN1[j], dx1[i], rgalpow1[k], emline, highemlinerest, ygal, header2, debug=debug
         data1[count] = result
         
         ; Stopper stopuret og printer
         tend = SYSTIME(/SECONDS)
         dt = round(tend - t0)
         print, 'Elapsed time during fit, in min, sec  = ', [dt/60, dt - (dt/60) * 60]
         print, 'Number of fits remaining              = ', (niter - count - count2)
         dttotal = (niter - count - count2)*dt
         print, 'Estimated time remaining, in min ,sec = ', [dttotal/60, dttotal - (dttotal/60) * 60]
         count += 1
      endfor
   endfor
   count2 += count
   ; Gemmer SN1, dx1 og rgalpow1
   data1.SNs = SN1
   data1.dxs = dx1
   data1.rgalpows = rgalpow1

   if not keyword_set(debug) then begin
      ; Gemmer data
      file1 = strcompress(pathname + filename + 'fit' + string(set) + 'dx' + string(dx1[i]) + '.fits', /REMOVE_ALL)
      mwrfits, data1, file1, /CREATE
   endif

endfor

end

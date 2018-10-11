function determsnr, y, noise=noise

if not keyword_set(noise) then begin
   ; Virker ikke så godt for små n 
   n = n_elements(y)
   y1 = reverse(y)
   
   if 0.01*n < 0.5 then step = 1 else step = round(0.01*n)
   set = round(0.05*n)
   limit = 1.2
   SN1 = make_array(n / step)
   count = 0
   ; Startende fra i=0 og frem i skridt af 'step' undersøges sæt af 'set' punkter.
   for i = 0, (n - set), step do begin
      ; i er startpunktet og j er slutpunktet for intervallet der undersøges
      j = i + set - 1
      y2 = y1[i:j]
      ; Udregner mean, max og min af intervallets y-værdier
      meany = mean(y2)
      maxy = max(y2)
      miny = min(y2)
      x = findgen(set)
      ; Tjekker at forskellen på (max - mean) og (mean - min) ikke er mere end 'limit' i intervallet, og hvis det er opfyldt køres rutinen
      if maxy - meany lt limit * (meany - miny) and $
         meany - miny lt limit * (maxy - meany) then begin
         ; Fitter en lige linje til punkterne
         fit = linfit(x,y2)
         A = fit[1] & B = fit[0]
         liny = A * x + B
         ; Udregner variansen og derefter standard afvigelsen og S/N-forholdet
         var = 1. / (set-1) * total((y2 - liny)^2) 
         sigma = var^0.5
         SN2 = meany / sigma
         ; Gemmer S/N-forholdet i et array sammen med tidligere udregnede S/N-forhold
         SN1[count] = SN2
         count += 1
      endif
   endfor
   
   ; Midler over alle de fundne S/N-forhold
   SN = mean(SN1[0:count-1])
   ;print, SN
endif

; VIRKER IKKE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
if keyword_set(noise) then begin
   n = n_elements(noise)
   step = 0.01
   SN1 = make_array(n)
   count = 0
   for i = 0.5*step*n, n*(1-0.5*step)-1, 0.5*step*n do begin
      sigmai = (total(noise[i-0.5*step*n:i+0.5*step*n]^2) / (step*n-1))^0.5	;stddev(noise[i-0.5*step*n:i+0.5*step*n])
      y2 = mean(y[i-0.5*step*n:i+0.5*step*n])
      SN1[count] = y2 / sigmai
      count += 1
   endfor
   SN = mean(SN1[0:count-1])
endif

return, SN
end

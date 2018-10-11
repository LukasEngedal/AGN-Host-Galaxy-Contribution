pro degrade, x, y, dx1, x1, y1

dx0 = x[1] - x[0]
dx = dx1 / float(dx0)
n = n_elements(x)
m = floor(n / dx)
   
; Tjekker at dx1 ikke er den samme som dx0
if dx0 eq dx1 then begin
   x1 = x
   y1 = y
endif

; Tjekker at dx1 ikke er mindre end dx0
if dx1 lt dx0 then MESSAGE, ' Kan ikke ændre til en højere opløsning!'

; Degraderer data, hvis dx0 går op i dx1 
if dx1 mod dx0 eq 0 then begin

   ; Hvis dx går op i antallet af punkter køres dette
   if m eq n / float(dx) then begin
      x0 = x[0] - 0.5 * dx0 + 0.5 * dx1
      x1 = findgen(m) * dx1 + x0
      y1 = make_array(m)
      c = 0
      for i = 0, n-dx, dx do begin
         j = i + dx - 1 
         y2 = total(y[i:j])
         y1[c] = y2
         c += 1
      endfor
   endif

   ; Hvis dx ikke går op i antallet af punkter, og der dermed er overskydende endepunkter, køres dette der tager hensyn til sådanne
   if m ne n / float(dx) then begin
      x0 = x[0] - 0.5 * dx0 + 0.5 * dx1
      x1 = findgen(m+1) * dx1 + x0
      y1 = make_array(m+1)
      noise1 = make_array(m+1)
      c = 0
      for i = 0, n-dx, dx do begin
         j = i + dx - 1
         y2 = total(y[i:j])
         y1[c] = y2
         c += 1
      endfor
      l = n - m * dx
      y1[c] = total(y[m*dx:n-1]) * dx / l
   endif
endif

; Degraderer data, hvis dx0 IKKE går op i dx1 
if dx1 mod dx0 ne 0 then begin
   if m eq n / float(dx) then begin
      a = 0
      x0 = x[0] - 0.5 * dx0 + 0.5 * dx1				; Beregner den nye første x-værdi
      x1 = findgen(m) * dx1 + x0				; Opretter resten af x-værdierne
      y1 = make_array(m)
      i = 0
      for c = 0, m-1 do begin
         y2 = (1 - a) * y[i]					; Starter med at tage den resterende del af det sidstudvalgte datapunkt
         i += 1							; Går videre til næste datapunkt
         dx2 = dx - (1 - a)					; Justerer hvor meget der mangler
         j = floor(dx2)						; Beregner hvor mange hele datapunkt der kan udvælges
         if j gt 0 then y2 += total(y[i:i+j-1])			; Lægger de hele datapunkter til hvis der er nogen
         i += j							; Justerer hvor langt vi er nået
         dx2 -= j						; Justerer hvor meget der mangler
         if dx2 gt 0 then y2 += dx2 * y[i]			; Udvælger den manglende del af det sidste datapunkt hvis der er en sådan
         y1[c] = y2						; Gemmer resultatet i vores nye array
         a = dx2						; Gør klar til næste kørsel
      endfor
    endif
    
    if m ne n / float(dx) then begin
      a = 0
      x0 = x[0] - 0.5 * dx0 + 0.5 * dx1				; Beregner den nye første x-værdi
      x1 = findgen(m+1) * dx1 + x0				; Opretter resten af x-værdierne
      y1 = make_array(m+1)
      i = 0
      for c = 0, m-1 do begin
         y2 = (1 - a) * y[i]					; Starter med at tage den resterende del af det sidstudvalgte datapunkt
         i += 1							; Går videre til næste datapunkt
         dx2 = dx - (1 - a)					; Justerer hvor meget der mangler
         j = floor(dx2)						; Beregner hvor mange hele datapunkt der kan udvælges
         if j gt 0 then y2 += total(y[i:i+j-1])			; Lægger de hele datapunkter til hvis der er nogen
         i += j							; Justerer hvor langt vi er nået
         dx2 -= j						; Justerer hvor meget der mangler
         if dx2 gt 0 then y2 += dx2 * y[i]			; Udvælger den manglende del af det sidste datapunkt hvis der er en sådan
         y1[c] = y2						; Gemmer resultatet i vores nye array
         a = dx2						; Gør klar til næste kørsel
      endfor
      dxend = n mod dx						; Beregner hvor mange datapunkter der er tilbage
      y2 = (1 - a) * y[i]					; Starter med at tage den resterende del af det sidstudvalgte datapunkt
      i += 1							; Går videre til næste datapunkt
      dx2 = dxend - (1 - a)					; Justerer hvor meget der mangler
      if dx2 gt 0 then y2 += total(y[i:i+dx2-1])		; Lægger de resterende hele datapunkter til hvis der er nogen
      y2 = y2 * dx / dxend					; Ganger den resterende mængde flux med dx / dxend for at få et bud på fluxen
      y1[m] = y2
    endif
endif

end

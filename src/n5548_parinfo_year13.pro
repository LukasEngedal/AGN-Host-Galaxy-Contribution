function n5548_parinfo_year13, nemlines

; Definerer antallet af parametre
; parameters = [k, a, rgal, my1, sigma1, remline1, my2, sigma2, remline2, my3, sigma3, remline3, my4, sigma4, remline4, my5, sigma5, remline5]
; Powerlaw: k * x^a
; Rgalpow er forholdet imellem galaksen og powerlaw'en i et givet interval
; My1 er placeringen af den første emissionslinje, sigma1 er bredden af linjen og remline1 er den faktor gausskurven er blevet ganget med
; My2, sigma2 og remline2 er for den 2. emissionslinje
; My3, sigma3 og remline3 er for den 3. emissionslinje
; My4, sigma4 og remline4 er for den 4. emissionslinje
; My5, sigma5 og remline5 er for den 5. emissionslinje
np = 3 + 3 * nemlines
parinfo = replicate({value:0.D, fixed:0, limited:[0,0], limits:[0,0], step:0}, np)
 
; Definerer grænserne, startværdien og step-værdien for parameter 1, k
parinfo[0].limited = [1,0]
parinfo[0].limits = [0.D, 0.D]
parinfo[0].step = 1E-15
parinfo[0].value = 1E-15

; Definerer grænserne, startværdien og step-værdien for parameter 2, a
parinfo[1].limited = [1,1]
parinfo[1].limits = [-4.D, 0.5D]
parinfo[1].step = -0.1D
parinfo[1].value = -0.1D
   
; Definerer grænserne, startværdien og step-værdien for parameter 3, rgalpow
parinfo[2].limited = [1,0]
parinfo[2].limits = [0.D, 0.D]
parinfo[2].step = 0.01D
parinfo[2].value = 0.10D
   
if nemlines ge 1 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 4, my1
   parinfo[3].limited = [1,1]
   parinfo[3].limits = [4650, 4750]
   parinfo[3].step = 5
   parinfo[3].value = 4700

   ; Definerer grænserne, startværdien og step-værdien for parameter 5, sigma1
   parinfo[4].limited = [1,0]
   parinfo[4].limits = [0.D, 100.D]
   parinfo[4].step = 1.D 
   parinfo[4].value = 10.D
 
   ; Definerer grænserne, startværdien og step-værdien for parameter 6, remline1
   parinfo[5].limited = [1,0]
   parinfo[5].limits = [0.D, 0.D]
   parinfo[5].step = 1E-15
   parinfo[5].value = 1E-15
endif
   
if nemlines ge 2 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 7, my2
   parinfo[6].limited = [1,1]
   parinfo[6].limits = [4825, 4875]
   parinfo[6].step = 1
   parinfo[6].value = 4860
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 8, sigma2
   parinfo[7].limited = [1,0]
   parinfo[7].limits = [0.D, 50.D]
   parinfo[7].step = 1.D
   parinfo[7].value = 30.D
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 9, remline2
   parinfo[8].limited = [1,0]
   parinfo[8].limits = [0.D, 0.D]
   parinfo[8].step = 1E-15
   parinfo[8].value = 1E-14
endif

if nemlines ge 3 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 10, my3
   parinfo[9].limited = [1,1]
   parinfo[9].limits = [4875, 4925]
   parinfo[9].step = 1
   parinfo[9].value = 4910
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 11, sigma3
   parinfo[10].limited = [1,0]
   parinfo[10].limits = [0.D, 50.D]
   parinfo[10].step = 1.D
   parinfo[10].value = 30.D
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 12, remline3
   parinfo[11].limited = [1,0]
   parinfo[11].limits = [0.D, 0.D]
   parinfo[11].step = 1E-15
   parinfo[11].value = 1E-14
endif

if nemlines ge 4 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 13, my4
   parinfo[12].limited = [1,1]
   parinfo[12].limits = [5060, 5150]
   parinfo[12].step = 10
   parinfo[12].value = 5100
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 14, sigma4
   parinfo[13].limited = [1,0]
   parinfo[13].limits = [0.D, 50.D]
   parinfo[13].step = 1.D
   parinfo[13].value = 10.D
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 15, remline4
   parinfo[14].limited = [1,0]
   parinfo[14].limits = [0.D, 0.D]
   parinfo[14].step = 1E2
   parinfo[14].value = 5E2
endif

if nemlines ge 5 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 16, my5
   parinfo[15].limited = [1,1]
   parinfo[15].limits = [6550, 6750]
   parinfo[15].step = 10
   parinfo[15].value = 6650
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 17, sigma5
   parinfo[16].limited = [1,0]
   parinfo[16].limits = [0.D, 50.D]
   parinfo[16].step = 2.D
   parinfo[16].value = 100.D
   
   ; Definerer grænserne, startværdien og step-værdien for parameter 18, remline5
   parinfo[17].limited = [1,0]
   parinfo[17].limits = [0.D, 0.D]
   parinfo[17].step = 2E2
   parinfo[17].value = 2E3
endif
          
return, parinfo
end


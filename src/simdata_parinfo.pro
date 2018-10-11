function simdata_parinfo, nemlines, k, a, rgalpow, my1, sigma1, remline1, my2, sigma2, remline2, my3, sigma3, remline3, $
                          my4, sigma4, remline4, my5, sigma5, remline5

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
parinfo[0].step = k * 0.05
parinfo[0].value = k * 1.27

; Definerer grænserne, startværdien og step-værdien for parameter 2, a
parinfo[1].limited = [1,1]
parinfo[1].limits = [-4.D, 0.5D]
parinfo[1].step = a * 0.05
parinfo[1].value = a * 1.23
   
; Definerer grænserne, startværdien og step-værdien for parameter 3, rgalpow
parinfo[2].limited = [1,0]
parinfo[2].limits = [0.D, 0.D]
parinfo[2].step = rgalpow * 0.05
parinfo[2].value = rgalpow * 1.28
 
if nemlines ge 1 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 4, my1
   parinfo[3].limited = [1,1]
   parinfo[3].limits = [my1*0.75, my1*1.25]
   parinfo[3].step = my1 * 0.05
   parinfo[3].value = my1 * 1.14

   ; Definerer grænserne, startværdien og step-værdien for parameter 5, sigma1
   parinfo[4].limited = [1,0]
   parinfo[4].limits = [0, 0]
   parinfo[4].step = sigma1 * 0.05
   parinfo[4].value = sigma1 * 1.24
 
   ; Definerer grænserne, startværdien og step-værdien for parameter 6, remline1
   parinfo[5].limited = [1,0]
   parinfo[5].limits = [0.D, 0.D]
   parinfo[5].step = remline1 * 0.05
   parinfo[5].value = remline1 * 1.34
endif

if nemlines ge 2 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 7, my2
   parinfo[6].limited = [1,1]
   parinfo[6].limits = [my2*0.75, my2*1.25]
   parinfo[6].step = my2 * 0.05
   parinfo[6].value = my2 * 1.23

   ; Definerer grænserne, startværdien og step-værdien for parameter 8, sigma2
   parinfo[7].limited = [1,0]
   parinfo[7].limits = [0, 0]
   parinfo[7].step = sigma2 * 0.05
   parinfo[7].value = sigma2 * 1.22
 
   ; Definerer grænserne, startværdien og step-værdien for parameter 9, remline2
   parinfo[8].limited = [1,0]
   parinfo[8].limits = [0.D, 0.D]
   parinfo[8].step = remline2 * 0.05
   parinfo[8].value = remline2 * 1.34
endif

if nemlines ge 3 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 10, my3
   parinfo[9].limited = [1,1]
   parinfo[9].limits = [my3*0.75, my3*1.25]
   parinfo[9].step = my3 * 0.05
   parinfo[9].value = my3 * 1.21

   ; Definerer grænserne, startværdien og step-værdien for parameter 11, sigma3
   parinfo[10].limited = [1,0]
   parinfo[10].limits = [0, 0]
   parinfo[10].step = sigma3 * 0.05
   parinfo[10].value = sigma3 * 1.21
 
   ; Definerer grænserne, startværdien og step-værdien for parameter 12, remline3
   parinfo[11].limited = [1,0]
   parinfo[11].limits = [0.D, 0.D]
   parinfo[11].step = remline3 * 0.05
   parinfo[11].value = remline3 * 1.36
endif

if nemlines ge 4 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 10, my4
   parinfo[12].limited = [1,1]
   parinfo[12].limits = [my4*0.75, my4*1.25]
   parinfo[12].step = my4 * 0.05
   parinfo[12].value = my4 * 1.13

   ; Definerer grænserne, startværdien og step-værdien for parameter 11, sigma4
   parinfo[13].limited = [1,0]
   parinfo[13].limits = [0, 0]
   parinfo[13].step = sigma4 * 0.05
   parinfo[13].value = sigma4 * 1.23
 
   ; Definerer grænserne, startværdien og step-værdien for parameter 12, remline4
   parinfo[14].limited = [1,0]
   parinfo[14].limits = [0.D, 0.D]
   parinfo[14].step = remline4 * 0.05
   parinfo[14].value = remline4 * 1.31
endif

if nemlines ge 5 then begin
   ; Definerer grænserne, startværdien og step-værdien for parameter 10, my5
   parinfo[15].limited = [1,1]
   parinfo[15].limits = [my5*0.75, my5*1.25]
   parinfo[15].step = my5 * 0.05
   parinfo[15].value = my5 * 1.14

   ; Definerer grænserne, startværdien og step-værdien for parameter 11, sigma5
   parinfo[16].limited = [1,0]
   parinfo[16].limits = [0, 0]
   parinfo[16].step = sigma5 * 0.05
   parinfo[16].value = sigma5 * 1.32
 
   ; Definerer grænserne, startværdien og step-værdien for parameter 12, remline5
   parinfo[17].limited = [1,0]
   parinfo[17].limits = [0.D, 0.D]
   parinfo[17].step = remline5 * 0.05
   parinfo[17].value = remline5 * 1.23
endif
         
return, parinfo
end


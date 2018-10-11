function addnoise, y0, SN0, SN, s0

n = n_elements(y0)

if SN0 ne 0 and SN ne 0 then begin
   if SN gt SN0 then begin
      Message, 'The target S/N-ratio cannot be larger than the default S/N-ratio'
   endif

   ; Udregner sigma0 ud fra den nuværende SN, udregner sigma ud fra den ønskede SN, og beregner så 
   ; dsigma, som bestemmer hvor meget støj der skal til for at gå fra den nuværende til den ønskede SN, 
   ; idet sigma^2 = sigma0^2 + dsigma^2
   sigma0 = y0 / SN0
   sigma = y0 / SN
   dsigma = (sigma^2 - sigma0^2)^0.5
   
   ; Beregner støjen ud fra den beregnede dsigma
   s = s0 + randomu(seed) * 100.
   noise = randomn(s, n) * dsigma

   ; Lægger støjen til spektrum
   y = y0 + noise
endif

if SN0 eq 0 and SN ne 0 then begin
   sigma = y0 / SN
   s = s0 + randomu(seed) * 100.
   noise = randomn(s, n) * sigma
   y = y0 + noise
endif

if SN eq 0 then begin
   y = y0
endif

return, y
end

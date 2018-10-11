pro main_adjustparinfo, parinfo, p, nemlines

parinfo[0].step = p[0] * 0.05
parinfo[0].value = p[0]

parinfo[1].step = p[1] * 0.05
parinfo[1].value = p[1]
   
parinfo[2].step = p[2] * 0.05
parinfo[2].value = p[2]
 
if nemlines ge 1 then begin
   parinfo[3].step = p[3] * 0.05
   parinfo[3].value = p[3]

   parinfo[4].step = p[4] * 0.05
   parinfo[4].value = p[4]
 
   parinfo[5].step = p[5] * 0.05
   parinfo[5].value = p[5]
endif

if nemlines ge 2 then begin
   parinfo[6].step = p[6] * 0.05
   parinfo[6].value = p[6]

   parinfo[7].step = p[7] * 0.05
   parinfo[7].value = p[7]
 
   parinfo[8].step = p[8] * 0.05
   parinfo[8].value = p[8]
endif

if nemlines ge 3 then begin
   parinfo[9].step = p[9] * 0.05
   parinfo[9].value = p[9]

   parinfo[10].step = p[10] * 0.05
   parinfo[10].value = p[10]

   parinfo[11].step = p[11] * 0.05
   parinfo[11].value = p[11]
endif

if nemlines ge 4 then begin
   parinfo[12].step = p[12] * 0.05
   parinfo[12].value = p[12]

   parinfo[13].step = p[13] * 0.05
   parinfo[13].value = p[13]

   parinfo[14].step = p[14] * 0.05
   parinfo[14].value = p[14]
endif

if nemlines ge 5 then begin
   parinfo[15].step = p[15] * 0.05
   parinfo[15].value = p[15]

   parinfo[16].step = p[16] * 0.05
   parinfo[16].value = p[16]

   parinfo[17].step = p[17] * 0.05
   parinfo[17].value = p[17]
endif
         
end

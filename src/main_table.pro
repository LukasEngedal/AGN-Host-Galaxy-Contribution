pro main_table, set=set, sn=sn, dx=dx

; SÆT 1:
if set eq 1 then begin
   niter = 200
   SN0 = [40, 30, 20, 10, 5]
   rgalpow0 = [1.00, 0.95, 0.90, 0.85, 0.80, $
               0.75, 0.70, 0.65, 0.60, 0.55, $
               0.50, 0.45, 0.40, 0.35, 0.30, $
               0.25, 0.20, 0.15, 0.10, 0.05]
   nSN = n_elements(SN0)
   nrgalpow = n_elements(rgalpow0)
endif

; SÆT 2:
if set eq 2 then begin
   niter = 200
   SN0 = [40, 30, 20, 10, 5]
   rgalpow0 = [0.01, 0.02, 0.03, 0.04, 0.05, $
	       0.06, 0.07, 0.08, 0.09, 0.10, $
	       0.11, 0.12, 0.13, 0.14, 0.15, $
	       0.16, 0.17, 0.18, 0.19, 0.20]
   nSN = n_elements(SN0)
   nrgalpow = n_elements(rgalpow0)
endif

; SÆT 3:
if set eq 3 then begin
   niter = 200
   SN0 = [40, 30, 20, 10, 5]
   rgalpow0 = [0.02, 0.04, 0.06, 0.08, 0.10, $
	       0.12, 0.14, 0.16, 0.18, 0.20, $
	       0.22, 0.24, 0.26, 0.28, 0.30, $
	       0.32, 0.34, 0.36, 0.38, 0.40]
   nSN = n_elements(SN0)
   nrgalpow = n_elements(rgalpow0)
endif

; SÆT 4:
if set eq 4 then begin
   niter = 200
   SN0 = [40, 30, 20, 10, 5]
   rgalpow0 = (findgen(100) + 1) / 100
   nSN = n_elements(SN0)
   nrgalpow = n_elements(rgalpow0)
endif

pathname = '/home/lukas/Bachelorprojekt/Uge6/rgal/data/set' + string(set) + '/'
filename = strcompress(pathname + 'set' + string(set) + 'n' + string(niter) + 'dx' + string(dx) + '.fits', /REMOVE_ALL)
data0 = mrdfits(filename, 1, header1, /SILENT)

; Udvælger data
for i = 0, nSN-1 do begin
   if SN eq SN0[i] then data1 = data0[i*nrgalpow:(i+1)*nrgalpow-1] & s = 1
endfor
if s ne 1 then Message, ' There is no dataset with the given S/N-ratio!'

rgalpow = data1.rgalpow
rgalpowfit = data1.rgalpowfit
rgalpowfiterr = data1.rgalpowfiterr

; Gemmer data i tabeller
pathname1 = '/home/lukas/Bachelorprojekt/Uge6/rgal/tables/set' + string(set) + '/'
filename1 = strcompress(pathname1 + 'set' + string(set) + 'sn' + string(sn) + 'dx' + string(dx) + '.dat', /REMOVE_ALL)
openw, 1, filename1
writecol, filename1, rgalpow, rgalpowfit, rgalpowfiterr, fmt = '(d,d,d)'

end

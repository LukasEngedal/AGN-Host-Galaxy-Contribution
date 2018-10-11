pro simdata_setup, debug=debug

; Definerer de forskellige variable
set = 5		      			; Nr. på datasættet
emline = [1,1,2];[1,1,2,1,2]			; Antallet af emissionslinjer der skal fittes
m = 20  				; Antallet af iterations
SN1 = 40;[40, 30, 20, 10, 5]		; De ønskede S/N-forhold
dx1 = 2;[2, 4, 6, 8, 10]			; De ønskede opløsninger
if set eq 1 then $			; De ønskede rgalpow værdier
rgalpow1 = [1.00, 0.95, 0.90, 0.85, 0.80, $
           0.75, 0.70, 0.65, 0.60, 0.55, $
           0.50, 0.45, 0.40, 0.35, 0.30, $
           0.25, 0.20, 0.15, 0.10, 0.05]
if set eq 2 then $
rgalpow1 = [0.01, 0.02, 0.03, 0.04, 0.05, $
	   0.06, 0.07, 0.08, 0.09, 0.10, $
	   0.11, 0.12, 0.13, 0.14, 0.15, $
	   0.16, 0.17, 0.18, 0.19, 0.20]
if set eq 3 then $
rgalpow1 = [0.02, 0.04, 0.06, 0.08, 0.10, $
	   0.12, 0.14, 0.16, 0.18, 0.20, $
	   0.22, 0.24, 0.26, 0.28, 0.30, $
	   0.32, 0.34, 0.36, 0.38, 0.40]
if set eq 4 then rgalpow1 = (findgen(100) + 1) / 100
if set eq 5 then rgalpow1 = [0]

pathname = '/home/lukas/Bachelorprojekt/Uge7/data/simdata/'
filename = 'simdata1'
file = strcompress(pathname + filename + '.fits', /REMOVE_ALL)
data0 = mrdfits(file, 1, header1, /SILENT)

nemlines = n_elements(emline)
parinfo = simdata_parinfo(nemlines, data0[0].k, data0[0].a, data0[0].rgalpow, data0[0].my1, data0[0].sigma1, data0[0].remline1, $
	                  data0[0].my2, data0[0].sigma2, data0[0].remline2, data0[0].my3, data0[0].sigma3, data0[0].remline3, $
	                  data0[0].my4, data0[0].sigma4, data0[0].remline4, data0[0].my5, data0[0].sigma5, data0[0].remline5)

main, data0, pathname, filename, set, parinfo, SN1, dx1, rgalpow1, emline, m, debug=debug

end



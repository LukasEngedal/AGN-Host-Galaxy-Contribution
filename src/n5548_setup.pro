pro n5548_setup, debug=debug

; Definerer de forskellige variable
year = 13					; Datasættet der skal fittes
emline = [1,1,1]				; Antallet af emissionslinjer der skal fittes
m = 200  					; Antallet af iterations
SN1 = 0;[40, 30, 20, 15, 10, 7, 5]		; De ønskede S/N-forhold
dx1 = 2;[2, 4, 6]					; De ønskede opløsninger
set = 1						; Nr. på sættet af rgalpow værdier
rgalpow1 = [0]					; De ønskede rgalpow værdier
highemlinerest = 4861				; Laboratoriebølgelængden for emissionslinjen med den højeste top

pathname = '/home/lukas/Bachelorprojekt/Uge7/data/n5548/'
filename = 'year' + string(year)
file = strcompress(pathname + filename + '.dat', /REMOVE_ALL)
readcol, file, x, y, blank, format = 'f,f,f', /SILENT
parinfo = n5548_parinfo_year13(n_elements(emline))

; Tilpasser data så programmet kan læse dem
data0 = {x0: x[0], dx: x[1] - x[0], flux: y, l: [5050, 5150], SN: determsnr(y)}
SN1 = determsnr(y)
main, data0, pathname, filename, set, parinfo, SN1, dx1, rgalpow1, emline, highemlinerest, m, debug=debug

end


pro main_plot_snplot, dataset, name, set, save=save

dx = [2, 4, 6]

; Indlæser det første datasæt
pathname = '/home/lukas/Bachelorprojekt/Uge7/data/' + string(dataset) + '/'
filename = strcompress(pathname + string(name) + 'fit' + string(set) + 'dx' + string(dx[0]) + '.fits', /REMOVE_ALL)
data0 = mrdfits(filename, 1, header1, /SILENT)
n = n_elements(dx)
m = n_elements(data0)

SN = data0[0].SNs
rgalpowfit = make_array(n*m, /DOUBLE)
rgalpowfiterr = make_array(n*m, /DOUBLE)
count = 0
for i = 0, n-1 do begin
   filename = strcompress(pathname + string(name) + 'fit' + string(set) + 'dx' + string(dx[i]) + '.fits', /REMOVE_ALL)
   data = mrdfits(filename, 1, header1, /SILENT)
   for j = 0, m-1 do begin
      rgalpowfit[count+j] = mean(data[j].rgalpowfit, /DOUBLE)
      rgalpowfiterr[count+j] = stddev(data[j].rgalpowfit, /DOUBLE)
   endfor
   count += m
endfor

errline1 = rgalpowfit + rgalpowfiterr
errline2 = rgalpowfit - rgalpowfiterr

; Indlæser farver
device, decomposed = 0 
col=getcolor(/load)
WINDOW, 0, XSIZE=800, YSIZE=500

; Plotter det første datasæt
plot, SN, rgalpowfit[0*m:1*m-1], /nodata, background=col.white, col=col.black, yr = [0,max(rgalpowfit)*2]
oplot, SN, rgalpowfit[0*m:1*m-1], PSYM=2, col=col.blue
oplot, SN, errline1[0*m:1*m-1], col=col.blue
oplot, SN, errline2[0*m:1*m-1], col=col.blue
oplot, SN, rgalpowfit[1*m:2*m-1], PSYM=2, col=col.red
oplot, SN, errline1[1*m:2*m-1], col=col.red
oplot, SN, errline2[1*m:2*m-1], col=col.red
oplot, SN, rgalpowfit[2*m:3*m-1], PSYM=2, col=col.magenta
oplot, SN, errline1[2*m:3*m-1], col=col.magenta
oplot, SN, errline2[2*m:3*m-1], col=col.magenta
legend, ['Mean', 'Mean+stddev', 'Mean-stddev', $
         strcompress('dx ='+string(round(dx[0]))), $
         strcompress('dx ='+string(round(dx[1]))), $
         strcompress('dx ='+string(round(dx[2])))], $
         psym=[2,0,0,2,2,2], /right_legend, /top_legend, textcolors = col.black, $
         color = [col.black, col.black, col.black, col.blue, col.red, col.magenta], $
         charsize = 1.3
end

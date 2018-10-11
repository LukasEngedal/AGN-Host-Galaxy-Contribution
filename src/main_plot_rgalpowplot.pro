pro main_plot_rgalpowplot, data0, set, SN=SN, save=save

; Udvælger data
SN0 = data0[0].SNs
nSN = n_elements(SN0)
rgalpows = data0[0].rgalpows
nrgalpow = n_elements(rgalpows)

if keyword_set(SN) then begin
   for i = 0, nSN-1 do begin
      if SN eq SN0[i] then data = data0[i*nrgalpow:(i+1)*nrgalpow-1] & s = 1
   endfor
   if s ne 1 then Message, ' There is no dataset with the given S/N-ratio!'
endif

if not keyword_set(SN) then data = data0

; Opstiller data

n = n_elements(data)
rgalpow = make_array(n)
rgalpowfit = make_array(n)
rgalpowstd = make_array(n)
for i = 0, n-1 do begin
   rgalpow[i] = data[i].rgalpow
   rgalpowfit[i] = mean(data[i].rgalpowfit)
   rgalpowstd[i] = stddev(data[i].rgalpowfit)
endfor
ratio = rgalpowfit / rgalpow
err = rgalpowstd / rgalpow

if not keyword_set(SN) then begin
    errline1 = ratio + err
    errline2 = ratio - err
endif

; Indlæser farver
device, decomposed = 0 
col=getcolor(/load)
WINDOW, 0, XSIZE=800, YSIZE=500

if set eq 1 then l = [0.8, 1.2]
if set ne 1 then l = [0.6, 1.4]

; Plotter for en given S/N-ratio
if keyword_set(SN) then begin
   plot, rgalpow, ratio, /nodata, background = col.white, col=col.black, $
      xr = [0, max(rgalpow)+0.05], yr = [l[0],l[1]], $;[min(ratio)-err[-2], max(ratio)+err[-2]], $
      charsize = 1.3, xtitle = 'rgalpow', ytitle = 'rgalpowfit / rgalpow', $
      title = strcompress('rgalpowfit / rgalpow as a function of rgalpow for' + $
      ' SN =' + string(round(SN)) + ' and dx =' + string(round(data[0].dx)))
   oplot, rgalpow, ratio, PSYM = 2, col = col.blue
   oplot, [0,100], [1,1], col=col.black
   if not keyword_set(noerr) then begin
      oploterror, rgalpow, ratio, err, psym = 3, errcolor = col.red
   endif
   legend, ['Mean', 'Mean+stddev', 'Mean-stddev'], psym=[2,0,0], /right_legend, /top_legend, $
           textcolors = col.black, color = [col.blue, col.red, col.red], charsize = 1.3
   
   ; Gemmer plottet hvis keyword'et er sat
   if keyword_set(save) then begin
      Device, decomposed=1
      image24=TVRD(True=1)
      pathname = '/home/lukas/Bachelorprojekt/Uge7/rgal/rgalpowplot/set' + string(set) + '/'
      filename = strcompress(pathname + 'set' + string(set) + 'dx' + $
                 string(round(data[0].dx)) + 'sn' + string(SN) + '.jpg', /REMOVE_ALL)
      write_jpeg, filename, image24, Quality=100, True=1 
   endif
endif

; Plotter for alle de forskellige S/N-ratios
if not keyword_set(SN) then begin
   m = nrgalpow
   plot, rgalpow, ratio, /nodata, background = col.white, col=col.black, $
         xr = [0, max(rgalpow)+0.05], yr = [l[0],l[1]], $
         charsize = 1.3, xtitle = 'rgalpow', ytitle = 'rgalpowfit / rgalpow', $
         title = strcompress('Rgalpowfit / rgalpow as a function of rgalpow for' + $
         ' different S/N and for dx =' + string(round(data[0].dx)))
   oplot, rgalpow[0*m:1*m-1], ratio[0*m:1*m-1], PSYM = 2, col = col.blue
   oplot, rgalpow[1*m:2*m-1], ratio[1*m:2*m-1], PSYM = 2, col = col.red
   oplot, rgalpow[2*m:3*m-1], ratio[2*m:3*m-1], PSYM = 2, col = col.magenta
   oplot, rgalpow[3*m:4*m-1], ratio[3*m:4*m-1], PSYM = 2, col = col.cyan
   oplot, rgalpow[4*m:5*m-1], ratio[4*m:5*m-1], PSYM = 2, col = col.gray
   oplot, [0,100], [1,1], col=col.black
   if not keyword_set(noerr) then begin
      oplot, rgalpow[0*m:1*m-1], errline1[0*m:1*m-1], color = col.blue
      oplot, rgalpow[1*m:2*m-1], errline1[1*m:2*m-1], color = col.red
      oplot, rgalpow[2*m:3*m-1], errline1[2*m:3*m-1], color = col.magenta
      oplot, rgalpow[3*m:4*m-1], errline1[3*m:4*m-1], color = col.cyan
      oplot, rgalpow[4*m:5*m-1], errline1[4*m:5*m-1], color = col.gray
      oplot, rgalpow[0*m:1*m-1], errline2[0*m:1*m-1], color = col.blue
      oplot, rgalpow[1*m:2*m-1], errline2[1*m:2*m-1], color = col.red
      oplot, rgalpow[2*m:3*m-1], errline2[2*m:3*m-1], color = col.magenta
      oplot, rgalpow[3*m:4*m-1], errline2[3*m:4*m-1], color = col.cyan
      oplot, rgalpow[4*m:5*m-1], errline2[4*m:5*m-1], color = col.gray
   endif
   legend, ['Mean', 'Mean+stddev', 'Mean-stddev', $
            strcompress('S/N ='+string(round(SN0[0]))), $
            strcompress('S/N ='+string(round(SN0[1]))), $
            strcompress('S/N ='+string(round(SN0[2]))), $
            strcompress('S/N ='+string(round(SN0[3]))), $
            strcompress('S/N ='+string(round(SN0[4])))], $
           psym=[2,0,0,2,2,2,2,2], /right_legend, /top_legend, textcolors = col.black, $
           color = [col.black, col.black, col.black, col.blue, col.red, col.magenta, col.cyan, col.gray], $
           charsize = 1.3
   
   ; Gemmer plottet hvis keyword'et er sat
   if keyword_set(save) then begin        
      Device, decomposed=1
      image24=TVRD(True=1)
      pathname = '/home/lukas/Bachelorprojekt/Uge7/rgalpowplot/set' + string(set) + '/'
      filename = strcompress(pathname + 'set' + string(set) + 'dx' + string(round(data[0].dx)) + '.jpg', /REMOVE_ALL)
      write_jpeg, filename, image24, Quality=100, True=1 
   endif
endif 

end

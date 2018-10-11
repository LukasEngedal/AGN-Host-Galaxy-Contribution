pro main_plot_hist, data0, set=set, SN=SN, rgalpow=rgalpow, save=save

; Udvælger data
SN0 = data0[0].SNs
nSN = n_elements(SN0)
rgalpows = data0[0].rgalpows
nrgalpow = n_elements(rgalpows)

for i = 0, nSN-1 do begin
   if SN eq SN0[i] then data1 = data0[i*nrgalpow:(i+1)*nrgalpow-1] & s = 1
endfor
if s ne 1 then Message, ' There is no dataset with the given S/N-ratio!'

for i = 0, nrgalpow-1 do begin
   if rgalpow eq rgalpows[i] then data = data1[i] & t = 1
endfor
if t ne 1 then Message, ' There is no dataset with the given rgalpow!'

; Udpakker data
dx = data.dx
rgalpow = data.rgalpow
rgalpowfit = data.rgalpowfit
ratio = rgalpowfit / rgalpow

; Udregner median, mean og stddev
ymedian = median(rgalpowfit, /EVEN, /DOUBLE) / rgalpow
ymean = mean(rgalpowfit, /DOUBLE) / rgalpow
sigma = stddev(rgalpowfit, /DOUBLE) / rgalpow

; Indlæser farver og opsætter vindue
device, decomposed = 0 
col=getcolor(/load)
WINDOW, 0, XSIZE=800, YSIZE=500

; Udregner histogrammet
range = max(ratio)-min(ratio)
if range le 0.10 then binsize = 0.0025
if range gt 0.10 and range le 0.20 then binsize = 0.005
if range gt 0.20 and range le 0.50 then binsize = 0.010
if range gt 0.50 and range le 1.00 then binsize = 0.025
if range gt 1.00 and range le 2.00 then binsize = 0.05
if range gt 2.00 and range le 3.00 then binsize = 0.10
if range gt 3.00 then binsize = 0.2
i0 = where(ratio eq min(ratio)) & i1 = i0[0]
ratio[i1] = ratio[i1] - (ratio[i1] mod binsize)
histo = HISTOGRAM(ratio, binsize = binsize)
bins = FINDGEN(N_ELEMENTS(histo)) * binsize + min(ratio)

; Plotter
plot, bins, histo, /nodata, background = col.white, col=col.black, $
      xr = [min(bins)-binsize,max(bins)+binsize], yr = [0, max(histo)+1], $
      charsize = 1.3, xtitle = 'rgalpowfit/rgalpow', ytitle = 'counts', $
      title = strcompress('Distribution of rgalpowfit/rgalpow values for S/N =' $
      + string(SN)+', dx =' + string(round(dx)) + ' and rgalpow =' + string(rgalpow)) 
cgHistoplot, ratio, BINSIZE=binsize, /OPLOT, datacolorname='black'
oplot, [ymedian, ymedian], [0, max(histo)], thick = 2, col=col.green
oplot, [ymean, ymean], [0, max(histo)], thick = 2, col=col.blue
oplot, [ymean-sigma, ymean-sigma], [0, max(histo)*0.50], thick = 2, col=col.blue
oplot, [ymean+sigma, ymean+sigma], [0, max(histo)*0.50], thick = 2, col=col.blue
oplot, [1, 1], [0, max(histo)], thick = 2, col=col.red
legend, ['Median', 'Mean', 'Mean-stddev', 'Mean+stddev', '1.00'], $
         linestyle=[0,0,0,0,0], /right_legend, /top_legend, textcolors = col.black, $
         color = [col.green, col.blue, col.blue, col.blue, col.red], $
         charsize = 1.3

; Gemmer plottet hvis keyword'et er sat
if keyword_set(save) then begin
   Device, decomposed=1
   image24=TVRD(True=1)
   pathname = '/home/lukas/Bachelorprojekt/Uge7/histogram/set' + string(set) + '/'
   filename = strcompress(pathname + 'histoset' + string(set) + $
                          'dx' + string(round(dx)) + 'sn' + string(SN) + '.jpg', /REMOVE_ALL)
   write_jpeg, filename, image24, Quality=100, True=1 
endif

end 

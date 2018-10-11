pro test

data = mrdfits('simdatatest.fits', 1, /SILENT)
y0 = data.flux
n = n_elements(y0)
x0 = data.x0
dx = data.dx
x = findgen(n) * dx + x0
SN01 = determsnr(y0)
SN02 = der_snr(y0) 

SN = 30
m = 200
SNs1 = make_array(m)
SNs2 = make_array(m)
for i = 0, m-1 do begin
   j = i
   
   y11 = addnoise(y0, SN01, SN, j)
   y12 = addnoise(y0, SN02, SN, j)
   SN1 = determsnr(y11)
   SN2 = der_snr(y12)
   ;y21 = addnoise(y11, SN1, SN, j+1)
   ;y22 = addnoise(y12, SN2, SN, j+1)
   
   SNs1[i] = determsnr(y11)
   SNs2[i] = der_snr(y12)
endfor

mean1 = mean(SNs1)
mean2 = mean(Sns2)
median1 = median(SNs1)
median2 = median(SNs2)
print, 'mean1 =' + string(mean1)
print, 'mean2 =' + string(mean2)
print, 'median1 =' + string(median1)
print, 'median2 =' + string(median2)
; Indlæser farver og opsætter vindue
device, decomposed = 0 
col=getcolor(/load)
WINDOW, 0, XSIZE=800, YSIZE=500

binsize = 0.5
i0 = where(SNs1 eq min(SNs1)) & i1 = i0[0]
SNs1[i1] = SNs1[i1] - (SNs1[i1] mod binsize)
i0 = where(SNs2 eq min(SNs2)) & i1 = i0[0]
SNs2[i1] = SNs2[i1] - (SNs2[i1] mod binsize)
histo = HISTOGRAM(SNs1, binsize = binsize)
bins = FINDGEN(N_ELEMENTS(histo)) * binsize + min(SNs1)
plot, bins, histo, /nodata, background = col.white, col=col.black, xr = [SN-10, SN+10]
cgHistoplot, SNs1, BINSIZE=binsize, /OPLOT, datacolorname='blue'
cgHistoplot, SNs2, BINSIZE=binsize, /OPLOT, datacolorname='red'
end

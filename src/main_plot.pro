pro main_plot, dataset=dataset, name=name, set=set, histo=histo, rgalpowplot=rgalpowplot, snplot=snplot, $
               dx=dx, SN=SN, rgalpow=rgalpow, save=save

; Laver et histogram over rgalpowfit-værdierne for det angivne datasæt
if keyword_set(histo) then begin
   ; Indlæser data
   pathname = '/home/lukas/Bachelorprojekt/Uge7/data/' + string(dataset) + '/'
   filename = strcompress(pathname + string(name) + 'fit' + string(set) + 'dx' + string(dx) + '.fits', /REMOVE_ALL)
   data0 = mrdfits(filename, 1, header1, /SILENT)
   ; Plotter
   main_plot_hist, data0, set=set, SN=SN, rgalpow=rgalpow, save=save
endif

; Plotter middelværdien af rgalpowfit/rgalpow for de forskellige rgalpow og S/N-værdier
if keyword_set(rgalpowplot) then begin
   ; Indlæser data
   pathname = '/home/lukas/Bachelorprojekt/Uge7/data/' + string(dataset) + '/'
   filename = strcompress(pathname + string(name) + 'fit' + string(set) + 'dx' + string(dx) + '.fits', /REMOVE_ALL)
   data0 = mrdfits(filename, 1, header1, /SILENT)
   ; Plotter
   main_plot_rgalpowplot, data0, set, SN=SN, save=save
endif

; Plotter middelværdien af rgalpowfit for forskellige S/N og dx værdier
if keyword_set(snplot) then begin
   main_plot_snplot, dataset, name, set, save=save
endif

end

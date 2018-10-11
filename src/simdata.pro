pro simdata

set = 'test'
k = 15000					; Powerlaw'ens amplitude
a = -1.574D					; Powerlaw'ens slope
l = [5050, 5150]				; Intervallet hvor powerlaw'en og galaksen sammenlignes
rgalpow = 0.50					; Forholdet imellem galaksen og powerlaw'en i ovennævnte interval
h = [2001, 9001]				; Intervallet som x-værdierne kommer til at løbe over
dx = 2						; Step-værdien for x-værdierne
SN = 40						; S/N-ratio
emline = [1,1,2,1,2]				; Antallet og typen af emissionslinjer
my1 = 2431					; Placeringen af den første emissionslinje
sigma1 = 33.45D					; Bredden af den første emissionslinje
remline1 = 11.21D				; Faktoren den første emissionslinje ganges med
my2 = 4123			 		; Placeringen af den anden emissionslinje
sigma2 = 37.64D					; Bredden af den anden emissionslinje
remline2 = 11.32D				; Faktoren den anden emissionslinje ganges med
my3 = 5867
sigma3 = 44.89D	
remline3 = 7.83D
my4 = 6578
sigma4 = 21.58D	
remline4 = 5.31D
my5 = 8143
sigma5 = 22.65D	
remline5 = 4.34D

ygal0=mrdfits('/home/lukas/Bachelorprojekt/Uge7/data/gal.fits', 0, header2, /SILENT)

s = randomu(seed) * 10
;z = randomu(s, /DOUBLE)
z = 0
data = simdata_iter(h, dx, ygal0, header2, l, emline, SN, z, s, k, a, rgalpow,  $
                    my1, sigma1, remline1, my2, sigma2, remline2, my3, sigma3, remline3, $
                    my4, sigma4, remline4, my5, sigma5, remline5)

pathname = '/home/lukas/Bachelorprojekt/Uge7/data/simdata/'
filename = strcompress(pathname + 'simdata' + string(set) + '.fits', /REMOVE_ALL)
mwrfits, data, filename, header, /CREATE

; Indlæser farver
device, decomposed = 0 
col=getcolor(/load)
WINDOW, 0, XSIZE=800, YSIZE=500

; Plotter
y = data.flux
n = n_elements(y)
x = findgen(n) * data.dx + data.x0
plot, x, y, /nodata, background=col.white, col=col.black
oplot, x, y, col=col.blue

end

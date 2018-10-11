function simdata_iter_init, n, nemlines

result = {x0: 0., dx: 0., z: 0., flux: make_array(n, /DOUBLE), k: 0D, a: 0D, rgalpow: 0., SN: 0., emline: make_array(nemlines), $
          l: [0,0], my1: 0D, sigma1: 0D, remline1: 0D, my2: 0D, sigma2: 0D, remline2: 0D, my3: 0D, sigma3: 0D, remline3: 0D, $
          my4: 0D, sigma4: 0D, remline4: 0D, my5: 0D, sigma5: 0D, remline5: 0D}

return, result
end

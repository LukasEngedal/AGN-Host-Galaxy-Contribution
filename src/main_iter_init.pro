function main_iter_init, n, m, nSN, ndx, nrgalpow, nemlines

result = {x0: 0., dx: 0., flux: make_array(n, /DOUBLE), kfit: make_array(m, /DOUBLE), afit: make_array(m, /DOUBLE), $
          rgalpowfit: make_array(m, /DOUBLE), niter: 0, SN: 0., SNs: make_array(nSN), dxs: make_array(ndx), z: 0., $
          rgalpows: make_array(nrgalpow), emline: make_array(nemlines), l: [0,0], meanniterfit: 0., rgalpow: 0., $
          my1fit: make_array(m, /DOUBLE), sigma1fit: make_array(m, /DOUBLE), remline1fit: make_array(m, /DOUBLE), $
          my2fit: make_array(m, /DOUBLE), sigma2fit: make_array(m, /DOUBLE), remline2fit: make_array(m, /DOUBLE), $
          my3fit: make_array(m, /DOUBLE), sigma3fit: make_array(m, /DOUBLE), remline3fit: make_array(m, /DOUBLE), $
          my4fit: make_array(m, /DOUBLE), sigma4fit: make_array(m, /DOUBLE), remline4fit: make_array(m, /DOUBLE), $
          my5fit: make_array(m, /DOUBLE), sigma5fit: make_array(m, /DOUBLE), remline5fit: make_array(m, /DOUBLE)}

return, result
end

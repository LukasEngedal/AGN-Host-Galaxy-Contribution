function addgal, x, y0, ygal0, rgalpow, l

i1 = where(x ge l[0])  &  i2 = where(x ge l[1])
gal = mean(ygal0[i1[0]:i2[0]])
pow = mean(y0[i1[0]:i2[0]])
ygal = ygal0 / gal * pow * rgalpow
y = y0 + ygal

return, y
end

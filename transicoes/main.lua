-- -- local circulo = display.newCircle (80, 50, 30)
-- -- Transições
-- -- Comandos: transition.to (variável, {parâmetros})
-- transition.to (circulo, {time=3000, y=400})

-- local circulo1 = display.newCircle (150, 50, 30)
-- transition.to (circulo1, {time=3000, y=400, iterations=2, delta=true})

-- local circulo2 = display.newCircle (220, 50, 30)
-- transition.to (circulo2, {time=3000, y=400, iterations=4, transition=easing.outElastic} ) 

-- local retangulo = display.newRect (200, 250, 50, 70)
-- transition.to (retangulo, {time=3000, rotation=90, yScale=2, alpha=0.5, iterations=-1} )

local circulo3 = display.newCircle (50, 400, 30)
circulo3:setFillColor (0, 0, 1)
transition.to (circulo3, {time=4000, y=60, iterations=-1, yScale=-2, alpha=0.8, transition=easing.inBounce} )

 local circulo4 = display.newCircle (50, 400, 30)
 circulo4:setFillColor (0, 0, 1)
 transition.to (circulo4, {time=4000, x=50, y=60, iterations=-1, yScale=-2, alpha=0.8, transition=easing.inElastic} )

 local circulo5 = display.newCircle (100, 400, 30)
 circulo5:setFillColor (0, 1, 1)
 transition.to (circulo5, {time=8000, y=60, iterations=-1, yScale=-2, alpha=0.8, transition=easing.inBounce} )
 
  local circulo6 = display.newCircle (100, 400, 30)
  circulo6:setFillColor (0, 1, 1)
  transition.to (circulo6, {time=8000, x=90, y=60, iterations=-1, yScale=-2, alpha=0.8, transition=easing.inElastic} )

  
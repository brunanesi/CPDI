local physics = require ("physics")
physics.start ()
physics.setGravity (2, 9.8)
physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

local baixo = display.newRect (display.contentCenterX, 480, 500, 50)
physics.addBody (baixo, "static")
baixo.myName = "Chão"

local bola1 = display.newImageRect ("imagens/bola1.png", 481*0.2, 518*0.2)
bola1.x = display.contentLeftX
bola1.y = display.contentCenterY
physics.addBody (bola1, {bounce=0.1, friction=0.3, radius=48})
bola1.myName = "Bola um"

local function colisaoLocal (event)
    if (event.phase == "began") then
        baixo:setFillColor(0, 1, 1)
    elseif (event.phase == began) then
        baixo:setFillColor (0.5, 0.3, 1)
    end
end

bola1:addEventListener ("collision", colisaoLocal)

local composer = require( "composer" )

local scene = composer.newScene()

physics.setGravity (0,0) 
local bg = display.newImageRect ("imagens/bg.jpeg", 480*0.9, 320*0.7)
bg.x, bg.y = display.contentCenterX+20, display.contentCenterY

local menuItens = display.newRect (20, display.contentCenterY, 35, 350)

local tanqueAgua = display.newRect (133, 208, 24, 6)
physics.addBody(tanqueAgua, "static")
tanqueAgua.alpha = 0
tanqueAgua.myName = "TanqueAgua"

local canoReto = display.newRect (menuItens.x, menuItens.y-60, 20, 40)
canoReto:setFillColor(0, 0, 0.5)
physics.addBody(canoReto, "dynamic", {isSensor=true})
canoReto.myName = "Cano_RetoA"

-- local acionA = display.newRect (canoReto.x, canoReto.y, 10, 5)
-- acionA:setFillColor(1,0,0)
-- physics.addBody(acionA,"dynamic")

local canoL = display.newRect (menuItens.x, menuItens.y, 20, 40)
canoL:setFillColor(0, 0.6, 0.2)
physics.addBody(canoL, "dynamic", {isSensor=true, box={x=0, y=0, halfWidth=10, halfHeight=20, angle=0}, box={x=10, y=-10, halfWidth=20, halfHeight=10, angle=0}})
canoL.myName = "Cano_L"

local canoL2 = display.newRect (menuItens.x, menuItens.y+60, 20, 40)
canoL2:setFillColor(0, 0.6, 0.2)
physics.addBody(canoL2, "static", {isSensor=true, box={x=0, y=0, halfWidth=10, halfHeight=20, angle=0}, box={x=10, y=10, halfWidth=20, halfHeight=10, angle=0}})
canoL2.myName = "Cano_L2"

------------------------- Criando a dinamica dos Cano reto -----------------------
local moverCanoReto = false
local function canosRetoMover(event) -- testar no Celular
    
    if (event.phase == "began" and moverCanoReto == false) then
        canoReto = event.target -- obj do evento
        transition.to(canoReto, {time=1000, x=display.contentCenterX, y=display.contentCenterY}) --xScale=1.2, yScale=1.2,
    
    elseif (event.phase == "ended" and moverCanoReto == false) then
        moverCanoReto = true
        dirCanoReto = true
        print(moverCanoReto)
        print(dirCanoReto)
    end -- if canoReto
    -- print(moverCanoReto)

    if (event.phase == "began" and moverCanoReto == true) then
        -- print(moverCanoReto)
        display.currentStage:setFocus (canoReto)
        canoReto.touchOffsetX = event.x - canoReto.x
        canoReto.touchOffsetY = event.y - canoReto.y
    elseif (event.phase == "moved" and moverCanoReto == true) then
        -- A cada fim de toque a localização inicial muda.
        canoReto.x = event.x - canoReto.touchOffsetX
        canoReto.y = event.y - canoReto.touchOffsetY
    elseif (event.phase ==  "ended" and moverCanoReto == true or event.phase == "cancelled" and moverCanoReto == true) then
        display.currentStage:setFocus (nil)
    end -- if movimentação
    return true

end -- if canosRetoMover
canoReto:addEventListener("touch", canosRetoMover)

local function canoRetoDir ()
    print("Direção=")
    print(dirCanoReto)
    if (dirCanoReto == true) then
        canoReto:rotate(90)
    end
end
canoReto:addEventListener("tap", canoRetoDir)

------------------------- Criando a dinamica dos Cano em L -----------------------
local moverCanoL = false
local function canoLMover(event) -- testar no Celular
    
    if (event.phase == "began" and moverCanoL == false) then
        canoL = event.target -- obj do evento
        transition.to(canoL, {time=1000, x=display.contentCenterX, y=display.contentCenterY}) --xScale=1.2, yScale=1.2,
    
    elseif (event.phase == "ended" and moverCanoL == false) then
        moverCanoL = true
        dirCanoL = true
        print(moverCanoL)
        print(dirCanoL)
    end -- if canoL
    -- print(moverCanoL)

    if (event.phase == "began" and moverCanoL == true) then
        -- print(moverCanoL)
        display.currentStage:setFocus (canoL)
        canoL.touchOffsetX = event.x - canoL.x
        canoL.touchOffsetY = event.y - canoL.y
    elseif (event.phase == "moved" and moverCanoL == true) then
        -- A cada fim de toque a localização inicial muda.
        canoL.x = event.x - canoL.touchOffsetX
        canoL.y = event.y - canoL.touchOffsetY
    elseif (event.phase ==  "ended" and moverCanoL == true or event.phase == "cancelled" and moverCanoL == true) then
        display.currentStage:setFocus (nil)
    end -- if movimentação
    return true

end -- if canoLMover
canoL:addEventListener("touch", canoLMover)

local function canoLDir ()
    print("Direção=")
    print(dirCanoL)
    if (dirCanoL == true) then
        canoL:rotate(180)
    end
end
canoL:addEventListener("tap", canoLDir)

local function colisaoCanos ()

    if (event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2

        if((obj1.myName == "Cano_L" and obj2.myName == "TanqueAgua") or
        (obj1.myName == "TanqueAgua" and obj2.myName == "Cano_L")) then
            physics.removeBody("Cano_L")

            
        end
    end


end
timer.performWithDelay( 1000, colisaoCanos )

return FaseAgua
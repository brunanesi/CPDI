local physics = require ("physics")
physics.start ()
physics.setDrawMode ("hybrid")

-- Remover a barra de notificação:
display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/background.png", 360, 570)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local plataforma = display.newImageRect ("imagens/platform.png", 300,50)
plataforma.x = display.contentCenterX
plataforma.y = display.contentHeight - 25
physics.addBody (plataforma, "static")

local balao = display.newImageRect ("imagens/balloon.png", 112, 112)
balao.x = display.contentCenterX
balao.y = display.contentCenterY
balao.alpha = 0.6
physics.addBody (balao, "dynamic", {radius=50, bounce=0.6})

-- criação da junta pivô (" tipo de junta, objA, objB, ancoraX, ancoraY")
 local jointPivot = physics.newJoint ("pivot", plataforma, balao, plataforma.x, plataforma.y)
jointPivot.isMotorEnabled = true -- ativa o motor da junta pivo 
jointPivot.motorSpeed = 40 -- define a velocidade do torque do motor
jointPivot.maxMotorTorque = 1000 -- define o valor máximo da velocidade do torque, utilizado para melhor visualização do efeito. 
jointPivot.isLimitEnabled = true  -- determina como ativado os limites de rotação.
jointPivot:setRotationLimits (1000, -100)



local numToques = 0

local toquesText = display.newText (numToques, display.contentCenterX, 50, native.systemFont, 40)
toquesText:setFillColor (1, 1, 1)

local function cima ()
    -- Parâmetros: (impulsoX, impulsoY, objeto,x, objeto.y)
    balao:applyLinearImpulse (0, -0.75, balao.x, balao.y)
    numToques = numToques + 1
    toquesText.text = numToques
end

local function zerou ()
    numToques = 0
    toquesText.text = numToques
end

plataforma:addEventListener ("collision", zerou)
balao:addEventListener ("tap", cima)
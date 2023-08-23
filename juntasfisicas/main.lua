local physics = require ( "physics")
physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

local joint
local bodies = {} -- string / tabela para armazenamento dos corpos
local bodiesGroup = display.newGroup ()
local joints = {} -- string/tabela para armazenamento das juntas

-- criação junta pivô

-- local staticBox = display.newRect (0, 0, 60, 60)
-- staticBox: setFillColor (0.2, 0.2, 1)
-- physics.addBody (staticBox, "static", {isSensor=true})
-- staticBox.x, staticBox.y = display.contentCenterX, 80

-- local shape = display.newRect (0, 0, 40, 100)
-- shape:setFillColor (1, 0.2, 0.4)
-- physics.addBody (shape, "dynamic")
-- shape.x, shape.y, shape.rotation = 100, staticBox.y-40, 0

-- -- criação da junta pivô (" tipo de junta, objA, objB, ancoraX, ancoraY")
-- local jointPivot = physics.newJoint ("pivot", staticBox, shape, staticBox.x, staticBox.y)
-- jointPivot.isMotorEnabled = true -- ativa o motor da junta pivo 
-- jointPivot.motorSpeed = -40 -- define a velocidade do torque do motor
-- jointPivot.maxMotorTorque = 1000 -- define o valor máximo da velocidade do torque, utilizado para melhor visualização do efeito. 
-- jointPivot.isLimitEnabled = true  -- determina como ativado os limites de rotação.
-- jointPivot:setRotationLimits (-60, 125)

------------------------------------------------------------------------------

-- criação junta de distancia

-- local staticBox = display.newRect (0, 0, 60, 60)
-- staticBox:setFillColor (0.2, 0.2, 1)
-- physics.addBody (staticBox, "static", {isSensor=true})
-- staticBox.x, staticBox.y = 200, 180

-- local shape = display.newRect (0, 0, 40, 100)
-- shape:setFillColor (1, 0.2, 0.4)
-- physics.addBody (shape, "dynamic")
-- shape.x, shape.y  = 200, 80
-- -- ("tipo de junta", objtA, objB, ancoraObjA.x,  ancoraObjA.y, ancoraObjB.x, ancoraObjB.y )
-- local jointDistance = physics.newJoint ("distance", staticBox, shape, staticBox.x, staticBox.y-10, shape.x, shape.y)
-- jointDistance.frequency = 0.8 -- definir os ciclos do amortecimento em hertz, frequencia, quanto menor o valor mais macio vai ser o retorno.
-- jointDistance.dampingRatio = 0.8 -- nivel de amortecimento, onde 1 é amortecimento crítico.
-- jointDistance.length = staticBox.y - shape.y  -- define a distancia entre os pontos de ancoragem. 

-- shape:applyLinearImpulse (0.3, 0, shape.x, shape.y-5) 
----------------------------------------------------------------------------------------

-- JUNTA DE PISTÃO

-- local staticBox = display.newRect (0, 0, 60, 60 )
-- staticBox:setFillColor (0.2, 0.2, 1)
-- physics.addBody (staticBox, "static", {isSensor=true})
-- staticBox.x, staticBox.y = display.contentCenterX, 360

-- local shape = display.newRect (0, 0, 140, 30)
-- shape:setFillColor (1, 0.2, 0.4)
-- physics.addBody (shape, "dynamic", {bounce=1})
-- shape.x, shape.y = display.contentCenterX, 310

-- -- criação da junta pistão ( "tipo de junta", objA, objB, ancoraX, ancoraY, eixoX, eixooY)
-- local jointPiston = physics.newJoint ("piston", staticBox, shape, shape.x, shape.y, 0, 1)

-- jointPiston.isMotorEnabled = true -- habilita o motor da junta
-- jointPiston.motorSpeed = -30 -- negativo leva para cima, define a velocidado do motor
-- jointPiston.maxMotorForce = 1000 -- define o valor maximo da força
-- jointPiston.isLimitEnabled = true -- define que a junta possui limites de movimentação
-- jointPiston:setLimits (-140, 0)

-----------------------------------------------------------------------------------------------

-- JUNTA DE FRICÇÃO

local bodies = {} -- string / tabela para armazenamento dos corpos
local bodiesGroup = display.newGroup ()
local joints = {} -- string/tabela para armazenamento das juntas

-- bodiesGroup.alpha = 0 -- define que todos os elementos do grupo possuem alfa 0
-- transition.to (bodiesGroup, {time=600, alpha=1, transition=easing.outQuad}) -- transição do grupo para o alfa 1 em 600 milesegundos com efeito outQuad

-- local shape1 = display.newRect (bodiesGroup, 0, 0, 40, 40)
-- shape1:setFillColor (1, 0.2, 0.4)
-- physics.addBody (shape1, "dynamic")
-- shape1.x, shape1.y, shape1.rotation = display.contentCenterX-60, 170, 0
-- shape1.angularVelocity = 200 -- adiciona um impulso angular ao shape (rotação ao redor do proprio eixo)
-- bodies [#bodies+1] = shape1 -- adiciona o shape/tabela string bodies sem sobrescrever.

-- local shape2 = display.newRect (bodiesGroup, 0, 0, 40, 40)
-- shape2:setFillColor (1, 0.2, 0.4)
-- physics.addBody (shape2, "dynamic")
-- shape2.x, shape2.y, shape2.rotation = display.contentCenterX+60, 170, 0
-- shape2.angularVelocity = 200
-- bodies [#bodies+1] = shape2

-- local dirtField = display.newRect (bodiesGroup, 0, 0, 120, 190)
-- dirtField.type = "dirt"
-- dirtField:setFillColor (0.4, 0.25, 0.2)
-- physics.addBody (dirtField, "static", {isSensor=true})
-- dirtField.x, dirtField.y = display.contentCenterX-60, 335
-- bodies [#bodies+1] = dirtField

-- local grassField = display.newRect (bodiesGroup, 0, 0, 120, 190)
-- grassField.type = "grass"
-- grassField:setFillColor (0.1, 0.4, 0.3)
-- physics.addBody (grassField, "static", {isSensor=true})
-- grassField.x, grassField.y = display.contentCenterX+60, 335
-- bodies [#bodies+1] = grassField

-- local function handleCollision (self, event)
--     if (event.phase == "began" ) then

--         local forceLimit = 0
--         local torqueLimit = 0

--         if (event.other.type == "dirt") then
--             forceLimit = 0.22
--             torqueLimit = 0.022
--         else 
--             forceLimit = 0.28
--             torqueLimit = 0.028
--         end
-- -- criar um timer com função temporaria para criação das juntas 10 milisegundos após a colisão
--         timer.performWithDelay (10,
--                 function ()
--                 -- cria a junta já dentro da string joints, onde o objA é o colidido e o B o ouvinte da função, e as ancoras sao criadas de acordo com a localização dos objB.
--                 joints [#joints+1] = physics.newJoint ("friction", event.other, self, self.x, self.y)
--             -- altera os valores máximos de força e troque de acordo com o obtido no if acima.
--                 joints [#joints].maxForce = forceLimit
--                 joints[#joints].maxTorque = torqueLimit
--             end -- fecha a function do timer
--             ) -- fecha o timer
--     end -- fecha o if began
-- end -- fecha a function


-- shape1.collision = handleCollision
-- shape1:addEventListener ("collision", shape1)

-- shape2.collision = handleCollision
-- shape2:addEventListener ("collision", shape2)

-----------------------------------------------------------------------------------------------------------

-- JUNTA DE SOLDA

-- local shape = display.newRect (0, 0, 60, 60)
-- shape:setFillColor (1, 0.2, 0.4)
-- physics.addBody (shape, "dynamic", {bounce=1})
-- shape.x, shape.y = display.contentCenterX -10, 230

-- local welded = display.newRect (0, 0, 60, 60)
-- welded:setFillColor (0.6, 0.1, 0.7)
-- physics.addBody (welded, "dynamic", {bounce=1})
-- welded.x, welded.y = display.contentCenterX+40, 180
-- welded.rotation = -25

-- local staticBox = display.newRect (0, 0, display.contentWidth-40, 50)
-- staticBox:setFillColor (0.2, 0.2, 1)
-- physics.addBody (staticBox, "static")
-- staticBox.x, staticBox.y = display.contentCenterX, 420

-- local jointWeld = physics.newJoint ("weld", welded, shape, shape.x, shape.y)
-- -- jointWeld.damingRatio = 0.1
-- -- jointWeld.frequency = 0.1 -- deixa as juntas mais molinhas e nao tao rigidas

-----------------------------------------------------------------------------------------------------------

-- -- JUNTA DE RODA: semelhante a de pistao, exeto que gira entorno dela livremente 

-- local vehicleBody = display.newRect (bodiesGroup, 0, 0, 110, 20)
-- vehicleBody:setFillColor (0.6, 0.1, 0.7)
-- physics.addBody (vehicleBody, "dynamic")
-- vehicleBody.x, vehicleBody.y = display.contentCenterX-50, 330
-- vehicleBody.isFixedRotation = true
-- bodies [#bodies+1] = vehicleBody

-- local wheelA = display.newCircle (bodiesGroup, 0, 0, 15)
-- wheelA:setFillColor (1, 0.2, 0.4)
-- physics.addBody (wheelA, "dynamic", {bounce = 0.5, friction=0.8, radius=15})
-- wheelA.x, wheelA.y = vehicleBody.x-35, vehicleBody.y+30
-- bodies [#bodies+1] = wheelA

-- local wheelB = display.newCircle (bodiesGroup, 0, 0, 15)
-- wheelB:setFillColor (1, 0.2, 0.4)
-- physics.addBody (wheelB, "dynamic", {bounce=0.5, friction=0.8, radius=15})
-- wheelB.x, wheelB.y = vehicleBody.x, vehicleBody.y+30
-- bodies [#bodies+1] = wheelB

-- local wheelC= display.newCircle (bodiesGroup, 0, 0, 15)
-- wheelC:setFillColor (1, 0.2, 0.4)
-- physics.addBody (wheelC, "dynamic", {bounce=0,5, friction=0.8, radius=15})
-- wheelC.x, wheelC.y = vehicleBody.x+35, vehicleBody.y+30
-- bodies [#bodies+1]= wheelC

-- local staticBox = display.newRect (bodiesGroup, 0, 0, display.contentWidth-40, 50)
-- staticBox:setFillColor (0.2, 0.2, 1)
-- physics.addBody (staticBox, "static", {bounce=0, friction=1})
-- staticBox.x, staticBox.y = display.contentCenterX, 420
-- bodies [#bodies+1] = staticBox 

-- local bumperA = display.newRect (bodiesGroup, 0, 0, 30, 20)
-- bumperA:setFillColor (0.2, 0.2, 1)
-- physics.addBody (bumperA, "static", {bounce=1, friction=0})
-- bumperA.x, bumperA.y = staticBox.x - staticBox.width/2+15, 385
-- bodies [#bodies+1] = bumperA

-- local bumperB = display.newRect (bodiesGroup, 0, 0, 30, 20)
-- bumperB:setFillColor (0.2, 0.2, 1)
-- physics.addBody (bumperB, "static", {bounce=1, friction=0})
-- bumperB.x, bumperB.y = staticBox.x+staticBox.width/2-15, 385
-- bodies [#bodies+1] = bumperB

-- -- criação das variáveis para armazenamento dos parâmetros de frequencia e DampingRatio
-- local springFrequency = 30
-- local springDampingRatio = 1.0

-- --criação da junta já dentro da string joints ([joints+1]) faz com que a variável não seja sobrescrita
-- joints[#joints+1] = physics.newJoint ("wheel", vehicleBody, wheelA, wheelA.x, wheelA.y, 1, 1)
-- joints[#joints].springFrequency = springFrequency
-- joints[#joints].springDampingRatio = springDampingRatio

-- --atribui a frequencia e damping a junta dos valores já criados anteriormente.
-- joints[#joints+1] = physics.newJoint ("wheel", vehicleBody, wheelB, wheelB.x, wheelB.y, 1 ,1)
-- joints[#joints].springFrequency = springFrequency
-- joints[#joints].springDampingRatio = springDampingRatio

-- joints[#joints+1] = physics.newJoint ("wheel", vehicleBody, wheelC, wheelC.x, wheelC.y, 1, 1)
-- joints[#joints].springFrequency = springFrequency
-- joints[#joints].springDampingRatio = springDampingRatio

-- -- aplicação de torque as rodas para movimentação do carro
-- wheelA:applyTorque (2)
-- wheelB:applyTorque (2)
-- wheelC:applyTorque (2)

-------------------------------------------------------------------------

--JUNTA DA POLIA 

local bodyA= display.newCircle (bodiesGroup,0, 0, 0.4)
bodyA:setFillColor (1, 0.2, 0.4)
physics.addBody (bodyA, "dynamic", {bounce=0.8, radius=40})
bodyA.x, bodyA.y = display.contentCenterX-50, 260
bodies [#bodies+1] = bodyA

local bodyB= display.newCircle (bodiesGroup,0, 0, 26)
bodyB:setFillColor (1, 0.2, 0.4)
physics.addBody (bodyB, "dynamic", {bounce=0.8, radius=26})
bodyB.x, bodyB.y = display.contentCenterX+50, 300
bodies[#bodies+1] = bodyB

local staticBox = display.newRect (bodiesGroup, 0, 0, display.contentWidth-40,50)
staticBox:setFillColor (0.2, 0.2, 1)
physics.addBody (staticBox, "static", {bounce=0.8})
staticBox.x, staticBox.y = display.contentCenterX, 420
bodies [#bodies+1] = staticBox 

-- criando a junta ("tipo de junta", corpoA, corpoB, pinoA.x, pinoA.y, pinoB.x, pinoB.y, ancoraA.x, ancoraA.y, ancoraB.x, ancoraB.y)
local joint = physics.newJoint ("pulley", bodyA, bodyB, bodyA.x, bodyA.y-100, bodyB.x, bodyB.y-140, bodyA.x, bodyA.y, bodyB.x, bodyB.y, 1.0) -- o paramentro 1.0 significa que o lado mais pesado vai descer, se aumentar o valor do 1 o lado mais pesado vai me movimentar mais rápido.


local physics = require("physics")
physics.start()
physics.setGravity(0, 9.8)
physics.setDrawMode("hybrid")

display.setStatusBar(display.HiddenStatusBar)

local grupoBg = display.newGroup()
local grupoMain = display.newGroup()
local grupoUI = display.newGroup()

local pontos = 0

local bg = display.newImageRect(grupoBg, "imagens/bg.jpg", 450, 673)
bg.x = display.contentCenterX
bg.y = 240

local pontosText = display.newText(grupoUI, "P O N T O S // " .. pontos, 50, 30, native.systemFont, 15)

local player = display.newImageRect(grupoMain, "imagens/cesto.png", 130, 130)
player.x = 60
player.y = 380
player.myName = "cesto"
physics.addBody(player, "kinematic")

local botaoDireita = display.newImageRect(grupoMain, "imagens/seta.png", 512 / 12, 512 / 12)
botaoDireita.x = 300
botaoDireita.y = 440
botaoDireita.rotation = 90

local botaoEsquerda = display.newImageRect(grupoMain, "imagens/seta.png", 512 / 12, 512 / 12)
botaoEsquerda.x = 250
botaoEsquerda.y = 440
botaoEsquerda.rotation = -90

local function moverCesto(direcao)
    local velocidade = 10
    if direcao == "direita" then
        player.x = player.x + velocidade
    elseif direcao == "esquerda" then
        player.x = player.x - velocidade
    end
end

botaoDireita:addEventListener("tap", function() moverCesto("direita") end)
botaoEsquerda:addEventListener("tap", function() moverCesto("esquerda") end)

local function criarFlor()
    local flor = display.newImageRect(grupoMain, "imagens/flor.png", 432 / 4, 577 / 4)
    flor.x = math.random(50, display.contentWidth - 50)
    flor.y = -100
    flor.myName = "flor"
    physics.addBody(flor, "dynamic")

    local function removerFlor()
        display.remove(flor)
    end

    transition.to(flor, { y = display.contentHeight + 100, time = 2000, onComplete = removerFlor })
end

local function colisao(event)
    if event.phase == "began" then
        local objeto1 = event.object1
        local objeto2 = event.object2

        if (objeto1.myName == "cesto" and objeto2.myName == "flor") or
           (objeto1.myName == "flor" and objeto2.myName == "cesto") then
            pontos = pontos + 1
            pontosText.text = "P O N T O S // " .. pontos
        end
    end
end

local florTimer = timer.performWithDelay(1500, criarFlor, -1)
Runtime:addEventListener("collision", colisao)

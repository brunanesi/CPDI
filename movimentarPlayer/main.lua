local bg = display.newImageRect ("imagens/sky.png" , 960*3, 240*3)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ("imagens/ground.png" , 1028, 256)
chao.x = display.contentCenterX
chao.y = 490

local player = display.newImageRect ("imagens/player.png", 532/3, 469/3)
player.x = 50
player.y = 300

-- Andar para a direita
local function direita ()
    player.x = player.x + 4
end

local botaoDireita = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDireita.x = 300
botaoDireita.y = 400
botaoDireita:addEventListener ("tap", direita)

local function esquerda ()
    player.x = player.x - 4
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoEsquerda.x = 220
botaoEsquerda.y = 400
botaoEsquerda.rotation = 180
botaoEsquerda: addEventListener ("tap", esquerda)

local function subir ()
    player.y = player.y -40
end

local botaoSubir = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoSubir.x = 260
botaoSubir.y = 380
botaoSubir.rotation = 275
botaoSubir: addEventListener ("tap", subir)

local function descer ()
    player.y = player.y +40
end

local botaoDescer = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDescer.x = 260
botaoDescer.y = 430
botaoDescer.rotation = 90
botaoDescer: addEventListener ("tap", descer)

local function diagonalDiCm ()
    player.x = player.x + 5
    player.y = player.y -5
end

local botaoDiagonalCm = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDiagonalCm.x = 300
botaoDiagonalCm.y = 360
botaoDiagonalCm.rotation = 315
botaoDiagonalCm:addEventListener ("tap", diagonalDiCm)

local function diagonalDireitaBaixo ()
    player.y = player.y + 30
    player.x = player.x + 30
end

local botaoDiagonalBx = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDiagonalBx.x = 300
botaoDiagonalBx.y = 450
botaoDiagonalBx.rotation = 45
botaoDiagonalBx:addEventListener ("tap", diagonalDireitaBaixo)

local function diagonal1 ()
    player.y = player.y - 2 
    player.x = player.x -2
end

local botaoCimaEsquerda = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoCimaEsquerda.x = 225
botaoCimaEsquerda.y = 360
botaoCimaEsquerda.rotation = 225
botaoCimaEsquerda:addEventListener ("tap", diagonal1)

local function diagInEsq ()
    player.y = player.y + 2 
    player.x = player.x -2
end

local botaoDiagBE = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDiagBE.x = 224
botaoDiagBE.y = 450
botaoDiagBE.rotation = 140
botaoDiagBE:addEventListener ("tap", diagInEsq)

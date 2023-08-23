-- Adicionar nova imagem na tela:
-- Comandos: display.newImageRect ("pasta/arquivo.formato", largura, altura)
local bg = display.newImageRect ("imagens/bg.jpg" , 1280*1.25, 720*1.25)
-- Definir localização do objeto.
-- Comando: variável.linha que vou definir = localização na linha. x = horizontal y = vertical
bg.x = display.contentCenterX -- Comando que centraliza a variável em qualquer resolução.
bg.y = display.contentCenterY
local pikachu = display.newImageRect ("imagens/pikachu.png" , 1191/5, 1254/5)
pikachu.x = display.contentCenterX
pikachu.y = display.contentCenterY

local charmander = display.newImageRect ("imagens/charmander.png" , 507/2, 492/2)
charmander.x = 380
charmander.y = 200
----------------------------------------------------------------

-- Criando um retângulo: 
-- Comandos: display.newRect (localizaçãp x, localizção y, largura, altura)

local retangulo = display.newRect (750, 380, 100, 70)

-- Criando um círculo
-- Comandos: displau.newCircle (x, y, radius (raio (merade do círculo)) )

local circulo = display.newCircle (150, 80, 50)

local mystery = display.newImageRect ("imagens/mystery.png" , 507/2, 492/2)
mystery.x = 750
mystery.y = 380

local pikachu = display.newImageRect ("imagens/pikachu.png" , 1191/5, 1254/5)
pikachu.x = display.contentCenterX
pikachu.y = display.contentCenterY
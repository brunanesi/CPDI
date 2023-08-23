-- Criando grupos de exibição

local backGroup = display.newGroup () -- Back usado para plano de fundo, decorações que não terão interação com o jogo.
local mainGroup = display.newGroup () -- Usado para os objetos que terão interação dentro do jogo, grupo principal
local uiGroup = display.newGroup () -- Utilizado para placar, vidas, texto, que ficarão na frente do jogo porém sem interação.

-- Método embutido
-- Inclui o objeto no grupo já na sua criação
local bg = display.newImageRect (backGroup, "imagens/bg.jpg", 509*2, 339*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- Método direto:
-- Inclui o objeto depois da sua criação.
local chao = display.newImageRect ("imagens/chao.png", 4503/5, 613/5)
chao.x = display.contentCenterX
chao.y = 430
mainGroup:insert (chao)


local sol = display.newImageRect (backGroup, "imagens/sun.png", 256*0.3, 256*0.3)
sol.x = 200
sol.y = 65

local nuvem = display.newImageRect ("imagens/cloud.png", 2360/8, 984/8 )
nuvem.x = 300
nuvem.y = 85
backGroup:insert (nuvem)

local arvoreUm = display.newImageRect (mainGroup, "imagens/tree.png", 1024*0.28, 1024*0.28)
arvoreUm.x = display.contentCenterLeft
arvoreUm.y = 280

local arvoreDois = display.newImageRect ("imagens/tree.png", 1024*0.28, 1024*0.28)
arvoreDois.x = 300
arvoreDois.y = 280
mainGroup:insert (arvoreDois)

chao:toFront (chao)
arvoreDois:toFront ()
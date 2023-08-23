-- chamar a biblioteca de física
local physics = require ("physics")
-- dar star na física
physics.start ()
-- definir a gravidade x, y
physics.setGravity (0, 0)
-- definir modo de exibição/ renderização
physics.setDrawMode ("normal")

-- remover a barra de notificações do usuário, escondendo a hora e notificações
display.setStatusBar (display.HiddenStatusBar)

-- criar grupos de exibição, para organizar os itens do jogo
-- bg = grupo de fundo, atras, sem interação com os principais
-- main grupo = dos principais, localizado no meio
-- UI = decorações, interações não diretas...
local grupoBg = display.newGroup () -- objetos decorativos, cenários, não tem interação
local grupoMain = display.newGroup () -- bloco princial  - tudo que possa interagir com o player fica aqui
local grupoUI = display.newGroup () -- informações, pontuação, vidas, extras

-- criar duas variáveis e atribuir valor a elas - valor vida e pontos
local pontos = 0
local vidas = 5

-- Adicionar background

local bg = display.newImageRect (grupoBg,"imagens/bg3.jpg", 564, 846 )
bg.x = display.contentCenterX -- localização horizontal
bg.y = 250 -- localização vertical

-- adicionar placar na tela
-- (grupo, "escreve o que vai aparecer na tela", localizaçãoX, localizaçãoY, fonte, tamanho da fonte) os .. significa concatenação - que liga esses itens as configurações
local pontosText = display.newText (grupoUI, "P O N T O S  //  "  ..  pontos, 50, 30, native.systemFont, 15)

local vidasText = display.newText (grupoUI, "V I D A S // ".. vidas, 36, 48, native.systemFont, 15)

-- adicionar herói
local player = display.newImageRect (grupoMain, "imagens/gato.png", 564/4, 388/4)
player.x = 80
player.y = 370
player.myName = "gato"
-- adicionando corpo físico, interação, na imagem
physics.addBody (player, "kinematic") -- tem colisoes com o corpo dinamico mas nao colide com estatico nao tem influencia da gravidade

-- criar botão
local botaoCima = display.newImageRect (grupoMain,"imagens/seta.png", 512/12, 512/12)
botaoCima.x = 240
botaoCima.y = 440

local botaoBaixo = display.newImageRect (grupoMain,"imagens/seta.png", 512/12, 512/12)
botaoBaixo.x = 80
botaoBaixo.y = 440
-- mudar direção da imagem
botaoBaixo.rotation = 180

-- adicionar funções de movimentação
local function cima ()
    player.y = player.y - 20 --subindo 10 pixels
end

local function baixo ()
    player.y = player.y + 20 -- descendo 10 pixels
end

-- Adicionar o ouvinte e a função do botão
botaoCima: addEventListener ("tap", cima)
botaoBaixo: addEventListener ("tap", baixo)

-- Adicionar botão de tiro:
local botaoTiro = display.newImageRect (grupoMain, "imagens/botaotiro.png",667/8, 720/8 )
botaoTiro.x = display.contentCenterX
botaoTiro.y = 440

-- Função para atirar:
local function atirar ()
    local raioPlayer = display.newImageRect (grupoMain, "imagens/tiro.png", 4500/30, 4500/30)
    raioPlayer.x= player.x 
    raioPlayer.y = player.y
    physics.addBody (raioPlayer, "dynamic", {isSensor=true} ) -- determinamos que o projetil é um sensor, o que ativa detecção continua de colisão.
    transition.to (raioPlayer, {x=500, time=900, 
    -- quando a transição for completa, removemos o projetil do display
                    onComplete = function () display.remove (raioPlayer)
                    end})
     raioPlayer.myName = "pur"
     raioPlayer:toBack ()
end

botaoTiro:addEventListener ("tap" , atirar)

-- Adicionando inimigo
local inimigo = display.newImageRect (grupoMain, "imagens/urso.png" , 500*0.25 , 500*0.25)
inimigo.x = 270
inimigo.y = 370
inimigo.myName = "urso"
physics.addBody (inimigo, "kinematic")
local direcaoInimigo = "cima"

-- Função para o inimigo atirar:
-- o inimigo deve atirar sozinho
local function inimigoAtirar ()
    local tiroInimigo = display.newImageRect (grupoMain, "imagens/tiro.png" , 4500/30, 4500/30)
    tiroInimigo.x = inimigo.x
    tiroInimigo.y = inimigo.y
    physics.addBody (tiroInimigo, "dynamic", {isSensor=true})
    transition.to (tiroInimigo, {x=200, time=900,
                    onComplete = function () 
                        display.remove (tiroInimigo)
                    end})
    tiroInimigo.myName = "aur"
end

-- Criando o timer de disparo do inimgo:
-- Comando time: (tempo repetição, função, quantidade de repetição )
inimigo.timer = timer.performWithDelay (math.random (1000, 1500), inimigoAtirar, 0)

--Movimentação do inimigo:
local function movimentarInimigo ()
-- se a localizaçao x não for igual a nulo então
        if not (inimigo.x == nill ) then
-- quando a direção do inimgo for cima entao o movimento sera negativo para subir
                if (direcaoInimigo == "cima" ) then
                    inimigo.y = inimigo.y -1
--se a localização do inimigo foi menor ou igual a 50 altera a direção para baixo, 50 é onde acaba a tela nesse tipo de visualizador
                        if (inimigo.y <= 50) then
                            -- altera para baixo
                            direcaoInimigo = "baixo"
                        end -- referente ao (inimigo.y...)

                -- se a direção do inimigo for igual a baixo, é somando o pixel para ir descendo         
                elseif (direcaoInimigo == "baixo") then
                    inimigo.y = inimigo.y + 1
                -- se a localização y do inimigo dor maior ou igual a 400 então ele irá inverter para cima para não sair da tela
                    if (inimigo.y >= 400 ) then
                        direcaoInimigo = "cima"
                    end
                end
            --se nao
            else
                print ( "inimigo morreu!")
                -- Runtime: representa todo o jogo (evento é executado para todos), enterframe: esta ligado ao valor de FPS do jogo (frames por segundo), no caso, a função vai ser executada 60 vezes por segundo.
                Runtime:removeEventListener ("enterFrame", movimentarInimigo)
            end
        end
        Runtime:addEventListener ("enterFrame", movimentarInimigo)

-- Função de colisão:
local function onCollision (event)
-- Quando a fase de evento for began então
    if (event.phase == "began" ) then
-- Variáveis criadas para facilitar a escrita do codigo        
        local obj1 = event.object1
        local obj2 = event.object2
-- Quando o myName do objeto 1 for .... e o myName do objeto 2 for.... aqui o primeiro obj é o tiro do player e o segundo é o inimigo. depois vice e verce objt 1 inimigo e obj 2 tiro do player
        if ((obj1.myName == "pur"  and obj2.myName == "urso") or (obj1.myName == "urso" and obj2.myName == "pur")) then

        if (obj1.myName == "pur") then
-- remove o projetil do jogo
            display.remove (obj1)
        else
            display.remove (obj2)
        end
-- somar 10 pontos a cada colisão
        pontos = pontos + 10
-- atualizo od pontos da tela        
        pontosText.text = "P O N T O S // " .. pontos
--

    elseif ((obj1.myName == "gato" and obj2.myName == "aur") or (obj1.myName == "aur" and obj2.myName == "gato") ) then
        if (obj1.myname == "aur") then
            display.remove (obj1)
        else
            display. remove (obj2)
        end
-- Reduz uma vida do player a cada colisão 
        vidas = vidas - 1
-- Atualiza a vidas
        vidasText.text = "V I D A S // " .. vidas
        end -- fecha o if myName
    end -- fecha o if event.phase
end -- fecha a function

Runtime:addEventListener ("collision", onCollision )


-- ADICIONANDO AUDIO

local bgAudio = audio.loadStream ("Audio/bg.mp3")
audio.reserveChannels (1)
audio.setVolume (0.6, {channel=1})
audio.play (bgAudio, {channel=1, loops=-1})


local audioFeitico = audio.loadSound ( "Audio/feitico.mp3")
local parametros = {time = 2000, fadein = 200}

local function tocarFeitico()
    audio.play (audioFeitico, parametros)
end

botaoTiro:addEventListener ("tap", tocarFeitico)

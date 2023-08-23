local Teclado = {}

function Teclado.novo (player)

    local function verificarTecla (event)
        if event.phase == "down" then
            if event.keyName == "d" then
                player.direcao = "direita"
                player:setSequence ("correndo")
                player:play()
                player.xScale = 1       
            elseif event.keyName == "a" then
                player.direcao = "esquerda"
                player:setSequence ("correndo")
                player:play()
                player.xScale = -1
            elseif event.keyName == "space" then
                player.numeroPulo = player.numeroPulo + 1
                    if player.numeroPulo == 1 then
                        player:applyLinearImpulse (0, -0.4, player.x, player.y)
                    elseif player.numeroPulo == 2 then
                        transition.to (player, {rotation=player.rotation+360, time=750})
                        player:applyLinearImpulse (0, -0.4, player.x, player.y)
                    end
            end
        elseif event.phase == "up" then
            if event.keyName == "d" then
                player.direcao = "parado"
                player:setSequence("parado")
                player:play()
            elseif event.keyName == "a" then
                player.direcao = "parado"
                player:setSequence("parado")
                player:play()
            end
        end 
    end
    Runtime:addEventListener ("key", verificarTecla) -- key = teclado
    local function verificarDirecao ()
        local velocidadeX, velocidadeY = player:getLinearVelocity()
        if player.direcao == "direita" and velocidadeX <= 200 then -- se a direçao do player for direita e a velocidade for menor ou igual a 200 THEN 
            player:applyLinearImpulse (0.2, 0, player.x, player.y) -- aplica impulso linear para a direita
        elseif player.direcao == "esquerda" and velocidadeX >= -200 then 
            player:applyLinearImpulse (-0.2, 0, player.x, player.y)
        end 
    end 
    -- "enterFrame" - executa a função o numero de fps/s, nesse caso 60x por segundo
    Runtime:addEventListener ("enterFrame", verificarDirecao)
end

return Teclado -- fecha string teclado

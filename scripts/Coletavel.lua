local Coletavel = {} -- criando a string

function Coletavel.novaMoeda (x, y)
    local moeda = display.newImageRect ("imagens/coin.png", 46, 46)
    -- sugestao de deixar a definição da localização para o main
    moeda.x = x
    moeda.y = y
    moeda.id= "moeda"
    physics.addBody (moeda, "kinematic", {isSensor=true}) -- o kinematico faz com que ela nao tenha interação com a gravidade

    transition.to (moeda, {y=500, time=8000, rotation=1080, onComplete= function () -- ir até o y em 8 segundos, o 1080 vai rotacionando direto até o chao, e o oncomplete se ela nao for caputada pelo player ela é removida
        display.remove (moeda)
    end})

    return moeda
end

return Coletavel
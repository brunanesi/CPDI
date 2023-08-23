local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
--O código fora das funções de evento de cena abaixo será executado apenas UMA VEZ, a menos que
-- a cena é totalmente removida (não reciclada) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
physics.setGravity (0, 9.8)

local function gotoFaseAgua()
	composer.gotoScene ("FaseAgua")
end

local function gotoMenu()
	composer.gotoScene ("Menu")
end


local poeiraTabela = {}
math.randomseed (os.time()) -- Matém a aleatoriedade "sorteio", os.time=garante a não repetição
local gameLoopTimer


-- Criando a poeira
local function criarPoeira()
	local novaPoeira = display.newImageRect ("imagens/poeira.png", 138/10, 142/10)
	-- Incluindo a poeira na tabela
	table.insert (poeiraTabela, novaPoeira)

	local localizacao = math.random (4)

	if (localizacao == 1) then
		print("local 1")
		novaPoeira.x = display.contentWidth-10
		novaPoeira.y = math.random(100)
		transition.moveBy (novaPoeira, {time=1500, alpha=0.2, x=20, y=50})
		novaPoeira:rotate(math.random(0, 90))

	elseif (localizacao == 2) then
		print("local 2")
		novaPoeira.x = math.random(display.contentWidth-10)
		novaPoeira.y = math.random(400)
		transition.moveBy (novaPoeira, {time=1500, alpha=0.4, x=10, y=70})
		novaPoeira:rotate(math.random(-90, 0))

	elseif (localizacao == 3) then
		print("local 3")
		novaPoeira.x = math.random(display.contentWidth-10)
		novaPoeira.y = display.contentHeight-250
		transition.moveBy (novaPoeira, {time=1500, alpha=1, x=0.6, y=math.random(100,150)})
		novaPoeira:rotate(math.random(-180, 180))
	
	elseif (localizacao == 4) then
		print("local 4")
		novaPoeira.x = math.random(display.contentWidth-10)
		novaPoeira.y = display.contentHeight-250
		transition.moveBy (novaPoeira, {time=1500, alpha=0.8, x=0, y=math.random(10,60)})
		novaPoeira:rotate(math.random(0, 360))

	end
end

-- Como estamos usando o moveTo, se alguma poeira ficas fora da tela conseguimos deletar.
local function gameLoop ()
	criarPoeira()
		-- Qaundo eu nomeio do "1 ao -1", estaremos contando em ordem decrescente.
		-- ex: #poeiraTabela =10. 1 é o inicio, e o -1, vai ir removendo um, até 1.
		for i = #poeiraTabela, 1, -1 do -- # tamanho da tabela
			local thisPoeira = poeiraTabela [i]
		-- Quando a poeira estiver fora da tela em tantos pixels ela some
			if (thisPoeira.x < -10 or thisPoeira.x > display.contentWidth + 10 or thisPoeira.y < -10 or thisPoeira.y > display.contentHeight) then
				display.remove (thisPoeira)
				table.remove (poeiraTabela, i)
			end
		end
end


-- -----------------------------------------------------------------------------------
-- Funções de evento de cena
-- -----------------------------------------------------------------------------------

-- create()  - Ocorre quando a cena é criada pela primeira vez, mas ainda não apareceu na tela.
-- Vai criar tudo que será carregado durante a cena
function scene:create( event )

	local sceneGroup = self.view
	-- O código aqui é executado quando a cena é criada pela primeira vez, mas ainda não apareceu na tela
	backGroup = display.newGroup ()
	sceneGroup:insert(backGroup)
	mainGroup = display.newGroup ()
	sceneGroup:insert(mainGroup)
	HUD = display.newGroup ()
	sceneGroup:insert(HUD)


    local bg = display.newImageRect (backGroup, "imagens/bgSujo.png", 2001/4.15, 1334/6)
    bg.x, bg.y = display.contentCenterX, display.contentCenterY-5

	-- Paredes, para o corpo não sair da visão do celular:
	local paredeEsq = display.newRect (mainGroup, display.contentWidth+20, display.contentHeight-160, 50, 400)
	paredeEsq:setFillColor (0, 0, 0.9)
	paredeEsq.alpha = 0
	physics.addBody (paredeEsq, "static")

	local paredeDireita = display.newRect (mainGroup, display.contentWidth-500, display.contentHeight-160, 50, 400)
	paredeDireita:setFillColor (0, 0, 0.9)
	paredeDireita.alpha= 0
	physics.addBody (paredeDireita, "static")

	local chao = display.newImageRect (mainGroup, "imagens/chaoSujo.png", 2001/4.15, 193/5)
	chao.x, chao.y = display.contentCenterX, display.contentHeight-45
	physics.addBody (chao, "static", {friction=1, box={x=0, y=-7, halfWidth=500, halfHeight=11, angle=0}})


	local numItensLibera = 0
	local numItensFase = 0

	------------------------------- Objetos na tela ------------------------------------------

	local ventilador = display.newImageRect (mainGroup, "imagens/suporteAr.png", 209/8, 705/6)
	ventilador.x, ventilador.y = display.contentCenterX-150, display.contentCenterY+50
	-- physics.addBody (ventilador, "dynamic") -- Colide com  qualquer tipo de corpo

	local escudoAr = display.newImageRect (mainGroup,"imagens/escudoAr.png", 276/8, 272/8)
	escudoAr.x, escudoAr.y = display.contentWidth-20, display.contentHeight-80
	-- physics.addBody (escudoAr, "dynamic") -- Colide com  qualquer tipo de corpo

	local pinoVentilador = display.newImageRect (mainGroup,"imagens/pinoAr.png", 163/15, 225/15)
	pinoVentilador.x, pinoVentilador.y = display.contentWidth-25, display.contentHeight-70
	-- physics.addBody (pinoVentilador, "dynamic") -- Colide com  qualquer tipo de corpo

	local radiacao = display.newImageRect (mainGroup,"imagens/rad.png", 442/10, 547/10)
	radiacao.x, radiacao.y = display.contentWidth-25, display.contentHeight-70
	physics.addBody (radiacao, "dynamic", {friction=1, box={x=0, y=0, halfWidth=15, halfHeight=25, angle=0}})
	radiacao.myName = "Radiacao"

	local radiacao1 = display.newImageRect (mainGroup,"imagens/rad.png", 442/10, 547/10)
	radiacao1.x, radiacao1.y = display.contentWidth-36, display.contentHeight-120
	physics.addBody (radiacao1, "dynamic", {friction=1, box={x=0, y=0, halfWidth=15, halfHeight=25, angle=0}})
	radiacao.myName = "Radiacao1"

	local radiacao2 = display.newImageRect (mainGroup,"imagens/rad.png", 442/10, 547/10)
	radiacao2.x, radiacao2.y = display.contentWidth-40, display.contentHeight-60
	physics.addBody (radiacao2, "dynamic", {friction=1, box={x=0, y=0, halfWidth=15, halfHeight=25, angle=0}})
	radiacao2:rotate(-90)
	radiacao.myName = "Radiacao2"

	local mala = display.newImageRect (mainGroup,"imagens/mala.png", 463/10, 238/8)
	mala.x, mala.y = ventilador.x-10, display.contentHeight-90
	physics.addBody (mala, "dynamic", {friction=1, box={x=0, y=0, halfWidth=19, halfHeight=10, angle=0}})

	local paAr1 = display.newImageRect (mainGroup,"imagens/paAr.png", 146/10, 288/8)
	paAr1.x, paAr1.y = ventilador.x-10, display.contentHeight-90
	physics.addBody (paAr1, "dynamic", {friction=1, box={x=0, y=0, halfWidth=5, halfHeight=12, angle=0}})

	local paAr2 = display.newImageRect (mainGroup,"imagens/paAr.png", 146/10, 288/8)
	paAr2.x, paAr2.y = ventilador.x-50, display.contentHeight-90
	physics.addBody (paAr2, "dynamic", {friction=1, box={x=0, y=0, halfWidth=5, halfHeight=12, angle=0}})
	paAr2:rotate(-180)

	local paAr3 = display.newImageRect (mainGroup,"imagens/paAr.png", 146/10, 288/8)
	paAr3.x, paAr3.y = ventilador.x+100, display.contentHeight-90
	physics.addBody (paAr3, "dynamic", {friction=1, box={x=0, y=0, halfWidth=5, halfHeight=12, angle=0}})
	paAr3:rotate(-90)

	----------------------------- TEXTO --------------------------------

	local textComece = display.newText (HUD,"Faça o catavento funcionar utilizando energia limpa!", display.contentCenterX, display.contentCenterY-50, native.systemFont, 15)
	transition.to(textComece, {time=2000, alpha=0})

		----------------------------------------- Funções pegar os obj ----------------------------------------------

	local function pegarRadiacao (event)
		local radiacao = event.target
		if (event.phase == "began") then
			print("objeto tocado")
			transition.to (radiacao, {time=1000, xScale=2, yScale=1.2, interations=1.1, transition=easing.outElastic, alpha=0})
			physics.removeBody(radiacao)
			numItensLibera = numItensLibera+1
		-- elseif (event.phase == "ended") then
			print("R0")
		end
		
		return true  
	end
	radiacao:addEventListener("touch", pegarRadiacao)

	local function pegarRadiacao1 (event)
		local radiacao1 = event.target
		if (event.phase == "began") then
			print("objeto tocado")
			physics.removeBody(radiacao1)
			transition.to (radiacao1, {time=1000, xScale=2, yScale=1.2, interations=1.1, transition=easing.outElastic, alpha=0})
			numItensLibera = numItensLibera+1
		-- elseif (event.phase == "ended") then
			print("R1")
		end

		return true  
	end
	radiacao1:addEventListener("touch", pegarRadiacao1)

	local function pegarRadiacao2 (event)
		local radiacao2 = event.target
		if (event.phase == "began") then
			print("objeto tocado")
			physics.removeBody(radiacao2)
			transition.to (radiacao2, {time=1000, xScale=2, yScale=1.2, interations=1.1, transition=easing.outElastic, alpha=0})
			numItensLibera = numItensLibera+1
		-- elseif (event.phase == "ended") then
			print("R2")
		end
		return true  
	end
	radiacao2:addEventListener("touch", pegarRadiacao2)

	------------------------------- Funções pegar os obj para Montar Ventilador ---------------------------------
	local function pegarPaAr1 (event)
		local paAr1 = event.target

		if (event.phase == "began") then
			print("objeto tocado")
				if(numItensLibera >= 3) then
				transition.to (paAr1, {time=1000, xScale=2, yScale=1.2, interations=1.1, transition=easing.outElastic, alpha=0})
				numItensFase = numItensFase + 1
				physics.removeBody(paAr1)
			elseif (numItensLibera<=2) then
				local lixoText = display.newText(HUD, "Recolha o lixo primeiro!", display.contentCenterX, display.contentCenterY-50, native.systemFont, 30)
				transition.to(lixoText, {time=1000, alpha=0})
			end
			-- print(numItensLibera)
		end
		return true  
	end
	paAr1:addEventListener("touch", pegarPaAr1)


	local function pegarPaAr2 (event)
		local paAr2 = event.target
		if (event.phase == "began") then
			print("objeto tocado")
				if(numItensLibera >= 3) then
				transition.to (paAr2, {time=1000, xScale=2, yScale=1.2, interations=1.1, transition=easing.outElastic, alpha=0})
				numItensFase = numItensFase + 1
				physics.removeBody(paAr2)
			elseif (numItensLibera<=2) then
				local lixoText = display.newText(HUD, "Recolha o lixo primeiro!", display.contentCenterX, display.contentCenterY-50, native.systemFont, 30)
				transition.to(lixoText, {time=1000, alpha=0})
			end --cond
			-- print(numItensLibera)
		end --Meio

		return true    
	end --Function
	paAr2:addEventListener("touch", pegarPaAr2)

	local function pegarPaAr3 (event)
		local paAr3 = event.target
		if (event.phase == "began") then
			print("objeto tocado")
				if(numItensLibera >= 3) then
				transition.to (paAr3, {time=1000, xScale=2, yScale=1.2, interations=1.1, transition=easing.outElastic, alpha=0})
				numItensFase = numItensFase + 1
				physics.removeBody(paAr3)
			elseif (numItensLibera<=2) then
				local lixoText = display.newText(HUD, "Recolha o lixo primeiro!", display.contentCenterX, display.contentCenterY-50, native.systemFont, 30)
				transition.to(lixoText, {time=1000, alpha=0})
			end --cond
			-- print(numItensLibera)
		end --Meio
		return true  
	end
	paAr3:addEventListener("touch", pegarPaAr3)
	
	local function pegarEscudoAr (event)
		local escudoAr = event.target
		if (event.phase >= "began") then
			print("objeto tocado")
				if(numItensLibera >= 3) then
				transition.to (escudoAr, {time=1000, xScale=2, yScale=1.2, interations=1.1, transition=easing.outElastic, alpha=0})
				numItensFase = numItensFase + 1
				physics.removeBody(escudoAr)
			elseif (numItensLibera<=2) then
				local lixoText = display.newText(HUD, "Recolha o lixo primeiro!", display.contentCenterX, display.contentCenterY-50, native.systemFont, 30)
				transition.to(lixoText, {time=1000, alpha=0})
			end --cond
			-- print(numItensLibera)
		end --Meio
		return true  

	end
	escudoAr:addEventListener("touch", pegarEscudoAr)

	local function pegarPinoVentilador (event)
		local pinoVentilador = event.target
		if (event.phase == "began") then
			print("objeto tocado")
				if(numItensLibera >= 3) then
				transition.to (pinoVentilador, {time=1000, xScale=2, yScale=0.5, interations=0.5, transition=easing.outElastic, alpha=0})
				numItensFase = numItensFase + 1
				physics.removeBody(pinoVentilador)
			elseif (numItensLibera<=2) then
				local lixoText = display.newText(HUD, "Recolha o lixo primeiro!", display.contentCenterX, display.contentCenterY-50, native.systemFont, 30)
				transition.to(lixoText, {time=1000, alpha=0})
			end --cond
			-- print(numItensLibera)
		end --Meio
		return true  
	end
	pinoVentilador:addEventListener("touch", pegarPinoVentilador)

	local function proxFase(event)
		local ventilador = event.target

		if(numItensFase >= 5) then
			
			local textFaseAgua = display.newText(HUD, "Continue", 100, display.contentCenterY, native.systemFont, 20)
			local textMenu = display.newText(HUD, "Volte ao Menu", 350, display.contentCenterY, native.systemFont, 20)

			textMenu:addEventListener ("tap", gotoMenu)
			textFaseAgua:addEventListener ("tap", gotoFaseAgua)

		elseif(numItensFase<=4) then

			local continue= display.newText(HUD, "Falta itens!", 100, display.contentCenterY, native.systemFont, 40)
			transition.to(continue, {time=1200, alpha=0})
			
		end
		return true
	end
	ventilador:addEventListener ("touch", proxFase)

end -- Scene


-- show() - Ocorre imediatamente antes e/ou imediatamente após a cena aparecer na tela.  
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		--O código aqui é executado quando a cena ainda está fora da tela (mas está prestes a aparecer na tela)


	elseif ( phase == "did" ) then
		-- O código aqui é executado quando a cena está inteiramente na tela

		-- criando um Cronometro Regressivo
		local secondsLeft = 180 -- 3min *60, manterá o relógio atulizado na contagem
		local clockText = display.newText(HUD, "3:00", display.contentWidth-45, 80, native.systemFont, 20) -- Colocando relógio na tela.

		-- Atualização do tempo
		local function updateTime(event)

			secondsLeft = secondsLeft -1 -- Diminuindo 1s a cada periodo de tempo(180s).
			-- rastreamos o tempo em segundos e convertemos em minutos
			local minutos = math.floor(secondsLeft / 60) -- math.floor tansforma o número em inteiro(minutos)
			local segundos = secondsLeft %60 -- % pega a parte fracionária da divisão.
			-- Criamos uma string formatada
			-- Puxando os valores de cima na forma decimal. 
			local timeDisplay = string.format("%02d:%02d", minutos, segundos) 
	
			-- Atualizando o texto
			clockText.text = timeDisplay
			
			if (secondsLeft <= 60) then
				transition.to (clockText, {time=800, xScale=2, yScale=2, delay=300, xScale=1, yScale=1})
				clockText:setFillColor(1,0,0)
			end
	
			if (secondsLeft == 0) then
				local gameOver = display.newText(HUD, "Game Over", display.contentCenterX, display.contentCenterY, native.systemFont, 20)

				local textRefazer= display.newText(HUD, "refazer", 100, display.contentCenterY, native.systemFont, 20)
				local textMenu = display.newText(HUD, "Volte ao Menu", 150, display.contentCenterY, native.systemFont, 20)

				textMenu:addEventListener ("tap", gotoMenu)
				textRefazer:addEventListener ("tap", gotoFaseAgua)

			end
		end -- if relógio
		countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft)
		gameLoopTimer = timer.performWithDelay (700, gameLoop, 0)


	end -- show did
end -- show


-- hide()
function scene:hide( event )
	print("fim de cena")

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- O código aqui é executado quando a cena está na tela (mas está prestes a sair da tela) 
		timer.cancel (gameLoopTimer)
		timer.cancel (countDownTimer)


	elseif ( phase == "did" ) then
		-- O código aqui é executado imediatamente após a cena sair totalmente da tela
		composer.removeScene("FaseAr")
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
 		-- O código aqui é executado antes da remoção da visualização da cena
	local poeiraTabela = {0}
	
end

-- Adicionando audio

local bgAudio = audio.loadStream ("Audio/bg1.mp3")
audio.reserveChannels (1)
audio.setVolume (0.6, {channel=1})
audio.play (bgAudio, {channel=1, loops=-1})

-- Audio lixo
local audioClique = audio.loadSound ( "audio/efeitolixo.mp3")
-- informações de como o audio deve ser reproduzido
local parametros = {time = 2000, fadein = 200}

local function tocarClique ()
    audio.play (audioClique, parametros)
end




-- -----------------------------------------------------------------------------------
-- Ouvintes de função de evento de cena
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
return scene


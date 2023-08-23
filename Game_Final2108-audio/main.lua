local composer = require("composer")
local perspective = require ("perspective")

------- Chamando a física ---------
local physics = require ("physics")
physics.start()
physics.setDrawMode ("normal")

-- Criar a camera
local camera = perspective.createView()
camera:prependLayer () -- prepara os layers da camera. (layer == camdas)

display.setStatusBar (display.HiddenStatusBar)

-- Comando que inicia a cena inicial.
composer.gotoScene ("Menu")

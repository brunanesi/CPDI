local composer = require ("composer")

display.setStatusBar (display.HiddenStatusBar)

math.randomseed (os.time())

-- comando que inicia a cena inicial.
composer.gotoScene ("game")
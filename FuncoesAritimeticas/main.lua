-- Variável global. (Deve ser evitado)
vidas = 2
print (vidas)
print ("o valor de vidas: " .. vidas)
---------------
-- Variáveis locais ( só é lida dentro do script)
-- (local) é utilizado somente na crição da variável.
local pontos = 10 
print (pontos)
print ("O valor de pontos: " .. pontos)
------------- Operações aritméticas ----------
-- Soma
-- local (significa que a variável é local) laranjas (nome da variável) = (atribuir valor) 10 (valor atribuído a variável)
local laranjas = 10

laranjas = laranjas + 5
-- print imprime a informação dentro do console.
print (laranjas)

local bananas = 5

-- Soma entre variáveis 
local cesta = 0
cesta = laranjas + bananas 
print ("a soma entre as variáveis laranjas e bananas é: " .. cesta)

print ("Na sua cesta possuem " .. cesta.. " frutas")

-- Subtração

cesta = laranjas - bananas
bananas = bananas - 1 

-- Multiplicação

local carro = 8
carro = carro * 2
print ("quantidade de carros: " .. carro)

carro = carro * 0.5
print ("Divisão pela multiplicação: " .. carro)

-- Divisão
local gato = 6
gato = gato / 2
print ("A divisâo final é: " .. gato)

local arvore = 97.5
arvore = arvore / 4
print ("A divisâo com vírgula é: " .. arvore)

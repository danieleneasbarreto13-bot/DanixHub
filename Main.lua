-- // DANIEL HUB LOGO - CUSTOM 3D LOGO //
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local FloatButton = Instance.new("Frame", ScreenGui)
local DLabel = Instance.new("TextLabel", FloatButton)
local CrownLabel = Instance.new("TextLabel", FloatButton)
local Button = Instance.new("TextButton", FloatButton)

-- // Configuração do Botão Flutuante (Arrastável) //
FloatButton.Size = UDim2.new(0, 60, 0, 70) -- Tamanho do Logo
FloatButton.Position = UDim2.new(0.1, 0, 0.2, 0) -- Posição inicial
FloatButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Fundo Preto
FloatButton.BorderSizePixel = 0
FloatButton.Active = true
FloatButton.Draggable = true -- Você pode mover com o dedo!

-- Cantos arredondados
local Corner = Instance.new("UICorner", FloatButton)
Corner.CornerRadius = UDim.new(0, 10)

-- Borda Roxa Neon
local Stroke = Instance.new("UIStroke", FloatButton)
Stroke.Color = Color3.fromRGB(160, 32, 240) -- Roxo
Stroke.Thickness = 3

-- // A Coroa 👑 //
CrownLabel.Size = UDim2.new(1, 0, 0, 30)
CrownLabel.Position = UDim2.new(0, 0, 0, -10) -- Um pouco acima do D
CrownLabel.Text = "👑"
CrownLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Dourado
CrownLabel.Font = Enum.Font.FredokaOne
CrownLabel.TextSize = 30
CrownLabel.BackgroundTransparency = 1

-- // O 'D' em 3D Dourado //
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Position = UDim2.new(0, 0, 0, 10) -- Centralizado abaixo da coroa
DLabel.Text = "𝕯" -- Letra Gótica (Simula 3D)
DLabel.TextColor3 = Color3.fromRGB(255, 180, 0) -- Ouro Rico
DLabel.Font = Enum.Font.Creepster
DLabel.TextSize = 65
DLabel.BackgroundTransparency = 1

-- Efeito de Sombra (3D) no 'D'
DLabel.TextStrokeTransparency = 0
DLabel.TextStrokeColor3 = Color3.fromRGB(120, 85, 0) -- Ouro Escuro

-- // O Botão Invisível para Clicar //
Button.Size = UDim2.new(1, 0, 1, 0)
Button.BackgroundTransparency = 1
Button.Text = ""

-- Lógica para Abrir/Fechar a Tab Principal do Script (Ajuste o nome do seu menu aqui)
local MenuVisible = false
Button.MouseButton1Click:Connect(function()
    if MenuVisible == false then
        -- Coloque o nome da sua janela Rayfield ou Custom aqui
        -- game:GetService("CoreGui").Rayfield.Visible = true 
        print("Abrindo Menu do Daniel!")
        MenuVisible = true
    else
        -- game:GetService("CoreGui").Rayfield.Visible = false
        print("Fechando Menu do Daniel!")
        MenuVisible = false
    end
end)

print("Logotipo Daniel Hub Carregado!")

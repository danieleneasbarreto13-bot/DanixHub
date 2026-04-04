-- // DANIEL HUB PRO - EDIÇÃO FINAL (INTERFACE IDÊNTICA & AIMBOT MELHORADO) //
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Limpeza de segurança
if PlayerGui:FindFirstChild("DanielHubFinal") then
    PlayerGui.DanielHubFinal:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "DanielHubFinal"
ScreenGui.ResetOnSpawn = false

-- // 1. BOTÃO FLUTUANTE DO LOGO (👑 + D AMARELO) //
local LogoFrame = Instance.new("Frame", ScreenGui)
LogoFrame.Size = UDim2.new(0, 80, 0, 90)
LogoFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
LogoFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Fundo Preto
LogoFrame.Active = true
LogoFrame.Draggable = true -- VOCÊ PODE ARRASTAR PARA ONDE QUISER!

local LogoCorner = Instance.new("UICorner", LogoFrame)
LogoCorner.CornerRadius = UDim.new(0, 15)

local LogoStroke = Instance.new("UIStroke", LogoFrame)
LogoStroke.Color = Color3.fromRGB(160, 32, 240) -- Borda Roxa
LogoStroke.Thickness = 3

local Crown = Instance.new("TextLabel", LogoFrame)
Crown.Size = UDim2.new(1, 0, 0, 40)
Crown.Position = UDim2.new(0, 0, 0, -25)
Crown.Text = "👑"
Crown.BackgroundTransparency = 1
Crown.TextSize = 40

local DLabel = Instance.new("TextLabel", LogoFrame)
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Position = UDim2.new(0, 0, 0, 5)
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Amarelo Ouro
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 60
DLabel.BackgroundTransparency = 1

local OpenBtn = Instance.new("TextButton", LogoFrame)
OpenBtn.Size = UDim2.new(1, 0, 1, 0)
OpenBtn.BackgroundTransparency = 1
OpenBtn.Text = ""

-- // 2. JANELA PRINCIPAL (INTERFACE IDÊNTICA À IMAGEM) //
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 260) -- Tamanho proporcional à imagem
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fundo Totalmente Preto
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true -- Pode arrastar a aba

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(160, 32, 240) -- Borda Roxa
MainStroke.Thickness = 2

-- Título Daniel Hub
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "DANIEL HUB PRO"
Title.TextColor3 = Color3.fromRGB(255, 215, 0) -- Título Amarelo Ouro
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.BackgroundTransparency = 1
Title.ZIndex = 2

-- // 3. BOTÕES ESTILO IDÊNTICO À IMAGEM (CINZA ARREDONDADO) //
local _G = {Aim = false, Esp = false, Noc = false}

local function CreateFuncButton(txt, y, callback)
    local FuncBtn = Instance.new("TextButton", MainFrame)
    FuncBtn.Size = UDim2.new(0.9, 0, 0, 55) -- Botões grandes
    FuncBtn.Position = UDim2.new(0.05, 0, 0, y)
    FuncBtn.BackgroundColor3 = Color

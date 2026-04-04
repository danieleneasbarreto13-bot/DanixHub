-- // DANIEL HUB PRO - INTERFACE MARBLE EDITION //
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Limpeza de segurança
if PlayerGui:FindFirstChild("DanielHubPro") then
    PlayerGui.DanielHubPro:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "DanielHubPro"
ScreenGui.ResetOnSpawn = false

-- // 1. BOTÃO FLUTUANTE (LOGO D + 👑) //
local LogoFrame = Instance.new("Frame", ScreenGui)
LogoFrame.Size = UDim2.new(0, 70, 0, 80)
LogoFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
LogoFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LogoFrame.Active = true
LogoFrame.Draggable = true -- Mova o botão para onde quiser

local LogoCorner = Instance.new("UICorner", LogoFrame)
LogoCorner.CornerRadius = UDim.new(0, 15)

local LogoStroke = Instance.new("UIStroke", LogoFrame)
LogoStroke.Color = Color3.fromRGB(160, 32, 240)
LogoStroke.Thickness = 3

local Crown = Instance.new("TextLabel", LogoFrame)
Crown.Size = UDim2.new(1, 0, 0, 40)
Crown.Position = UDim2.new(0, 0, 0, -25)
Crown.Text = "👑"
Crown.BackgroundTransparency = 1
Crown.TextSize = 35

local DLabel = Instance.new("TextLabel", LogoFrame)
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 55
DLabel.BackgroundTransparency = 1

local OpenBtn = Instance.new("TextButton", LogoFrame)
OpenBtn.Size = UDim2.new(1, 0, 1, 0)
OpenBtn.BackgroundTransparency = 1
OpenBtn.Text = ""

-- // 2. JANELA PRINCIPAL COM FUNDO PERSONALIZADO //
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 350, 0, 220)
Main.Position = UDim2.new(0.5, -175, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true -- Mova a aba para onde quiser

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 12)

-- Imagem de Fundo (A que você enviou)
local BackgroundImg = Instance.new("ImageLabel", Main)
BackgroundImg.Size = UDim2.new(1, 0, 1, 0)
BackgroundImg.Image = "rbxassetid://169db234-6f48-4232-965c-16b138f2d294" -- ID do mármore
BackgroundImg.ScaleType = Enum.ScaleType.Crop
BackgroundImg.ZIndex = 0
Instance.new("UICorner", BackgroundImg).CornerRadius = UDim.new(0, 12)

-- Overlay Escuro para leitura
local Overlay = Instance.new("Frame", Main)
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.4
Overlay.ZIndex = 1
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(160, 32, 240)
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Título
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "DANIEL HUB PRO"
Title.TextColor3 = Color3.fromRGB(255, 215, 0) -- Ouro
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.ZIndex = 2

-- Abrir/Fechar
OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- // 3. SISTEMA DE BOTÕES ESTILIZADOS //
local _G = {Aim = false, Esp = false, Noc = false}

local function CreateToggle(txt, y, callback)
    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(0.9, 0, 0, 40)
    Container.Position = UDim2.new(0.05, 0, 0, y)
    Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Container.BackgroundTransparency = 0.8
    Container.ZIndex = 2
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 20)
    
    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Text = txt .. ": OFF"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.
   

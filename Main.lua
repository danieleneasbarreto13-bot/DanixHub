-- // DANIEL HUB PRO - DEFINITIVE EDITION //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Limpeza de UI para evitar bugs
local function Cleanup()
    local old = LocalPlayer.PlayerGui:FindFirstChild("DanielHubPrecision")
    if old then old:Destroy() end
end
Cleanup()

local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "DanielHubPrecision"
ScreenGui.ResetOnSpawn = false

-- // 1. ÍCONE FLUTUANTE (D AMARELO + 👑) //
local LogoFrame = Instance.new("Frame", ScreenGui)
LogoFrame.Size = UDim2.new(0, 85, 0, 95)
LogoFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
LogoFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LogoFrame.Active = true
LogoFrame.Draggable = true -- PODE ARRASTAR O 'D' PARA ONDE QUISER

local LogoCorner = Instance.new("UICorner", LogoFrame)
LogoCorner.CornerRadius = UDim.new(0, 18)

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
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Dourado
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 65
DLabel.BackgroundTransparency = 1

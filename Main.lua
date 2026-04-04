-- // DANIEL HUB - VERSÃO COMPATIBILIDADE TOTAL //
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove versões antigas se existirem para não bugar
if PlayerGui:FindFirstChild("DanielHubGui") then
    PlayerGui.DanielHubGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "DanielHubGui"
ScreenGui.ResetOnSpawn = false -- Não some quando você morre

-- // 1. JANELA PRINCIPAL //
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true -- Pode arrastar

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(160, 32, 240)
MainStroke.Thickness = 3

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "Feito por DANIEL"
Title.TextColor3 = Color3.fromRGB(160, 32, 240)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- // 2. O BOTÃO DO LOGO (👑 + D AMARELO) //
local FloatButton = Instance.new("Frame", ScreenGui)
FloatButton.Name = "LogoButton"
FloatButton.Size = UDim2.new(0, 70, 0, 80)
FloatButton.Position = UDim2.new(0.1, 0, 0.4, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
FloatButton.Active = true
FloatButton.Draggable = true

local Corner = Instance.new("UICorner", FloatButton)
Corner.CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", FloatButton)
Stroke.Color = Color3.fromRGB(160, 32, 240)
Stroke.Thickness = 2

local Crown = Instance.new("TextLabel", FloatButton)
Crown.Size = UDim2.new(1, 0, 0, 35)
Crown.Position = UDim2.new(0, 0, 0,

-- // DANIEL HUB PRO - VERSÃO FINAL OTIMIZADA //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Limpeza de UI anterior para evitar sobreposição
for _, v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
    if v.Name == "DanielHubFinal" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "DanielHubFinal"
ScreenGui.ResetOnSpawn = false

-- // 1. ÍCONE "D" COM COROA (BOTÃO DE ABERTURA) //
local Logo = Instance.new("Frame", ScreenGui)
Logo.Size = UDim2.new(0, 80, 0, 90)
Logo.Position = UDim2.new(0.05, 0, 0.4, 0)
Logo.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Logo.Active = true
Logo.Draggable = true -- Arraste para qualquer lugar

local LogoCorner = Instance.new("UICorner", Logo)
LogoCorner.CornerRadius = UDim.new(0, 15)
local LogoStroke = Instance.new("UIStroke", Logo)
LogoStroke.Color = Color3.fromRGB(160, 32, 240)
LogoStroke.Thickness = 3

local DLabel = Instance.new("TextLabel", Logo)
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
D

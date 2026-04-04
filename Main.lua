-- // DANIEL HUB - CORREÇÃO DE LOGO (D AMARELO + COROA) //
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- // 1. JANELA PRINCIPAL //
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(160, 32, 240)
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "Feito por DANIEL"
Title.TextColor3 = Color3.fromRGB(160, 32, 240)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- // 2. BOTÃO FLUTUANTE CORRIGIDO //
local FloatButton = Instance.new("Frame", ScreenGui)
FloatButton.Size = UDim2.new(0, 80, 0, 90) -- Aumentei o tamanho para caber tudo
FloatButton.Position = UDim2.new(0.1, 0, 0.2, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
FloatButton.Active = true
FloatButton.Draggable = true

local Corner = Instance.new("UICorner", FloatButton)
Corner.CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", FloatButton)
Stroke.Color = Color3.fromRGB(160, 32, 240)
Stroke.Thickness = 3

-- Coroa 👑
local Crown = Instance.new("TextLabel", FloatButton)
Crown.Size = UDim2.new(1, 0, 0, 40)
Crown.Position = UDim2.new(0, 0, 0, -20) -- Ajustado para ficar em cima
Crown.Text = "👑"
Crown.BackgroundTransparency = 1
Crown.TextSize = 40
Crown.ZIndex = 5

-- Letra D Amarela 🟡
local DLabel = Instance.new("TextLabel", FloatButton)
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Position = UDim2.new(0, 0, 0, 5) -- Centralizado
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Amarelo Ouro
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 60
DLabel.BackgroundTransparency = 1
DLabel.ZIndex = 4

-- Botão Invisível de Clique
local ClickBtn = Instance.new("TextButton", FloatButton)
ClickBtn.Size = UDim2.new(1, 0, 1, 0)
ClickBtn.BackgroundTransparency = 1
ClickBtn.Text = ""
ClickBtn.ZIndex = 10

ClickBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- // 3. BOTÕES DE FUNÇÕES //
local function CreateFuncBtn(text, pos)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    return btn
end

local ToggleAimbot = CreateFuncBtn("Aimbot: OFF", 60)
local ToggleEsp = CreateFuncBtn("ESP: OFF", 115)
local ToggleNoClip = CreateFuncBtn("NoClip: OFF", 170)

-- (Lógica de Aimbot/ESP/NoClip mantida igual ao anterior para funcionar 100%)
local _G = {Aimbot = false, Esp = false, NoClip = false}
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

ToggleAimbot.MouseButton1Click:Connect(function()
    _G.Aimbot = not _G.Aimbot
    ToggleAimbot.Text = _G.Aimbot and "Aimbot: ON" or "Aimbot: OFF"
    ToggleAimbot.BackgroundColor3 = _G.Aimbot and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(30, 30, 30)
end)

ToggleEsp.MouseButton1Click:Connect(function()
    _G.Esp = not _G.Esp
    ToggleEsp.Text = _G.Esp and "ESP: ON" or "ESP: OFF"
    ToggleEsp.BackgroundColor3 = _G.Esp and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 30, 30)
end)

ToggleNoClip.MouseButton1Click:Connect(function()
    _G.NoClip = not _G.NoClip
    ToggleNoClip.Text = _G.NoClip and "NoClip: ON" or "NoClip: OFF"
    ToggleNoClip.BackgroundColor3 = _G.NoClip and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(30, 30, 30)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local char = p.Character
            local tracer = char:FindFirstChild("DLine")
            if _G.Esp then
                if not tracer then
                    tracer = Instance.new("LineHandleAdornment", char)
                    tracer.Name = "DLine"
                    tracer.Thickness = 2

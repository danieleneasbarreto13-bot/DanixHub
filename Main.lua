local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // 1. CRIANDO A JANELA RAYFIELD (ESTILO INICIAL) //
local Window = Rayfield:CreateWindow({
   Name = "DANIEL HUB | V13",
   LoadingTitle = "Feito por DANIEL",
   LoadingSubtitle = "O melhor para o Delta!",
   ConfigurationSaving = { Enabled = false },
   Image = 104071203297793,
   CustomTheme = {
      ["AccentColor"] = Color3.fromRGB(160, 32, 240), -- Roxo 🟣
      ["BackgroundColor"] = Color3.fromRGB(0, 0, 0),   -- Preto 🌑
      ["WindowColor"] = Color3.fromRGB(12, 12, 12),
      ["TextColor"] = Color3.fromRGB(255, 255, 255),
      ["TabColor"] = Color3.fromRGB(35, 0, 70),
      ["TitleColor"] = Color3.fromRGB(160, 32, 240)
   }
})

-- // VARIÁVEIS DE FUNÇÃO //
local _G = { Esp = false, Aimbot = false, NoClip = false }
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- // ABA ÚNICA DO RAYFIELD //
local MainTab = Window:CreateTab("Painel Único", 4483362458)

MainTab:CreateToggle({
   Name = "Ativar NoClip (Atravessar)",
   CurrentValue = false,
   Callback = function(v) _G.NoClip = v end,
})

MainTab:CreateToggle({
   Name = "Aimbot Lock (Wall Check)",
   CurrentValue = false,
   Callback = function(v) _G.Aimbot = v end,
})

MainTab:CreateToggle({
   Name = "ESP + Linhas (Vermelho 🔴)",
   CurrentValue = false,
   Callback = function(v) _G.Esp = v end,
})

-- // 2. BOTÃO FLUTUANTE PERSONALIZADO (👑 + D DOURADO) //
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local FloatButton = Instance.new("Frame", ScreenGui)
local DLabel = Instance.new("TextLabel", FloatButton)
local Crown = Instance.new("TextLabel", FloatButton)
local ClickBtn = Instance.new("TextButton", FloatButton)

FloatButton.Size = UDim2.new(0, 75, 0, 85)
FloatButton.Position = UDim2.new(0.1, 0, 0.3, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
FloatButton.Active = true
FloatButton.Draggable = true

local Corner = Instance.new("UICorner", FloatButton)
Corner.CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", FloatButton)
Stroke.Color = Color3.fromRGB(160, 32, 240)
Stroke.Thickness = 3

Crown.Size = UDim2.new(1, 0, 0, 40)
Crown.Position = UDim2.new(0, 0, 0, -25)
Crown.Text = "👑"
Crown.BackgroundTransparency = 1
Crown.TextSize = 40

DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Dourado
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 55
DLabel.BackgroundTransparency = 1

ClickBtn.Size = UDim2.new(1, 0, 1, 0)
ClickBtn.BackgroundTransparency = 1
ClickBtn.Text = ""

-- Função de Abrir/Fechar a Tab do Rayfield
ClickBtn.MouseButton1Click:Connect(function()
    local core = game:GetService("CoreGui")
    local rf_gui = core:FindFirstChild("Rayfield")
    if rf_gui then
        rf_gui.Enabled = not rf_gui.Enabled
    end
end)

-- // 3. LÓGICA DO SCRIPT (WALL CHECK + ESP + NOCLIP) //
game:GetService("RunService").RenderStepped:Connect(function()
    -- Wall Check Aimbot
    if _G.Aimbot then
        local target, dist = nil, 500
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, screen = Camera:WorldToViewportPoint(p.Character.Head.

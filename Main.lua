local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🕸️ VÓRTEX SCRIPT 🕸️",
   LoadingTitle = "Carregando Sistema Completo...",
   LoadingSubtitle = "Créditos: 👑DANIEL 👑",
   ConfigurationSaving = { Enabled = false }
})

-- Variáveis de Controle
local _G = {
    Aimbot = false,
    Esp = false,
    EspColor = Color3.fromRGB(0, 255, 0),
    JumpEnabled = false,
    JumpPower = 50,
    Discord = "https://discord.gg/VWbCUddZ5", -- Link do seu Discord atualizado
    Aliados = {} -- Tabela de aliados
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- // INTERFACE DO BOTÃO DE PULO (MÓVEL)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local JumpBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Arrow = Instance.new("TextLabel")

JumpBtn.Name = "VortexJumpBtn"
JumpBtn.Parent = ScreenGui
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
JumpBtn.Position = UDim2.new(0.5, 0, 0.8, 0)
JumpBtn.Size = UDim2.new(0, 65, 0, 65)
JumpBtn.Text = ""
JumpBtn.Visible = false
JumpBtn.Active = true
JumpBtn.Draggable = true 

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = JumpBtn

Arrow.Parent = JumpBtn
Arrow.Size = UDim2.new(1, 0, 1, 0)
Arrow.BackgroundTransparency = 1
Arrow.Text = "↑"
Arrow.TextColor3 = Color3.fromRGB(0, 255, 0)
Arrow.TextSize = 45
Arrow.Font = Enum.Font.SourceSansBold

JumpBtn.MouseButton1Click:Connect(function()
    local Char = LocalPlayer.Character
    if Char and Char:FindFirstChild("HumanoidRootPart") then
        Char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DEFINITIVE AIM",
   LoadingTitle = "A Corrigir Motores de Mira...",
   LoadingSubtitle = "Filtro de Colisão Ignorado",
   ConfigurationSaving = { Enabled = false }
})

-- Variáveis de Controlo
local _G = {
    Esp = false,
    Aimbot = false,
    Distance = false,
    JumpPower = 50,
    JumpEnabled = false
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Criando a Interface do Botão Externo (Invisível por padrão)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local ExternalJumpBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Arrow = Instance.new("TextLabel")

ExternalJumpBtn.Name = "ExternalJumpBtn"
ExternalJumpBtn.Parent = ScreenGui
ExternalJumpBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fundo Preto
ExternalJumpBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
ExternalJumpBtn.Size = UDim2.new(0, 60, 0, 60)
ExternalJumpBtn.Text = ""
ExternalJumpBtn.Visible = false
ExternalJumpBtn.Active = true
ExternalJumpBtn.Draggable = true -- Permite mover

UICorner.CornerRadius = UDim.new(1, 0) -- Torna redondo
UICorner.Parent = ExternalJumpBtn

Arrow.Parent = ExternalJumpBtn
Arrow.Size = UDim2.new(1, 0, 1, 0)
Arrow.BackgroundTransparency = 1
Arrow.Text = "↑"
Arrow.TextColor3 = Color3.fromRGB(0, 255, 0) -- Seta Verde
Arrow.TextSize = 40
Arrow.Font = Enum.Font.SourceSansBold

-- Função de Pulo
local function DoJump()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        task.wait(0.05)
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, _G.JumpPower, 0)
    end
end

ExternalJumpBtn.MouseButton1Click:Connect(DoJump)

--- ABAS DO MENU ---
local MainTab = Window:CreateTab("Combate & Visual", 4483362458)
local MovementTab = Window:CreateTab("Movimentação", 4483362459)

--- INTERFACE DE COMBATE ---
MainTab:CreateToggle({
   Name = "Visual: X-RAY ESP",
   CurrentValue = false,
   Callback = function(Value) _G.Esp = Value end,
})

MainTab:CreateToggle({
   Name = "Visual: Distância (Studs)",
   CurrentValue = false,
   Callback = function(Value) _G.Distance = Value end,
})

MainTab:CreateToggle({
   Name = "Combate: Grudar Mira (Head-Lock)",
   CurrentValue = false,
   Callback = function(Value) _G.Aimbot = Value end,
})

--- INTERFACE DE MOVIMENTAÇÃO (NOVO) ---
MovementTab:CreateToggle({
   Name = "Ativar Botão de Pulo Externo",
   CurrentValue = false,
   Callback = function(Value)
       _G.JumpEnabled = Value
       ExternalJumpBtn.Visible = Value
   end,
})

MovementTab:CreateSlider({
   Name = "Força do Pulo",
   Range = {1, 100},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DANIEL HUB",
   LoadingTitle = "Carregando Sistema Completo...",
   LoadingSubtitle = "Créditos: DANIEL",
   ConfigurationSaving = { Enabled = false }
})

-- Variáveis de Controle
local _G = {
    Aimbot = false,
    Esp = false,
    EspColor = Color3.fromRGB(0, 255, 0),
    JumpEnabled = false,
    JumpPower = 50
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

JumpBtn.Name = "DanielJumpBtn"
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

-- Mecânica de Pulo
JumpBtn.MouseButton1Click:Connect(function()
    local Char = LocalPlayer.Character
    if Char and Char:FindFirstChild("HumanoidRootPart") then
        Char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        Char.HumanoidRootPart.Velocity = Vector3.new(Char.HumanoidRootPart.Velocity.X, _G.JumpPower, Char.HumanoidRootPart.Velocity.Z)
    end
end)

-- // FUNÇÃO WALL CHECK (MIRA)
local function IsVisible(targetPart)
    local character = LocalPlayer.Character
    if not character then return false end
    local origin = Camera.CFrame.Position
    local destination = targetPart.Position
    local direction = (destination - origin).Unit * (destination - origin).Magnitude
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character, targetPart.Parent}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    return raycastResult == nil
end

-- // INTERFACE DO MENU
local MainTab = Window:CreateTab("Principal", 4483362458)

MainTab:CreateSection("Combate & Mira")

MainTab:CreateToggle({
   Name = "Ativar Head-Lock (Wall-Check)",
   CurrentValue = false,
   Callback = function(Value) _G.Aimbot = Value end,
})

MainTab:CreateSection("Visuais & Cores")

MainTab:CreateToggle({
   Name = "Ativar X-RAY ESP",
   CurrentValue = false,
   Callback = function(Value) _G.Esp = Value end,
})

MainTab:CreateColorPicker({
    Name = "Cor do Brilho (ESP)",
    Color = _G.EspColor,
    Callback = function(Value) _G.EspColor = Value end
})

MainTab:CreateSection("Movimentação")

MainTab:CreateToggle({
   Name = "Mostrar Botão de Pulo",
   CurrentValue = false,
   Callback = function(Value)
       _G.JumpEnabled = Value
       JumpBtn.Visible = Value
   end,
})

MainTab:CreateSlider({
   Name = "Força do Pulo",
   Range = {1, 100},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Callback = function(Value) _G.JumpPower = Value end,
})

MainTab:CreateSection("Personalização do Script")

MainTab:CreateColorPicker({
    Name = "Cor de Destaque do Menu",
    Color = Color3.fromRGB(0, 255, 0),
    Callback = function(Value)
        -- Muda a cor dos elementos do Rayfield em tempo real
        Window.ModifyTheme({AccentColor = Value})
    end
})

MainTab:CreateSection("Créditos")

MainTab:CreateParagraph({
    Title = "👑 FEITO POR DANIEL", 
    Content = "Script definitivo otimizado para Delta Executor."
})

-- // LÓGICA DE LOOP (AIMBOT / ESP)
local function GetClosestTarget()
    local target = nil
    local shortestDistance = math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen and IsVisible(head) then
                local screenDist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if screenDist < shortestDistance then
                    target = head
                    shortestDistance = screenDist
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestTarget()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("EliteHL")
            if _G.Esp then
                if not hl then
                    hl = Instance.new("Highlight", p.Character)
                    hl.Name = "EliteHL"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
                hl.FillColor = _G.EspColor
            elseif hl then hl:Destroy() end
        end
    end
end)

Rayfield:Notify({
   Title = "DANIEL HUB CARREGADO",
   Content = "Todas as funções estão ativas!",
   Duration = 5,
   Image = 4483362458,
})

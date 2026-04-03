local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "✠𝕯𝖆𝖓𝖎𝖊𝖑✠", -- Nome atualizado aqui
   LoadingTitle = "INICIANDO SISTEMA...",
   LoadingSubtitle = "By Daniel - V13",
   ConfigurationSaving = { Enabled = false },
   Image = 104071203297793 
})

-- Variáveis de Controle
local _G = {
    Esp = false,
    Aimbot = false,
    Distance = true,
    NoClip = false
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Abas
local MoveTab = Window:CreateTab("Movimentação", 104071203297793)
local CombatTab = Window:CreateTab("Combate & Visual", 104071203297793)

--- SEÇÃO DE MOVIMENTAÇÃO ---
MoveTab:CreateToggle({
   Name = "NoClip (Atravessar Paredes)",
   CurrentValue = false,
   Callback = function(Value) _G.NoClip = Value end,
})

RunService.Stepped:Connect(function()
    if _G.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

--- SEÇÃO DE COMBATE E VISUAL ---
CombatTab:CreateToggle({
   Name = "Grudar na Cabeça (Agressivo)",
   CurrentValue = false,
   Callback = function(Value) _G.Aimbot = Value end,
})

CombatTab:CreateToggle({
   Name = "X-RAY ESP (Bordas Verdes)",
   CurrentValue = false,
   Callback = function(Value) _G.Esp = Value end,
})

CombatTab:CreateToggle({
   Name = "Mostrar Distância [M]",
   CurrentValue = true,
   Callback = function(Value) _G.Distance = Value end,
})

--- BUSCA DE ALVO ---
local function GetClosestTarget()
    local target = nil
    local shortestDistance = math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
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

--- LOOP DE RENDERIZAÇÃO ---
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestTarget()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local char = p.Character
            
            local hl = char:FindFirstChild("EliteHL")
            if _G.Esp then
                if not hl then
                    hl = Instance.new("Highlight", char)
                    hl.Name = "EliteHL"
                    hl.FillColor = Color3.fromRGB(0, 255, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            elseif hl then hl:Destroy() end

            local bill = char.Head:FindFirstChild("EliteDist")
            if _G.Distance then
                if not bill then
                    bill = Instance.new("BillboardGui", char.Head)
                    bill.Name = "EliteDist"
                    bill.Size = UDim2.new(0, 100, 0, 50)
                    bill.AlwaysOnTop = true
                    bill.ExtentsOffset = Vector3.new(0, 3, 0)
                    local lbl = Instance.new("TextLabel", bill)
                    lbl.BackgroundTransparency = 1
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.TextColor3 = Color3.fromRGB(0, 255, 0)
                    lbl.TextStrokeTransparency = 0
                    lbl.Font = Enum.Font.SourceSansBold
                    lbl.TextSize = 18
                    lbl.Name = "Label"
                end
                if char:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                    bill.Label.Text = math.floor(dist) .. "m"
                end
            elseif bill then bill:Destroy() end
        end
    end
end)

Rayfield:Notify({
   Title = "BEM-VINDO, DANIEL",
   Content = "Script carregado com sucesso!",
   Duration = 3,
   Image = 104071203297793,
})

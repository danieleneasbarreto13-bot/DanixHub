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
    Distance = false
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local MainTab = Window:CreateTab("Combate & Visual", 4483362458)

--- FUNÇÃO DE VISIBILIDADE ULTRA-MELHORADA ---
local function IsVisible(part)
    if not part or not LocalPlayer.Character then return false end
    
    local char = LocalPlayer.Character
    local origin = Camera.CFrame.Position
    local destination = part.Position
    local direction = (destination - origin).Unit * (destination - origin).Magnitude
    
    local params = RaycastParams.new()
    -- Ignora o teu personagem E o personagem do inimigo para o tiro passar
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {char, part.Parent}
    
    local result = workspace:Raycast(origin, direction, params)
    
    -- Se o raio não bater em NADA (nil), o caminho está livre
    return result == nil
end

--- INTERFACE ---
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

--- LÓGICA DE VISUAIS ---
RunService.Heartbeat:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local char = p.Character
            
            -- Aura ESP
            local hl = char:FindFirstChild("EliteHL")
            if _G.Esp then
                if not hl then
                    hl = Instance.new("Highlight", char)
                    hl.Name = "EliteHL"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            elseif hl then hl:Destroy() end

            -- Distância
            local bill = char:FindFirstChild("EliteDist")
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
                    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                    lbl.TextStrokeTransparency = 0
                    lbl.Font = Enum.Font.SourceSansBold
                    lbl.TextSize = 16
                    lbl.Name = "Label"
                end
                local mag = (LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                bill.Label.Text = math.floor(mag) .. " Studs"
            elseif bill then bill:Destroy() end
        end
    end
end)

--- BUSCA DE ALVO (SIMPLIFICADA E AGRESSIVA) ---
local function GetClosestTarget()
    local target = nil
    local shortestDistance = math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            
            if onScreen then
                -- Se o Aimbot não funcionar, remove temporariamente o 'and IsVisible(head)' para testar
                if IsVisible(head) then
                    local screenDist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if screenDist < shortestDistance then
                        target = head
                        shortestDistance = screenDist
                    end
                end
            end
        end
    end
    return target
end

--- LOOP DA CÂMARA (LOCK INSTANTÂNEO) ---
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestTarget()
        if target then
            -- MIRA DIRETA NA CABEÇA
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

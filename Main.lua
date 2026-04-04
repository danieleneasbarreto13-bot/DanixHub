local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // INTERFACE PRETO E ROXO //
local Window = Rayfield:CreateWindow({
   Name = "DANIEL HUB | V13",
   LoadingTitle = "Feito por DANIEL", -- Sem fontes estranhas para não dar []
   LoadingSubtitle = "O melhor para o Delta VNG!",
   ConfigurationSaving = { Enabled = false },
   Image = 104071203297793,
   CustomTheme = {
      ["AccentColor"] = Color3.fromRGB(160, 32, 240), -- Roxo 🟣
      ["BackgroundColor"] = Color3.fromRGB(0, 0, 0),   -- Preto 🌑
      ["WindowColor"] = Color3.fromRGB(12, 12, 12),
      ["TextColor"] = Color3.fromRGB(255, 255, 255),
      ["TabColor"] = Color3.fromRGB(35, 0, 70),
      ["TabTextColor"] = Color3.fromRGB(255, 255, 255),
      ["TitleColor"] = Color3.fromRGB(160, 32, 240),
      ["ButtonColor"] = Color3.fromRGB(45, 0, 90),
      ["ToggleColor"] = Color3.fromRGB(160, 32, 240)
   }
})

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

-- // TODAS AS FUNÇÕES EM UMA SÓ ABA //
local MainTab = Window:CreateTab("Painel Único", 104071203297793)

MainTab:CreateSection("Configurações do Script")

MainTab:CreateToggle({
   Name = "Ativar NoClip (Atravessar)",
   CurrentValue = false,
   Callback = function(v) _G.NoClip = v end,
})

MainTab:CreateToggle({
   Name = "Aimbot Lock (Somente Visíveis)",
   CurrentValue = false,
   Callback = function(v) _G.Aimbot = v end,
})

MainTab:CreateToggle({
   Name = "X-RAY ESP (Vermelho 🔴)",
   CurrentValue = false,
   Callback = function(v) _G.Esp = v end,
})

-- // FUNÇÃO PARA CHECAR SE O INIMIGO ESTÁ ATRÁS DA PAREDE //
local function IsVisible(part)
    local character = LocalPlayer.Character
    if not character then return false end
    
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {character, part.Parent}
    
    local origin = Camera.CFrame.Position
    local direction = (part.Position - origin).Unit * (part.Position - origin).Magnitude
    local result = workspace:Raycast(origin, direction, params)
    
    return result == nil -- Se bater em algo (parede), result não é nil, então retorna false
end

-- // BUSCA DE ALVO PRÓXIMO DA MIRA //
local function GetClosestTarget()
    local target, dist = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local pos, screen = Camera:WorldToViewportPoint(head.Position)
            
            if screen then
                -- SÓ GRUDA SE ESTIVER VISÍVEL (WALL CHECK)
                if IsVisible(head) then
                    local m = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if m < dist then 
                        target = head
                        dist = m 
                    end
                end
            end
        end
    end
    return target
end

-- // LOOP PRINCIPAL //
RunService.RenderStepped:Connect(function()
    -- AIMBOT AGRESSIVO (VISÍVEL)
    if _G.Aimbot then
        local target = GetClosestTarget()
        if target then 
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) 
        end
    end
    
    -- NOCLIP
    if _G.NoClip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
    
    -- VISUAIS VERMELHOS [M]
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local char = p.Character
            
            -- ESP Highlight (Vermelho)
            local hl = char:FindFirstChild("E_HL")
            if _G.Esp then
                if not hl then
                    hl = Instance.new("Highlight", char); hl.Name = "E_HL"
                    hl.FillColor = Color3.fromRGB(255, 0, 0) -- VERMELHO 🔴
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            elseif hl then hl:Destroy() end

            -- Distância (Vermelho)
            local bill = char.Head:FindFirstChild("E_Dist")
            if _G.Distance then
                if not bill then
                    bill = Instance.new("BillboardGui", char.Head); bill.Name = "E_Dist"
                    bill.Size = UDim2.new(0,100,0,50); bill.AlwaysOnTop = true
                    bill.ExtentsOffset = Vector3.new(0,3,0)
                    local l = Instance.new("TextLabel", bill)
                    l.BackgroundTransparency = 1; l.Size = UDim2.new(1,0,1,0)
                    l.TextColor3 = Color3.fromRGB(255, 0, 0); l.Font = "SourceSansBold"; l.TextSize = 18
                    l.Name = "Label"
                end
                if char:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                    bill.Label.Text = math.floor(d) .. "m"
                end
            elseif bill then bill:Destroy() end
        end
    end
end)

Rayfield:Notify({
   Title = "Feito por DANIEL",
   Content = "Script Carregado! Modo: Wall Check Ativo.",
   Duration = 5,
   Image = 104071203297793,
})

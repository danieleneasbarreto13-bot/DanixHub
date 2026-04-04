local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // INTERFACE PERSONALIZADA PRETO E ROXO //
local Window = Rayfield:CreateWindow({
   Name = "✠ 𝕯𝖆𝖓𝖎𝖊𝖑 ✠ HUB", 
   LoadingTitle = "✠ 𝕯𝖆𝖓𝖎𝖊𝖑 ✠", 
   LoadingSubtitle = "Bem-vindo ao seu Script Especial!",
   ConfigurationSaving = { Enabled = false },
   Image = 104071203297793,
   -- FORÇANDO AS CORES PRETO E ROXO
   CustomTheme = {
      ["AccentColor"] = Color3.fromRGB(160, 32, 240), -- Roxo Vibrante 🟣
      ["BackgroundColor"] = Color3.fromRGB(0, 0, 0),   -- Preto Puro 🌑
      ["WindowColor"] = Color3.fromRGB(15, 15, 15),    -- Cinza Quase Preto
      ["TextColor"] = Color3.fromRGB(255, 255, 255),
      ["TabColor"] = Color3.fromRGB(30, 0, 60),       -- Roxo Escuro
      ["TabTextColor"] = Color3.fromRGB(255, 255, 255),
      ["TitleColor"] = Color3.fromRGB(160, 32, 240),
      ["DescriptionColor"] = Color3.fromRGB(200, 200, 200),
      ["ButtonColor"] = Color3.fromRGB(50, 0, 100),
      ["ButtonTextColor"] = Color3.fromRGB(255, 255, 255),
      ["ToggleColor"] = Color3.fromRGB(160, 32, 240)
   }
})

local _G = { Esp = false, Aimbot = false, Distance = true, NoClip = false }
local Camera, Players, RunService = workspace.CurrentCamera, game:GetService("Players"), game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ABAS COM A FOTO DO GATINHO
local MoveTab = Window:CreateTab("Movimentação", 104071203297793)
local CombatTab = Window:CreateTab("Combate & Visual", 104071203297793)

--- SEÇÃO DE MOVIMENTAÇÃO ---
MoveTab:CreateToggle({
   Name = "NoClip (Atravessar Paredes)",
   CurrentValue = false,
   Callback = function(v) _G.NoClip = v end,
})

RunService.Stepped:Connect(function()
    if _G.NoClip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

--- SEÇÃO DE COMBATE (AIMBOT AGRESSIVO) ---
CombatTab:CreateToggle({
   Name = "Aimbot Lock (Instantâneo)",
   CurrentValue = false,
   Callback = function(v) _G.Aimbot = v end,
})

CombatTab:CreateToggle({
   Name = "X-RAY ESP (Verde 🟢)",
   CurrentValue = false,
   Callback = function(v) _G.Esp = v end,
})

-- FUNÇÃO DE ALVO MAIS PRÓXIMO DA MIRA
local function GetClosestTarget()
    local target, dist = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local pos, screen = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if screen then
                local m = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if m < dist then target = p.Character.Head; dist = m end
            end
        end
    end
    return target
end

--- LOOP DE RENDERIZAÇÃO ---
RunService.RenderStepped:Connect(function()
    -- AIMBOT AGRESSIVO
    if _G.Aimbot then
        local target = GetClosestTarget()
        if target then 
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) 
        end
    end
    
    -- VISUAIS VERDES [M]
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local char = p.Character
            
            local hl = char:FindFirstChild("E_HL")
            if _G.Esp then
                if not hl then
                    hl = Instance.new("Highlight", char); hl.Name = "E_HL"
                    hl.FillColor = Color3.fromRGB(0, 255, 0)
                end
            elseif hl then hl:Destroy() end

            local bill = char.Head:FindFirstChild("E_Dist")
            if _G.Distance then
                if not bill then
                    bill = Instance.new("BillboardGui", char.Head); bill.Name = "E_Dist"
                    bill.Size = UDim2.new(0,100,0,50); bill.AlwaysOnTop = true
                    bill.ExtentsOffset = Vector3.new(0,3,0)
                    local l = Instance.new("TextLabel", bill)
                    l.BackgroundTransparency = 1; l.Size = UDim2.new(1,0,1,0)
                    l.TextColor3 = Color3.fromRGB(0, 255, 0); l.Font = "SourceSansBold"; l.TextSize = 18
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
   Title = "✠ 𝕯𝖆𝖓𝖎𝖊𝖑 ✠ HUB ATIVADO",
   Content = "Fundo Preto e Detalhes Roxos prontos!",
   Duration = 5,
   Image = 104071203297793,
})

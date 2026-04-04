local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DANIEL HUB | V13", -- Nome simples pro sistema não travar
   LoadingTitle = "✠ DANIEL ✠", -- Nome estiloso na entrada
   LoadingSubtitle = "Bem-vindo ao seu Script Especial!",
   ConfigurationSaving = { Enabled = false },
   Image = 104071203297793,
   CustomTheme = {
      ["AccentColor"] = Color3.fromRGB(120, 0, 200), -- Roxo Vibrante
      ["BackgroundColor"] = Color3.fromRGB(10, 10, 10), -- Preto
      ["WindowColor"] = Color3.fromRGB(15, 15, 15),
      ["TextColor"] = Color3.fromRGB(255, 255, 255),
      ["TabColor"] = Color3.fromRGB(25, 0, 45),
      ["TabTextColor"] = Color3.fromRGB(200, 200, 200),
      ["TitleColor"] = Color3.fromRGB(255, 255, 255),
      ["ButtonColor"] = Color3.fromRGB(50, 0, 90),
      ["ButtonTextColor"] = Color3.fromRGB(255, 255, 255),
      ["ToggleColor"] = Color3.fromRGB(70, 0, 130)
   }
})

local _G = { Esp = false, Aimbot = false, Distance = true, NoClip = false }
local Camera, Players, RunService = workspace.CurrentCamera, game:GetService("Players"), game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local MoveTab = Window:CreateTab("Movimento", 104071203297793)
local CombatTab = Window:CreateTab("Combate", 104071203297793)

MoveTab:CreateToggle({
   Name = "NoClip (Atravessar)",
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

CombatTab:CreateToggle({
   Name = "Aimbot Lock (Cabeça)",
   CurrentValue = false,
   Callback = function(v) _G.Aimbot = v end,
})

CombatTab:CreateToggle({
   Name = "ESP (Verde)",
   CurrentValue = false,
   Callback = function(v) _G.Esp = v end,
})

local function GetClosest()
    local t, dist = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local pos, screen = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if screen then
                local m = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if m < dist then t = p.Character.Head; dist = m end
            end
        end
    end
    return t
end

RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosest()
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
    end
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
                end
                local d = (LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                bill.TextLabel.Text = math.floor(d) .. "m"
            elseif bill then bill:Destroy() end
        end
    end
end)

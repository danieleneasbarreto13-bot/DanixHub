local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DEFINITIVE AIM",
   LoadingTitle = "A Corrigir Motores de Mira...",
   LoadingSubtitle = "Filtro de Colisão Ignorado",
   ConfigurationSaving = { Enabled = false },
   Image = 104071203297793 -- Sua foto personalizada
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

local MainTab = Window:CreateTab("Combate & Visual", 104071203297793)

--- FUNÇÃO DE VISIBILIDADE ---
local function IsVisible(part)
    if not part or not LocalPlayer.Character then return false end
    local char = LocalPlayer.Character
    local origin = Camera.CFrame.Position
    local destination = part.Position
    local direction = (destination - origin).Unit * (destination - origin).Magnitude
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {char, Camera}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                if distance < shortestDistance and IsVisible(player.Character.HumanoidRootPart) then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

MainTab:CreateToggle({
   Name = "Ativar ESP (Wallhack)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Esp = Value
   end
})

MainTab:CreateToggle({
   Name = "Ativar Aimbot",
   CurrentValue = false,
   Callback = function(Value)
      _G.Aimbot = Value
   end
})

MainTab:CreateToggle({
   Name = "Mostrar Distância",
   CurrentValue = false,
   Callback = function(Value)
      _G.Distance = Value
   end
})

RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

Rayfield:LoadConfiguration()

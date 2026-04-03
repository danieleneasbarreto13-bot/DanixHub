local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DANIX HUB",
   LoadingTitle = "Carregando Foto do Gato...",
   LoadingSubtitle = "Configurando Aimbot...",
   ConfigurationSaving = { Enabled = false },
   Image = 104071203297793 -- ID da sua foto do gato
})

-- Variáveis de Controle
local _G = {
    Esp = false,
    Aimbot = false,
    Distance = false
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Criando a Aba com a sua Foto (Onde você clica para abrir as funções)
local MainTab = Window:CreateTab("Principal", 104071203297793) 

MainTab:CreateSection("Funções de Elite")

MainTab:CreateToggle({
   Name = "Ativar ESP (Ver através da parede)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Esp = Value
      if not Value then
          -- Limpa o ESP se desligar (opcional)
      end
   end
})

MainTab:CreateToggle({
   Name = "Ativar Aimbot (Mira Automática)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Aimbot = Value
   end
})

-- Função para achar o player mais próximo
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

-- Rodar o Aimbot o tempo todo
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

Rayfield:Notify({
   Title = "Danix Hub Ativado!",
   Content = "Clique no ícone do gato para configurar",
   Duration = 5,
   Image = 104071203297793,
})

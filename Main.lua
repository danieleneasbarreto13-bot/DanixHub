local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | VISUAL EDITION",
   LoadingTitle = "Carregando Módulos Visuais...",
   LoadingSubtitle = "Créditos: DANIEL",
   ConfigurationSaving = { Enabled = false }
})

-- Variáveis de Controle
local _G = {
    Esp = false,
    EspColor = Color3.fromRGB(0, 255, 0) -- Cor padrão: Verde
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- // ABA ÚNICA (INTERFACE)
local MainTab = Window:CreateTab("Visual", 4483362458)

MainTab:CreateSection("Configurações de Visão")

MainTab:CreateToggle({
   Name = "Ativar X-RAY ESP",
   CurrentValue = false,
   Callback = function(Value) _G.Esp = Value end,
})

MainTab:CreateColorPicker({
    Name = "Cor do ESP",
    Color = _G.EspColor,
    Callback = function(Value)
        _G.EspColor = Value
    end
})

-- // BARRA DE CRÉDITOS
MainTab:CreateSection("Créditos")

MainTab:CreateParagraph({
    Title = "👑 Autoria", 
    Content = "FEITO POR DANIEL - Script de Customização Visual"
})

-- // LÓGICA DO ESP (ATUALIZAÇÃO DE COR EM TEMPO REAL)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("EliteHL")
            
            if _G.Esp then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "EliteHL"
                    hl.Parent = p.Character
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
                -- Atualiza a cor conforme o que você escolher no menu
                hl.FillColor = _G.EspColor
                hl.OutlineColor = Color3.new(1, 1, 1) -- Contorno branco para destacar
            else
                if hl then 
                    hl:Destroy() 
                end
            end
        end
    end
end)

Rayfield:Notify({
   Title = "DANIEL VISUALS",
   Content = "Sistema de cores carregado com sucesso!",
   Duration = 5,
   Image = 4483362458,
})

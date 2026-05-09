local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // VARIÁVEIS DE CONTROLE e CONFIGURAÇÕES
local _G = {
    Aimbot = false,
    AimbotTarget = "Head", -- Head ou HumanoidRootPart
    Smoothness = 1, -- Quanto maior, mais suave e "legit" fica a mira
    UseFOV = true,
    FOVRadius = 150,
    FOVColor = Color3.fromRGB(255, 0, 0),
    
    Esp = false,
    EspColor = Color3.fromRGB(255, 0, 0),
    Aliados = {},
    
    JumpEnabled = false,
    JumpPower = 50,
    Discord = "https://discord.gg/VWbCUddZ5"
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- // DESENHO DO CÍRCULO DE FOV (Field of View)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.FOVRadius
FOVCircle.Color = _G.FOVColor
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.Visible = _G.UseFOV

-- Atualiza a posição do círculo de FOV na tela continuamente
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Radius = _G.FOVRadius
    FOVCircle.Color = _G.FOVColor
    FOVCircle.Visible = (_G.UseFOV and _G.Aimbot)
end)

-- // CRIANDO A JANELA PRINCIPAL
local Window = Rayfield:CreateWindow({
   Name = "🕸️ VÓRTEX SCRIPT V2 🕸️",
   LoadingTitle = "Carregando Módulo de Combate...",
   LoadingSubtitle = "Créditos: 👑 DANIEL & WELDERSON 👑",
   ConfigurationSaving = { Enabled = false }
})

-- // INTERFACE DO BOTÃO DE PULO (MÓVEL)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local JumpBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Arrow = Instance.new("TextLabel")

JumpBtn.Name = "VortexJumpBtn"
JumpBtn.Parent = ScreenGui
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
JumpBtn.Position = UDim2.new(0.8, 0, 0.5, 0)
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
Arrow.TextColor3 = Color3.fromRGB(255, 0, 0)
Arrow.TextSize = 45
Arrow.Font = Enum.Font.SourceSansBold

JumpBtn.MouseButton1Click:Connect(function()
    if _G.JumpEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChildOfClass("Humanoid") then
            local humanoid = Char:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = _G.JumpPower
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- // VERIFICAÇÃO DE VISIBILIDADE (WALL CHECK)
local function IsVisible(targetPart)
    local character = LocalPlayer.Character
    if not character then return false end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {character, Camera}
    raycastParams.IgnoreWater = true

    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin

    local raycastResult = workspace:Raycast(origin, direction, raycastParams)

    if raycastResult then
        local hitInstance = raycastResult.Instance
        if hitInstance:IsDescendantOf(targetPart.Parent) then
            return true
        end
        return false
    end
    return true
end

-- // SELEÇÃO DO ALVO MAIS PRÓXIMO DA MIRA (DENTRO DO FOV)
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(_G.AimbotTarget) and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            if not table.find(_G.Aliados, player.Name) then
                if IsVisible(player.Character[_G.AimbotTarget]) then
                    local pos, onScreen = Camera:WorldToViewportPoint(player.Character[_G.AimbotTarget].Position)
                    if onScreen then
                        local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                        
                        -- Se o FOV estiver ativado, só foca se estiver dentro do círculo
                        if not _G.UseFOV or distance <= _G.FOVRadius then
                            if distance < shortestDistance then
                                closestPlayer = player
                                shortestDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- // LOOP DE EXECUÇÃO DO AIMBOT (COM SUAVIDADE)
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(_G.AimbotTarget) then
            local targetPos = target.Character[_G.AimbotTarget].Position
            -- Interpolação (Lerp) para suavizar a câmera
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), 1 / _G.Smoothness)
        end
    end
end)

-- // SISTEMA DE ESP (HIGHLIGHTS)
local function CreateESP(player)
    local function ApplyESP()
        if player == LocalPlayer then return end
        
        local char = player.Character or player.CharacterAdded:Wait()
        if not char then return end

        if char:FindFirstChild("VortexESP") then
            char.VortexESP:Destroy()
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = "VortexESP"
        highlight.Parent = char
        highlight.Adornee = char
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0.1
        
        if table.find(_G.Aliados, player.Name) then
            highlight.FillColor = Color3.fromRGB(0, 0, 255)
            highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
        else
            highlight.FillColor = _G.EspColor
            highlight.OutlineColor = _G.EspColor
        end

        highlight.Enabled = _G.Esp
    end

    ApplyESP()
    player.CharacterAdded:Connect(ApplyESP)
end

-- Inicializa ESP para players existentes e futuros
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end
Players.PlayerAdded:Connect(CreateESP)

local function UpdateESPState()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("VortexESP") then
            player.Character.VortexESP.Enabled = _G.Esp
            if table.find(_G.Aliados, player.Name) then
                player.Character.VortexESP.FillColor = Color3.fromRGB(0, 0, 255)
                player.Character.VortexESP.OutlineColor = Color3.fromRGB(0, 0, 255)
            else
                player.Character.VortexESP.FillColor = _G.EspColor
                player.Character.VortexESP.OutlineColor = _G.EspColor
            end
        end
    end
end

-- // CONSTRUÇÃO DA ABA DA INTERFACE
local TabPrincipal = Window:CreateTab("Principal", 4483362458)

-- [ SEÇÃO: COMBATE ]
TabPrincipal:CreateSection("Aimbot & Ajustes")

TabPrincipal:CreateToggle({
    Name = "Ativar Aimbot",
    CurrentValue = false,
    Flag = "ToggleAimbot",
    Callback = function(Value)
        _G.Aimbot = Value
    end,
})

TabPrincipal:CreateDropdown({
    Name = "Parte do Corpo Alvo",
    Options = {"Head", "HumanoidRootPart"},
    CurrentOption = {"Head"},
    MultipleOptions = false,
    Flag = "DropdownTarget",
    Callback = function(Option)
        _G.AimbotTarget = Option[1]
    end,
})

TabPrincipal:CreateSlider({
    Name = "Suavidade do Aimbot (1 = Instantâneo)",
    Range = {1, 15},
    Increment = 1,
    CurrentValue = 1,
    Flag = "SliderSmooth",
    Callback = function(Value)
        _G.Smoothness = Value
    end,
})

-- [ SEÇÃO: CONFIGURAÇÕES DE FOV ]
TabPrincipal:CreateSection("Configurações do FOV (Círculo de Mira)")

TabPrincipal:CreateToggle({
    Name = "Mostrar Círculo de FOV",
    CurrentValue = true,
    Flag = "ToggleFOV",
    Callback = function(Value)
        _G.UseFOV = Value
    end,
})

TabPrincipal:CreateSlider({
    Name = "Tamanho do FOV",
    Range = {50, 600},
    Increment = 10,
    CurrentValue = 150,
    Flag = "SliderFOVSize",
    Callback = function(Value)
        _G.FOVRadius = Value
    end,
})

TabPrincipal:CreateColorPicker({
    Name = "Cor do Círculo de FOV",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ColorFOV",
    Callback = function(Value)
        _G.FOVColor = Value
    end,
})

-- [ SEÇÃO: ESP (WALLHACK) ]
TabPrincipal:CreateSection("Visual (ESP)")

TabPrincipal:CreateToggle({
    Name = "Ativar ESP (Wallhack)",
    CurrentValue = false,
    Flag = "ToggleESP",
    Callback = function(Value)
        _G.Esp = Value
        UpdateESPState()
    end,
})

TabPrincipal:CreateColorPicker({
    Name = "Cor do ESP Inimigo",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ColorESP",
    Callback = function(Value)
        _G.EspColor = Value
        UpdateESPState()
    end,
})

-- [ SEÇÃO: MOVIMENTAÇÃO ]
TabPrincipal:CreateSection("Movimentação")

TabPrincipal:CreateToggle({
    Name = "Botão de Pulo (Mobile)",
    CurrentValue = false,
    Flag = "ToggleJumpButton",
    Callback = function(Value)
        _G.JumpEnabled = Value
        JumpBtn.Visible = Value
    end,
})

TabPrincipal:CreateSlider({
    Name = "Força do Pulo",
    Range = {50, 200},
    Increment = 5,
    CurrentValue = 50,
    Flag = "SliderJump",
    Callback = function(Value)
        _G.JumpPower = Value
    end,
})

-- [ SEÇÃO: SISTEMA DE ALIADOS ]
TabPrincipal:CreateSection("Sistema de Aliados")

TabPrincipal:CreateInput({
    Name = "Adicionar Aliado",
    PlaceholderText = "Digite o nome exato do player...",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        if Text ~= "" and not table.find(_G.Aliados, Text) then
            table.insert(_G.Aliados, Text)
            Rayfield:Notify({
                Title = "Aliado Adicionado",
                Content = Text .. " agora é seu aliado!",
                Duration = 3,
                Image = 4483362458,
            })
            UpdateESPState()
        end
    end,
})

TabPrincipal:CreateButton({
    Name = "Limpar Todos os Aliados",
    Callback = function()
        _G.Aliados = {}
        Rayfield:Notify({
            Title = "Aliados Resetados",
            Content = "Lista de aliados limpa com sucesso.",
            Duration = 3,
            Image = 4483362458,
        })
        UpdateESPState()
    end,
})

-- [ SEÇÃO: COMUNIDADE ]
TabPrincipal:CreateSection("Comunidade")

TabPrincipal:CreateButton({
    Name = "Copiar Link do Discord",
    Callback = function()
        setclipboard(_G.Discord)
        Rayfield:Notify({
            Title = "Discord Copiado!",
            Content = "O link do convite foi copiado para sua área de transferência.",
            Duration = 5,
            Image = 4483362458,
        })
    end,
})

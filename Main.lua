local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Variáveis de Controle
local _G = {
    Aimbot = false,
    Esp = false,
    EspColor = Color3.fromRGB(0, 255, 0),
    JumpEnabled = false,
    JumpPower = 50,
    Discord = "https://discord.gg/VWbCUddZ5",
    Aliados = {} -- Tabela de aliados para não focar no Aimbot/ESP
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Criando a Janela do Rayfield
local Window = Rayfield:CreateWindow({
   Name = "🕸️ VÓRTEX SCRIPT 🕸️",
   LoadingTitle = "Carregando Sistema Completo...",
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
JumpBtn.Position = UDim2.new(0.8, 0, 0.5, 0) -- Ajustado para o canto direito (melhor para celular)
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

-- Função do clique do Botão de Pulo
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

-- // FUNÇÃO DE VERIFICAÇÃO DE PAREDE (WALL CHECK)
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

-- // LÓGICA DO AIMBOT (Procura o jogador visível mais próximo da mira)
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            -- 1. Verifica se não é aliado
            if not table.find(_G.Aliados, player.Name) then
                -- 2. Verifica se o inimigo está visível
                if IsVisible(player.Character.Head) then
                    local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                    -- 3. Verifica se está na tela
                    if onScreen then
                        local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                        if distance < shortestDistance then
                            closestPlayer = player
                            shortestDistance = distance
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- Render do Aimbot
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end
end)

-- // LÓGICA DO ESP (Highlight de Silhueta)
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
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        
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

-- Ativa o ESP para quem já está no servidor e para quem entrar
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end
Players.PlayerAdded:Connect(CreateESP)

-- Atualiza o estado visual do ESP dinamicamente
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

-- // ABA ÚNICA (TODAS AS OPÇÕES JUNTAS)
local TabPrincipal = Window:CreateTab("Principal", 4483362458)

-- [ SEÇÃO: COMBATE ]
TabPrincipal:CreateSection("Combate & Trapaças")

TabPrincipal:CreateToggle({
    Name = "Aimbot (Segurar Mira + WallCheck)",
    CurrentValue = false,
    Flag = "ToggleAimbot",
    Callback = function(Value)
        _G.Aimbot = Value
    end,
})

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
    Color = Color3.fromRGB(0, 255, 0),
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

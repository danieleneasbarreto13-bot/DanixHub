local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- // VARIÁVEIS DE CONTROLE e CONFIGURAÇÕES
local _G = {
    Aimbot = false,
    AimbotTarget = "Head", -- Head ou HumanoidRootPart
    Smoothness = 1, -- Quanto maior, mais suave fica a mira
    UseFOV = true,
    FOVRadius = 150,
    FOVColor = Color3.fromRGB(255, 0, 0),
    WallCheck = true, -- Ativado por padrão (mira não puxa através da parede)
    
    Esp = false,
    Tracers = false, -- [ADICIONADO]
    EspColor = Color3.fromRGB(255, 0, 0),
    Aliados = {},
    
    -- Configurações de Movimento
    JumpEnabled = false,
    JumpPower = 50,
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16, -- Velocidade padrão do Roblox

    Discord = "https://discord.gg/VWbCUddZ5",

    -- Variável de personalização profissional da UI
    InterfaceColor = Color3.fromRGB(255, 0, 0) -- Começa com o Vermelho padrão
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

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

-- // FUNÇÃO DE TRACERS (LINHAS) [ADICIONADO]
local function CreateTracer(player)
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = _G.EspColor
    line.Thickness = 1
    line.Transparency = 1

    local function UpdateTracer()
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if _G.Tracers and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player ~= LocalPlayer then
                local hrp = player.Character.HumanoidRootPart
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                if onScreen and not table.find(_G.Aliados, player.Name) then
                    line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) 
                    line.To = Vector2.new(vector.X, vector.Y)
                    line.Color = _G.EspColor
                    line.Visible = true
                else
                    line.Visible = false
                end
            else
                line.Visible = false
                if not player.Parent then
                    line:Remove()
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(UpdateTracer)()
end

-- // CRIANDO A JANELA PRINCIPAL (FLUENT UI)
local Window = Fluent:CreateWindow({
    Title = "VÓRTEX SCRIPT V2",
    SubTitle = "by Daniel",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl 
})

task.wait(0.5)

-- // FUNÇÃO AUXILIAR PARA TORNAR ELEMENTOS ARRASTÁVEIS NO MOBILE
local function MakeDraggable(guiObject)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- // BOTÃO FLUTUANTE PARA ABRIR/FECHAR MENU (MOBILE)
local MobileGui = Instance.new("ScreenGui")
MobileGui.Name = "VortexMobileUI"
MobileGui.Parent = CoreGui
MobileGui.ResetOnSpawn = false

local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Parent = MobileGui
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleMenuBtn.Position = UDim2.new(0.1, 0, 0.15, 0)
ToggleMenuBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleMenuBtn.Text = "🕸️"
ToggleMenuBtn.TextColor3 = _G.InterfaceColor
ToggleMenuBtn.TextSize = 30
ToggleMenuBtn.Font = Enum.Font.SourceSansBold
ToggleMenuBtn.BorderSizePixel = 0
ToggleMenuBtn.ZIndex = 10

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = ToggleMenuBtn

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = _G.InterfaceColor
BtnStroke.Thickness = 2.5
BtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BtnStroke.Parent = ToggleMenuBtn

MakeDraggable(ToggleMenuBtn)

local menuOpen = true
ToggleMenuBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    Window:Minimize(not menuOpen)
    ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    task.wait(0.1)
    ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
end)

-- // INTERFACE DO BOTÃO DE PULO (MÓVEL)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.ResetOnSpawn = false

local JumpBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Arrow = Instance.new("TextLabel")

JumpBtn.Name = "VortexJumpBtn"
JumpBtn.Parent = ScreenGui
JumpBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
JumpBtn.Position = UDim2.new(0.8, 0, 0.5, 0)
JumpBtn.Size = UDim2.new(0, 65, 0, 65)
JumpBtn.Text = ""
JumpBtn.Visible = false
JumpBtn.Active = true

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = JumpBtn

local JumpStroke = Instance.new("UIStroke")
JumpStroke.Color = _G.InterfaceColor
JumpStroke.Thickness = 2.5
JumpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
JumpStroke.Parent = JumpBtn

Arrow.Parent = JumpBtn
Arrow.Size = UDim2.new(1, 0, 1, 0)
Arrow.BackgroundTransparency = 1
Arrow.Text = "↑"
Arrow.TextColor3 = _G.InterfaceColor
Arrow.TextSize = 45
Arrow.Font = Enum.Font.SourceSansBold

MakeDraggable(JumpBtn)

JumpBtn.MouseButton1Click:Connect(function()
    if _G.JumpEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChildOfClass("Humanoid") then
            local humanoid = Char:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = _G.JumpPower
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            JumpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            task.wait(0.1)
            JumpBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        end
    end
end)

-- // FUNÇÃO PARA MUDAR CORES DA INTERFACE
local function UpdateUITheme(newColor)
    _G.InterfaceColor = newColor
    if ToggleMenuBtn and BtnStroke then
        ToggleMenuBtn.TextColor3 = newColor
        BtnStroke.Color = newColor
    end
    if JumpBtn and JumpStroke and Arrow then
        JumpStroke.Color = newColor
        Arrow.TextColor3 = newColor
    end
end

-- // LOOP WALKSPEED
RunService.Heartbeat:Connect(function()
    if _G.WalkSpeedEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChildOfClass("Humanoid") then
            Char:FindFirstChildOfClass("Humanoid").WalkSpeed = _G.WalkSpeedValue
        end
    end
end)

-- // VISIBILIDADE E AIMBOT
local function IsVisible(targetPart, targetCharacter)
    if not _G.WallCheck then return true end
    local character = LocalPlayer.Character
    if not character then return false end
    local ignoreList = {character, Camera}
    if targetCharacter then table.insert(ignoreList, targetCharacter) end
    local parts = Camera:GetPartsObscuringTarget({targetPart.Position}, ignoreList)
    return #parts == 0
end

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(_G.AimbotTarget) and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            if not table.find(_G.Aliados, player.Name) then
                local targetPart = player.Character[_G.AimbotTarget]
                if IsVisible(targetPart, player.Character) then
                    local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
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

RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(_G.AimbotTarget) then
            local targetPos = target.Character[_G.AimbotTarget].Position
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
        if char:FindFirstChild("VortexESP") then char.VortexESP:Destroy() end
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

for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
    CreateTracer(player) -- Inicializa Tracers
end
Players.PlayerAdded:Connect(function(p)
    CreateESP(p)
    CreateTracer(p) -- Inicializa Tracers
end)

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

-- // CRIAÇÃO DAS ABAS
local Tabs = {
    Combate = Window:AddTab({ Title = "Combate", Icon = "crosshair" }),
    Visual = Window:AddTab({ Title = "Visual & ESP", Icon = "eye" }),
    Movimento = Window:AddTab({ Title = "Movimento", Icon = "zap" }),
    Outros = Window:AddTab({ Title = "Config & Social", Icon = "settings" })
}

task.wait(0.2)

-- [ ABA: COMBATE ]
Tabs.Combate:AddSection("Configurações do Aimbot")
Tabs.Combate:AddToggle("AimbotToggle", {Title = "Ativar Aimbot", Default = false}):OnChanged(function(v) _G.Aimbot = v end)
Tabs.Combate:AddToggle("WallCheckToggle", {Title = "Verificar Paredes (Wall Check)", Default = true}):OnChanged(function(v) _G.WallCheck = v end)
Tabs.Combate:AddDropdown("TargetDropdown", {Title = "Parte do Corpo Alvo", Values = {"Head", "HumanoidRootPart"}, CurrentValue = "Head", Callback = function(v) _G.AimbotTarget = v end})
Tabs.Combate:AddSlider("SmoothSlider", {Title = "Suavidade do Aimbot", Description = "Ajusta o atraso da mira", Min = 1, Max = 15, Default = 1, Rounding = 0, Callback = function(v) _G.Smoothness = v end})
Tabs.Combate:AddSection("Círculo de FOV")
Tabs.Combate:AddToggle("FOVToggle", {Title = "Ativar Círculo de FOV", Default = true}):OnChanged(function(v) _G.UseFOV = v end)
Tabs.Combate:AddSlider("FOVSlider", {Title = "Tamanho do FOV", Min = 50, Max = 600, Default = 150, Rounding = 0, Callback = function(v) _G.FOVRadius = v end})
Tabs.Combate:AddColorpicker("FOVColorPicker", {Title = "Cor do FOV", Default = Color3.fromRGB(255, 0, 0), Callback = function(v) _G.FOVColor = v end})

-- [ ABA: VISUAL ]
Tabs.Visual:AddSection("ESP / Wallhack")
Tabs.Visual:AddToggle("ESPToggle", {Title = "Ativar ESP Highlight", Default = false}):OnChanged(function(v) _G.Esp = v UpdateESPState() end)
-- NOVO BOTÃO TRACERS
Tabs.Visual:AddToggle("TracerToggle", {Title = "Ativar ESP Tracers (Linhas)", Default = false}):OnChanged(function(v) _G.Tracers = v end)

Tabs.Visual:AddColorpicker("ESPColorPicker", {Title = "Cor do ESP Inimigo", Default = Color3.fromRGB(255, 0, 0), Callback = function(v) _G.EspColor = v UpdateESPState() end})

-- [ ABA: MOVIMENTO ]
Tabs.Movimento:AddSection("Controles de Movimento")
Tabs.Movimento:AddToggle("SpeedToggle", {Title = "Ativar Velocidade (WalkSpeed)", Default = false}):OnChanged(function(v) 
    _G.WalkSpeedEnabled = v 
    if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end)
Tabs.Movimento:AddSlider("SpeedSlider", {Title = "Velocidade do Jogador", Min = 16, Max = 250, Default = 16, Rounding = 0, Callback = function(v) _G.WalkSpeedValue = v end})
Tabs.Movimento:AddToggle("JumpToggle", {Title = "Botão de Pulo (Mobile)", Default = false}):OnChanged(function(v) _G.JumpEnabled = v JumpBtn.Visible = v end)
Tabs.Movimento:AddSlider("JumpSlider", {Title = "Força do Pulo", Min = 50, Max = 200, Default = 50, Rounding = 0, Callback = function(v) _G.JumpPower = v end})

-- [ ABA: OUTROS ]
Tabs.Outros:AddSection("Sistema de Aliados")
Tabs.Outros:AddInput("InputAliado", {Title = "Adicionar Aliado", Placeholder = "Nome exato...", Callback = function(Text)
    if Text ~= "" and not table.find(_G.Aliados, Text) then
        table.insert(_G.Aliados, Text)
        UpdateESPState()
    end
end})
Tabs.Outros:AddButton({Title = "Limpar Todos os Aliados", Callback = function() _G.Aliados = {} UpdateESPState() end})
Tabs.Outros:AddSection("Personalização do Menu")
Tabs.Outros:AddDropdown("ThemeDropdown", {Title = "Tema Visual", Values = {"Dark", "Light", "Amethyst", "Aqua"}, CurrentValue = "Dark", Callback = function(v) Window:SetTheme(v) end})
Tabs.Outros:AddColorpicker("UIColorsPicker", {Title = "Cor dos Botões Externos", Default = Color3.fromRGB(255, 0, 0), Callback = function(v) UpdateUITheme(v) end})
Tabs.Outros:AddButton({Title = "Copiar Link do Discord", Callback = function() setclipboard(_G.Discord) end})

Window:SelectTab(1)
Fluent:Notify({Title = "Vortex Script V2", Content = "Menu carregado com sucesso!", Duration = 5})

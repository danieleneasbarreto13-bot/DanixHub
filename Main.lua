-- // DANIEL HUB - VERSÃO BOTÃO FLUTUANTE //
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
local OpenBtn = Instance.new("TextButton", ScreenGui)
local UICornerBtn = Instance.new("UICorner", OpenBtn)
local UIBorderBtn = Instance.new("UIStroke", OpenBtn)

-- // CONFIGURAÇÃO DO BOTÃO QUE ABRE O MENU //
OpenBtn.Name = "DanielOpenButton"
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Preto
OpenBtn.Text = "✠" -- Ícone no botão
OpenBtn.TextColor3 = Color3.fromRGB(160, 32, 240) -- Roxo
OpenBtn.TextSize = 30
OpenBtn.Active = true
OpenBtn.Draggable = true -- VOCÊ PODE MOVER PARA ONDE QUISER

UICornerBtn.CornerRadius = UDim.new(0, 50) -- Deixa redondo
UIBorderBtn.Color = Color3.fromRGB(160, 32, 240) -- Borda Roxa
UIBorderBtn.Thickness = 2

-- // CONFIGURAÇÃO DA JANELA PRINCIPAL //
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 220, 0, 260)
Frame.Position = UDim2.new(0.5, -110, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(160, 32, 240)
Frame.Visible = false -- Começa invisível
Frame.Active = true
Frame.Draggable = true

-- Título
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "Feito por DANIEL"
Title.TextColor3 = Color3.fromRGB(160, 32, 240)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Abrir/Fechar ao clicar no botão
OpenBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- // BOTÕES DE FUNÇÕES //
local function CreateBtn(text, pos)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    return btn
end

local ToggleAimbot = CreateBtn("Aimbot: OFF", 60)
local ToggleEsp = CreateBtn("ESP + LINHAS: OFF", 115)
local ToggleNoClip = CreateBtn("NoClip: OFF", 170)

-- // VARIÁVEIS E LÓGICA //
local _G = {Aimbot = false, Esp = false, NoClip = false}
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

ToggleAimbot.MouseButton1Click:Connect(function()
    _G.Aimbot = not _G.Aimbot
    ToggleAimbot.Text = _G.Aimbot and "Aimbot: ON" or "Aimbot: OFF"
    ToggleAimbot.BackgroundColor3 = _G.Aimbot and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(30, 30, 30)
end)

ToggleEsp.MouseButton1Click:Connect(function()
    _G.Esp = not _G.Esp
    ToggleEsp.Text = _G.Esp and "ESP: ON" or "ESP: OFF"
    ToggleEsp.BackgroundColor3 = _G.Esp and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 30, 30)
end)

ToggleNoClip.MouseButton1Click:Connect(function()
    _G.NoClip = not _G.NoClip
    ToggleNoClip.Text = _G.NoClip and "NoClip: ON" or "NoClip: OFF"
    ToggleNoClip.BackgroundColor3 = _G.NoClip and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(30, 30, 30)
end)

-- // LOOP DE FUNÇÕES //
game:GetService("RunService").RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local char = p.Character
            
            -- Tracers
            local tracer = char:FindFirstChild("DLine")
            if _G.Esp then
                if not tracer then
                    tracer = Instance.new("LineHandleAdornment", char)
                    tracer.Name = "DLine"
                    tracer.Thickness = 2
                    tracer.Color3 = Color3.fromRGB(255, 0, 0)
                    tracer.AlwaysOnTop = true
                end
                tracer.Adornee = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                tracer.Target = char.HumanoidRootPart
            elseif tracer then tracer:Destroy() end

            -- Highlight
            local hl = char:FindFirstChild("DHL")
            if _G.Esp then
                if not hl then
                    hl = Instance.new("Highlight", char)
                    hl.Name = "DHL"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                end
            elseif hl then hl:Destroy() end
        end
    end

    if _G.Aimbot then
        local target = nil
        local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onScreen then
                    local ray = Ray.new(Camera.CFrame.Position, (p.Character.Head.Position - Camera.CFrame.Position).Unit * 500)
                    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, p.Character})
                    if not hit then
                        local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if mag < dist then target = p.Character.Head; dist = mag end
                    end
                end
            end
        end
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
    end

    if _G.NoClip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

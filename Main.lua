-- // DANIEL HUB PRO - REPRODUÇÃO EXATA DA IMAGEM //
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Limpeza de UI anterior
if PlayerGui:FindFirstChild("DanielHubPrecision") then
    PlayerGui.DanielHubPrecision:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "DanielHubPrecision"
ScreenGui.ResetOnSpawn = false

-- // 1. LOGO FLUTUANTE ARRASTÁVEL (D + 👑) //
local Logo = Instance.new("Frame", ScreenGui)
Logo.Size = UDim2.new(0, 75, 0, 85)
Logo.Position = UDim2.new(0.05, 0, 0.4, 0)
Logo.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Logo.Active = true
Logo.Draggable = true --

local LogoCorner = Instance.new("UICorner", Logo)
LogoCorner.CornerRadius = UDim.new(0, 15)

local LogoStroke = Instance.new("UIStroke", Logo)
LogoStroke.Color = Color3.fromRGB(160, 32, 240)
LogoStroke.Thickness = 3

local Crown = Instance.new("TextLabel", Logo)
Crown.Size = UDim2.new(1, 0, 0, 40)
Crown.Position = UDim2.new(0, 0, 0, -28)
Crown.Text = "👑"
Crown.BackgroundTransparency = 1
Crown.TextSize = 38

local DLabel = Instance.new("TextLabel", Logo)
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Dourado
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 55
DLabel.BackgroundTransparency = 1

local ToggleBtn = Instance.new("TextButton", Logo)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

-- // 2. TAB PRINCIPAL (IDÊNTICA À IMAGEM) //
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 240)
Main.Position = UDim2.new(0.5, -175, 0.5, -120)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Fundo Escuro
Main.Visible = false
Main.Active = true
Main.Draggable = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 15)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(160, 32, 240) -- Borda Roxa
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "DANIEL HUB PRO"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.BackgroundTransparency = 1

ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- // 3. BOTÕES ESTILO PÍLULA //
local _G = {Aim = false, Esp = false, Noc = false}

local function AddToggle(txt, y, callback)
    local Btn = Instance.new("TextButton", Main)
    Btn.Size = UDim2.new(0.85, 0, 0, 48)
    Btn.Position = UDim2.new(0.075, 0, 0, y)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Cinza da imagem
    Btn.Text = txt .. ": OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    
    local Corner = Instance.new("UICorner", Btn)
    Corner.CornerRadius = UDim.new(0, 24) -- Formato pílula

    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
        Btn.Text = txt .. (active and ": ON" or ": OFF")
        Btn.BackgroundColor3 = active and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(45, 45, 45)
    end)
end

AddToggle("AIMBOT (HEAD LOCK)", 65, function(v) _G.Aim = v end)
AddToggle("ESP VISUAL (RED)", 120, function(v) _G.Esp = v end)
AddToggle("NOCLIP (WALLS)", 175, function(v) _G.Noc = v end)

-- // 4. LÓGICA DO AIMBOT COM WALL CHECK //
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.Aim then
        local target = nil
        local maxDist = 600
        
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local _, visible = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                
                if visible then
                    -- Wall Check (Não atravessa paredes)
                    local ray = Ray.new(workspace.CurrentCamera.CFrame.Position, (head.Position - workspace.CurrentCamera.CFrame.Position).Unit * 500)
                    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {Player.Character, p.Character})
                    
                    if not hit then
                        local dist = (Player.Character.HumanoidRootPart.Position - head.Position).Magnitude
                        if dist < maxDist then
                            target = head
                            maxDist = dist
                        end
                    end
                end
            end
        end
        if target then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position)
        end
    end

    if _G.Noc and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    if _G.Esp then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character then
                local hl = p.Character:FindFirstChild("DHL") or Instance.new("Highlight", p.Character)
                hl.Name = "DHL"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    end
end)

-- // DANIEL HUB PRO - REPRODUÇÃO FIEL //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Limpeza de UI antiga
local oldGui = LocalPlayer.PlayerGui:FindFirstChild("DanielHubPrecision")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "DanielHubPrecision"
ScreenGui.ResetOnSpawn = false

-- // 1. LOGO FLUTUANTE (O "D" COM COROA) //
local LogoFrame = Instance.new("Frame", ScreenGui)
LogoFrame.Size = UDim2.new(0, 80, 0, 90)
LogoFrame.Position = UDim2.new(0.05, 0, 0.35, 0)
LogoFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LogoFrame.Active = true
LogoFrame.Draggable = true --

local LogoCorner = Instance.new("UICorner", LogoFrame)
LogoCorner.CornerRadius = UDim.new(0, 15)

local LogoStroke = Instance.new("UIStroke", LogoFrame)
LogoStroke.Color = Color3.fromRGB(160, 32, 240)
LogoStroke.Thickness = 3

local Crown = Instance.new("TextLabel", LogoFrame)
Crown.Size = UDim2.new(1, 0, 0, 40)
Crown.Position = UDim2.new(0, 0, 0, -25)
Crown.Text = "👑"
Crown.BackgroundTransparency = 1
Crown.TextSize = 35

local DLabel = Instance.new("TextLabel", LogoFrame)
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Dourado
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 60
DLabel.BackgroundTransparency = 1

local OpenBtn = Instance.new("TextButton", LogoFrame)
OpenBtn.Size = UDim2.new(1, 0, 1, 0)
OpenBtn.BackgroundTransparency = 1
OpenBtn.Text = ""

-- // 2. ABA PRINCIPAL (IDÊNTICA À IMAGEM) //
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 250)
Main.Position = UDim2.new(0.5, -180, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Preto Sólido
Main.Visible = false
Main.Active = true
Main.Draggable = true --

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 15)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(160, 32, 240)
MainStroke.Thickness = 3

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "DANIEL HUB PRO"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.BackgroundTransparency = 1

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- // 3. BOTÕES ESTILO PÍLULA ROXA //
local _G = {Aim = false, Esp = false, Noc = false}

local function CreateToggle(txt, y, callback)
    local Btn = Instance.new("TextButton", Main)
    Btn.Size = UDim2.new(0.85, 0, 0, 50)
    Btn.Position = UDim2.new(0.075, 0, 0, y)
    Btn.BackgroundColor3 = Color3.fromRGB(160, 32, 240) -- Roxo da Imagem
    Btn.Text = txt .. ": ON"
    Btn.TextColor3 = Color3.fromRGB(0, 0, 0) -- Texto Preto
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    
    local Corner = Instance.new("UICorner", Btn)
    Corner.CornerRadius = UDim.new(0, 25) -- Formato Pílula

    Btn.MouseButton1Click:Connect(function()
        _G[callback] = not _G[callback]
        Btn.Text = txt .. (_G[callback] and ": ON" or ": OFF")
        Btn.BackgroundColor3 = _G[callback] and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(60, 60, 60)
    end)
end

CreateToggle("AIMBOT (HEAD LOCK)", 65, "Aim")
CreateToggle("ESP VISUAL (RED)", 125, "Esp")
CreateToggle("NOCLIP (WALLS)", 185, "Noc")

-- // 4. LÓGICA DO AIMBOT (SEM PAREDE) & ESP //
RunService.RenderStepped:Connect(function()
    if _G.Aim then
        local target = nil
        local shortestDist = math.huge
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen then
                    -- Checagem de Parede (Raycast)
                    local ray = Ray.new(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * 500)
                    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, p.Character})
                    
                    if not hit then
                        local mouseDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if mouseDist < shortestDist then
                            target = head
                            shortestDist = mouseDist
                        end
                    end
                end
            end
        end
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end

    if _G.Esp then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hl = p.Character:FindFirstChild("DHL") or Instance.new("Highlight", p.Character)
                hl.Name = "DHL"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineTransparency = 0
            end
        end
    end

    if _G.Noc and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

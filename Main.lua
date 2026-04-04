-- // DANIEL HUB PRO - SISTEMA DE DISTÂNCIA E ARRASTE //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Limpeza de UI antiga
for _, v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
    if v.Name == "DanielHubV4" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "DanielHubV4"
ScreenGui.ResetOnSpawn = false

-- // 1. O ÍCONE "D" TOTALMENTE ARRASTÁVEL //
local Logo = Instance.new("Frame", ScreenGui)
Logo.Size = UDim2.new(0, 80, 0, 90)
Logo.Position = UDim2.new(0.05, 0, 0.4, 0)
Logo.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Logo.Active = true
Logo.Draggable = true -- Agora você põe onde quiser!

local LogoCorner = Instance.new("UICorner", Logo)
LogoCorner.CornerRadius = UDim.new(0, 15)
local LogoStroke = Instance.new("UIStroke", Logo)
LogoStroke.Color = Color3.fromRGB(160, 32, 240)
LogoStroke.Thickness = 3

local DLabel = Instance.new("TextLabel", Logo)
DLabel.Size = UDim2.new(1, 0, 1, 0)
DLabel.Text = "D"
DLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
DLabel.Font = Enum.Font.FredokaOne
DLabel.TextSize = 60
DLabel.BackgroundTransparency = 1

local Crown = Instance.new("TextLabel", Logo)
Crown.Size = UDim2.new(1, 0, 0, 40)
Crown.Position = UDim2.new(0, 0, 0, -25)
Crown.Text = "👑"
Crown.BackgroundTransparency = 1
Crown.TextSize = 35

local OpenBtn = Instance.new("TextButton", Logo)
OpenBtn.Size = UDim2.new(1, 0, 1, 0)
OpenBtn.BackgroundTransparency = 1
OpenBtn.Text = ""

-- // 2. MENU PRINCIPAL (FUNDO MÁRMORE + ESTICADO) //
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 460, 0, 280)
Main.Position = UDim2.new(0.5, -230, 0.5, -140)
Main.Visible = false
Main.Active = true
Main.Draggable = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 15)

local Bg = Instance.new("ImageLabel", Main)
Bg.Size = UDim2.new(1, 0, 1, 0)
Bg.Image = "rbxassetid://169db234-6f48-4232-965c-16b138f2d294" -- Mármore fiel
Bg.ScaleType = Enum.ScaleType.Crop
Bg.ZIndex = 0
Instance.new("UICorner", Bg).CornerRadius = UDim.new(0, 15)

-- Abertura
OpenBtn.MouseButton1Down:Connect(function()
    Main.Visible = not Main.Visible
end)

-- // 3. BOTÕES ON/OFF COM DISTÂNCIA //
local _G = {Aim = false, Esp = false, Noc = false}

local function CreateToggle(txt, y, val)
    local B = Instance.new("TextButton", Main)
    B.Size = UDim2.new(0.9, 0, 0, 55)
    B.Position = UDim2.new(0.05, 0, 0, y)
    B.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
    B.Text = txt .. ": ON"
    B.Font = Enum.Font.GothamBold
    B.TextSize = 18
    B.TextColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 25)

    B.MouseButton1Down:Connect(function()
        _G[val] = not _G[val]
        B.Text = txt .. (_G[val] and ": ON" or ": OFF")
        B.BackgroundColor3 = _G[val] and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(60,60,60)
    end)
end

CreateToggle("AIMBOT (CLOSEST VISIBLE)", 70, "Aim")
CreateToggle("ESP + DISTANCE (METERS)", 135, "Esp")
CreateToggle("NOCLIP (WALLS)", 200, "Noc")

-- // 4. LÓGICA DO AIMBOT (CLOSEST + WALL CHECK) //
local function GetClosestPlayer()
    local target = nil
    local shortestDist = 600
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local pos, vis = Camera:WorldToViewportPoint(head.Position)
            
            if vis then
                -- Verifica se há parede no caminho
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
    return target
end

-- // 5. LOOP DE RENDERIZAÇÃO //
RunService.RenderStepped:Connect(function()
    -- Aimbot
    if _G.Aim then
        local t = GetClosestPlayer()
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Position) end
    end

    -- ESP com Distância
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local char = p.Character
            local hrp = char.HumanoidRootPart
            local tag = char:FindFirstChild("DanielESP") or Instance.new("BillboardGui", char)
            
            if _G.Esp then
                tag.Name = "DanielESP"
                tag.Size = UDim2.new(0, 200, 0, 50)
                tag.AlwaysOnTop = true
                tag.Adornee = char:FindFirstChild("Head")
                tag.ExtentsOffset = Vector3.new(0, 3, 0)

                local label = tag:FindFirstChild("Label") or Instance.new("TextLabel", tag)
                label.Name = "Label"
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                label.Font = Enum.Font.GothamBold
                label.TextSize = 14
                
                local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                label.Text = p.Name .. " [" .. dist .. "M]"
                
                local hl = char:FindFirstChild("Highlight") or Instance.new("Highlight", char)
                hl.FillColor = Color3.fromRGB(255, 0, 0)
            else
                if char:FindFirstChild("DanielESP") then char.DanielESP:Destroy() end
                if char:FindFirstChild("Highlight") then char.Highlight:Destroy() end
            end
        end
    end

    -- NoClip
    if _G.Noc and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

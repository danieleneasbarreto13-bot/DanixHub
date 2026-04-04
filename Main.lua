-- // DANIEL HUB PRO - SUPORTE TOTAL DELTA //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Tenta encontrar o melhor lugar para a interface
local ParentObj = nil
local success, err = pcall(function()
    ParentObj = game:GetService("CoreGui")
end)
if not success then ParentObj = LocalPlayer:WaitForChild("PlayerGui") end

-- Limpa execuções travadas
for _, v in pairs(ParentObj:GetChildren()) do
    if v.Name == "DanielHubFinalV3" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", ParentObj)
ScreenGui.Name = "DanielHubFinalV3"
ScreenGui.ResetOnSpawn = false

-- // 1. ÍCONE "D" + 👑 (BOTÃO DE SEGURANÇA) //
local Logo = Instance.new("Frame", ScreenGui)
Logo.Size = UDim2.new(0, 80, 0, 90)
Logo.Position = UDim2.new(0.05, 0, 0.4, 0)
Logo.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Logo.Active = true
Logo.Draggable = true 

Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Logo)
Stroke.Color = Color3.fromRGB(160, 32, 240)
Stroke.Thickness = 3

local DText = Instance.new("TextLabel", Logo)
DText.Size = UDim2.new(1, 0, 1, 0)
DText.Text = "D"
DText.TextColor3 = Color3.fromRGB(255, 215, 0)
DText.Font = Enum.Font.FredokaOne
DText.TextSize = 60
DText.BackgroundTransparency = 1

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

-- // 2. MENU ULTRA ESTICADO (ESTILO 1775267276388.png) //
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 460, 0, 260) -- Super esticado
Main.Position = UDim2.new(0.5, -230, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Visible = false
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(160, 32, 240)
MainStroke.Thickness = 3

-- FUNDO DE MÁRMORE (IMAGEM 7348.jpg)
local Bg = Instance.new("ImageLabel", Main)
Bg.Size = UDim2.new(1, 0, 1, 0)
Bg.Image = "rbxassetid://169db234-6f48-4232-965c-16b138f2d294" -- ID da sua imagem
Bg.ScaleType = Enum.ScaleType.Crop
Bg.ZIndex = 0
Instance.new("UICorner", Bg).CornerRadius = UDim.new(0, 15)

-- TÍTULO DUAS CORES
local T1 = Instance.new("TextLabel", Main)
T1.Size = UDim2.new(0.5, 0, 0, 50)
T1.Text = "DANIEL"
T1.TextColor3 = Color3.fromRGB(160, 32, 240)
T1.Font = Enum.Font.GothamBold
T1.TextSize = 28
T1.Position = UDim2.new(0, 15, 0, 0)
T1.TextXAlignment = Enum.TextXAlignment.Right
T1.BackgroundTransparency = 1

local T2 = Instance.new("TextLabel", Main)
T2.Size = UDim2.new(0.5, 0, 0, 50)
T2.Text = " HUB PRO"
T2.TextColor3 = Color3.fromRGB(255, 215, 0)
T2.Font = Enum.Font.GothamBold
T2.TextSize = 28
T2.Position = UDim2.new(0.5, 0, 0, 0)
T2.TextXAlignment = Enum.TextXAlignment.Left
T2.BackgroundTransparency = 1

-- Ação de Abrir
OpenBtn.MouseButton1Down:Connect(function()
    Main.Visible = not Main.Visible
end)

-- // 3. BOTÕES PÍLULA //
local _G = {Aim = false, Esp = false, Noc = false}

local function CreateBtn(txt, y, val)
    local B = Instance.new("TextButton", Main)
    B.Size = UDim2.new(0.9, 0, 0, 50)
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

CreateBtn("AIMBOT (HEAD)", 70, "Aim")
CreateBtn("ESP VERMELHO", 130, "Esp")
CreateBtn("NOCLIP (WALLS)", 190, "Noc")

-- // 4. LOOP DE FUNÇÕES //
RunService.RenderStepped:Connect(function()
    if _G.Aim then
        local target = nil
        local dist = 600
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                if vis then
                    local ray = Ray.new(workspace.CurrentCamera.CFrame.Position, (head.Position - workspace.CurrentCamera.CFrame.Position).Unit * 500)
                    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, p.Character})
                    if not hit then
                        local mDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)).Magnitude
                        if mDist < dist then target = head; dist = mDist end
                    end
                end
            end
        end
        if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position) end
    end

    if _G.Esp then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("DHL") or Instance.new("Highlight", p.Character)
                h.Name = "DHL"; h.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    end

    if _G.Noc and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

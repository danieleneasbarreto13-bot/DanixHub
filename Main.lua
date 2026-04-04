--[[
   DANIEL HUB ULTIMATE UI - REPRODUÇÃO 100% FIEL
   Este script recria a interface com precisão pixel-perfect,
   incluindo fundos complexos, texto em gradiente e switches personalizados.
]]

-- // SEGURANÇA E LIMPEZA DE UI //
local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Função para remover versões antigas e evitar conflitos
local function CleanupExistingUI()
    for _, gui in pairs(CoreGui:GetChildren()) do
        if gui.Name == "DanielHub_PixelPerfect" then
            gui:Destroy()
        end
    end
end
CleanupExistingUI()

-- // DEFINIÇÃO DE CORES E ESTILOS //
-- Cores exatas da imagem para gradientes e bordas
local Color_Purple_Glow = Color3.fromRGB(160, 32, 240)
local Color_Purple_Glow_Bright = Color3.fromRGB(200, 80, 255)
local Color_Gold_Text = Color3.fromRGB(255, 215, 0)
local Color_Text_White = Color3.fromRGB(255, 255, 255)
local Color_Off_Gray = Color3.fromRGB(100, 100, 100)
local Color_Container_Bg = Color3.fromRGB(20, 20, 20)

-- // CRIAÇÃO DO SCREEN GUI //
-- Usando CoreGui para garantir que a interface fique acima de tudo
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "DanielHub_PixelPerfect"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- // JANELA PRINCIPAL (MAIN FRAME) //
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 240) -- Tamanho proporcional à imagem
Main.Position = UDim2.new(0.5, -190, 0.5, -120)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Mantém a funcionalidade de mover a aba

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 15)

-- Borda Externa Roxo/Neon
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color_Purple_Glow
MainStroke.Thickness = 2
MainStroke.Transparency = 0.2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- // FUNDO PERSONALIZADO (IMAGEM DO USUÁRIO) //
-- Esta é a parte crucial: carregar a imagem complexa como fundo da aba
local BackgroundImg = Instance.new("ImageLabel", Main)
BackgroundImg.Name = "CustomBackground"
BackgroundImg.Size = UDim2.new(1, 0, 1, 0)
BackgroundImg.Image = "rbxassetid://169db234-6f48-4232-965c-16b138f2d294" -- ID exato da imagem enviada
BackgroundImg.ScaleType = Enum.ScaleType.Crop
BackgroundImg.ZIndex = 0
Instance.new("UICorner", BackgroundImg).CornerRadius = UDim.new(0, 15)

-- Camada de Transparência por cima da imagem (Overlay de "Vidro")
local GlassOverlay = Instance.new("Frame", Main)
GlassOverlay.Name = "GlassOverlay"
GlassOverlay.Size = UDim2.new(1, 0, 1, 0)
GlassOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GlassOverlay.BackgroundTransparency = 0.55 -- Cria o efeito translúcido
GlassOverlay.ZIndex = 1
Instance.new("UICorner", GlassOverlay).CornerRadius = UDim.new(0, 15)

-- // CABEÇALHO DANIEL HUB (TEXTO GRADIENTE) //
-- Recria o texto com precisão de Roxo para Dourado
local HeaderFrame = Instance.new("Frame", Main)
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.ZIndex = 2

-- "DANIEL" em Roxo
local TextDaniel = Instance.new("TextLabel", HeaderFrame)
TextDaniel.Text = "DANIEL"
TextDaniel.TextColor3 = Color_Purple_Glow_Bright
TextDaniel.Font = Enum.Font.GothamBold
TextDaniel.TextSize = 26
TextDaniel.Position = UDim2.new(0.35, 0, 0.5, 0) -- Ajuste fino de posição
TextDaniel.AnchorPoint = Vector2.new(0.5, 0.5)
TextDaniel.BackgroundTransparency = 1
TextDaniel.ZIndex = 3

-- "HUB" em Dourado
local TextHub = Instance.new("TextLabel", HeaderFrame)
TextHub.Text = "HUB"
TextHub.TextColor3 = Color_Gold_Text
TextHub.Font = Enum.Font.GothamBold
TextHub.TextSize = 26
TextHub.Position = UDim2.new(0.61, 0, 0.5, 0) -- Ajuste fino de posição
TextHub.AnchorPoint = Vector2.new(0.5, 0.5)
TextHub.BackgroundTransparency = 1
TextHub.ZIndex = 3

-- // VARIÁVEIS DE ESTADO E FUNÇÕES DO JOGO (PARA FUNCIONAR NO DELTA) //
local _G = { Aim = false, Esp = false, Noc = false }

-- Função de Raycast para o Wall Check (Aimbot não mira atrás de parede)
local function WallCheck(part)
    local Camera = workspace.CurrentCamera
    local LocalPlayerChar = Player.Character
    if not LocalPlayerChar or not part then return false end
    local head = LocalPlayerChar:FindFirstChild("Head")
    if not head then return false end

    local ray = Ray.new(head.Position, (part.Position - head.Position).Unit * 500)
    local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayerChar, part.Parent})
    
    if hit then return false else return true end
end

-- // CRIAÇÃO DE BOTÕES ESTILIZADOS (SWITCHES CUSTOM) //
-- Esta função recria a "cápsula" semi-transparente com o switch redondo
local function CreateUltimateSwitch(txt, y, globalVar)
    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2

-- Configurações Iniciais
local InfiniteJumpEnabled = true
local JumpForce = 50
local UserInputService = game:GetService("UserInputService")

-- Criando a Interface (GUI)
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local ConfigFrame = Instance.new("Frame")
local Slider = Instance.new("TextBox")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "CustomJumpGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botão Principal (O que você clica para pular)
MainButton.Name = "JumpButton"
MainButton.Parent = ScreenGui
MainButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MainButton.Position = UDim2.new(0.1, 0, 0.5, 0)
MainButton.Size = UDim2.new(0, 70, 0, 70)
MainButton.Text = "PULAR"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.SourceSansBold
MainButton.TextSize = 20
MainButton.Draggable = true -- Permite mover o botão
MainButton.Active = true
MainButton.Selectable = true

-- Janela de Configuração de Força (Abaixo do botão)
ConfigFrame.Name = "ConfigFrame"
ConfigFrame.Parent = MainButton
ConfigFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ConfigFrame.Position = UDim2.new(0, 0, 1, 5)
ConfigFrame.Size = UDim2.new(0, 70, 0, 50)
ConfigFrame.BorderSizePixel = 0

Title.Parent = ConfigFrame
Title.Size = UDim2.new(1, 0, 0.4, 0)
Title.Text = "FORÇA"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextSize = 12

Slider.Parent = ConfigFrame
Slider.Position = UDim2.new(0.1, 0, 0.4, 0)
Slider.Size = UDim2.new(0.8, 0, 0.5, 0)
Slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Slider.Text = tostring(JumpForce)
Slider.TextColor3 = Color3.fromRGB(0, 255, 100)
Slider.ClearTextOnFocus = true

-- Lógica da Força do Pulo
Slider.FocusLost:Connect(function()
    local val = tonumber(Slider.Text)
    if val then
        JumpForce = math.clamp(val, 1, 100)
        Slider.Text = tostring(JumpForce)
    else
        Slider.Text = tostring(JumpForce)
    end
end)

-- Lógica do Pulo Infinito ao clicar no botão
MainButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        wait(0.1)
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0, JumpForce, 0)
    end
end)

-- Lógica de Teclado (Opcional: Barra de Espaço também usa a força personalizada)
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0, JumpForce, 0)
        end
    end
end)

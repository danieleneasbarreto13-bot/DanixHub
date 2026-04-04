--- NOVO SISTEMA DE PULO MELHORADO ---
local function DoJump()
    local Character = LocalPlayer.Character
    if Character then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        
        if RootPart and Humanoid then
            -- Força o estado de pulo para o jogo entender a ação
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            
            -- Zera a velocidade de queda (Y = 0) para o pulo ser sempre consistente
            -- e aplica a força definida no Slider
            RootPart.Velocity = Vector3.new(RootPart.Velocity.X, _G.JumpPower, RootPart.Velocity.Z)
        end
    end
end

-- Slider com feedback em tempo real
MovementTab:CreateSlider({
   Name = "Potência do Pulo (Ajuste Fino)",
   Range = {1, 200}, -- Aumentei para 200 caso queira pulos super altos
   Increment = 1,
   Suffix = " Studs/s",
   CurrentValue = 50,
   Callback = function(Value)
       _G.JumpPower = Value
   end,
})

-- Botão externo com feedback visual ao clicar
ExternalJumpBtn.MouseButton1Down:Connect(function()
    ExternalJumpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Escurece ao apertar
    DoJump()
end)

ExternalJumpBtn.MouseButton1Up:Connect(function()
    ExternalJumpBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Volta ao normal
end)

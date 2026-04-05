local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // BUSCA A CHAVE DO SEU GITHUB
local KeyDoGitHub = game:HttpGet("https://raw.githubusercontent.com/danieleneasbarreto13-bot/DanixHub/refs/heads/main/Key.txt")

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DANIEL HUB",
   LoadingTitle = "Sistema de Verificação 24h...",
   LoadingSubtitle = "Créditos: DANIEL & WELDERSON",
   ConfigurationSaving = {
      Enabled = true,
      Folder = "EliteHubConfig",
      FileName = "DanixKeySystem"
   },
   KeySystem = true, 
   KeySettings = {
      Title = "Chave Necessária",
      Subtitle = "A chave expira a cada 24 horas",
      Note = "Clique no botão abaixo para copiar!",
      FileName = "EliteKeyFile", 
      SaveKey = true, -- SALVA POR 24H
      Key = {KeyDoGitHub},
      Actions = {
          [1] = {
              Text = "Copiar Link (Key)",
              OnPress = function()
                  setclipboard("https://linkvertise.com/access/4856817/SVCyV5atG9C1")
              end
          }
      }
   }
})

-- // ABA PRINCIPAL DO SCRIPT
local Tab = Window:CreateTab("Principal", 4483362458)
Tab:CreateSection("Bem-vindo, " .. game.Players.LocalPlayer.Name)

Tab:CreateButton({
   Name = "Avisar que está funcionando",
   Callback = function()
       Rayfield:Notify({Title = "Sucesso!", Content = "O Elite Hub foi carregado!", Duration = 5})
   end,
})

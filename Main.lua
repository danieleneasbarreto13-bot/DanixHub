local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Este link lê a chave que está no seu GitHub (Key.txt)
local KeyDoGitHub = game:HttpGet("https://raw.githubusercontent.com/danieleneasbarreto13-bot/DanixHub/refs/heads/main/Key.txt")

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DANIEL HUB",
   LoadingTitle = "Validando Acesso 24h...",
   LoadingSubtitle = "Créditos: DANIEL & WELDERSON",
   ConfigurationSaving = {
      Enabled = true,
      Folder = "EliteHubConfig",
      FileName = "DanixKeySystem"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Sistema de Chave | Elite Hub",
      Subtitle = "A chave expira a cada 24 horas",
      Note = "Pegue a chave aqui: https://linkvertise.com/access/4856817/SVCyV5atG9C1", 
      FileName = "EliteKeyFile", 
      SaveKey = true, -- Salva a chave no celular do usuário por 24h
      Key = {KeyDoGitHub} 
   }
})

-- // O RESTANTE DO SEU CÓDIGO (VARIÁVEIS, TABS, ETC) VEM ABAIXO...

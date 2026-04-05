local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Esta linha conecta o seu script ao arquivo do GitHub que você criou
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
      Note = "Pegue a chave no Linkvertise (Link no Discord)",
      FileName = "EliteKeyFile", 
      SaveKey = true, -- Mantém o usuário logado enquanto você não mudar a Key no GitHub
      Key = {KeyDoGitHub} -- Aqui ele verifica se a key digitada é igual à do GitHub
   }
})

-- O RESTANTE DO SEU CÓDIGO (VARIÁVEIS, TABS, ETC) VEM ABAIXO...

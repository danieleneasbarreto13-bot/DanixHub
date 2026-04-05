local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // BUSCA A CHAVE DO SEU GITHUB
local KeyDoGitHub = game:HttpGet("https://raw.githubusercontent.com/danieleneasbarreto13-bot/DanixHub/refs/heads/main/Key.txt")

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DANIEL HUB",
   LoadingTitle = "Sistema de Verificação 24h...",
   LoadingSubtitle = "Créditos: DANIEL & WELDERSON",
   ConfigurationSaving = {
      Enabled = true,
      Folder = "DanixConfig",
      FileName = "KeySystem"
   },
   KeySystem = true, -- Ativa o bloqueio por chave
   KeySettings = {
      Title = "Chave Necessária",
      Subtitle = "A chave expira a cada 24 horas",
      Note = "Clique no botão abaixo para copiar o link da Key!",
      FileName = "DanixKey", 
      SaveKey = true, -- Salva a chave para não pedir toda hora
      GrabKeyFromSite = false,
      Key = {KeyDoGitHub} -- Compara com o seu GitHub
   }
})

-- // BOTÃO PARA COPIAR O LINK (APARECE NO MENU CASO PRECISE)
local KeyTab = Window:CreateTab("Obter Key", 4483362458)
KeyTab:CreateSection("Links de Acesso")

KeyTab:CreateButton({
   Name = "📋 Copiar Link do Linkvertise",
   Callback = function()
       setclipboard("https://linkvertise.com/access/4856817/SVCyV5atG9C1")
       Rayfield:Notify({
           Title = "Copiado!",
           Content = "Link copiado! Cole no seu navegador.",
           Duration = 5,
           Image = 4483362458,
       })
   end,
})

-- // O RESTANTE DO SEU CÓDIGO (BOTÕES, AIMBOT, ESP) COMEÇA AQUI...
-- (Mantenha o código que você já tem abaixo desta linha)

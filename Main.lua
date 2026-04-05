local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // BUSCA A CHAVE DO SEU GITHUB (Sempre atualizada)
local KeyDoGitHub = game:HttpGet("https://raw.githubusercontent.com/danieleneasbarreto13-bot/DanixHub/refs/heads/main/Key.txt")

local Window = Rayfield:CreateWindow({
   Name = "ELITE V13 | DANIEL HUB",
   LoadingTitle = "Sistema de Verificação 24h...",
   LoadingSubtitle = "Créditos: DANIEL & WELDERSON",
   ConfigurationSaving = {
      Enabled = true,
      Folder = "EliteHubConfig", -- Nome da pasta que será criada no Delta
      FileName = "DanixKeySystem"
   },
   KeySystem = true, 
   KeySettings = {
      Title = "Chave Necessária",
      Subtitle = "A chave expira a cada 24 horas",
      Note = "Clique no botão abaixo para copiar o link!",
      FileName = "EliteKeyFile", -- O arquivo que vai salvar a chave por 24h
      SaveKey = true, -- ISSO GARANTE O ACESSO POR 24H SEM PEDIR DE NOVO
      GrabKeyFromSite = false,
      Key = {KeyDoGitHub} 
   }
})

-- // ABA PARA OBTER A CHAVE (Aparece se o usuário fechar a tela inicial)
local KeyTab = Window:CreateTab("Obter Key", 4483362458)
KeyTab:CreateSection("Clique no botão para copiar o link da Key")

KeyTab:CreateButton({
   Name = "📋 COPIAR LINK DA KEY (LINKVERTISE)",
   Callback = function()
       -- COPIA O SEU LINK DO LINKVERTISE PARA O CELULAR
       setclipboard("https://linkvertise.com/access/4856817/SVCyV5atG9C1")
       
       -- AVISA QUE COPIOU
       Rayfield:Notify({
           Title = "Link Copiado!",
           Content = "O link foi copiado. Cole no Google para pegar a chave!",
           Duration = 5,
           Image = 4483362458,
       })
   end,
})

-- // AQUI COMEÇA O SEU SCRIPT (TABS DE COMBATE, ESP, ETC)
local MainTab = Window:CreateTab("Principal", 4483362458)
-- Adicione suas funções abaixo...

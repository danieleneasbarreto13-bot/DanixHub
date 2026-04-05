local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
        Note = "Clique no botão abaixo para copiar o link!",
        FileName = "EliteKeyFile",
        SaveKey = true,
        Key = {KeyDoGitHub},
        Actions = {
            {
                Text = "Copiar Link (Key)",
                OnPress = function()
                    setclipboard("https://linkvertise.com/access/4856817/SVCyV5atG9C1")
                end
            }
        }
    }
})

local Tab = Window:CreateTab("Principal", 4483362458)
Tab:CreateSection("Bem-vindo ao Elite Hub V13")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- //////////////////////////////////////////////////////////////////
-- // TELA DE ENTRADA PERSONALIZADA PRETO E ROXO ✠𝕯𝖆𝖓𝖎𝖊𝖑✠ //
-- //////////////////////////////////////////////////////////////////
local Window = Rayfield:CreateWindow({
   Name = "✠𝕯𝖆𝖓𝖎𝖊𝖑✠ HUB", -- Nome Principal
   LoadingTitle = "✠𝕯𝖆𝖓𝖎𝖊𝖑✠", -- Fonte Gótica na Entrada
   LoadingSubtitle = "Seja Muito Bem-Vindo, Mestre!", -- Mensagem de Entrada
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "DanielHub",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false, -- Sistema de Chave desligado
   Theme = "DarkTheme", -- Tema escuro de base
   -- CONFIGURAÇÃO DE CORES (Degradê Preto e Roxo)
   CustomTheme = {
      ["AccentColor"] = Color3.fromRGB(75, 0, 130), -- Roxo Indigo Vibrante (Para Toggles, Sliders)
      ["BackgroundColor"] = Color3.fromRGB(15, 15, 15), -- Quase Preto (Fundo das Abas)
      ["WindowColor"] = Color3.fromRGB(10, 10, 10), -- Preto Profundo (Janela Principal)
      ["TextColor"] = Color3.fromRGB(240, 240, 240), -- Branco Gelo (Texto Principal)
      ["TabColor"] = Color3.fromRGB(30, 0, 50), -- Roxo Muito Escuro (Fundo das Abas)
      ["TabTextColor"] = Color3.fromRGB(200, 200, 200), -- Cinza Claro (Texto das Abas)
      ["TitleColor"] = Color3.fromRGB(255, 255, 255), -- Branco Puro (Título da Janela)
      ["DescColor"] = Color3.fromRGB(180, 180, 180), -- Cinza Médio (Subtítulos/Descrições)
      ["ButtonColor"] = Color3.fromRGB(40, 0, 70), -- Roxo Escuro (Botoes)
      ["ButtonTextColor"] = Color3.fromRGB(255, 255, 255), -- Branco (Texto dos Botões)
      ["ToggleColor"] = Color3.fromRGB(60, 0, 100), -- Roxo Médio (Fundo do Toggle Desligado)
      ["SliderColor"] = Color3.fromRGB(60, 0, 100), -- Roxo Médio (

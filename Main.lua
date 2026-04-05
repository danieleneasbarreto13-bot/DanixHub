   KeySettings = {
      Title = "Chave Necessária",
      Subtitle = "A chave expira a cada 24 horas",
      Note = "Clique no botão abaixo para copiar!",
      FileName = "EliteKeyFile", 
      SaveKey = true,
      Key = {KeyDoGitHub},
      -- ESTA LINHA ABAIXO É O QUE CRIA O BOTÃO DE COPIAR NA JANELA
      Actions = {
          [1] = {
              Text = "Copiar Link (Key)",
              OnPress = function()
                  setclipboard("https://linkvertise.com/access/4856817/SVCyV5atG9C1")
              end
          }
      }
   }

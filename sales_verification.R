# Carregando os pacotes necessários
library(readxl)
library(dplyr)
library(openxlsx)

# Lendo as planilhas Excel
planilha_completa <- read_excel("C:/Users/acer/Downloads/relatorio_geral_editado.xlsx")
planilha_vendedor <- read_excel("C:/Users/acer/Downloads/planilha_vendedor.xlsx")

# Renomeando colunas na planilha do vendedor para melhor legibilidade
planilha_vendedor <- planilha_vendedor %>%
  rename(data_emissao = data,
         valor_contabil = 'Valor total (R$)')

# Marcando as vendas correspondentes ao Vendedor A
planilha_completa <- planilha_completa %>%
  mutate(Sinalizacao = ifelse(
    (empresa %in% planilha_vendedor$empresa) &
      (data_emissao %in% planilha_vendedor$data_emissao) &
      (valor_contabil %in% planilha_vendedor$valor_contabil),
    "Vendedor A", "Outros"
  ))

# Exportando o dataframe com sinalização para um arquivo Excel
write.xlsx(planilha_completa, file = "C:/Users/acer/Downloads/relatorio_completo_com_sinalizacao.xlsx")
# Gerenciamento de Produtos Agrícolas
**Escopo inicial**: desenvolver um sistema de gerenciamento de produtos agrícolas para auxiliar agricultores no controle de seus produtos. 
Features como gerência de produção, gerência de estoque, gerência de vendas e outras mais contemplam as ideias de desenvolvimento para esse projeto.  

**Analisar e Definir**: Arquitetura do Sistema e Padrões de Projeto  
**Tecnologias**: Dart, Flutter, Firebase

# Tabela de Complexidade (Min de 26pts)

**Pontuação de Complexidade mínima: 26 pontos**
| Critério | Pontos | Aplicação | Subtotal |
|---------|--------|-----------|---------|
| **Cadastro Simples** | 1 ponto (máx. 5) | **Usuário** | 1 x 1 = 1 |
| **Cadastro com Associação (1:N)** | 3 pontos | **Usuário:Empresa (1:N)** e **Produto:Empresa (1:N)** | 2 x 3 = 6 |
| **Cadastro com Associação (N:N)** | 6 pontos | **Carrinho:Produto (N:N)** | 1 x 6 = 6 |
| **Consumo de API com Persistência Remota** | 3 pontos | **Firebase Cloud** | 1 x 3 = 3 |
| **Organização Arquitetural (MVC, MVVW ou Clean)** | 2 pontos | **Clean Architecture** | 1 X 2 = 2 |
| **Componentização** | 2 pontos | **SubmitButtom**, **InfoCard** e **SubmitButtom** | 2 x 2 = 4 |
| **Implementação CI/CD** | 8 pontos | **Github Actions (CI)** e **Firebase App Distribution (CD)** | 1 x 8 = 8 |

**Total = 30**

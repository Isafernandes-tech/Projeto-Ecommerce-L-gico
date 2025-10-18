# 🛒 Projeto SQL - E-commerce

![Status](https://img.shields.io/badge/Status-Concluído-green)
![SQL](https://img.shields.io/badge/SQL-Prática-blue)

## 📖 Descrição
Projeto simula o banco de dados de um **e-commerce**, com **modelagem lógica refinada**, persistência de dados e consultas SQL complexas.  

Objetivos:  
- Criar banco e tabelas com **chaves primárias e estrangeiras**  
- Aplicar **constraints** (Cliente PF/PJ exclusivo, múltiplos pagamentos, status de entrega)  
- Criar queries SQL que respondam perguntas de negócio  

## 🗂 Estrutura do Banco

| Entidade / Relacionamento | Descrição |
|---------------------------|-----------|
| Cliente | PF ou PJ, constraint para não ter CPF e CNPJ ao mesmo tempo |
| Produto | Produtos do e-commerce com categoria, descrição e valor |
| Fornecedor | Fornecedores de produtos |
| Estoque | Estoques físicos, relacionados a produtos e quantidade |
| Pedido | Pedidos realizados pelos clientes |
| Pagamento | Formas de pagamento de cada pedido (múltiplas) |
| Entrega | Status e código de rastreio de cada pedido |
| Terceiro Vendedor | Vendedores externos |
| Produto_Estoque | Produto x Estoque |
| Fornecedor_Produto | Fornecedor x Produto |
| Produto_Pedido | Produto x Pedido |
| Produto_Terceiro_Vendedor | Produto x Vendedor |

## ❓ Perguntas de Negócio

1. Cliente PF ou PJ: Um cliente pode ter CPF e CNPJ ao mesmo tempo?  
2. Pagamento múltiplo: Um pedido pode ter várias formas de pagamento?  
3. Entrega: Qual o status e código de rastreio de cada pedido?  
4. Estoque: Quantos produtos existem em cada estoque?  
5. Produtos, pedidos e vendedores: Algum vendedor também é fornecedor?

## ⚡ Exemplos de Queries
**Recuperação simples**
```sql
SELECT * FROM Cliente;

Filtro com WHERE

SELECT * FROM Pedido WHERE status_pedido = 'Em andamento';


Atributo derivado

SELECT p.descricao, (p.valor * pe.quantidade) AS Valor_Total_Estoque
FROM Produto p JOIN Produto_Estoque pe ON p.id_produto = pe.produto_id;


Ordenação

SELECT nome, endereco FROM Cliente ORDER BY nome ASC;


Agrupamento e HAVING

SELECT c.nome, COUNT(p.id_pedido) AS Total_Pedidos
FROM Cliente c JOIN Pedido p ON c.id_cliente = p.cliente_id
GROUP BY c.nome HAVING COUNT(p.id_pedido) > 1;


Junção complexa

SELECT c.nome AS Cliente, pr.descricao AS Produto, p.quantidade, f.razao_social AS Fornecedor
FROM Produto_Pedido p
JOIN Pedido pe ON p.pedido_id = pe.id_pedido
JOIN Cliente c ON pe.cliente_id = c.id_cliente
JOIN Produto pr ON p.produto_id = pr.id_produto
JOIN Fornecedor_Produto fp ON pr.id_produto = fp.produto_id
JOIN Fornecedor f ON fp.fornecedor_id_fornecedor = f.id_fornecedor;


Consultas de negócio

-- Produtos de fornecedores e estoques
SELECT f.razao_social, pr.descricao, pe.quantidade AS Estoque
FROM Fornecedor f
JOIN Fornecedor_Produto fp ON f.id_fornecedor = fp.fornecedor_id_fornecedor
JOIN Produto pr ON fp.produto_id = pr.id_produto
JOIN Produto_Estoque pe ON pr.id_produto = pe.produto_id;

-- Verificar se algum vendedor também é fornecedor
SELECT v.razao_social AS Vendedor, f.razao_social AS Fornecedor
FROM Terceiro_Vendedor v
JOIN Fornecedor f ON v.razao_social = f.razao_social;

🛠 Tecnologias

MySQL 8.0+

MySQL Workbench

💡 Autor

Isabelle Nascimento

📌 Observações

Dados fictícios, apenas para aprendizado

Projeto pronto para GitHub e avaliação

Queries podem ser adaptadas ou expandidas


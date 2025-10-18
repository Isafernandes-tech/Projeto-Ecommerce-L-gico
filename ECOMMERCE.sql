CREATE DATABASE IF NOT EXISTS modelo_conceitual;
USE modelo_conceitual;

-- =======================
-- Entidade Fornecedor
-- =======================
CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    centro_de_alta VARCHAR(100)
);

-- =======================
-- Entidade Estoque
-- =======================
CREATE TABLE Estoque (
    id_estoque INT PRIMARY KEY,
    local VARCHAR(100) NOT NULL
);

-- =======================
-- Entidade Produto
-- =======================
CREATE TABLE Produto (
    id_produto INT PRIMARY KEY,
    categoria VARCHAR(50),
    descricao VARCHAR(100),
    valor DECIMAL(10,2) NOT NULL
);

-- =======================
-- Entidade Cliente (PF ou PJ)
-- =======================
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14),
    cnpj VARCHAR(18),
    endereco VARCHAR(200),
    CONSTRAINT chk_pf_pj CHECK (
        (cpf IS NOT NULL AND cnpj IS NULL) OR
        (cpf IS NULL AND cnpj IS NOT NULL)
    )
);

-- =======================
-- Entidade Pedido
-- =======================
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    status_pedido VARCHAR(50),
    descricao VARCHAR(200),
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id_cliente)
);

-- =======================
-- Entidade Terceiro Vendedor
-- =======================
CREATE TABLE Terceiro_Vendedor (
    id_terceiro_vendedor INT PRIMARY KEY,
    razao_social VARCHAR(100),
    local VARCHAR(100)
);

-- =======================
-- Entidade Pagamento (um pedido pode ter várias formas)
-- =======================
CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY,
    tipo_pagamento VARCHAR(50),
    valor DECIMAL(10,2) NOT NULL,
    pedido_id INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id_pedido)
);

-- =======================
-- Entidade Entrega
-- =======================
CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY,
    status_entrega VARCHAR(50),
    codigo_rastreio VARCHAR(50),
    pedido_id INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id_pedido)
);

-- =======================
-- Relacionamento Produto x Estoque
-- =======================
CREATE TABLE Produto_Estoque (
    produto_id INT,
    estoque_id INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (produto_id, estoque_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(id_produto),
    FOREIGN KEY (estoque_id) REFERENCES Estoque(id_estoque)
);

-- =======================
-- Relacionamento Fornecedor x Produto
-- =======================
CREATE TABLE Fornecedor_Produto (
    fornecedor_id INT,
    produto_id INT,
    PRIMARY KEY (fornecedor_id, produto_id),
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(id_fornecedor),
    FOREIGN KEY (produto_id) REFERENCES Produto(id_produto)
);

-- =======================
-- Relacionamento Produto x Pedido
-- =======================
CREATE TABLE Produto_Pedido (
    produto_id INT,
    pedido_id INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (produto_id, pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(id_produto),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id_pedido)
);

-- =======================
-- Relacionamento Produto x Terceiro Vendedor
-- =======================
CREATE TABLE Produto_Terceiro_Vendedor (
    terceiro_vendedor_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (terceiro_vendedor_id, produto_id),
    FOREIGN KEY (terceiro_vendedor_id) REFERENCES Terceiro_Vendedor(id_terceiro_vendedor),
    FOREIGN KEY (produto_id) REFERENCES Produto(id_produto)
);

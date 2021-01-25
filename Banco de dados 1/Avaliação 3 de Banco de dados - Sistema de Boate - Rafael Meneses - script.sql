/* Avaliação 3 de Banco de dados - Sistema de Boate - Rafael Meneses*/

create database sistema_boate;

use sistema_boate;

/* Lógico_1: */

CREATE TABLE PRODUTO (
    idProduto int not null auto_increment primary key,
    nome varchar(40),
    tipo varchar(20),
    valor numeric(15,2)
);

CREATE TABLE EVENTO (
    idEvento int not null auto_increment primary key,
    data date,
    nome varchar(20),
    gastosEvento numeric(15,2),
    idBoate int
);

CREATE TABLE PESSOA (
    idPessoa int not null auto_increment primary key,
    nome varchar(30),
    cpf char(11),
    nascimento date,
    idEndereco int,
    idTelefone int
);

CREATE TABLE BOATE (
    idBoate int not null auto_increment primary key,
    nome varchar(30),
    capacidade int,
    descricao varchar(50),
    idEndereco int,
    idTelefone int
);

CREATE TABLE ENDERECO (
    idEndereco int not null auto_increment primary key,
    rua varchar(50),
    cep char(8),
    bairro varchar(30),
    numero int,
    complemento varchar(30),
    idCidade int
);

CREATE TABLE CIDADE (
    idCidade int not null auto_increment primary key,
    nome varchar(30),
    estado char(2),
    pais char(2)
);

CREATE TABLE BAR (
    idBar int not null auto_increment primary key,
    nome varchar(30),
    espacoTotalProdutos int,
    espacoTotalFuncionarios int,
    descricao varchar(50)
);

CREATE TABLE VENDAS_PESSOA_BAR (
    idVendas int not null auto_increment primary key,
    data date,
    quantidadeVendas int,
    idProduto int,
    idPessoa int,
    idBar int
);

CREATE TABLE FORNECEDOR (
    idFornecedor int not null auto_increment primary key,
    nome varchar(30),
    cnpj char(14),
    idTelefone int,
    idEndereco int
);

CREATE TABLE DEPOSITO (
    idDeposito int not null auto_increment primary key,
    data date,
    quantidadeProduto int,
    idProduto int
);

CREATE TABLE NOTA_FORNECEDOR_BOATE (
    idNota int not null auto_increment primary key,
    data date,
    valor int,
    quantidadeProduto int,
    idProduto int,
    idFornecedor int,
    idBoate int
);

CREATE TABLE REGISTRO_BOATE_PESSOA (
    idRegistro int not null auto_increment primary key,
    data date,
    categoria varchar(40),
    idBoate int,
    idPessoa int
);

CREATE TABLE COMPRAS_PESSOA_BAR (
    idCompras int not null auto_increment primary key,
    data date,
    quantidadeCompras int,
    idProduto int,
    idPessoa int,
    idBar int
);

CREATE TABLE CONTROLE_BAR_PRODUTO (
    idControle int not null auto_increment primary key,
    data date,
    quantidadeProduto int,
    idBar int,
    idProduto int
);

CREATE TABLE MOVIMENTACAO_BAR_PRODUTO (
    idMovimentacao int not null auto_increment primary key,
    data date,
    quantidadeProduto int,
    idBar int,
    idProduto int
);

CREATE TABLE TELEFONE (
    idTelefone int not null auto_increment primary key,
    ddi char(4),
    ddd char(4),
    numero char(9),
    tipo varchar(20)
);
 
ALTER TABLE EVENTO ADD CONSTRAINT FK_EVENTO_2
    FOREIGN KEY (idBoate)
    REFERENCES BOATE (idBoate)
    ON DELETE CASCADE;
 
ALTER TABLE PESSOA ADD CONSTRAINT FK_PESSOA_2
    FOREIGN KEY (idEndereco)
    REFERENCES ENDERECO (idEndereco)
    ON DELETE RESTRICT;
 
ALTER TABLE PESSOA ADD CONSTRAINT FK_PESSOA_3
    FOREIGN KEY (idTelefone)
    REFERENCES TELEFONE (idTelefone)
    ON DELETE CASCADE;
 
ALTER TABLE BOATE ADD CONSTRAINT FK_BOATE_2
    FOREIGN KEY (idEndereco)
    REFERENCES ENDERECO (idEndereco)
    ON DELETE CASCADE;
 
ALTER TABLE BOATE ADD CONSTRAINT FK_BOATE_3
    FOREIGN KEY (idTelefone)
    REFERENCES TELEFONE (idTelefone)
    ON DELETE CASCADE;
 
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_2
    FOREIGN KEY (idCidade)
    REFERENCES CIDADE (idCidade)
    ON DELETE RESTRICT;
 
ALTER TABLE VENDAS_PESSOA_BAR ADD CONSTRAINT FK_VENDAS_PESSOA_BAR_2
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto)
    ON DELETE RESTRICT;
 
ALTER TABLE VENDAS_PESSOA_BAR ADD CONSTRAINT FK_VENDAS_PESSOA_BAR_3
    FOREIGN KEY (idPessoa)
    REFERENCES PESSOA (idPessoa);
 
ALTER TABLE VENDAS_PESSOA_BAR ADD CONSTRAINT FK_VENDAS_PESSOA_BAR_4
    FOREIGN KEY (idBar)
    REFERENCES BAR (idBar);
 
ALTER TABLE FORNECEDOR ADD CONSTRAINT FK_FORNECEDOR_2
    FOREIGN KEY (idTelefone)
    REFERENCES TELEFONE (idTelefone)
    ON DELETE CASCADE;
 
ALTER TABLE FORNECEDOR ADD CONSTRAINT FK_FORNECEDOR_3
    FOREIGN KEY (idEndereco)
    REFERENCES ENDERECO (idEndereco)
    ON DELETE CASCADE;
 
ALTER TABLE DEPOSITO ADD CONSTRAINT FK_DEPOSITO_2
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto)
    ON DELETE SET NULL;
 
ALTER TABLE NOTA_FORNECEDOR_BOATE ADD CONSTRAINT FK_NOTA_FORNECEDOR_BOATE_2
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto)
    ON DELETE RESTRICT;
 
ALTER TABLE NOTA_FORNECEDOR_BOATE ADD CONSTRAINT FK_NOTA_FORNECEDOR_BOATE_3
    FOREIGN KEY (idFornecedor)
    REFERENCES FORNECEDOR (idFornecedor);
 
ALTER TABLE NOTA_FORNECEDOR_BOATE ADD CONSTRAINT FK_NOTA_FORNECEDOR_BOATE_4
    FOREIGN KEY (idBoate)
    REFERENCES BOATE (idBoate);
 
ALTER TABLE REGISTRO_BOATE_PESSOA ADD CONSTRAINT FK_REGISTRO_BOATE_PESSOA_2
    FOREIGN KEY (idBoate)
    REFERENCES BOATE (idBoate);
 
ALTER TABLE REGISTRO_BOATE_PESSOA ADD CONSTRAINT FK_REGISTRO_BOATE_PESSOA_3
    FOREIGN KEY (idPessoa)
    REFERENCES PESSOA (idPessoa);
 
ALTER TABLE COMPRAS_PESSOA_BAR ADD CONSTRAINT FK_COMPRAS_PESSOA_BAR_2
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto)
    ON DELETE RESTRICT;
 
ALTER TABLE COMPRAS_PESSOA_BAR ADD CONSTRAINT FK_COMPRAS_PESSOA_BAR_3
    FOREIGN KEY (idPessoa)
    REFERENCES PESSOA (idPessoa);
 
ALTER TABLE COMPRAS_PESSOA_BAR ADD CONSTRAINT FK_COMPRAS_PESSOA_BAR_4
    FOREIGN KEY (idBar)
    REFERENCES BAR (idBar);
 
ALTER TABLE CONTROLE_BAR_PRODUTO ADD CONSTRAINT FK_CONTROLE_BAR_PRODUTO_2
    FOREIGN KEY (idBar)
    REFERENCES BAR (idBar);
 
ALTER TABLE CONTROLE_BAR_PRODUTO ADD CONSTRAINT FK_CONTROLE_BAR_PRODUTO_3
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto);
 
ALTER TABLE MOVIMENTACAO_BAR_PRODUTO ADD CONSTRAINT FK_MOVIMENTACAO_BAR_PRODUTO_2
    FOREIGN KEY (idBar)
    REFERENCES BAR (idBar);
 
ALTER TABLE MOVIMENTACAO_BAR_PRODUTO ADD CONSTRAINT FK_MOVIMENTACAO_BAR_PRODUTO_3
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto);
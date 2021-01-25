drop database if exists vendas;

create database vendas;
use vendas;

create table marca(
idMarca int not null auto_increment primary key,
nome varchar(60)
);

create table tipo(
idTipo int not null auto_increment primary key,
nome varchar(60)
);

create table produto(
idProduto int not null auto_increment primary key,
nome varchar(60),
quantAtual numeric(15,2),
quantMinima numeric(15,2),
valorVenda numeric(15,2),
idMarca int not null,
idTipo int not null,
foreign key (idMarca) references marca(idMarca) on update cascade on delete restrict,
foreign key (idTipo) references tipo(idTipo) on update cascade on delete restrict
);

create table cliente(
idCliente int not null auto_increment primary key,
nome varchar(60),
telefone varchar(15),
email varchar(60),
cpf char(11),
dataNasc date,
endereco varchar(100),
numeroVendas int
);

create table venda(
idVenda int not null auto_increment primary key,
dataVenda date,
numeroNf varchar(5),
subtotal numeric(15,2),
desconto numeric(15,2),
total numeric(15,2),
idCliente int,
foreign key (idCliente) references cliente(idCliente) on update cascade on delete restrict
);

create table itens_venda(
valorUnit numeric(15,2),
quantidade numeric(15,2),
total numeric(15,2),
idVenda int ,
idProduto int ,
foreign key (idVenda) references venda(idVenda) on update cascade on delete restrict,
foreign key (idProduto) references produto(idProduto) on update cascade on delete restrict
);

create table fornecedor(
idFornec int not null auto_increment primary key,
razaoSocial varchar(60),
email varchar(60),
cnpj varchar(15),
telefone varchar(15),
nomeFantasia varchar(60),
numeroCompras varchar(15)
);

create table compra(
idCompra int not null auto_increment primary key,
subtotal numeric(15,2),
desconto numeric(15,2),
total numeric(15,2),
dataCompra date,
numeroNf varchar(20),
idFornec int ,
foreign key (idFornec) references fornecedor(idFornec) on update cascade on delete restrict
);

create table itens_compra(
valorUnit numeric(15,2),
quantidade numeric(15,2),
total numeric(15,2),
idCompra int ,
idProduto int ,
foreign key (idCompra) references compra(idCompra) on update cascade on delete restrict,
foreign key (idProduto) references produto(idProduto) on update cascade on delete restrict
);

create table historico_estoque(
idHist int not null auto_increment primary key,
valorUnit numeric(15,2),
quantidade numeric(15,2),
total numeric(15,2),
idProduto int not null,
idVenda int ,
idCompra int ,
foreign key (idProduto) references produto(idProduto) on update cascade on delete restrict,
foreign key (idVenda) references venda(idVenda) on update cascade on delete restrict,
foreign key (idCompra) references compra(idCompra) on update cascade on delete restrict
);

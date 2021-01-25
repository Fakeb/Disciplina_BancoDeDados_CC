/*Atividade 03*/
/*1.Para excluir todos os produtos que possuem quantidade em estoque zero e nunca foram vendidos.*/

delete from produto
where quantAtual = 0
and idProduto not in(select distinct iv.idProduto
					 from itens_venda iv)
and idProduto not in(select distinct idProduto
					 from itens_compra);

/*select * from produto;*/
				
/*2.Para excluir todos os clientes que não compraram da empresa.*/

delete from cliente
where idCliente not in(select distinct v.idCliente
					 from venda v);

/*select * from cliente;*/

/*3.Para reajustar o valor unitário dos produtos que foram vendidos mais de 5 vezes em 10%.*/

update produto set valorVenda = (valorVenda*1.1)
where idProduto in (
    select distinct iv.idProduto
    from itens_venda iv
    group by iv.idProduto
    having sum(iv.quantidade) > 5);
    
/*select * from produto;*/

/*4.Para alterar o numero de vendas do cliente (contagem de vendas).*/

update cliente as c 
set c.numeroVendas = (select count(v.idVenda)
					  from venda v
					  where v.idCliente = c.idCliente);
                    
/*select * from cliente;*/

/*5.Para alterar o numero de compras do fornecedor (contagem de compras).*/

update fornecedor as f 
set f.numeroCompras = (select count(c.idCompra)
					   from compra c
					   where c.idFornec = f.idFornec);
                    
/*select * from fornecedor;*/

/*6.Criar a tabela ENDERECO (normalizada até cidade).*/

create table cidade(
idCidade int not null auto_increment primary key,
nome varchar(30),
uf char(2)
);

create table endereco(
idEndereco int not null auto_increment,
tipoLog varchar(20),
logradouro varchar(60),
numero varchar(10),
complemento varchar(30),
cep char(8),
bairro varchar(60),
descricao varchar(20),
idCidade int,
idCliente int not null,
primary key (idEndereco),
foreign key (idCidade) references cidade(idCidade) on update cascade on delete restrict,
foreign key (idCliente) references cliente(idCliente) on update cascade on delete restrict
);

/*select * from cidade;
select * from endereco;*/

/*7.Popule a tabela adequadamente (utiliza o comando INSERT seguido de SELECT).*/

/*select * from cliente;*/

insert into cidade(nome,uf)
values ('Santa Maria','RS'),
	   ('Porto Alegre','RS'),
       ('Curitiba','PR'),
       ('São Paulo','SP'),
       ('Minas Gerais','MG');
       
/*select * from cidade;*/

insert into endereco(logradouro, idCliente)
	select distinct c.endereco, c.idCliente
    from cliente c;

/*select * from endereco;*/

update endereco
set tipoLog = 'Rua', numero = '632', complemento = '', cep = '97030532', bairro = 'Uglione', descricao = '', idCidade = '1'
where idCliente = 1;
update endereco
set tipoLog = 'Rua', numero = '350', complemento = 'Apartamento 301', cep = '97333532', bairro = 'Chácara das Flores', descricao = '', idCidade = '1'
where idCliente = 2;
update endereco
set tipoLog = 'Rua', numero = '132', complemento = '', cep = '91110532', bairro = 'Cascata', descricao = '', idCidade = '2'
where idCliente = 3;
update endereco
set tipoLog = 'Rua', numero = '32', complemento = '', cep = '97990532', bairro = 'Passo D Areia', descricao = '', idCidade = '1'
where idCliente = 4;
update endereco
set tipoLog = 'Rua', numero = '62', complemento = 'Apartamento 203', cep = '97000532', bairro = 'Atuba', descricao = '', idCidade = '3'
where idCliente = 5;

/*select * from endereco;*/

/*8.Exclua o atributo ENDERECO da tabela CLIENTE.*/

/*select * from cliente;*/

alter table cliente drop endereco;

/*select * from cliente;*/
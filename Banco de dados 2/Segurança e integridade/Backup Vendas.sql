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

insert into marca (nome)
values ('Coca-Cola'),
	   ('Piracanjuba'),
       ('Pullman'),
       ('Kaiser'),
       ('Beltrame hortifruti'),
       ('Pastelao'),
       ('Uniao'),
       ('Leve');
       
insert into tipo (nome)
values ('Pastelao'),
       ('Beltrame'),
       ('Padaria José'),
       ('Nacional'),
       ('Posto Ipiranga');

insert into produto (nome, quantAtual, quantMinima, valorVenda, idMarca, idTipo)
values ('Refrigerante 2L', '10', '5', '6.40', '1', '2'),
	   ('Refrigerante Lata', '10', '5', '2.30', '1', '2'),
	   ('Leite Condensado', '20', '5', '4.40', '2', '2'),
	   ('Pão de forma', '10', '5', '4.50', '3', '3'),
	   ('Leite 1L', '30', '5', '5.00', '2', '2'),
	   ('Cerveja 473ml', '9', '5', '2.80', '4', '2'),
       ('Cerveja 330ml', '7', '5', '2.20', '4', '2'),
       ('Cebola 150g', '16', '5', '0.90', '5', '2'),
       ('Açucar refinado', '11', '5', '3.90', '7', '4'),
       ('Olho Soja', '17', '5', '5.80', '8', '4'),
       ('Pastel da casa', '0', '5', '36.20', '6', '1');

insert into cliente (nome, telefone, email, cpf, dataNasc, endereco, numeroVendas)
values ('Rafael Meneses', '55992702522', 'rafinha@gmail.com', '39561100053', '1998-05-02', 'Rua Papa Leão XIII', '10'),
	   ('Gabriel Marconatto', '55992148311', 'marconiltom@gmail.com', '26222900046', '1997-07-26', 'Rua E', '4'),
	   ('Felipe Duarte', '55996098722', 'lipera@gmail.com', '26447654042', '1992-04-12', 'Rua Cândida Vargas', '4'),
	   ('Stefani zuse', '55998898891', 'tefa@gmail.com', '64502241008', '1999-03-07', 'Rua Agne', '4'),
	   ('Thiago Rocha', '55993515725', 'thiaguim@gmail.com', '64066778038', '1998-06-18', 'Rua Roberto Holtermann', '4'),
       ('Cássio Gamarra', '55993555525', 'Cass@gmail.com', '64069999038', '1998-05-28', 'Rua Pará', '0');
/*
       
insert into venda (dataVenda, numeroNF, subtotal, desconto, total, idCliente)
values ('2020-02-26', '00001', '8.70', '0.70', '8.00', '1'),
	   ('2020-02-15', '00002', '8.70', '0.70', '8.00', '1'),
	   ('2020-03-25', '00003', '8.70', '0.70', '8.00', '1'),
	   ('2020-03-15', '00004', '8.70', '0.70', '8.00', '1'),
	   ('2020-04-22', '00005', '8.90', '0.90', '8.00', '2'),
	   ('2020-04-11', '00006', '8.90', '0.90', '8.00', '2'),
	   ('2020-05-02', '00007', '8.90', '0.90', '8.00', '2'),
	   ('2020-05-01', '00008', '8.90', '0.90', '8.00', '2'),
	   ('2020-06-09', '00009', '7.80', '0.80', '7.00', '3'),
	   ('2020-06-05', '00010', '7.80', '0.80', '7.00', '3'),
       ('2020-07-26', '00011', '7.80', '0.80', '7.00', '3'),
	   ('2020-07-15', '00012', '7.80', '0.80', '7.00', '3'),
	   ('2020-08-25', '00013', '3.10', '0.10', '3.00', '4'),
	   ('2020-08-15', '00014', '3.10', '0.10', '3.00', '4'),
	   ('2020-09-22', '00015', '3.10', '0.10', '3.00', '4'),
	   ('2020-09-11', '00016', '3.10', '0.10', '3.00', '4'),
	   ('2020-10-02', '00017', '9.70', '0.70', '9.00', '5'),
	   ('2020-10-01', '00018', '9.70', '0.70', '9.00', '5'),
	   ('2020-11-09', '00019', '9.70', '0.70', '9.00', '5'),
	   ('2020-11-05', '00020', '9.70', '0.70', '9.00', '5');

insert into itens_venda (idVenda, idProduto, valorUnit, quantidade, total)
values ('1', '1', '6.40', '1', '6.40'),
	   ('2', '2', '2.30', '1', '2.30'),
	   ('3', '3', '4.40', '1', '4.40'),
	   ('4', '4', '4.50', '1', '4.50'),
	   ('5', '5', '5.00', '1', '5.00'),
	   ('6', '6', '2.80', '1', '2.80'),
	   ('7', '7', '2.20', '1', '2.20'),
	   ('8', '8', '0.90', '1', '0.90'),
	   ('9', '9', '3.90', '1', '3.90'),
	   ('10', '10', '8.00', '1', '8.00'),
       ('11', '1', '6.40', '1', '6.40'),
	   ('12', '2', '2.30', '1', '2.30'),
	   ('13', '3', '4.40', '1', '4.40'),
	   ('14', '4', '4.50', '1', '4.50'),
	   ('15', '5', '5.00', '1', '5.00'),
	   ('16', '6', '2.80', '1', '2.80'),
	   ('17', '7', '2.20', '1', '2.20'),
	   ('18', '8', '0.90', '1', '0.90'),
	   ('19', '9', '3.90', '1', '3.90'),
	   ('20', '10', '8.00', '1', '8.00');

*/
insert into fornecedor (razaoSocial, email, cnpj, telefone, nomeFantasia, numeroCompras)
values ('Random', 'random@yahoo.com', '64557545000113', '55922180231', 'Random bebidas', '10'),
	   ('Ifood', 'ifood@yahoo.com', '93557565000113', '55944189011', 'ifood', '4'),
	   ('José Paes', 'jose@yahoo.com', '77527542000113', '55931180387', 'Padaria José', '4'),
	   ('Nacional', '@yahoo.com', '43997545000113', '55983480311', 'Nacional', '4'),
	   ('Postao', '@yahoo.com', '23347545000113', '55989380311', 'Ipiranga', '4');
/*
insert into compra (subtotal, desconto, total, dataCompra, numeroNf, idFornec)
values ('3.50', '0.50', '3.00', '2020-01-11', '00001', '1'),
	   ('4.50', '0.50', '4.00', '2020-01-12', '00002', '1'),
	   ('7.50', '0.50', '7.00', '2020-02-15', '00003', '1'),
	   ('10.50', '0.50', '10.00', '2020-02-18', '00004', '1'),
	   ('11.50', '0.50', '11.00', '2020-03-22', '00005', '2'),
	   ('13.50', '0.50', '13.00', '2020-03-24', '00006', '2'),
	   ('13.50', '0.50', '13.00', '2020-04-29', '00007', '2'),
	   ('33.50', '0.50', '33.00', '2020-04-02', '00008', '2'),
	   ('23.50', '0.50', '23.00', '2020-05-03', '00009', '3'),
	   ('53.50', '0.50', '53.00', '2020-05-08', '00010', '3'),
       ('23.50', '0.50', '23.00', '2020-01-11', '00011', '3'),
	   ('32.50', '0.50', '32.00', '2020-01-12', '00012', '3'),
	   ('31.50', '0.50', '31.00', '2020-02-15', '00013', '4'),
	   ('11.50', '0.50', '11.00', '2020-02-18', '00014', '4'),
	   ('1.50', '0.50', '1.00', '2020-03-22', '00015', '4'),
	   ('3.50', '0.50', '3.00', '2020-03-24', '00016', '4'),
	   ('4.50', '0.50', '4.00', '2020-04-29', '00017', '5'),
	   ('7.50', '0.50', '7.00', '2020-04-02', '00018', '5'),
	   ('9.50', '0.50', '9.00', '2020-05-03', '00019', '5'),
	   ('3.50', '0.50', '3.00', '2020-05-08', '00020', '5');

insert into itens_compra (idCompra, idProduto, valorUnit, quantidade, total)
values ('1', '1', '6.40', '3', '6.40'),
	   ('2', '2', '2.30', '2', '2.30'),
	   ('3', '3', '4.40', '5', '4.40'),
	   ('4', '4', '4.50', '7', '4.50'),
	   ('5', '5', '5.00', '9', '5.00'),
	   ('6', '6', '2.80', '5', '2.80'),
	   ('7', '7', '2.20', '4', '2.20'),
	   ('8', '8', '0.90', '5', '0.90'),
	   ('9', '9', '3.90', '2', '3.90'),
	   ('10', '10', '5.80', '2', '5.80'),
       ('11', '10', '36.20', '1', '36.20'),
	   ('12', '1', '6.40', '3', '6.40'),
	   ('13', '2', '2.30', '2', '2.30'),
	   ('14', '3', '4.40', '1', '4.40'),
	   ('15', '4', '4.50', '2', '4.50'),
	   ('16', '5', '5.00', '2', '5.00'),
	   ('17', '6', '2.80', '7', '2.80'),
	   ('18', '7', '2.20', '7', '2.20'),
	   ('19', '8', '0.90', '8', '0.90'),
	   ('20', '9', '3.90', '9', '3.90');
*/
/*Atividade 03*/
/*1.Para excluir todos os produtos que possuem quantidade em estoque zero e nunca foram vendidos.*/

delete from produto
where quantAtual = 0
and idProduto not in(select distinct iv.idProduto
					 from itens_venda iv)
and idProduto not in(select distinct idProduto
					 from itens_compra);
                     
/*2.Para excluir todos os clientes que não compraram da empresa.*/
/*
delete from cliente
where idCliente not in(select distinct v.idCliente
					 from venda v);
*/
/*3.Para reajustar o valor unitário dos produtos que foram vendidos mais de 5 vezes em 10%.*/

update produto set valorVenda = (valorVenda*1.1)
where idProduto in (
    select distinct iv.idProduto
    from itens_venda iv
    group by iv.idProduto
    having sum(iv.quantidade) > 5);

/*4.Para alterar o numero de vendas do cliente (contagem de vendas).*/

update cliente as c 
set c.numeroVendas = (select count(v.idVenda)
					  from venda v
					  where v.idCliente = c.idCliente);

/*5.Para alterar o numero de compras do fornecedor (contagem de compras).*/

update fornecedor as f 
set f.numeroCompras = (select count(c.idCompra)
					   from compra c
					   where c.idFornec = f.idFornec);

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

/*7.Popule a tabela adequadamente (utiliza o comando INSERT seguido de SELECT).*/

insert into cidade(nome,uf)
values ('Santa Maria','RS'),
	   ('Porto Alegre','RS'),
       ('Curitiba','PR'),
       ('São Paulo','SP'),
       ('Minas Gerais','MG');

insert into endereco(logradouro, idCliente)
	select distinct c.endereco, c.idCliente
    from cliente c;

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

/*8.Exclua o atributo ENDERECO da tabela CLIENTE.*/

alter table cliente drop endereco;

/*exemplo, completar numero de vendas de clientes*/

delimiter //
create TRIGGER t_calc_num_vendas_ai
after INSERT ON venda
FOR EACH ROW
BEGIN 
	declare num_vendas int;
    
    select count(v.idVenda) into num_vendas
    from venda v
    where v.idCliente = new.idCliente;
    
    update cliente as c
    set c.numeroVendas = num_vendas
    where c.idCliente = new.idCliente;

END;
//delimiter ;

/*Atividade 04*/
/*1.Que atribua 0 (zero) à quantidade atual dos produtos cujo mesmo campo seja nulo.*/
delimiter //
create TRIGGER t_atrib_zero_prod_bi
before insert on produto
FOR EACH ROW
BEGIN
    if (new.quantAtual is null) or (new.quantAtual < 0) then
        set new.quantAtual = 0;
    end if;
END;
//delimiter ;

/*2.Que evite a inserção de valores redundantes (campos significativos).*/
delimiter //
create TRIGGER t_verif_nome_marca_bi
before insert on marca
FOR EACH ROW
BEGIN
    declare msg varchar(150);
    
    if exists (select distinct m.idMarca
                from marca m
                where m.nome = new.nome) then
            set msg = concat('Marca já foi inserida anteriormente: ', new.nome);
            signal sqlstate '45000' set message_text = msg;
    end if;
    
END;
//delimiter ;

/*3.Que insira um registro na tabela histórico toda vez que um produto seja inserido ou alterado.*/

delimiter //
create TRIGGER t_insert_prod_historico_ai
after insert on produto
FOR EACH ROW
BEGIN
	
    insert into historico_estoque (idProduto,valorUnit,quantidade,total,operacao,data_operacao)
    values (new.idProduto, new.valorVenda, new.quantAtual, new.valorVenda*new.quantAtual, 'I',current_date());
    
END;
//delimiter ;

delimiter //
create TRIGGER t_insert_prod_historico_au
after update on produto
FOR EACH ROW
BEGIN
	declare quant decimal(15,2);
    
    set quant = abs(old.quantAtual - new.quantAtual);
	
    insert into historico_estoque (idProduto,valorUnit,quantidade,total,operacao,data_operacao)
    values (new.idProduto, new.valorVenda, quant, new.valorVenda*quant, 'U',current_date());
    
END;
//delimiter ;

delimiter //
create TRIGGER t_insert_prod_historico_ad
after delete on produto
FOR EACH ROW
BEGIN
	
    insert into historico_estoque (idProduto,valorUnit,quantidade,total,operacao,data_operacao)
    values (old.idProduto, old.valorVenda, old.quantAtual, old.valorVenda*old.quantAtual, 'D',current_date());
    
END;
//delimiter ;

/*4.Que ao inserir um ITENsVENDA, busque o valor do produto (tabela PRODUTOS) e atribua ao valor unitário de ITENSVENDA*/
/*venda*/

delimiter //
create TRIGGER t_busca_vlr_produto_bi_venda
before insert on itens_venda
FOR EACH ROW
BEGIN
	declare vlr decimal(15,2);
    
    select p.valorVenda into vlr
    from produto p
    where p.idProduto = new.idProduto;
    
    set new.valorUnit = vlr;
    set new.total = vlr * new.quantidade;
END;
//delimiter ;

/*compra*/
delimiter //
create TRIGGER t_busca_vlr_produto_bi_compra
before insert on itens_compra
FOR EACH ROW
BEGIN
	declare vlr decimal(15,2);
    
    select p.valorVenda into vlr
    from produto p
    where p.idProduto = new.idProduto;
    
    set new.valorUnit = (vlr-(vlr/4)); /*ajustando valor*/
    set new.total = (vlr-(vlr/4)) * new.quantidade; /*ajustando valor*/
END;
//delimiter ;

/*Atividade 05*/
/*4.Crie os campos necessários (faltantes).*/

alter table compra
add finalizada boolean default false;

alter table venda
add finalizada boolean default false;

/*1.Para atualizar o subtotal de uma venda ou compra toda vez que um item seja inserido, atualizado ou excluído.*/

/*venda insert*/
delimiter // 
create TRIGGER calc_subtotal_itens_venda_ai
after INSERT ON itens_venda
FOR EACH ROW
BEGIN 
    declare subt decimal(15,2);
    
    select sum(iv.total) into subt
    from itens_venda iv
    where iv.idVenda = new.idVenda;
    
    update venda as v
    set v.subTotal = subt,
		v.total = subt-(subt*v.desconto)/100
    where v.idVenda = new.idVenda;
END;
//delimiter ;

/*venda delete*/
delimiter // 
create TRIGGER calc_subtotal_itens_venda_ad
after DELETE ON itens_venda
FOR EACH ROW
BEGIN 
    declare subt decimal(15,2);
    
    select sum(iv.total) into subt
    from itens_venda iv
    where iv.idVenda = old.idVenda;
    
    update venda as v
    set v.subTotal = subt,
		v.total = subt-(subt*v.desconto)/100
    where v.idVenda = old.idVenda;
END;
//delimiter ;

/*venda update*/
delimiter // 
create TRIGGER calc_subtotal_itens_venda_au
after UPDATE ON itens_venda
FOR EACH ROW
BEGIN 
    declare subt decimal(15,2);
    
    select sum(iv.total) into subt
    from itens_venda iv
    where iv.idVenda = new.idVenda;
    
    update venda as v
    set v.subTotal = subt,
		v.total = subt-(subt*v.desconto)/100
    where v.idVenda = new.idVenda;
END;
//delimiter ;

/*compra insert*/
delimiter // 
create TRIGGER calc_subtotal_itens_compra_ai
after INSERT ON itens_compra
FOR EACH ROW
BEGIN 
    declare subt decimal(15,2);
    
    select sum(ic.total) into subt
    from itens_compra ic
    where ic.idCompra = new.idCompra;
    
    update compra as c
    set c.subTotal = subt,
		c.total = subt-(subt*c.desconto)/100
    where c.idCompra = new.idCompra;
END;
//delimiter ;

/*compra delete*/
delimiter // 
create TRIGGER calc_subtotal_itens_compra_ad
after DELETE ON itens_compra
FOR EACH ROW
BEGIN 
    declare subt decimal(15,2);
    
    select sum(ic.total) into subt
    from itens_compra ic
    where ic.idCompra = old.idCompra;
    
    update compra as c
    set c.subTotal = subt,
		c.total = subt-(subt*c.desconto)/100
    where c.idCompra = old.idCompra;
END;
//delimiter ;

/*compra update*/
delimiter // 
create TRIGGER calc_subtotal_itens_compra_au
after UPDATE ON itens_compra
FOR EACH ROW
BEGIN 
    declare subt decimal(15,2);
    
    select sum(ic.total) into subt
    from itens_compra ic
    where ic.idCompra = new.idCompra;
    
    update compra as c
    set c.subTotal = subt,
		c.total = subt-(subt*c.desconto)/100
    where c.idCompra = new.idCompra;
END;
//delimiter ;

/*2.Para atualizar o número de compras ou vendas sempre após finalizar as mesmas.*/
/*alterar na tabela cliente*/
delimiter //
create TRIGGER t_calcNV_venda_au
after UPDATE on venda
FOR EACH ROW
BEGIN
	declare nv int;
    
    if new.finalizada then
		select count(v.idVenda) into nv
        from venda v
        where v.idCliente = new.idCliente
        and v.finalizada;
        
        update cliente as c
        set c.numeroVendas = nv
        where c.idCliente = new.idCliente;
	end if;
END;
//delimiter ;

/*alterando tabela fornecedor*/
delimiter //
create TRIGGER t_calcNV_compra_au
after UPDATE on compra
FOR EACH ROW
BEGIN
	declare nc int;
    
    if new.finalizada then
		select count(f.idCompra) into nc
        from fornecedor f
        where f.idFornec = new.idFornec
        and f.finalizada;
        
        update fornecedor as f
        set f.numeroVendas = nv
        where f.idFornec = new.idFornec;
	end if;
END;
//delimiter ;

/*3.Para atualizar o estoque toda vez que uma compra ou venda for finalizada.*/

delimiter // 
create trigger t_atualiza_estoque_venda_au
after update on venda
for each row
begin
	if new.finalizada then
		update produto p set p.quantAtual = p.quantAtual - (
			select iv.quantidade
			from itens_venda iv
			where iv.idVenda = new.idVenda and iv.idProduto = p.idProduto
		) where p.idProduto = (select iv.idProduto from itens_venda iv where iv.idVenda = new.idVenda and iv.idProduto = p.idProduto);
	end if;
end;
//delimiter ;

/*5.Crie trigger(s) para situações semelhantes.*/

/*impedir a alteração/exclusão de uma venda/compra ja finalizada*/
/*para venda alteraçao*/
delimiter //
create TRIGGER t_impede_alt_venda_bu
before UPDATE on venda
FOR EACH ROW
BEGIN
	declare msg varchar(100);
    if old.finalizada then
		set msg = concat('A venda: NF ', old.numeroNF, 'já foi finalizada e não pode ser alterada!');
        signal sqlstate '45000' set message_text = msg;
	END IF;
END;
//delimiter ;

/*para venda exclusão*/
delimiter //
create TRIGGER t_impede_del_venda_bd
before DELETE on venda
FOR EACH ROW
BEGIN
	declare msg varchar(100);
    if old.finalizada then
		set msg = concat('A venda: NF ', old.numeroNF, 'já foi finalizada e não pode ser excluida!');
        signal sqlstate '45000' set message_text = msg;
	END IF;
END;
//delimiter ;

/*para compra alteraçao*/
delimiter //
create TRIGGER t_impede_alt_compra_bu
before UPDATE on compra
FOR EACH ROW
BEGIN
	declare msg varchar(100);
    if old.finalizada then
		set msg = concat('A compra: NF ', old.numeroNF, 'já foi finalizada e não pode ser alterada!');
        signal sqlstate '45000' set message_text = msg;
	END IF;
END;
//delimiter ;

/*para compra exclusão*/
delimiter //
create TRIGGER t_impede_del_compra_bd
before DELETE on compra
FOR EACH ROW
BEGIN
	declare msg varchar(100);
    if old.finalizada then
		set msg = concat('A compra: NF ', old.numeroNF, 'já foi finalizada e não pode ser excluida!');
        signal sqlstate '45000' set message_text = msg;
	END IF;
END;
//delimiter ;

/*para atribuir falso no finalizado depois de inserir em venda*/
delimiter //
	create TRIGGER t_atribFalse_venda_bi
    before INSERT on venda
    FOR EACH ROW
    BEGIN
		set new.finalizada=false;
	END;
//delimiter ;

/*para atribuir flaso no finalizado depois de inserir em compra*/
delimiter //
	create TRIGGER t_atribFalse_compra_bi
    before INSERT on compra
    FOR EACH ROW
    BEGIN
		set new.finalizada=false;
	END;
//delimiter ;

/*TESTE 01 - Faça um TRIGGER que dispare antes de inserir uma nova venda, busque o número de vendas do cliente e calcule o desconto conforme a tabela:*/
/*Vendas Desconto*/
delimiter // 
create TRIGGER calc_desc_inserir_venda
before INSERT ON venda
FOR EACH ROW
BEGIN 
	declare nVendas int;
    
		select numeroVendas into nVendas
		from cliente c
		where c.idCliente = new.idCliente;
        
    if (nVendas >= 2 and nVendas <= 9) then
        set new.desconto = 5;
	elseif (nVendas >= 10 and nVendas <= 24) then
        set new.desconto  = 10;
    elseif (nVendas >= 25 and nVendas <= 36) then
        set new.desconto = 15;
    elseif (nVendas > 36) then
        set new.desconto = 20;
    else
        set new.desconto = 0;
    end if;

END;
//delimiter ;

/*Compras Desconto*/
delimiter // 
create TRIGGER calc_desc_inserir_compra
before INSERT ON compra
FOR EACH ROW
BEGIN 
	declare nCompras int;
    
		select numeroCompras into nCompras
		from fornecedor f
		where f.idFornec = new.idFornec;
        
    if (nCompras >= 2 and nCompras <= 9) then
        set new.desconto = 5;
	elseif (nCompras >= 10 and nCompras <= 24) then
        set new.desconto  = 10;
    elseif (nCompras >= 25 and nCompras <= 36) then
        set new.desconto = 15;
    elseif (nCompras > 36) then
        set new.desconto = 20;
    else
        set new.desconto = 0;
    end if;

END;
//delimiter ;

/*Atualizando as vendas*/

insert into venda (dataVenda, numeroNF, idCliente)
values ('2020-02-26', '00001', '1'),
	   ('2020-02-15', '00002', '1'),
	   ('2020-03-25', '00003', '1'),
	   ('2020-03-15', '00004', '1'),
	   ('2020-04-22', '00005', '2'),
	   ('2020-04-11', '00006', '2'),
	   ('2020-05-02', '00007', '2'),
	   ('2020-05-01', '00008', '2'),
	   ('2020-06-09', '00009', '3'),
	   ('2020-06-05', '00010', '3'),
       ('2020-07-26', '00011', '3'),
	   ('2020-07-15', '00012', '3'),
	   ('2020-08-25', '00013', '4'),
	   ('2020-08-15', '00014', '4'),
	   ('2020-09-22', '00015', '4'),
	   ('2020-09-11', '00016', '4'),
	   ('2020-10-02', '00017', '5'),
	   ('2020-10-01', '00018', '5'),
	   ('2020-11-09', '00019', '5'),
	   ('2020-11-05', '00020', '5');
       
insert into itens_venda (idVenda, idProduto, quantidade)
values ('1', '1','2'),
	   ('2', '2','2'),
	   ('3', '3','2'),
	   ('4', '4','2'),
	   ('5', '5','2'),
	   ('6', '6','2'),
	   ('7', '7','2'),
	   ('8', '8','2'),
	   ('9', '9','2' ),
	   ('10', '10','2'),
       ('11', '1','2'),
	   ('12', '2','2'),
	   ('13', '3','2'),
	   ('14', '4','2'),
	   ('15', '5','2'),
	   ('16', '6','2'),
	   ('17', '7','2'),
	   ('18', '8','2'),
	   ('19', '9','2'),
	   ('20', '10','2');

/*Atualizando compras*/

insert into compra (dataCompra, numeroNf, idFornec)
values ('2020-01-11', '00001', '1'),
	   ('2020-01-12', '00002', '1'),
	   ('2020-02-15', '00003', '1'),
	   ('2020-02-18', '00004', '1'),
	   ('2020-03-22', '00005', '2'),
	   ('2020-03-24', '00006', '2'),
	   ('2020-04-29', '00007', '2'),
	   ('2020-04-02', '00008', '2'),
	   ('2020-05-03', '00009', '3'),
	   ('2020-05-08', '00010', '3'),
       ('2020-01-11', '00011', '3'),
	   ('2020-01-12', '00012', '3'),
	   ('2020-02-15', '00013', '4'),
	   ('2020-02-18', '00014', '4'),
	   ('2020-03-22', '00015', '4'),
	   ('2020-03-24', '00016', '4'),
	   ('2020-04-29', '00017', '5'),
	   ('2020-04-02', '00018', '5'),
	   ('2020-05-03', '00019', '5'),
	   ('2020-05-08', '00020', '5');

insert into itens_compra (idCompra, idProduto, quantidade)
values ('1','1','2'),
	   ('2','2','2'),
	   ('3','3','2'),
	   ('4','4','2'),
	   ('5','5','2'),
	   ('6','6','2'),
	   ('7','7','2'),
	   ('8','8','2'),
	   ('9','9','2'),
	   ('10','10','2'),
       ('11','10','2'),
	   ('12','1','2'),
	   ('13','2','2'),
	   ('14','3','2'),
	   ('15','4','2'),
	   ('16','5','2'),
	   ('17','6','2'),
	   ('18','7','2'),
	   ('19','8','2'),
	   ('20','9','2');

/*Atividade 04*/
/*exemplo, completar numero de vendas de clientes
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

insert into venda(numeroNF, idCliente)
values('123','1');

select * from cliente;*/

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

/*Testando o exercicio 1*/
insert into produto (nome, quantAtual, idMarca, idTipo)
values ('test', -5, 1, 1);

/*select * from produto;*/

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

/*Testando exercicio 2*/

insert into marca(nome)
values ('levs');

/*select * from marca;*/

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

/*Testando exercicio 3*/

alter table historico_estoque add operacao char(1),
add data_operacao date;

update produto
set valorVenda = valorVenda*1.1
where nome='TESTEPROD04';

delete from produto
where nome = 'TESTEPROD09';

insert into produto (nome, quantAtual, quantMinima, valorVenda, idMarca, idTipo)
values ('TESTEPROD09', '10', '5', '10', '1', '1');

/*select * from produto;
select * from historico_estoque;*/

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
    
    set new.valorUnit = vlr;
    set new.total = vlr * new.quantidade;
END;
//delimiter ;

/*Testando exercicio 4*/

/*select * from produto;
select * from venda;
select * from itens_venda;*/

insert into itens_venda(idVenda, idProduto, quantidade)
values ('6','1','3');
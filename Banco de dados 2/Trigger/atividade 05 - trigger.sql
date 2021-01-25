/*Atividade 05*/
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

/*testando venda*/

insert into itens_venda (quantidade, idVenda, idProduto)
values ('2','23','1');

delete from itens_venda
where idVenda = 20
and idProduto = 1;

update itens_venda
set total = 20
where idVenda = 20;

select * from venda;
select * from itens_venda;
select * from produto;

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

/*testando compra*/

insert into itens_compra (quantidade, idCompra, idProduto)
values ('2','20','2');

delete from itens_compra
where idCompra = 20
and idProduto = 2;

update itens_compra
set total = 10
where idCompra = 20;

select * from itens_compra;
select * from produto;
select * from compra;

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

/*testando tabela cliente*/
select * from venda;
select * from cliente;

update cliente
set numeroVendas = 0;

update venda
set dataVenda = '2020-09-22',
	finalizada = true
where idVenda = 6;

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

/*testando tabela fornecedor*/
select * from compra;
select * from fornecedor;

update fornecedor
set numeroVendas = 0;

update compra
set dataCompra = '2020-09-22',
	finalizada = true
where idCompra = 6;

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

/*testando a compra ou venda*/

/*4.Crie os campos necessários (faltantes).*/

alter table compra
add finalizada boolean default false;

alter table venda
add finalizada boolean default false;

select * from compra;
select * from venda;

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

/*testando venda*/
update venda
set dataVenda = '2020-09-21'
where idVenda = 6;

insert into itens_venda(idVenda, idProduto, quantidade)
values('6','3','4');

select * from venda;
select * from produto;
select * from itens_venda;

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

/*testando compra*/
delete from venda
where idVenda = 6;

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


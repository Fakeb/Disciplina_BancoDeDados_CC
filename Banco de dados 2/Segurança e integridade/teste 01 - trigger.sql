/*Faça um TRIGGER que dispare antes de inserir uma nova venda, busque o número de vendas do cliente e calcule o desconto conforme a tabela:*/
/*Testando*/
delimiter // 
create TRIGGER calc_desc_inserir_venda
before INSERT ON venda
FOR EACH ROW
BEGIN 
	declare nVendas int;
    
		select numeroVendas into nVendas
		from cliente c
		where c.idCliente = new.idCliente;
        
    if (nVendas >= 2 and nVendas <= 9) and (new.desconto != 5) then
        set new.desconto = 5;
	elseif (nVendas >= 10 and nVendas <= 24) and (new.desconto != 10) then
        set new.desconto  = 10;
    elseif (nVendas >= 25 and nVendas <= 36) and (new.desconto != 15) then
        set new.desconto = 15;
    elseif (nVendas > 36) and (new.desconto != 20)then
        set new.desconto = 20;
    else
        set new.desconto = 0;
    end if;

END;
//delimiter ;

/*Vendas*/
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
/*Compras*/
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

drop trigger calc_desc_inserir_venda;

insert into venda (dataVenda, numeroNF, subTotal, idCliente)
values ('2020-11-09','00003','10','1');

insert into itens_venda (quantidade, idVenda, idProduto)
values ('2','11','1');

select * from venda;
select * from cliente;
select * from itens_venda;

update venda
set finalizada = false
where idVenda = 1;

delete from venda
where idVenda = 1;

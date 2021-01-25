/*Atividade 07*/
/*1.Criar triggers para calcular o valor total do produto após inserir/atualizar um item da compra (caso a compra não tenha sido finalizada). Calcular o subtotal e total da compra.*/
/*questao 4 da atividade 04, questao 1 da atividade 05*/

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

/*2.Criar triggers para calcular o valor total do produto após inserir/atualizar um item da venda (caso a venda não tenha sido finalizada). Calcular o subtotal e total da venda.*/

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

/*3.Criar uma Visão que mostre a data da venda, número da NF, subtotal, desconto, total e o nome do cliente para as vendas do ano de 2020*/

create VIEW show_venda_2020 (dataVenda, NF, subtotal, desconto, total, nomeCliente)
as
select v.dataVenda, v.numeroNF, v.subtotal, v.desconto, v.total, c.nome
from venda v
inner join cliente c on v.idCliente = c.idCliente
where year(v.dataVenda) = 2020;

select * from show_venda_2020;

/*4.Fazer uma stored procedure que receba como parâmetro de entrada o código do cliente e calcule o número de vendas que o mesmo realizou, efetuando a atualização do número de vendas (tabela CLIENTE).*/

delimiter //
create PROCEDURE sp_show_codigo_cliente(in idCli int)
BEGIN
    
    declare contagem int;
    
    select count(idCli) into contagem
	from venda v
	inner join cliente c on v.idCliente = c.idCliente
	where v.idCliente = idCli;
    
    update cliente c 
    set c.numeroVendas = contagem
    where c.idCliente = idCli;
    
END;
//delimiter ;

call sp_show_codigo_cliente(3);

/*5.Criar uma visão que mostre todos os produtos vendidos de uma marca específica nos 2 primeiros meses do 2º semestre do ano de 2020.*/

create VIEW show_venda_produtos (nomeProduto, Marca)
as
select p.nome, m.nome
from itens_venda iv
inner join venda v on iv.idVenda = v.idVenda
inner join produto p on iv.idProduto = p.idProduto
inner join marca m on p.idMarca = m.idMarca
where year(v.dataVenda) = 2020 and MONTH(v.dataVenda) between 7 and 8 and m.nome = "Piracanjuba"
group by p.idProduto
order by 1 desc;

select * from show_venda_produtos;

/*6.Elaborar uma Stored Procedure que receba como parâmetro TODOS os dados de um PRODUTO (exceto as IDs), juntamente com o nome da marca e o nome do tipo.*/
/*
- Verificar se a MARCA e TIPO existem em suas respectivas tabelas e retornar suas IDs.
- Caso não existam, inserir na respectiva tabela e recuperar a ID.
- Inserir os dados completos do PRODUTO.
*/

delimiter //
create PROCEDURE sp_insereProduto (in pnome varchar(60), in pquant_minima decimal(15,2), 
								   in pquant_atual decimal(15,2), in pvalor_venda decimal(15,2),
								   in pmarca varchar(60), in ptipo varchar(60))
begin
	declare idm int default 0;
	declare idt int default 0;
    declare msg varchar(60);
    
    select m.idMarca into idm
	from marca m
    where m.nome = pmarca
    limit 1;
    
    select t.idTipo into idt
    from tipo t
    where t.nome = ptipo
    limit 1;
    
    if (idm=0) or (idm is null) then
		insert into marca(nome)
        values (pmarca);
        
	select last_insert_id() into idm;
	end if;
        
	if (idt = 0) or (idt is null) then
		insert into tipo(nome)
		values (ptipo);
            
	select last_insert_id() into idt;
	end if;
    
    if exists (select p.idProduto
				from produto p
				where p.nome = pnome
                and p.idMarca = idm
                and p.idTipo = idt) then 
    set msg = contat('produto ja existe com o nome:',pnome,' e marca:', pmarca, ' e tipo:', ptipo);
    signal sqlstate '45000' set message_text = msg;
    else
		insert into produto (nome, quantMinima, quantAtual, valorVenda, idTipo, idMarca)
		values (pnome, pquant_minima, pquant_atual, pvalor_venda, idt,idm);
	end if;
end;
//delimiter ;

drop PROCEDURE sp_insereProduto;

select * from produto;
select * from marca;
select * from tipo;

call sp_insereProduto('Laka',30,30,8,'Lacta','Chocolate');


/*Atividade 06*/
/*Criar VIEW:*/
/*1 - Que mostre o somatório do total em vendas, agrupado por cliente, no ano de 2020.*/
create VIEW show_sum_total (Nome, Total)
as
select c.nome, sum(v.total)
from venda v
inner join cliente c on v.idCliente = c.idCliente
where year(v.dataVenda) = 2020
group by v.idCliente
order by 2 desc;

select * from show_sum_total;

/*2 - Que mostre os 5 produtos mais vendidos no mês de setembro/2020. Agrupar pelo nome do produto.*/

create VIEW show_top5_mes_produtos (Produto, Quantidade)
as
select p.nome, sum(iv.quantidade)
from itens_venda iv
inner join produto p on iv.idProduto = p.idProduto
inner join venda v on iv.idVenda = v.idVenda
where year (v.dataVenda) = 2020
and month(v.dataVenda) = 9
group by p.nome
order by 2 desc
limit 5;

select * from show_top5_mes_produtos;

/*Fazer Stored Procedure:*/
/*3 - Que implemente o exercício 1, com passagem de parâmetros referente ao período.*/

delimiter //
create PROCEDURE sp_show_sum_total(in ano int)
BEGIN
	select c.nome as Nome, sum(v.total) as SP_Total
    from venda v
    inner join cliente c on v.idCliente = c.idCliente
    where year (v.dataVenda) = ano
    group by v.idCliente
    order by 2 desc;
END;
//delimiter ;

call sp_show_sum_total(2020);

/*4 - Que implemente o exercício 2, com passagem de parâmetros referente ao período.*/

delimiter //
create PROCEDURE sp_show_top5_mes_produtos(in ano int, in mes int)
BEGIN
	select p.nome as Nome, sum(iv.quantidade) as SP_Total
    from itens_venda iv
    inner join produto p on iv.idProduto = p.idProduto
    inner join venda v on iv.idVenda = v.idVenda
    where year (v.dataVenda) = ano
    and month (v.dataVenda) = mes
    group by p.nome
    order by 2 desc
    limit 5;

END;
//delimiter ;

call sp_show_top5_mes_produtos(2020,9);

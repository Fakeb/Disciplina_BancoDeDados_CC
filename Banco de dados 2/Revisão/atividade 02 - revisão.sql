/*Atividade 02*/     
/*1.Que mostre o somatório dos totais em produtos vendidos no ano de 2020, cuja marca seja "Marca01" e o tipo seja o "Tipo01". Agrupe pelo nome do produto.*/
		 
select p.nome, sum(iv.quantidade) as 'Somatório'
from itens_venda iv
inner join venda v on iv.idVenda = v.idVenda
inner join produto p on iv.idProduto = p.idProduto
inner join marca m on p.idMarca = m.idMarca
inner join tipo t on p.idTipo = t.idTipo
where (m.nome='Coca-Cola') and (t.nome='Beltrame')
and year (v.dataVenda)=2020
group by p.nome;

/*2.Que mostre todos os produtos comprados do "Fornecedor01" e que tenham sido vendidos no mês de agosto de 2020.*/

select distinct p.nome
from itens_compra ic
inner join compra c on c.idCompra = ic.idCompra
inner join fornecedor f on c.idFornec = f.idFornec
inner join produto p on p.idProduto = ic.idProduto
where f.razaoSocial like 'Random' and 
year(c.dataCompra) = 2020 and month(c.dataCompra) = 02;

/*3.Que mostre os 5 clientes que mais compraram na loja, o número de produtos que comprou, seu total e a média comprada.*/

select c.nome, sum(iv.quantidade) numeroProdutos, round(sum(iv.quantidade*iv.valorUnit),2) totalVendido, round(avg(iv.quantidade*iv.valorUnit),2) mediaVendida
from itens_venda iv
inner join venda v on iv.idVenda = v.idVenda
inner join cliente c on v.idCliente = c.idCliente
group by c.nome
order by c.numeroVendas desc
limit 5;
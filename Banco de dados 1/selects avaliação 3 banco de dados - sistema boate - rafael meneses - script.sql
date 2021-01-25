/*Selects avaliação 3 banco de dados - sistema boate - rafael meneses*/

use sistema_boate;

/*1: Exibir nome e valor da tabela produto onde os produtos tem valor superior ou igual a 50, ordenando por maior valor*/

select nome, valor from PRODUTO
where valor >= 50
order by valor desc;

/*2: Exibir a quantidade de compra de produtos de cada cliente e seus nomes, ordenando por mais compras*/

select nome, SUM(quantidadeCompras) as 'TotalCompraProdutos'
from PESSOA p 
join COMPRAS_PESSOA_BAR v on v.idPessoa = p.idPessoa
group by nome
order by TotalCompraProdutos desc;

/*3: Exibir o nome dos produtos e suas soma das vendas do dia '2020-06-26', ordenando pelo maior valor*/

select nome, SUM(quantidadeVendas*valor) as 'valor'
from PRODUTO p
join VENDAS_PESSOA_BAR v on v.idProduto = p.idProduto
where data = '2020-06-26'
group by nome
order by valor desc;

/*4: Exibir o nome dos produtos movimentados, suas quantidades e quais os bares, de todas festas*/

select b.nome, p.nome, SUM(quantidadeProduto) as 'total'
from MOVIMENTACAO_BAR_PRODUTO mov
join BAR b on b.idBar = mov.idBar
join PRODUTO p on p.idProduto = mov.idProduto
group by p.nome, b.nome;

/*5: Exibir o nome dos funcionarios, total de vendas e ordernar por maior vendas*/

select pe.nome as Funcionario, SUM(quantidadeVendas) as 'Total_Vendas'
from VENDAS_PESSOA_BAR vendas
join PESSOA pe on pe.idPessoa = vendas.idPessoa
group by pe.nome
order by Total_Vendas DESC;

/*6: Exibir Mostra todos os clientes de 'santa maria'*/

select pe.nome, c.nome
from PESSOA pe
join ENDERECO e on e.idEndereco = pe.idEndereco
join CIDADE c on c.idCidade = e.idCidade
where c.nome = 'Santa Maria'
order by pe.nome ASC;

/*7: Exibir o nome todos os eventos que a boate 'Aruna Club' realizou , suas despesas e o lucro da festa*/

select ev.nome, v.data, ev.gastosEvento, SUM(v.quantidadeVendas*p.valor) as 'Lucro'
from PRODUTO p
join VENDAS_PESSOA_BAR v on v.idProduto = p.idProduto
join EVENTO ev on ev.data = v.data
where v.data in ('2020-06-19','2020-06-26', '2020-07-03')
group by v.data
order by valor DESC;

/*8: Exibir o fornecer que menos forneceu produtos e quantos produtos forneceu*/

select f.nome, SUM(quantidadeProduto) as 'Quantidade'
from FORNECEDOR f
join NOTA_FORNECEDOR_BOATE nota on nota.idFornecedor = f.idFornecedor
group by f.nome
order by Quantidade ASC
limit 1;

/*9: Exibir o bar que mais teve movimentação de bebidas e quantas foram*/

select b.nome, SUM(quantidadeProduto) as 'Quantidade'
from BAR b
join MOVIMENTACAO_BAR_PRODUTO mov on mov.idBar = b.idBar
group by b.nome
order by Quantidade DESC
limit 1;

/*10: Exibir o nome do funcionário que teve o maior valor de vendas, exibindo o total de itens vendidos e o valor total.*/

select 
	Resultado.Funcionario,
    SUM(Resultado.total) as Total,
    SUM(Resultado.TotalItens) as TotalItens
from
(select	pe.nome as Funcionario,
	vendas.quantidadeVendas * p.valor as total,
    vendas.quantidadeVendas as TotalItens,
    p.nome as produto
from PESSOA pe
join VENDAS_PESSOA_BAR vendas on pe.idPessoa = vendas.idPessoa 
join PRODUTO p on vendas.idProduto = p.idProduto) as Resultado
group by resultado.Funcionario
order by Total DESC
limit 1;

# Rafael Meneses
# Atividade 12
#1 - Que mostre o número de filmes locados e o total. Agrupe por cliente.
select c.nome as 'Nome do Cliente', sum(l.subTotal+l.multa-l.desconto) as 'Total em Locações (R$)' ,
	(select count(lf.idLocacao)
    from locacao_filme lf
    inner join locacao l2 on lf.idLocacao = l2.idLocacao
    where l2.idCliente = l.idCliente
    ) as 'Numero de filmes locados'
from locacao l
inner join cliente c on l.idCliente = c.idCliente
group by c.nome;

#2 - Que mostre os 3 endereços que menos efetuaram locações do gênero "COMÉDIA" com o ator "CUBA JR." no ano de 2020.
select c.endereco, count(lf.idLocacao)
from locacao_filme lf
inner join locacao l on lf.idLocacao = l.idLocacao
inner join cliente c on l.idCliente = c.idCliente
where l.dataLoc between '2020-01-01' and '2020-12-31'
and lf.idFilme in (select distinct fa.idFilme
					from filme_ator fa
					inner join filme f on fa.idFilme = f.idFilme
                    inner join genero g on f.idGenero = g.idGenero
                    inner join ator a on fa.idAtor = a.idAtor
                    where g.nome = 'Aventura'
                    and fa.ator = 0
                    and a.nome = 'Johnny Depp'
                    )
group by c.endereco
order by 2 desc
limit 3;

#3 - Que mostre a média e o total (R$) em filmes locados, agrupado pela categoria.
select c.nome as 'Categoria', avg(lf.valor) as 'Média', sum(lf.valor) as 'Total R$'
from locacao_filme lf
inner join filme f on f.idFilme = lf.idFilme
inner join categoria c on c.idCategoria = f.idCategoria
group by c.nome;

#4 - Que mostre a listagem de clientes da locadora, o último gênero locado e a última data em que locou.
select c.nome as 'Nome do Cliente',
(select g.nome
from locacao_filme lf
inner join locacao l on lf.idLocacao = l.idLocacao
inner join filme f on lf.idFilme = f.idFilme
inner join genero g on f.idGenero = g.idGenero
where l.idLocacao = c.idCliente
order by l.dataLoc desc limit 1) as "Último gênero",
(select max(l.dataLoc) from locacao l where l.idCliente = c.idCliente) "Data locação"
from cliente c
order by c.nome;

#5 - Que mostre a quantidade de filmes locados agrupados por gênero.
select nome as "Gênero", count(lf.idLocacao) as "Quantidade"
from genero g
inner join filme f on g.idGenero = f.idGenero
inner join locacao_filme lf on f.idFilme = lf.idFilme
inner join locacao l on lf.idLocacao = l.idLocacao
where lf.idLocacao = l.idLocacao
group by nome;
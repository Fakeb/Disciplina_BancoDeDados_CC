#Rafael Meneses
#atividade 14

#1 Que mostre todos os clientes que locaram filmes com valor maior ou igual ao valor médio das categoria. Mostrar também o número de Filmes locados por eles.

select c.nome, count(lf.idFilme) numero_filmes
from locacao_filme lf
inner join locacao l on lf.idLocacao = l.idLocacao
inner join cliente c on l.idCliente = c.idCliente
where lf.valor >= (select avg (ca.valor) from categoria ca)
group by c.nome;

#2 Que mostre a lista de gêneros, juntamente com o último filme locado de cada gênero.

select g.nome as 'Gênero', (select f.titulo 
    from locacao_filme lf
    inner join locacao l on l.idLocacao = lf.idLocacao
    inner join filme f on lf.idFilme = f.idFilme
    where f.idGenero = g.idGenero
    order by l.dataLoc desc
    limit 1) as 'Filme'
from genero g
order by g.nome;

#3 Melhore o exercício 2, trazendo os filmes locados em um determinado período.

select distinct g.nome as 'Gênero', (select f.titulo 
    from locacao_filme lf
    inner join locacao l on l.idLocacao = lf.idLocacao
    inner join filme f on lf.idFilme = f.idFilme
    where f.idGenero =g.idGenero and l.dataLoc between '2020-03-01' and '2020-03-31'
    order by l.dataLoc desc
    limit 1) as 'Filme'
from genero g
inner join filme f2 on f2.idGenero = g.idGenero
inner join locacao_filme lf2 on lf2.idFilme = f2.idFilme
inner join locacao l2 on l2.idLocacao = lf2.idLocacao
where l2.dataLoc between '2020-03-01' and '2020-03-31'
order by g.nome;

#4 Que mostre todos os filmes já locados e a quantidade de vezes que cada um foi locado.

select f.titulo as 'Título', count(lf.idFilme) as 'Quantidade'
from filme f
inner join locacao_filme lf on lf.idFilme = f.idFilme
group by f.titulo;

#5 Que mostre os 2 filmes mais locados no ano de 2020.

select f.titulo as Filme, count(lf.idFilme) as Quantidade, l.dataLoc as Data
from filme f
inner join locacao_filme lf on lf.idFilme = f.idFilme
inner join locacao l on l.idLocacao = lf.idLocacao
where year(l.dataLoc) = '2020'
group by f.titulo
order by quantidade desc
limit 2;

#6 Que mostre o Gênero mais locado e o ator que mais atuou em filmes desse Gênero.

select g.nome as 'Gênero', count(f2.idGenero) as 'Quantidade', (select a.nome
    from filme_ator fa
    inner join filme f on f.idFilme = fa.idFilme
    inner join ator a on a.idAtor = fa.idAtor
    where f.idGenero = g.idGenero and fa.ator = 1
    group by a.nome
    having count(fa.idAtor)>1
    order by count(fa.idAtor) desc
    limit 1
    ) as 'Ator'
from locacao_filme lf
inner join filme f2 on f2.idFilme = lf.idFilme
inner join genero g on g.idGenero = f2.idGenero
inner join locacao l on l.idLocacao = lf.idLocacao
group by g.nome
order by quantidade desc
limit 1;
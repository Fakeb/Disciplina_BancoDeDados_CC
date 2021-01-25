#Rafael Meneses
#Atividade 11
#1 - Que mostre todos os filmes da locadora, incluindo seu gênero, categoria e valor.
SELECT f.titulo Titulo, g.nome Genero, c.nome Categoria, c.valor Valor from filme f 
join genero g on f.idFilme = g.idGenero
join categoria c on f.idFilme = c.idCategoria
order by f.titulo;

#2 - Que mostre todos os filmes (sem repetição) locados.
SELECT DISTINCT f.titulo Titulo from filme f 
join locacao_filme lf on f.idFilme = lf.idfilme 
order by f.titulo;

#3 - Que mostre todos os filmes (sem repetição) locados no ano de 2020 cujo diretor seja 'Fulano'.
select distinct f.titulo from locacao_filme lf # buscar os titulos que nao se repetem, monta uma tabela lf
inner join locacao l on lf.idLocacao =l.idLocacao # juntar as linhas com os ids iguais
inner join filme f on lf.idFilme=f.idFilme 
inner join filme_ator fa on f.idFilme=fa.idFilme
inner join ator a on fa.idAtor=a.idAtor
where l.dataLoc between '2020-01-01' and '2020-12-31' #where year(l.dataLoc)=2020 where month(l.dataLoc)=05
and fa.diretor=1
and a.nome='Johnny Depp'
order by f.titulo;
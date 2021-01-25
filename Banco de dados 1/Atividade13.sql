#atividade 13 - Rafael Meneses

#1 - Reajustar as categorias que possuam o gênero mais locado (mais que 5 vezes) no período de maio de 2020 (reajustar em 10%).
use locadora;

update categoria c set c.valor = (c.valor * 1.10)
where(select count(f.idGenero)
	from locacao_filme lf
	inner join locacao l on l.idLocacao = lf.idLocacao
	inner join filme f on f.idFilme = lf.idFilme
where f.idCategoria = c.idCategoria and l.dataLoc between '2020-05-01' and '2020-05-31') > 1;

#2 - Excluir os clientes que não efetuaram locações até 30/04/2020
delete from cliente
where idCliente not in(select l.idCliente
	from locacao l
    where l.dataLoc < '2020-04-30');
    
#3 - Crie uma tabela "ENDERECO" (com os atributos: "TIPOLOGRADOURO", "LOGRADOURO", "NUMERO", "COMPLEMENTO", "BAIRRO", "CIDADE", "UF" E "CEP"). a) Popular a nova tabela com comando INSERT + SELECT
create table endereco (
	idEndereco int not null auto_increment primary key,
    tipoLog varchar(20),
    log varchar(60),
    numero int,
    complemento varchar(15),
    bairro varchar(60),
    cidade varchar(60),
    uf char(2),
    cep int,
    idCliente int not null,
    foreign key(idCliente) references cliente (idCliente) on update cascade on delete cascade
);

insert into endereco(idCliente, log)
select distinct c.idCliente, c.endereco
from cliente c;

#4 - Fazer uma consulta SQL que mostre os 3 bairros que mais locaram filmes com o diretor "Steven Spielberg".
select e.bairro as Bairro, count(lf.idFilme) as 'Filmes Locados'
from locacao_filme lf
inner join locacao l on l.idLocacao = lf.idLocacao
inner join endereco e on e.idCliente = l.idCliente
inner join filme f on f.idFilme = lf.idFilme
inner join filme_ator fa on fa.idFilme = f.idFilme
inner join ator a on a.idAtor = fa.idAtor
where fa.diretor = 1 and a.nome like 'Steven Spielberg'
group by e.bairro
order by 2 desc
limit 3;
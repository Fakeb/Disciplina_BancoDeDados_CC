#Rafael Meneses
#Atividade 10
create database locadora;

use locadora;

create table categoria(
idCategoria int not null auto_increment primary key,
nome varchar(60),
valor numeric(15,2) 
);

create table genero(
idGenero int not null auto_increment primary key,
nome varchar(60)
);

create table cliente(
idCliente int not null auto_increment primary key,
nome varchar(60),
cpf varchar(15),
endereco varchar(60),
telefone varchar(15)
);

create table locacao(
idLocacao int not null auto_increment primary key,
subTotal numeric(15,2),
dataLoc date,
multa numeric(15,2),
desconto numeric(15,2),
idCliente int not null
);

create table ator(
idAtor int not null auto_increment primary key,
nome varchar(60)
);

create table filme (
idFilme int not null auto_increment primary key,
titulo varchar(60),
tituloOriginal varchar(60),
quantidade int,
idGenero int not null,
idCategoria int not null,
foreign key (idGenero) references genero(idGenero) on update cascade on delete cascade,
foreign key (idCategoria) references categoria(idCategoria) on update cascade on delete cascade
);

create table filme_ator(
idFilme_Ator int not null auto_increment primary key,
ator boolean,
diretor boolean,
idFilme int not null,
idAtor int not null,
foreign key (idFilme) references filme(idFilme) on update cascade on delete cascade,
foreign key (idAtor) references ator(idAtor) on update cascade on delete cascade
);

create table locacao_filme(
idLocacao_Filme int not null auto_increment primary key,
dataDevol date,
numDias int,
valor numeric(15,2),
idLocacao int not null,
idFilme int not null,
foreign key (idLocacao) references locacao(idLocacao) on update cascade on delete restrict,
foreign key (idFilme) references filme(idFilme) on update cascade on delete restrict
);

insert into categoria (nome, valor)
values ('Sem Categoria', 0.0),
	   ('Dia das Maes', 4.24),
       ('Lançamento', 10.20),
       ('Hallowen', 5.25),
       ('Quarentena', 3.50);

insert into genero (nome)
values ('Romance'),
	   ('Comédia'),
       ('Ficção'),
       ('Drama'),
       ('Suspense'),
       ('Terror'),
       ('Documentário'),
       ('Biografia'),
       ('Ação'),
       ('Anime');

insert into cliente (nome, cpf, endereco, telefone)
values ('Pietra', '04259177755', 'Rua Marechal Rondon, 97043350 - RS', '5526863850'),
	   ('Rafael', '04259177036', 'Rua Marechal Rondon, 97043350 - RS', '5526863851'),
       ('Vanessa', '15917773600', 'Rua Francisco Brochado da Rocha, 97043200 - RS', '55991252914'),
	   ('Eduardo', '36057151151', 'Rua Francisco Brochado da Rocha, 97043200 - RS', '55991252214'),
       ('Cezar', '72758543095', 'Rua das Castanheiras, 97030764 - RS', '55991233914'),
	   ('Ragnar', '67767211061', 'Rua das Castanheiras, 97030764 - RS', '55994452914'),
       ('Helena', '83525822081', 'Rua Poeta Paulo Souza, 97040400 - RS', '55991252444'),
	   ('Kendrick', '88697799040', 'Rua Poeta Paulo Souza, 97040400 - RS', '55991253314'),
       ('Valentina', '60724615067', 'Travessa Vital Antunes, 97065320 - RS', '55991233914'),
	   ('Logic', '60724615067', 'Travessa Vital Antunes, 97065320 - RS', '55991255514');

insert into locacao (subTotal, dataLoc, multa, desconto, idCliente)
values (10.50, '2020-09-23', 5.00, 1.00, 1),
       (55.00, '2020-06-30', 22.30, 24.00, 2),
       (25.00, '2020-05-23', 23.40, 2.00, 3),
       (35.00, '2020-03-13', 12.00, 3.30, 4),
       (20.40, '2020-01-19', 24.50, 4.30, 10),
       (20.20, '2020-01-23', 5.20, 4.20, 5),
       (53.30, '2020-02-12', 6.40, 5.50, 9),
       (12.50, '2020-02-02', 3.00, 9.30, 6),
       (21.00, '2020-03-13', 13.30, 7.40, 8),
       (33.20, '2020-03-12', 14.00, 9.40, 7);

insert into ator (nome)
values ('Bradley Cooper'),
       ('Leonardo DiCaprio'),
       ('Brad Pitt'),
       ('Will Smith'),
       ('Dwayne Johnson'),
       ('Jim Carrey'),
       ('Sylvester Stallone'),
       ('Chris Hemsworth'),
       ('Jack Nicholson'),
       ('Scarlett Johansson');

insert into filme (titulo, tituloOriginal, quantidade, idGenero, idCategoria)
values ('Era uma vez em Hollywood', 'Once Upon a Time in Hollywood', 22, 2, 3),
       ('Nasce uma Estrela', 'A Star is Born', 15, 1, 2),
       ('Velozes e Furiosos 8', 'The Fast and the Furious 8', 13, 9, 1),
       ('Eu sou a Lenda', 'I am Legend', 10, 3, 5),
       ('Guerra Mundial Z', 'World War Z', 18, 6, 5),
       ('A Origem', 'Inception', 15, 3, 3),
       ('O Show de Truman', 'The Truman Show', 14, 2, 5),
       ('Rocky Balboa', 'Rocky Balboa', 37, 9, 1),
       ('Jojo Rabbit', 'Jojo Rabbit', 9, 4, 1),
       ('O Iluminado', 'The Shining', 12, 6, 4);
       
insert into filme_ator (idFilme, idAtor, ator, diretor)
values (1, 2, 1, 0),
       (2, 1, 1, 1),
       (3, 5, 1, 0),
       (4, 4, 1, 0),
       (5, 3, 1, 0),
       (6, 2, 1, 0),
       (7, 6, 1, 0),
       (8, 7, 1, 1),
       (9, 10, 1, 0),
       (10, 9, 1, 1),
       (1, 3, 1, 0),
       (2, 10, 1, 0),
       (3, 4, 1, 0),
       (4, 5, 1, 0),
       (5, 6, 1, 0),
       (6, 7, 0, 1),
       (7, 8, 0, 1),
       (8, 9, 0, 1),
       (9, 2, 0, 1),
       (10, 1, 0, 1);
       
insert into locacao_filme (idLocacao, idFilme, valor, numDias, dataDevol)
values (3, 1, 1.00, 3, '2020-02-23'),
       (4, 2, 2.00, 3, '2020-03-21'),
       (5, 3, 3.50, 3, '2020-12-22'),
       (5, 4, 5.00, 3, '2020-11-23'),
       (7, 5, 6.00, 3, '2020-02-24'),
       (1, 6, 125.50, 1, '2020-03-25'),
       (9, 7, 44.20, 2, '2020-02-10'),
       (8, 8, 22.00, 3, '2020-01-03'),
       (10, 9, 12.00, 4, '2020-06-02'),
       (6, 10, 93.00, 5, '2020-07-01'),
       (5, 10, 141.40, 2, '2020-09-03'),
       (4, 9, 13.40, 1, '2020-09-04'),
       (3, 8, 23.40, 15, '2020-08-05'),
       (3, 7, 30.20, 4, '2020-10-06'),
       (3, 6, 45.20, 2, '2020-11-07'),
       (4, 5, 15.20, 5, '2020-09-22'),
       (5, 4, 22.20, 6, '2020-09-23'),
       (1, 3, 15.20, 7, '2020-08-24'),
       (1, 2, 2.20, 5, '2020-03-25'),
       (2, 1, 3.50, 2, '2020-02-23');

# Atividade 11
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
and a.nome='Leonardo DiCaprio'
order by f.titulo;

# Atividade 12
#1 - Que mostre o número de filmes locados e o total. Agrupe por cliente.
select c.nome Nome, count(*) Locados, SUM(lf.valor) Total from filme f
join locacao_filme lf on f.idFilme = lf.idFilme
join locacao l on l.idLocacao = lf.idLocacao
join cliente c on c.idCliente = l.idCliente
group by c.nome;

#2 - Que mostre os 3 endereços que menos efetuaram locações do gênero "COMÉDIA" com o ator "CUBA JR." no ano de 2020.
select c.endereco as 'Endereço', count(lf.idLocacao) as "Número de locações"
from locacao_filme lf
inner join locacao l on lf.idLocacao = l.idLocacao
inner join cliente c ON l.idCliente = c.idCliente
inner join filme f on lf.idFilme = f.idFilme
inner join genero g on f.idGenero = g.idGenero
where year(l.dataLoc) = 2020 and g.nome like 'Comédia'
and lf.idFilme in
(select distinct fa.idFilme
from filme_ator fa
inner join ator a on fa.idAtor = a.idAtor
where a.nome like 'Leonardo DiCaprio' and fa.ator = 1 and fa.diretor = 0)
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



#--------------- resoluçao aula ----------------------


#ex 1
select c.nome as 'Nome do Cliente', sum(l.subTotal+l.multa-l.desconto) as 'Total em Locações (R$)' ,
	(select count(lf.idLocacao)
    from locacao_filme lf
    inner join locacao l2 on lf.idLocacao = l2.idLocacao
    where l2.idCliente = l.idCliente
    ) as 'Numero de filmes locados'
from locacao l
inner join cliente c on l.idCliente = c.idCliente
group by c.nome;

#ex 2 
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

#ex 2 - cassio 
select C.ENDERECO as 'Endereço', count(LF.IDLOCACAO) as "Número de locações"
from LOCACAO_FILME LF
inner join LOCACAO L on LF.IDLOCACAO = L.IDLOCACAO
inner join CLIENTE C ON L.IDCLIENTE = C.IDCLIENTE
inner join FILME F on LF.IDFILME = F.IDFILME
inner join GENERO G on F.IDGENERO = G.IDGENERO
where year(L.DATALOC) = 2020 and G.NOME like 'Comédia'
and LF.IDFILME in
(select distinct FA.IDFILME
from FILME_ATOR FA
inner join ATOR A on FA.IDATOR = A.IDATOR
where A.NOME like 'Johnny Depp' and FA.ATOR = 0 and FA.DIRETOR = 1)
group by C.ENDERECO
order by 2 desc
limit 3;


#atividade 13

update locacao as l
set l.desconto = l.desconto+2
where l.idLocacao in (select distinct lf.idLocacao
						from locacao_filme lf
						inner join filme f on lf.idFilme = f.idFilme
                        inner join genero g on f.idGenero = g.idGenero
                        where g.nome = 'Comédia');

select l.*
from locacao as l
where l.idLocacao in (select distinct lf.idLocacao
						from locacao_filme lf
                        inner join filme f on lf.idFilme = f.idFilme
                        inner join genero g on f.idGenero = g.idGenero
                        where g.nome = 'Comédia');
                        
#1
update categoria as c
set c.valor =c.valor+(c.valor*0.10)
where c.idCategoria in( 
    select c2.idCategoria from(
        select distinct c.idCategoria
        from locacao_filme lf
        inner join filme f on lf.idFilme = f.idFilme
        inner join categoria c on f.idCategoria = c.idCategoria
        inner join locacao l on l.idLocacao = lf.idLocacao
        where l.dataLoc between '2020-05-01' and '2020-05-31'
        group by c.idCategoria
        having count(lf.idLocacao) > 5
    ) as c2);

#1 - Reajustar as categorias que possuam o gênero mais locado (mais que 5 vezes) no período de maio de 2020 (reajustar em 10%).

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
/*1.Faça uma VIEW que mostre todos os clientes que compraram da empresa no ano de 2020, bem como total que eles compraram.*/

create VIEW show_sum_total (Nome, Total)
as
select c.nome, sum(v.total)
from venda v
inner join cliente c on v.idCliente = c.idCliente
where year(v.dataVenda) = 2020
group by v.idCliente
order by 2 desc;

select * from show_sum_total;

/*2.Faça uma STORED PROCEDURE que mostre, em um ano qualquer, o subtotal em compras, o total em descontos das compras, 
o subtotal em vendas, o total em descontos das vendas, o total em compras, o total em vendas e o saldo no ano (somatórios em R$). 
Agrupe pelo fornecedor e cliente.*/

delimiter //
create procedure p_somaVendasComprasDeClienteFornec(in periodo int)
begin
	declare mais_linhas int default 0;
	declare clienteFornec varchar(60);
	declare subtotalFC decimal(15,2);
	declare descontoFC decimal(15,2);
	declare totalFC decimal(15,2);
	declare descontosTotais decimal(15,2);
	declare somaTotalVenda decimal(15,2);
	declare somaTotalCompra decimal(15,2);
    declare somaSubTotalVenda decimal(15,2);
	declare somaSubTotalCompra decimal(15,2);
	declare curVenda cursor for select c.nome, sum(v.subTotal), (sum(v.subTotal)-sum(v.total)), sum(v.total)
									from venda  v
									inner join cliente c on c.idCliente = v.idCliente
									where year(v.dataVenda) = periodo
									group by c.nome;
						
	declare curCompra cursor for select f.razaoSocial, sum(c.subTotal), (sum(c.subTotal)-sum(c.total)), sum(c.total)
									from compra  c
									inner join fornecedor f on f.idFornec = c.idFornec
									where year(c.dataCompra) = periodo
									group by f.razaoSocial;

	declare continue handler for not found set mais_linhas=1;
	set mais_linhas=0;

	drop temporary table if exists tblresults;
	create temporary table if not exists tblresults (tipoTab varchar(60),
													 nomeTab varchar(60),
                                                     subTotalTab decimal(15,2),
                                                     descontoTab decimal(15,2),
                                                     totalTab decimal(15,2));

	select sum(v.subtotal) into somaSubTotalVenda
	from venda v
	where year(v.dataVenda) = periodo;

	select sum(c.subtotal) into somaSubTotalCompra
	from compra c
	where year(c.dataCompra) = periodo;
    
    select sum(v.total) into somaTotalVenda
	from venda v
	where year(v.dataVenda) = periodo;

	select sum(c.total) into somaTotalCompra
	from compra c
	where year(c.dataCompra) = periodo;
    
    set descontosTotais = (somaSubTotalVenda-somaSubTotalCompra)-(somaTotalVenda-somaTotalCompra);
    
	insert into tblresults (tipoTab, nomeTab, subTotalTab, descontoTab, totalTab) 
	values ("Saldo","Venda - Compra",(somaSubTotalVenda-somaSubTotalCompra), descontosTotais, (somaTotalVenda-somaTotalCompra));

	open curCompra;
	teste_loop: loop fetch curCompra into clienteFornec, subtotalFC, descontoFC, totalFC;
		if mais_linhas = 1 then
			leave teste_loop;
		end if;
        
		insert into tblresults (tipoTab, nomeTab, subTotalTab, descontoTab, totalTab) 
		values ("Compra", clienteFornec, subtotalFC, descontoFC, totalFC);

	end loop teste_loop;

	set mais_linhas=0;

	open curVenda;
	teste_loop: loop fetch curVenda into clienteFornec, subtotalFC, descontoFC, totalFC;
		if mais_linhas = 1 then
			leave teste_loop;
		end if;
        
		insert into tblresults (tipoTab, nomeTab, subTotalTab, descontoTab, totalTab) 
		values ("Venda", clienteFornec, subtotalFC, descontoFC, totalFC);
        
	end loop teste_loop;

	select tipoTab as Tipo, nomeTab as Nome, subTotalTab as SubTotal, descontoTab as Desconto, totalTab as Total from tblresults;

end; //delimiter ;

drop procedure p_somaVendasComprasDeClienteFornec;

CALL p_somaVendasComprasDeClienteFornec(2020);
/*1 - Fazer uma stored procedure que receba como parâmetro de entrada um período, calcule o total (R$) em produtos vendidos no período e mostre:
	- Nome do Produto,
	- Total (R$) do produto,
	- Percentual de venda do produto em relação ao total vendido no período.--> a soma de cada produto multiplicado por 100 dividito por todas as somas do total */

delimiter //
create PROCEDURE sp_show_periodo_prodVendidos(in periodoIni date, in periodoFim date)
BEGIN	
    
    declare somaVendas decimal(15,2);
    
    select sum(iv.total) into somaVendas
    from itens_venda iv
    inner join venda v on iv.idVenda = v.idVenda
	where v.dataVenda between periodoIni and periodoFim;
    
	select p.nome as nomeProduto, sum(iv.total) as somaVendaProduto, (sum(iv.total)*100)/somaVendas as PercentualVendas
	from produto p
    inner join itens_venda iv on p.idProduto = iv.idProduto 
    inner join venda v on iv.idVenda = v.idVenda
	where v.dataVenda between periodoIni and periodoFim
    group by p.idProduto;
   
END;
//delimiter ;

drop PROCEDURE sp_show_periodo_prodVendidos;
    
call sp_show_periodo_prodVendidos("2020-01-01","2020-12-30");

/*1 com cursor*/
delimiter //
create PROCEDURE sp_show_periodo_prodVendidos(in periodoIni date, in periodoFim date)
BEGIN
	declare mais_linhas int default 0;
	declare idp int;
	declare nomeProd varchar(60);
	declare totalGeral decimal(15,2);
	declare totalProd decimal(15,2);
	declare percProd decimal(15,2);
	declare msg varchar(100);
	DECLARE cur CURSOR FOR SELECT p.nome, sum(iv.total)
			FROM itens_venda iv
			inner join venda v on iv.idVenda = v.idVenda
			inner join produto p on iv.idProduto = p.idProduto
			where v.dataVenda between periodoIni and periodoFim
			and iv.total is not null
			group by p.nome;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET mais_linhas = 1;
	set mais_linhas = 0;
	DROP TEMPORARY TABLE IF EXISTS tblResults;
	CREATE TEMPORARY TABLE IF NOT EXISTS tblResults (nomeProduto varchar(60), TotalProduto decimal(15,2), PercProduto decimal(15,2));
	select sum(iv.total) into totalGeral
	from itens_venda iv
	inner join venda v on iv.idVenda = v.idVenda
	where v.dataVenda between periodoIni and periodoFim
    and iv.total is not null;
    if totalGeral > 0 then
		open cur;
        teste_loop: LOOP FETCH cur INTO nomeProd, totalProd;
			if mais_linhas = 1 then
				LEAVE teste_loop;
			END IF;
            set percProd = (totalProd*100)/totalGeral;
            insert into tblResults (nomeProduto, totalProduto, percProduto) values (nomeProd, totalProd, percProd);
		END LOOP teste_loop;
        select nomeProduto, totalProduto, percProduto from tblResults;
	else
		set msg = 'Total inválido!!!';
        signal sqlstate '45000' set message_text = msg;
	end if;
END;
// delimiter ;

call sp_show_periodo_prodVendidos("2020-01-01","2020-12-30");

/*2 - Fazer uma stored procedure que receba como parâmetro de entrada um período, calcule o total (R$) em produtos vendidos e comprados no período e mostre:
	- Nome do Produto,
	- Total (R$) vendido do produto,
	- Percentual de venda do produto em relação ao total vendido no período.
	- Total (R$) comprado do produto.
	- Percentual de compra do produto em relação ao total comprado no período.*/
    
delimiter //
create PROCEDURE sp_show_periodo_prodVendidos_prodcompra(in periodoIni date, in periodoFim date)
BEGIN	
    
    declare somaVendas decimal(15,2);
    declare somaCompras decimal(15,2);
    
    select sum(c.total) into somaCompras
    from itens_compra ic
    inner join compra c on ic.idCompra = c.idCompra
	where c.dataCompra between periodoIni and periodoFim;
    
    select sum(iv.total) into somaVendas
    from itens_venda iv
    inner join venda v on iv.idVenda = v.idVenda
	where v.dataVenda between periodoIni and periodoFim;
    
	select p.nome as nomeProduto,
		sum(iv.total) as somaVendaProduto,
        (sum(iv.total)*100)/somaVendas as PercentualVendas
	from produto p
    inner join itens_venda iv on p.idProduto = iv.idProduto 
    inner join venda v on iv.idVenda = v.idVenda
	where v.dataVenda between periodoIni and periodoFim
    group by p.idProduto;
    
	select p.nome as nomeProduto,
		sum(ic.total) as somaCompraProduto,
		(sum(ic.total)*100)/somaCompras as PercentualCompras
	from produto p
    inner join itens_compra ic on p.idProduto = ic.idProduto
    inner join compra c on ic.idCompra = c.idCompra
	where c.dataCompra between periodoIni and periodoFim
    group by p.idProduto;
END;
//delimiter ;

drop PROCEDURE sp_show_periodo_prodVendidos_prodcompra;
    
call sp_show_periodo_prodVendidos_prodcompra("2020-01-01","2020-12-30");

/*2 com cursor*/

DELIMITER //
CREATE PROCEDURE P_ListaVendasCompra(in periodoIni date, in periodoFim date)
BEGIN       
	declare mais_linhas int default 0; 
    declare idp int;
	declare nomeProdutos varchar(60);    
	declare totalcalcCompra decimal(15,2);	
    declare totalcalcVenda decimal(15,2);
    declare totalCompra decimal(15,2);
    declare totalVenda decimal(15,2);
    declare porcentagemCompra decimal(15,2);
    declare porcentagemVenda decimal(15,2);
    DECLARE cur CURSOR FOR select distinct p.idProduto, p.nome
						from produto p
						where p.idProduto in (select distinct iv.idProduto
 						                      from itens_venda iv
      						                  inner join venda v on iv.idVenda = v.idVenda
											  where v.dataVenda between periodoIni and periodoFim)
						or p.idProduto in (select distinct ic.idProduto
                       						from itens_compra ic
                       						inner join compra c on ic.idCompra = c.idCompra
                       						where c.dataCompra between periodoIni and periodoFim);	                           
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET mais_linhas = 1;     
	SET mais_linhas = 0;       
	DROP TEMPORARY TABLE IF EXISTS tblResults;     
	CREATE TEMPORARY TABLE IF NOT EXISTS tblResults (nomeProdutosTabela varchar(60), totalVendaTabela decimal(15,2), porcentagemVendaTabela decimal(15,2),
													totalCompraTabela decimal(15,2), porcentagemCompraTabela decimal(15,2));   
    SELECT sum(iv.total) into totalcalcVenda
	FROM itens_venda iv
	inner join venda v on iv.idVenda = v.idVenda
    where v.dataVenda between periodoIni and periodoFim
	and iv.total is not null;	
    
    SELECT sum(ic.total) into totalcalcCompra
	FROM itens_compra ic
	inner join compra c on ic.idCompra = c.idCompra
    where c.dataCompra between periodoIni and periodoFim
	and ic.total is not null;	
    
		OPEN cur;	
		teste_loop: LOOP FETCH cur INTO idp, nomeProdutos;		
			IF mais_linhas = 1 THEN			
				LEAVE teste_loop;		
			END IF;     
		
				select distinct sum(ic.total) into totalCompra
				from itens_compra ic
				inner join compra c on ic.idCompra = c.idCompra
				where ic.idProduto = idp
				and  c.dataCompra between periodoIni and periodoFim;
                
                set porcentagemCompra=(totalCompra*100)/totalcalcCompra;
			
				select distinct sum(iv.total) into totalVenda
				from itens_venda iv
				inner join venda v on iv.idVenda = v.idVenda
				where iv.idProduto = idp
				and v.dataVenda between periodoIni and periodoFim;
                
                set porcentagemVenda=(totalVenda*100)/totalcalcVenda;
                      
            insert into tblResults (nomeProdutosTabela, totalVendaTabela, porcentagemVendaTabela, totalCompraTabela, porcentagemCompraTabela) 
            values (nomeProdutos, totalVenda, porcentagemVenda, totalCompra, porcentagemCompra);    

        END LOOP teste_loop;         
        select nomeProdutosTabela, totalVendaTabela, porcentagemVendaTabela, totalCompraTabela, porcentagemCompraTabela from tblResults;   

END; //DELIMITER ;

drop PROCEDURE P_ListaVendasCompra;

call P_ListaVendasCompra("2020-01-01","2020-12-30");

-- inserção das queries no sql
use ecommerce;

show tables;
-- inserir informações no idClient, Fname, Mnit, Lname, CPF e Address
INSERT INTO client (Fname, Mnit, Lname, CPF, Address, BDate)
	VALUES ('Maria','M','Silva',12346789,'Rua Silva de Prata 29, Carangola - Cidade das Flores','1999-07-05'),
		   ('Matheus','O','Pimentel',987654321,'Rua Alemeda 289, Centro - Cidade das Flores','1984-08-20'),
			('Ricardo','F','Silva',45678913,'Avenida Alemeda Vinha 1009, Centro - Cidade das Flores','2004-05-01'),
			('Julia','S','França',789123456,'Rua Lareijras 861, Centro - Cidade das Flores','2006-10-30'),
			('Roberta','G','Assis',98745631,'Avenida de Koller 19, Centro - Cidade das Flores','1967-11-22'),
			('Isabela','M','Cruz',654789123,'Rua Alemeda das Flores 28, Centro - Cidade das Flores','1988-03-08');
    SELECT * FROM client;
            
-- inserir informações no idProduct, Pname, Classification_Kids, Category('Eletrônico','Vestimenta','Cosméticos','Alimentos','Brinquedos','Móveis'), Avaliação e Size
INSERT INTO product (Pname, Classification_Kids, Category, Avaliação, Size, PValue)
	VALUES ('Fone de ouvido',false,'Eletrônico','4',null, 255.50),
			('Barbie Elsa',true,'Brinquedos','3',null, 36.90),
			('Body Carters',true,'Vestimenta','5',null, 169.99),
			('Microfone Vedo - Youtuber',false,'Eletrônico','4',null, 90),
			('Sofá retrátil',false,'Móveis','3','3x57x80',1229.90),
			('Farinha de arroz',false,'Alimentos','2',null, 9.50),
			('Fire Stick Amazon',false,'Eletrônico','3',null, 349);
SELECT * FROM product;

-- inserir informações em idDemandClient, DemandStatus, DemandDescription, SendValue, PaymentCash
-- delete from demand where idDemandClient in (1, 2, 3, 4);
INSERT INTO demand (idDemandClient, DemandStatus, DemandDescription, SendValue, PaymentCash) 
	 VALUES (1, DEFAULT,'Compra via aplicativo',NULL,1),
			(2, DEFAULT,'Compra via aplicativo',50,0),
			(3,'Confirmado',NULL,NULL,1),
			(4, DEFAULT,'Compra via web site',150,0);
SELECT * FROM demand;

-- inserir informações em idPayment, TypePayment, PaymentStatus, LimitAvailable
INSERT INTO payments (idPayment, TypePayment, PaymentStatus, LimitAvaliable) 
VALUES (1,'Boleto', DEFAULT, 100),
		(2,'Débito','Pagamento aprovado', 150),
		(3,'Crédito','Pagamento rejeitado', 0),
		(4,'Dinheiro','Pagamento aprovado', 150);
SELECT * FROM payments;

-- inserir informações em idStock, Location, Amount
INSERT INTO stock(idStock,Location, Amount) 
VALUES (1,'Rio de Janeiro',1000),
		(2,'Rio de Janeiro',500),
		(3,'São Paulo',10),
		(4,'São Paulo',100),
		(5,'São Paulo',10),
		(6,'Brasília',60);
                          
SELECT * FROM stock;

-- inserir informações em idLproduct, idLStock, Location
INSERT INTO StockLocation (idLProduct, idLStock, Location) 
VALUES  (1,2,'RJ'),
		(2,6,'GO');
								
SELECT * FROM StockLocation;

-- inserir informações em  SocialName, CNPJ, Contact
INSERT INTO supplier (SocialName, CNPJ, Contact) 
VALUES ('Almeida e Filhos', 123456789123456,'21985474'),
		('Eletrônicos Silva',854519649143457,'21985484'),
		('Eletrônicos Valma', 934567893934695,'21975474');
							
SELECT * FROM supplier;

-- idSeller, SocialName, Address, AbstName, CNPJ, CPF, Contact
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, Address, Contact) 
VALUES ('Tech Eletronics', null, 123456789456321, null,'Rio de Janeiro', 219946287),
		('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
		('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);
						
SELECT * FROM seller;

-- idDelivery, StatusDelivery, TrackingCode
INSERT INTO delivery(idDelivery, StatusDelivery, TrackingCode) 
VALUES (1, 'Em andamento', 458),
		(2, 'Enviado', 789),
		(3, 'Entregue', 387),
		(4, 'Em andamento', 198),
		(5, 'Entregue', 455);
						
SELECT * FROM delivery;

-- idPSeller, idPproduct, prodQuantity
INSERT INTO productseller (idPSeller, idProduct, ProdAmount) 
VALUES (1,6,80),
		(2,7,10);
								
SELECT * FROM productseller;

-- idPOproduct, idPDemand, PdAmount, PdStatus
INSERT INTO productdemand (idPDemand, PdAmount, PdStatus) 
VALUES  (1, 5, DEFAULT),
		(2, 5, DEFAULT),
		(3, 6, DEFAULT);
						
SELECT * FROM productdemand;


-- inserir informações em idPsSupplier, idPsProduct
INSERT INTO ProductSupplier (idPsSupplier, idPsProduct, Amount) 
VALUES	(1,1,500),
		(1,2,600),
		(2,4,633),
        (3,3,5),
        (2,5,10);
        
SELECT * FROM ProductSupplier;

SELECT count(*) FROM client;
SELECT * FROM client c, demand d where c.idClient * idDemandClient;
SELECT Fname, Lname, idDemand, DemandStatus FROM client c, demand d where c.idClient * idDemandClient;
SELECT concat(Fname,' ',Lname) as Client, idDemand as Request, DemandStatus as Status FROM client c, demand d where c.idClient * idDemandClient;

INSERT INTO demand (idDemandClient, DemandStatus, DemandDescription, SendValue, PaymentCash)
VALUES (2, default, 'Compra via aplicativo', null, 1);

SELECT count(*) FROM client c, demand d 
where c.idClient * idDemandClient;

-- Recuperar quantos pedidos foram feitos por cada cliente
SELECT c.idClient, Fname, count(*) as Number_of_Demands FROM client c
INNER JOIN demand d ON c.idClient = d.idDemandClient
	GROUP BY idClient;
    
    -- Recuperação de pedidos com produtos associados
SELECT * FROM demand d;
SELECT c.idClient, Fname, count(*) as Number_of_Demands FROM client c
	INNER JOIN demand d ON c.idClient * d.idDemandClient
    INNER JOIN productdemand p ON p.idPDemand = d.idDemand
    GROUP BY idClient;

-- Avaliar quais estados possuem um estoque maior que 100 produtos
SELECT * FROM stock;
SELECT Location, Amount FROM stock 
	WHERE Amount>=100;
    
-- Algum vendedor também é fornecedor?
SELECT * FROM seller;
SELECT * FROM supplier;
SELECT s.SocialName, sp.SocialName FROM seller as s, supplier as sp
where s.SocialName = sp.SocialName;


-- Para compras acima de R$1000.00 o cliente ganha 5% de desconto
SELECT Pname, PValue FROM product;
UPDATE product
SET PValue =
CASE WHEN PValue >= 1000 THEN PValue - PValue * 0.1
     WHEN 500 > PValue < 1000 THEN PValue - PValue * 0.05
     ELSE 0
     END;
     

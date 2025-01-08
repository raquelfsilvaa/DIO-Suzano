-- inserção das queries no sql
use Oficina;

show tables;

-- inserir informações na tabela dos clientes;
INSERT INTO Clients (Fname, Lname, Contact, Address, CPF, CNPJ, City)
VALUES ('Marie','Curie',21345678907,'Rua dos Elementos, 49', 54678901378, null,'Rio de Janeiro'),
		('Albert','Einsten',81987654321,'Avenida da Relatividade, 1955', 23456789064, null, 'Recife'),
        ('Nikola','Tesla',11908371564, 'Rua das Correntes Alternadas, 314', null, 09372919328102,'São Paulo'),
        ('Leonardo','Da Vinci',71938329024,'Avenida dell Arte', null, 84839010107389,'Salvador'),
        ('Galileu','Galilei', 31948328202,'Estrada de Vênus, 1642',64637228095, null,'Belo Horizonte'),
        ('Isaac','Newton', 41833829293,'Rua das Maçãs, 981', 38399202038, null, 'Curitiba');
        
SELECT * FROM Clients;

INSERT INTO Mechanics (Fname, Lname, Contact)
VALUES ('Lorenzo','Salvatore', 98272910278),
		('Antonov','Pavlova', 63818191944),
        ('Lewis','Hamilton', 36278190392),
        ('George','Russell',46372819045);
        
SELECT * FROM Mechanics;

INSERT INTO Vehicles (Clients_idClient, VDescription, CarBrand)
VALUES (1, null, 'Toyota'),
		(2, 'BNB1878','Mercedes'),
        (3, 'CAC6382','Tesla'),
        (4, 'ART1452','Ferrari'),
        (5,'AST1564','Lamborghini'),
        (6,'APL1643','BMW');
        
SELECT * FROM Vehicles;

INSERT INTO Service_Order (idServiceOrder, Emission_Date, Conclusion_Date, BValue, Status_Service)
VALUES (1, '2025-01-03', null, 8964.6, DEFAULT),
		(2,'2024-11-29', '2024-12-10', 25685.9, 'Entregue'),
        (3, '2024-12-30', null, 53627,'Em andamento'),
        (4, '2024-09-08','2024-10-20', 63520.5,'Entregue'),
        (5, '2025-01-05', null, 2738,'Início do serviço'),
        (6, '2024-10-30','2024-12-02', 4653, 'Entregue');
        
SELECT * FROM Service_Order;

INSERT INTO Payments (idPayment, Orders_idServiceOrder, TypePayment, PaymentStatus, LimitAvaliable)
VALUES (1, 1, 'Débito', 'Pagamento aprovado', 50000),
		(2, 2, 'Crédito','Pagamento aprovado', 30000),
        (3, 3,'Boleto', DEFAULT, 45784),
        (4, 4, 'Dinheiro','Pagamento aprovado', DEFAULT),
        (5, 5, 'Pix','Pagamento reprovado', DEFAULT),
        (6, 6,'Crédito','Pagamento aprovado', 69000);
        
SELECT * FROM Payments;

-- Avaliar quais clientes são pessoas fisicas e quais são jurídicas
SELECT concat(c.Fname,' ',c.Lname) as Clients_Name, CPF as 'Pessoa Física', CNPJ as 'Pessoa Jurídica' FROM Clients as c;
   
-- Desconto de 10% para compras acima de 10000
SELECT BValue FROM Service_Order;
UPDATE Service_Order
SET BValue =
CASE WHEN BValue > 10000 THEN BValue - (BValue * 0.1)
	 ELSE BValue
     END;
SELECT concat(Fname,' ',Lname) as Clients_Name, idClient, BValue 
FROM (Clients as c JOIN Service_Order as s ON c.idClient=s.Clients_idClient);

-- Serviços que foram entregues
SELECT concat(Fname,' ',Lname) as Client_Name, idClient Status_Service
FROM (Clients as c JOIN Service_Order as s ON c.idClient=s.idServiceOrder)
WHERE Status_Service = 'Entregue'

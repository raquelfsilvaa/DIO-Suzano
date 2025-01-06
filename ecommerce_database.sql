-- criação do banco de dados para o cenário de e-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- tabela cliente
CREATE TABLE IF NOT EXISTS client(
		idClient int auto_increment primary key,
        Fname varchar (10),
        Mnit char (3),
        Lname varchar (20),
        CPF char (11) not null,
        Address varchar (255),
        BDate date not null,
        constraint unique_cpf_client unique (CPF)
);
alter table client auto_increment=1;

-- desc client

-- tabela produto
-- size = dimensao do produto
CREATE TABLE IF NOT EXISTS product(
		idProduct int auto_increment primary key,
        Pname varchar (45),
        Classification_Kids bool,
        Category enum('Eletrônico','Vestimenta','Cosméticos','Alimentos','Brinquedos','Móveis') not null,
        Avaliação float default 0,
        Size varchar (10),
        PValue float
);
-- tabela pagamentos
CREATE TABLE IF NOT EXISTS payments(
        idClient int auto_increment,
        idPayment int,
        TypePayment enum('Crédito','Débito','Pix','Carnê','Boleto','Dinheiro'),
        PaymentStatus enum('Em análise','Pagamento aprovado','Pagamento rejeitado') default 'Em análise',
        LimitAvaliable float,
        primary key(idClient, idPayment)
);

-- tabela pedido
-- drop table demand;
CREATE TABLE IF NOT EXISTS demand(
		idDemand int auto_increment primary key,
        idDemandClient int,
        DemandStatus enum('Cancelado','Confirmado','Em Processamento') default 'Em processamento',
        DemandDescription varchar(255),
        SendValue float default 10,
        PaymentCash boolean default false,
        constraint fk_demand_client foreign key (idDemandClient) references client (idClient)
);

-- criar tabela estoque 
CREATE TABLE IF NOT EXISTS stock (
		idStock int auto_increment primary key,
        Amount int default 0,
        Location varchar(255)
);

-- criar tabela fornecedor
CREATE TABLE IF NOT EXISTS supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char (15) not null,
        Contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
	
);
-- desc supplier;

-- criar tabela vendedor
CREATE TABLE IF NOT EXISTS seller (
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        Address varchar(45),
        CNPJ char(15),
        CPF char(9),
        Contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

-- criar tabela de entrega

CREATE TABLE IF NOT EXISTS delivery (
		idDelivery int auto_increment primary key,
        StatusDelivery enum('Em andamento', 'Enviado','Entregue') default 'Em andamento',
        TrackingCode varchar(45) not null
);

-- criar tabela da relação entre produto e vendedor

CREATE TABLE IF NOT EXISTS productseller (
		idPseller int auto_increment,
        idProduct int,
        ProdAmount int default 1,
        primary key (idPSeller, idProduct),
        constraint fk_product_seller foreign key (idPSeller) references seller (idSeller),
        constraint fk_product_product foreign key (idProduct) references product (idProduct)
);
-- desc productseller;

-- criar tabela da relação entre produto e demanda

CREATE TABLE IF NOT EXISTS productdemand (
		idDProduct int auto_increment,
        idPDemand int,
        PdAmount int default 1,
        PdStatus enum('Disponível','Em estoque') default 'Disponível',
        primary key (idDProduct, idPDemand),
        constraint fk_productdemand_seller foreign key (idDProduct) references product (idProduct),
        constraint fk_productdemand_product foreign key (idPDemand) references demand (idDemand)
); 
-- desc productdemand

-- criar tabela de produtos em estoque
CREATE TABLE IF NOT EXISTS StockLocation (
		idLProduct int auto_increment,
        idLStock int,
        Location varchar(255) not null,
        primary key (idLProduct, idLStock),
        constraint fk_productstock_seller foreign key (idLProduct) references product (idProduct),
        constraint fk_productstock_product foreign key (idLStock) references stock (idStock)
);
-- desc StockLocation

-- criar tabela da relação de produtos e fornecedor
CREATE TABLE IF NOT EXISTS ProductSupplier (
		idPsSupplier int auto_increment,
        idPsProduct int,
        Amount int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier foreign key (idPsSupplier) references supplier (idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);
-- desc ProductSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

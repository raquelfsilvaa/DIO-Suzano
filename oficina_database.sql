-- criação do banco de dados da oficina
-- drop database oficina;
create database Oficina;
use Oficina;

-- criação da tabela cliente
CREATE TABLE IF NOT EXISTS Clients(
		idClient int auto_increment not null primary key,
        Fname varchar(45) not null,
        Lname varchar(45),
        Contact char(11) not null,
        Address varchar(255),
        CPF char(11),
        CNPJ char(14),
        City varchar(255),
        constraint unique_cpf_client unique (CPF),
		constraint unique_cnpj_client unique (CNPJ)
);
alter table Clients auto_increment=1;

-- desc client;

-- criação da tabela dos mecânicos
CREATE TABLE IF NOT EXISTS Mechanics (
		idMechanic int auto_increment not null primary key,
        Fname varchar(45) not null,
        Lname varchar(45) not null,
        Contact char(11) not null,
        constraint unique_idMechanic_Mechanic unique (idMechanic)
);
alter table Mechanics auto_increment=1;

-- criação da tabela dos veículos
CREATE TABLE IF NOT EXISTS Vehicles (
		idVehicle int auto_increment not null,
        Clients_idClient int not null,
        VDescription varchar(255) null,
        CarBrand varchar(45) not null,
        primary key (idVehicle, Clients_idClient),
        constraint fk_idVehicle_idClient foreign key (Clients_idClient) references Clients (idClient)
);
-- desc Vehicles;

-- criação da tabela de ordem de serviço
CREATE TABLE IF NOT EXISTS Service_Order (
		idServiceOrder int not null,
        Clients_idClient int auto_increment not null,
	    Emission_Date date not null,
        Conclusion_Date date,
        BValue float,
        Status_Service enum('Aguardando autorização','Início do serviço','Em andamento','Entregue') DEFAULT 'Aguardando autorização',
        primary key (idServiceOrder, Clients_idClient),
        constraint fk_clients_serviceorder foreign key (Clients_idClient) references Clients (idClient)
);
alter table Service_Order auto_increment=1;
-- desc Service_Order;

-- criação da tabela pagamento
CREATE TABLE IF NOT EXISTS Payments (
		idPayment int not null,
        Clients_idClient int auto_increment not null,
        Orders_idServiceOrder int not null,
        TypePayment enum('Débito','Crédito','Boleto','Dinheiro','Carnê','Pix'),
        PaymentStatus enum('Em análise','Pagamento aprovado','Pagamento reprovado') DEFAULT 'Em análise',
        LimitAvaliable float DEFAULT 0,
        primary key (CLients_idClient, idPayment, Orders_idServiceOrder),
        constraint fk_serviceorder_client foreign key(Orders_idServiceOrder, Clients_idClient) references Service_Order (idServiceOrder, Clients_idClient),
        constraint fk_client_payment foreign key (Clients_idClient) references Clients (idClient)
);
-- desc Payments;

show tables;

show databases;

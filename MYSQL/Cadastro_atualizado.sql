-- excluir tabela do responsável, animal e agenda:
drop table responsavel;
drop table animal;
drop table agenda;

-- Criando o banco de dados adestra e acessando o banco:
CREATE SCHEMA adestra;
USE adestra;

-- Criando a tabela do tutor:
create table Tutor(
id_resp INT PRIMARY KEY AUTO_INCREMENT,
Nome varchar (80), 
Email varchar (50),
Senha varchar (15), 
Endereco varchar (200),
Telefone int (9),
Autoriza_imagem ENUM('Sim', 'Não'),
unique (Email)
);

-- criando a tabela do animal:
create table animal(
id_animal INT PRIMARY KEY AUTO_INCREMENT,
Nome varchar (100),
Raca varchar (50),
idade int (2),
Sexo ENUM('Macho', 'Femea'),
Castrado ENUM('Sim', 'Não'),
id_resp_animal int not null,
FOREIGN KEY (id_resp_animal) REFERENCES Tutor (id_resp));


/* fazendo os testes no banco:
  Inserindo dados na tabela responsável: */

INSERT INTO Tutor
VALUES (01,'João', 'oaomanuel@gmail.com', '12345', 'Rua teste tes testes', 1192354698, 'Sim'); 
INSERT INTO Tutor
VALUES (02,'Maria', 'maria_aparecida@gmail.com', '98765', 'Rua teste tes testes', 1195248953, 'Não');
INSERT INTO Tutor
VALUES (03,'Teresa', 'teresinha_jesus@gmail.com','teste', 'Rua teste tes testes', 1196248953, 'sim');
INSERT INTO Tutor
VALUES (04,'Carlos', 'carlossilveiro@gmail.com','teste', 'Rua teste tes testes', 1196248953, 'não');   

-- foi um teste para mostrar ao Luiz como seria feito uma alteração: 
Alter table responsavel
modify column Telefone varchar(11);

-- Visualizando os dados da tabela responsável e animal:
select *from Tutor;
select *from animal;


INSERT INTO animal
VALUES (01, 'Sasha', 'vira lata', 4, 'femea', 'Sim', 01); 

INSERT INTO animal
VALUES (02, 'teste', 'vira lata', 4, 'macho', 'nao', 02); 

INSERT INTO animal
VALUES (03, 'Ralf', 'pitbul', 4, 'macho', 'sim', 03);

INSERT INTO animal
VALUES (04, 'Princesa', 'Dalmatas', 4, 'femea', 'sim', 03);

INSERT INTO animal
VALUES (05, 'Hana', 'Pintcher', 4, 'femea', 'sim', 03);


/* criando a tabela agenda:
create table agenda(
id_agenda INT PRIMARY KEY AUTO_INCREMENT,
Agenda DATETIME,
id_agen_resp int not null,
id_agen_anil int not null,
FOREIGN KEY (id_agen_anil) REFERENCES animal (id_animal),
FOREIGN KEY (id_agen_resp) REFERENCES responsavel (id_resp));

INSERT INTO agenda
VALUES (01,'2004-10-11 10:00:00', 01, 02);
INSERT INTO agenda
VALUES (02,'2004-10-12 10:00:00', 01, 02);
INSERT INTO agenda
VALUES (03,'2004-10-13 10:00:00', 01, 02);
INSERT INTO agenda
VALUES (04,'2004-10-13 10:00:00', 03, 06);
INSERT INTO agenda
VALUES (05,'2004-10-13 11:00:00', 03, 05);
INSERT INTO agenda
VALUES (06,'2004-10-13 10:00:00', 03, 04);: */


create table agenda(
id_agenda INT PRIMARY KEY AUTO_INCREMENT,
nome_tutor varchar (50),
nome_animal varchar (30),
motivo_contato varchar (150),
dia date, -- YYYY-MM-DD:
horario time, -- hh:mm:ss:
situacao ENUM('Pendente', 'Confirmado', 'Atendido', 'Cancelado') );

Select * from agenda;

insert into agenda
values(01, 'João', 'Sasha', 'Cotação para adestramento', '2024-10-24', '10:00:00', 'Pendente');
insert into agenda
values(02, 'Teresa', 'Ralf', 'Em treinamento', '2024-10-24', '11:00:00', 'Confirmado');
insert into agenda
values(03, 'Teresa', 'Princesa', 'Em treinamento', '2024-10-24', '12:00:00', 'confirmado');



SELECT * FROM animal WHERE id_resp_animal = 3;
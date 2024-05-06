-- Tabela Filme(Entidade)
CREATE TABLE Filme (
    ID INTEGER PRIMARY KEY,
    Titulo VARCHAR(40) NOT NULL,
    Ano INTEGER NOT NULL CHECK (Ano <= 2021)
);

-- Tabela DVD(Entidade)
CREATE TABLE DVD (
    Num_ INTEGER PRIMARY KEY,
    Data_Fabricacao DATE NOT NULL CHECK (Data_Fabricacao < CURRENT_DATE),
    Filme_ID INTEGER NOT NULL,
    FOREIGN KEY (Filme_ID) REFERENCES Filme(ID)
);

-- Tabela Locacao(Entidade)
CREATE TABLE Locacao (
    DVD_Num INTEGER NOT NULL,
    Cliente_Num INTEGER NOT NULL,
    Data_Locacao DATE NOT NULL DEFAULT CURRENT_DATE,
    Data_Devolucao DATE NOT NULL CHECK (Data_Devolucao > Data_Locacao),
    Valor DECIMAL(7,2) NOT NULL CHECK (Valor > 0),
    PRIMARY KEY (Data_Locacao),
    FOREIGN KEY (DVD_Num) REFERENCES DVD(Num_),
    FOREIGN KEY (Cliente_Num) REFERENCES Cliente(Num_Cadastro)
);

-- Tabela Cliente(Entidade)
CREATE TABLE Cliente (
    Num_Cadastro INTEGER PRIMARY KEY,
    Nome VARCHAR(70) NOT NULL,
    Logradouro VARCHAR(150) NOT NULL,
    Num INTEGER NOT NULL CHECK (Num > 0),
    CEP CHAR(8) NOT NULL CHECK (LENGTH(CEP) = 8)
);

-- Tabela Filme_Estrela (entidade associativa)
CREATE TABLE Filme_Estrela (
    Filme_ID INTEGER NOT NULL,
    Estrela_ID INTEGER NOT NULL,
    FOREIGN KEY (Filme_ID) REFERENCES Filme(ID),
    FOREIGN KEY (Estrela_ID) REFERENCES Estrela(ID)
);

-- Tabela Estrela(Entidade)
CREATE TABLE Estrela (
    ID INTEGER PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);
-- Inserção de  dados na tabela Filme 
INSERT INTO Filme (ID, Titulo, Ano)
VALUES
    (1001, 'Whiplash', 2015),
    (1002, 'Birdman', 2015),
    (1003, 'Interestelar', 2014),
    (1004, 'A Culpa é das Estrelas', 2014),
    (1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
    (1006, 'Sing', 2016);
-- Inserção de  dados na tabela Filme_Estrela
INSERT INTO Filme_Estrela (Filme_ID, Estrela_ID)
VALUES
    (1002, 9901),
    (1002, 9902),
    (1001, 9903),
    (1005, 9904),
    (1005, 9905);
--Alteração da tabela da entidade estrela para a inclusão de um outro atributo em relação a nome real
ALTER TABLE Estrela ADD COLUMN Nome_real VARCHAR(50);
--Inserção dos  valores na tabela Estrel
INSERT INTO Estrela (ID, Nome, Nome_real)
VALUES
    (9901, 'Michael Keaton', 'Michael John Douglas'),
    (9902, 'Emma Stone', 'Emily Jean Stone'),
    (9903, 'Miles Teller', NULL),
    (9904, 'Steve Carell', 'Steven John Carell'),
    (9905, 'Jennifer Garner', 'Jennifer Anne Garner');
-- Inserção dos  dados na tabela DVD
INSERT INTO DVD (Num_, Data_Fabricacao, Filme_ID)
VALUES
    (10001, '2020-12-02', 1001),
    (10002, '2019-10-18', 1002),
    (10003, '2020-04-03', 1003),
    (10004, '2020-12-02', 1001),
    (10005, '2019-10-18', 1004),
    (10006, '2020-04-03', 1002),
    (10007, '2020-12-02', 1005),
    (10008, '2019-10-18', 1002),
    (10009, '2020-04-03', 1003);

-- Inserção dos  dados na tabela Cliente
INSERT INTO Cliente (Num_Cadastro, Nome, Logradouro, Num, CEP)
VALUES
    (5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
    (5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
    (5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, '08411150'),
    (5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, '02918190'),
    (5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110');
DELETE FROM Locacao WHERE DVD_Num = 10001 AND Cliente_Num = 5502 AND Data_Locacao = '2021-02-18';
-- Inserção dos  dados na tabela Locacao
INSERT INTO Locacao (DVD_Num, Cliente_Num, Data_Locacao, Data_Devolucao, Valor)
VALUES
    (10001, 5502, '2021-02-18 01', '2021-02-21', 3.50),
    (10009, 5502, '2021-02-18 02', '2021-02-21', 3.50),
    (10002, 5503, '2021-02-18 03', '2021-02-19', 3.50),
    (10002, 5505, '2021-02-20 01', '2021-02-23', 3.00),
    (10004, 5505, '2021-02-20 02', '2021-02-23', 3.00),
    (10005, 5505, '2021-02-20 03', '2021-02-23', 3.00),
    (10001, 5501, '2021-02-24 01', '2021-02-26', 3.50),
    (10008, 5501, '2021-02-24 02', '2021-02-26', 3.50);
--Atualização Cadastral  
UPDATE Cliente SET CEP = '08411150' WHERE Num_Cadastro = 5503;
UPDATE Cliente SET CEP = '02918190' WHERE Num_Cadastro = 5504;
UPDATE Locacao SET Valor = 3.25 WHERE Cliente_Num = 5502 AND Data_Locacao = '2021-02-18';
UPDATE DVD SET Data_Fabricacao = '2019-07-14' WHERE Num_ = 10005;
UPDATE Estrela SET Nome_real = 'Miles Alexander Teller' WHERE ID = 9903;
DELETE FROM Filme WHERE Titulo = 'Sing';
DELETE FROM Filme_Estrela WHERE Filme_ID = (SELECT ID FROM Filme WHERE Titulo = 'Sing');




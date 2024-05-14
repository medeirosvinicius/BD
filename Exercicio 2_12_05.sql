-- Tabela Filme
CREATE TABLE Filme (
    ID INTEGER PRIMARY KEY,
    Titulo VARCHAR(40) NOT NULL,
    Ano INTEGER NOT NULL CHECK (Ano <= 2021)
);

-- Tabela DVD (Entidade)
CREATE TABLE DVD (
    Num_ INTEGER PRIMARY KEY,
    Data_Fabricacao DATE NOT NULL CHECK (Data_Fabricacao < CURRENT_DATE),
    Filme_ID INTEGER NOT NULL,
    FOREIGN KEY (Filme_ID) REFERENCES Filme(ID)
);

-- Tabela Locacao (Entidade)
CREATE TABLE Locacao (
    DVD_Num INTEGER NOT NULL,
    Cliente_Num INTEGER NOT NULL,
    Data_Locacao DATE NOT NULL DEFAULT CURRENT_DATE,
    Data_Devolucao DATE NOT NULL CHECK (Data_Devolucao > Data_Locacao),
    Valor DECIMAL(7,2) NOT NULL CHECK (Valor > 0),
    PRIMARY KEY (Data_Locacao, DVD_Num, Cliente_Num), -- Adicionando chave primária composta
    FOREIGN KEY (DVD_Num) REFERENCES DVD(Num_),
    FOREIGN KEY (Cliente_Num) REFERENCES Cliente(Num_Cadastro)
);

-- Tabela Cliente (Entidade)
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
    FOREIGN KEY (Estrela_ID) REFERENCES Estrela(ID),
    PRIMARY KEY (Filme_ID, Estrela_ID) -- Adicionando chave primária composta
);

-- Tabela Estrela (Entidade)
CREATE TABLE Estrela (
    ID INTEGER PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);

-- Inserção dos registros na tabela Filme
INSERT INTO Filme (ID, Titulo, Ano)
VALUES
    (1001, 'Whiplash', 2015),
    (1002, 'Birdman', 2015),
    (1003, 'Interestelar', 2014),
    (1004, 'A Culpa é das estrelas', 2014),
    (1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
    (1006, 'Sing', 2016);

-- Inserção dos registros na tabela Estrela
INSERT INTO Estrela (ID, Nome)
VALUES
    (9901, 'Michael Keaton'),
    (9902, 'Emma Stone'),
    (9903, 'Miles Teller'),
    (9904, 'Steve Carell'),
    (9905, 'Jennifer Garner');

-- Inserção dos registros na tabela Filme_Estrela
INSERT INTO Filme_Estrela (Filme_ID, Estrela_ID)
VALUES
    (1002, 9901),
    (1002, 9902),
    (1001, 9903),
    (1005, 9904),
    (1005, 9905);

-- Inserção dos registros na tabela DVD
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
;


-- Inserção dos registros na tabela Cliente
INSERT INTO Cliente (Num_Cadastro, Nome, Logradouro, Num, CEP)
VALUES
    (5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
    (5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '0419110'),
    (5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
    (5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
    (5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110');


-- Atualização do CEP dos clientes 5503 e 5504
UPDATE Cliente
SET CEP = '08411150'
WHERE Num_Cadastro IN (5503, 5504);

-- Atualização do valor da locação de 2021-02-18 do cliente 5502
UPDATE Locacao
SET Valor = 3.25
WHERE Data_Locacao = '2021-02-18'
AND Cliente_Num = 5502;

-- Atualização do valor da locação de 2021-02-24 do cliente 5501
UPDATE Locacao
SET Valor = 3.10
WHERE Data_Locacao = '2021-02-24'
AND Cliente_Num = 5501;

-- Exclusão do DVD do filme "Sing" que não está cadastrado
DELETE FROM DVD
WHERE Filme_ID = (SELECT ID FROM Filme WHERE Titulo = 'Sing');

-- Atualização da data de fabricação do DVD 10005
UPDATE DVD
SET Data_Fabricacao = '2019-07-14'
WHERE Num_ = 10005;

-- Atualização do nome real de Miles Teller
UPDATE Estrela
SET Nome = 'Miles Alexander Teller'
WHERE ID = 9903;

SELECT ID, Ano, 
    CASE WHEN LENGTH(Titulo) > 10 THEN SUBSTR(Titulo, 1, 10) || '...' ELSE Titulo END AS NomeDoFilme
FROM Filme
WHERE ID IN (SELECT Filme_ID FROM DVD WHERE Data_Fabricacao > '2020-01-01');

SELECT Num_, Data_Fabricacao,
       ROUND((JULIANDAY('now') - JULIANDAY(Data_Fabricacao)) / 30) AS qtd_meses_desde_fabricacao
FROM DVD
WHERE Filme_ID = 1003;


SELECT Cliente.Num_Cadastro AS num_cliente, Data_Locacao, Data_Devolucao,
       JULIANDAY(Data_Devolucao) - JULIANDAY(Data_Locacao) AS dias_alugado,
       Valor
FROM Locacao
JOIN Cliente ON Locacao.Cliente_Num = Cliente.Num_Cadastro
WHERE Cliente.Nome LIKE '%Rosa%';

SELECT Nome,
       Logradouro || ' ' || CAST(Num AS VARCHAR) AS endereco_completo,
       SUBSTR(CEP, 1, 5) || '-' || SUBSTR(CEP, 6, 3) AS cep
FROM Cliente
WHERE Num_Cadastro IN (SELECT Cliente_Num FROM Locacao WHERE DVD_Num = 10002);

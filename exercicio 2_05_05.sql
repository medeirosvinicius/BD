-- Criação da tabela da entidade "Projeto"
CREATE TABLE Projeto (
    Id INT PRIMARY KEY,
    Nome VARCHAR(45),
    Data DATE
);
--Criaçao da tabela da entidade Usuario
CREATE TABLE Usuario (
    Id INT PRIMARY KEY,
    Nome VARCHAR(45),
    Username VARCHAR(45),
    Password VARCHAR(45),
    Email VARCHAR(45)
);
CREATE TABLE Users (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome VARCHAR(45),
    Username VARCHAR(45) UNIQUE,
    Password VARCHAR(45) DEFAULT '123mudar',
    Email VARCHAR(45)
);

CREATE TABLE Projects (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome VARCHAR(45),
    Data DATE CHECK (Data > '2014-09-01')
);

-- Tabela associativa Users_Projects
CREATE TABLE Users_Projects (
    Users_Id INT,
    Projects_Id INT,
    FOREIGN KEY (Users_Id) REFERENCES Users(Id),
    FOREIGN KEY (Projects_Id) REFERENCES Projects(Id),
    PRIMARY KEY (Users_Id, Projects_Id)
);

-- Alteração  da coluna username para VARCHAR(10)
ALTER TABLE Users
ALTER COLUMN username VARCHAR(10);

-- Alteraração  da coluna password para VARCHAR(8)
ALTER TABLE Users
ALTER COLUMN password VARCHAR(8);

--Inserção  dos atributos  do usuário
INSERT INTO Users (Id, Nome, Username, Password, Email)
VALUES
    (1, 'Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
    (2, 'Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
    (3, 'Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
    (4, 'Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
    (5, 'Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com');
--Inserção dos atributos da entidade projetos
INSERT INTO Projects (Id, Nome, Data)
VALUES
    (10001, 'Re-folha', '2014-09-05'),
    (10002, 'Manutenção PC ́s', '2014-09-06'),
    (10003, 'Auditoria', '2014-09-07');
--Inserção dos atributos da entidade associativa  usuario projeto
INSERT INTO Users_Projects (Users_Id, Projects_Id)
VALUES
    (1, 10001),
    (5, 10001),
    (3, 10003),
    (4, 10002),
    (2, 10002);

--Atualização de algumas informações no banco de dados
UPDATE Projects
SET Data = '2014-09-12'
WHERE Nome = 'Manutenção PC ́s';
UPDATE Users
SET Username = 'Rh_cido'
WHERE Nome = 'Aparecido';
UPDATE Users
SET Password = '888@*'
WHERE Username = 'Rh_maria' AND Password = '123mudar';
DELETE FROM Users_Projects
WHERE Users_Id = 2 AND Projects_Id = 10002;

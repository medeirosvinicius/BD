CREATE TABLE Projects (
    Id INT PRIMARY KEY   not null ,
    Name VARCHAR(45) NOT NULL,
    Descrição VARCHAR(45) NOT NULL,
    Date DATE NOT NULL CHECK (Date > '2014-09-01')
);
CREATE TABLE Users (
    Id INT PRIMARY KEY Not Null ,
    Name VARCHAR(45) NOT NULL,
    username VARCHAR(10) NOT NULL UNIQUE,
    email VARCHAR(45) NOT NULL,
    password VARCHAR(8) DEFAULT '123mudar'
);
CREATE TABLE Projects_Users (
    Id INT PRIMARY KEY Not Null,
    users_id INT NOT NULL,
    projects_id INT NOT NULL,
    FOREIGN KEY (users_id) REFERENCES Users(Id),
    FOREIGN KEY (projects_id) REFERENCES Projects(Id)
);
INSERT INTO Users (Id, Name, Username, Password, Email)
    (1, 'Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
    (2, 'Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
    (3, 'Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
    (4, 'Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
    (5, 'Aparecido', 'Rh_aparecido', '55@!cido', 'aparecido@empresa.com');

INSERT INTO Projects (Id, Name, Description, Date)
    (10001, 'Re-folha', 'Refatoração das Folhas', '2014-09-05'),
    (10002, 'Manutenção PC ́s', 'Manutenção PC ́s', '2014-09-06'),
    (10003, 'Auditoria', NULL, '2014-09-07');
UPDATE Projects
SET Date = '2014-09-12'
WHERE Name = 'Manutenção PC ́s';
UPDATE Users
SET username = 'Rh_cido'
WHERE Name = 'Aparecido';
UPDATE Users
SET password = '888@*'
WHERE username = 'Rh_maria' AND password = '123mudar';
DELETE FROM Projects_Users
WHERE users_id = 2 AND projects_id = 10002;
SELECT Id, Name, Email, 
       CASE WHEN Password = '123mudar' THEN Password ELSE '********' END AS Password,
       Username
FROM Users;

SELECT P.Name AS Nome_Projeto, P.Descrição AS Descrição, P.Date AS Data_Início, 
       DATE_ADD(P.Date, INTERVAL 15 DAY) AS Data_Final
FROM Projects P
JOIN Users_has_projects UP ON P.Id = UP.projects_id
JOIN Users U ON UP.users_id = U.Id
WHERE U.Email = 'aparecido@empresa.com' AND P.Id = 10001;
SELECT U.Name AS Nome_Usuário, U.Email AS Email
FROM Users U
JOIN Users_has_projects UP ON U.Id = UP.users_id
JOIN Projects P ON UP.projects_id = P.Id
WHERE P.Name = 'Auditoria';
SELECT P.Name AS Nome_Projeto, P.Descrição AS Descrição, P.Date AS Data_Início, 
       '2014-09-16' AS Data_Final,
       79.85 * DATEDIFF('2014-09-16', P.Date) AS Custo_Total
FROM Projects P
WHERE P.Name LIKE '%Manutenção%';

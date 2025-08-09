CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_nascimento DATE
);

CREATE TABLE Autores (
    id_autor INT PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL
);

CREATE TABLE Livros (
    id_livro INT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    quantidade INT DEFAULT 0 CHECK (quantidade >= 0),
    status VARCHAR(20) DEFAULT 'disponível'
);

CREATE TABLE Livro_Autor (
    id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro),
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

CREATE TABLE Emprestimos (
    id_emprestimo INT PRIMARY KEY,
    id_aluno INT,
    id_livro INT,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    FOREIGN KEY (id_aluno) REFERENCES Alunos(id_aluno),
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro),
    CHECK (data_devolucao IS NULL OR data_devolucao >= data_emprestimo)
);

-- Trigger para atualizar quantidade de livros
DELIMITER //

CREATE TRIGGER Atualiza_Quantidade_Livros
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    UPDATE Livros
    SET quantidade = quantidade - 1
    WHERE id_livro = NEW.id_livro;
END//

DELIMITER ;



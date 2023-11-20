-------------------------------Author table yaradilir---------------------------------
CREATE TABLE Author (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Surname VARCHAR(50)
);

-------------------------------Book table yaradilir---------------------------------

CREATE TABLE Book (
    Id INT PRIMARY KEY,
    Name VARCHAR(100) CHECK (LEN(Name) >= 2 AND LEN(Name) <= 100),
    PageCount INT CHECK (PageCount >= 10),
    AuthorId INT,
    FOREIGN KEY (AuthorId) REFERENCES Author(Id)
);

-------------------------------Authors elave edilir---------------------------------
INSERT INTO Author (Id, Name, Surname)
VALUES
    (1, 'John', 'Doe'),
    (2, 'Jane', 'Smith'),
    (3, 'Ahmad', 'Khan');

-------------------------------Books elave edilir-----------------------------------
INSERT INTO Book (Id, Name, PageCount, AuthorId)
VALUES
    (101, 'The Art of Programming', 300, 1),
    (102, 'Data Science Basics', 250, 2),
    (103, 'History of Civilization', 400, 3);

INSERT INTO Book (Id, Name, PageCount, AuthorId)
VALUES
    (104, 'Clean Code', 1500, 2),
    (105, 'Code Complete', 140, 3),
    (106, 'Introduction of Algorithms', 760, 3);


-------------------------------Books ve Authorun elaqeli view`i yaradilr-----------------------------------
CREATE VIEW BooksWithAuthorInfo AS
SELECT
    B.Id AS BookId,
    B.Name AS BookName,
    B.PageCount,
    A.Name + ' ' + A.Surname AS AuthorFullName
FROM
    Book B
JOIN
    Author A ON B.AuthorId = A.Id;

-------------------------------Author adina gore Melumatlarin cixarilmasi Proseduru-----------------------------------
CREATE PROCEDURE GetBooksByAuthor
    @AuthorName VARCHAR(50)
AS
BEGIN
    SELECT
        B.Id AS BookId,
        B.Name AS BookName,
        B.PageCount,
        A.Name + ' ' + A.Surname AS AuthorFullName
    FROM
        Book B
    JOIN
        Author A ON B.AuthorId = A.Id
    WHERE
        A.Name = @AuthorName;
END;

-------------------------------Insert Author Proseduru-----------------------------------
CREATE PROCEDURE InsertAuthor
    @ID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50)
AS
BEGIN
    INSERT INTO Author (Id, Name, Surname)
    VALUES (@ID, @FirstName, @LastName);
END;

-------------------------------Update Author Proseduru-----------------------------------
CREATE PROCEDURE UpdateAuthor
    @AuthorId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50)
AS
BEGIN
    UPDATE Author
    SET Name = @FirstName,
        Surname = @LastName
    WHERE Id = @AuthorId;
END;

-------------------------------Delete Author Proseduru-----------------------------------
CREATE PROCEDURE DeleteAuthorProcedure
    @AuthorId INT
AS
BEGIN
    DELETE FROM Author
    WHERE Id = @AuthorId;
END;


-------------------------------Author ve Kitablari haqqinda Prosedur-----------------------------------
CREATE VIEW AuthorsView AS
SELECT
    A.Id AS Id,
    A.Name + ' ' + A.Surname AS FullName,
    COUNT(B.Id) AS BooksCount,
    SUM(B.PageCount) AS OverallPageCount
FROM
    Author A
LEFT JOIN
    Book B ON A.Id = B.AuthorId
GROUP BY
    A.Id, A.Name, A.Surname;


-------------------------------Prosedurlarin yoxlanilmasi EXEC ile-----------------------------------
EXEC GetBooksByAuthor @AuthorName = 'Ahmad';
EXEC InsertAuthor @ID = 4, @FirstName = 'Robert', @LastName = 'Martin';
EXEC UpdateAuthor @AuthorId = 2, @FirstName = 'Jane', @LastName = 'Smith';
EXEC DeleteAuthorProcedure @AuthorId = 4;

-------------------------------Table`lere baxmaq ucun...-----------------------------------
SELECT * FROM Book;
SELECT * FROM Author;
SELECT * FROM BooksWithAuthorInfo;
SELECT * FROM AuthorsView;


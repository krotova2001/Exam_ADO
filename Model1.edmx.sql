
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/15/2023 18:40:13
-- Generated from EDMX file: C:\Users\zvuk2\source\repos\krotova2001\Exam_ADO\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Books];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'UsersSet'
CREATE TABLE [dbo].[UsersSet] (
    [Iduser] int IDENTITY(1,1) NOT NULL,
    [username] nvarchar(max)  NOT NULL,
    [password] nvarchar(max)  NOT NULL,
    [fullname] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'BooksSet'
CREATE TABLE [dbo].[BooksSet] (
    [Idbook] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(max)  NOT NULL,
    [Cost] int  NOT NULL,
    [Year] int  NOT NULL,
    [Users_Iduser] int  NOT NULL,
    [Genre_IdGenre] int  NOT NULL,
    [Akcii_Idakcii] int  NOT NULL
);
GO

-- Creating table 'AuthorsSet'
CREATE TABLE [dbo].[AuthorsSet] (
    [IdAuthor] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'GenreSet'
CREATE TABLE [dbo].[GenreSet] (
    [IdGenre] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'SalesSet'
CREATE TABLE [dbo].[SalesSet] (
    [Idsale] int IDENTITY(1,1) NOT NULL,
    [date] datetime  NOT NULL
);
GO

-- Creating table 'AkciiSet'
CREATE TABLE [dbo].[AkciiSet] (
    [Idakcii] int IDENTITY(1,1) NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Discount] int  NOT NULL,
    [start] datetime  NOT NULL,
    [stop] datetime  NOT NULL
);
GO

-- Creating table 'AuthorsBooks'
CREATE TABLE [dbo].[AuthorsBooks] (
    [Authors_IdAuthor] int  NOT NULL,
    [Books_Idbook] int  NOT NULL
);
GO

-- Creating table 'SalesBooks'
CREATE TABLE [dbo].[SalesBooks] (
    [Sales_Idsale] int  NOT NULL,
    [Books_Idbook] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Iduser] in table 'UsersSet'
ALTER TABLE [dbo].[UsersSet]
ADD CONSTRAINT [PK_UsersSet]
    PRIMARY KEY CLUSTERED ([Iduser] ASC);
GO

-- Creating primary key on [Idbook] in table 'BooksSet'
ALTER TABLE [dbo].[BooksSet]
ADD CONSTRAINT [PK_BooksSet]
    PRIMARY KEY CLUSTERED ([Idbook] ASC);
GO

-- Creating primary key on [IdAuthor] in table 'AuthorsSet'
ALTER TABLE [dbo].[AuthorsSet]
ADD CONSTRAINT [PK_AuthorsSet]
    PRIMARY KEY CLUSTERED ([IdAuthor] ASC);
GO

-- Creating primary key on [IdGenre] in table 'GenreSet'
ALTER TABLE [dbo].[GenreSet]
ADD CONSTRAINT [PK_GenreSet]
    PRIMARY KEY CLUSTERED ([IdGenre] ASC);
GO

-- Creating primary key on [Idsale] in table 'SalesSet'
ALTER TABLE [dbo].[SalesSet]
ADD CONSTRAINT [PK_SalesSet]
    PRIMARY KEY CLUSTERED ([Idsale] ASC);
GO

-- Creating primary key on [Idakcii] in table 'AkciiSet'
ALTER TABLE [dbo].[AkciiSet]
ADD CONSTRAINT [PK_AkciiSet]
    PRIMARY KEY CLUSTERED ([Idakcii] ASC);
GO

-- Creating primary key on [Authors_IdAuthor], [Books_Idbook] in table 'AuthorsBooks'
ALTER TABLE [dbo].[AuthorsBooks]
ADD CONSTRAINT [PK_AuthorsBooks]
    PRIMARY KEY CLUSTERED ([Authors_IdAuthor], [Books_Idbook] ASC);
GO

-- Creating primary key on [Sales_Idsale], [Books_Idbook] in table 'SalesBooks'
ALTER TABLE [dbo].[SalesBooks]
ADD CONSTRAINT [PK_SalesBooks]
    PRIMARY KEY CLUSTERED ([Sales_Idsale], [Books_Idbook] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Users_Iduser] in table 'BooksSet'
ALTER TABLE [dbo].[BooksSet]
ADD CONSTRAINT [FK_UsersBooks]
    FOREIGN KEY ([Users_Iduser])
    REFERENCES [dbo].[UsersSet]
        ([Iduser])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UsersBooks'
CREATE INDEX [IX_FK_UsersBooks]
ON [dbo].[BooksSet]
    ([Users_Iduser]);
GO

-- Creating foreign key on [Genre_IdGenre] in table 'BooksSet'
ALTER TABLE [dbo].[BooksSet]
ADD CONSTRAINT [FK_GenreBooks]
    FOREIGN KEY ([Genre_IdGenre])
    REFERENCES [dbo].[GenreSet]
        ([IdGenre])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_GenreBooks'
CREATE INDEX [IX_FK_GenreBooks]
ON [dbo].[BooksSet]
    ([Genre_IdGenre]);
GO

-- Creating foreign key on [Authors_IdAuthor] in table 'AuthorsBooks'
ALTER TABLE [dbo].[AuthorsBooks]
ADD CONSTRAINT [FK_AuthorsBooks_Authors]
    FOREIGN KEY ([Authors_IdAuthor])
    REFERENCES [dbo].[AuthorsSet]
        ([IdAuthor])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Books_Idbook] in table 'AuthorsBooks'
ALTER TABLE [dbo].[AuthorsBooks]
ADD CONSTRAINT [FK_AuthorsBooks_Books]
    FOREIGN KEY ([Books_Idbook])
    REFERENCES [dbo].[BooksSet]
        ([Idbook])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AuthorsBooks_Books'
CREATE INDEX [IX_FK_AuthorsBooks_Books]
ON [dbo].[AuthorsBooks]
    ([Books_Idbook]);
GO

-- Creating foreign key on [Akcii_Idakcii] in table 'BooksSet'
ALTER TABLE [dbo].[BooksSet]
ADD CONSTRAINT [FK_AkciiBooks]
    FOREIGN KEY ([Akcii_Idakcii])
    REFERENCES [dbo].[AkciiSet]
        ([Idakcii])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AkciiBooks'
CREATE INDEX [IX_FK_AkciiBooks]
ON [dbo].[BooksSet]
    ([Akcii_Idakcii]);
GO

-- Creating foreign key on [Sales_Idsale] in table 'SalesBooks'
ALTER TABLE [dbo].[SalesBooks]
ADD CONSTRAINT [FK_SalesBooks_Sales]
    FOREIGN KEY ([Sales_Idsale])
    REFERENCES [dbo].[SalesSet]
        ([Idsale])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Books_Idbook] in table 'SalesBooks'
ALTER TABLE [dbo].[SalesBooks]
ADD CONSTRAINT [FK_SalesBooks_Books]
    FOREIGN KEY ([Books_Idbook])
    REFERENCES [dbo].[BooksSet]
        ([Idbook])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SalesBooks_Books'
CREATE INDEX [IX_FK_SalesBooks_Books]
ON [dbo].[SalesBooks]
    ([Books_Idbook]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------

-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/16/2023 22:00:56
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

IF OBJECT_ID(N'[dbo].[FK_UsersBooks]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BooksSet] DROP CONSTRAINT [FK_UsersBooks];
GO
IF OBJECT_ID(N'[dbo].[FK_GenreBooks]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BooksSet] DROP CONSTRAINT [FK_GenreBooks];
GO
IF OBJECT_ID(N'[dbo].[FK_AuthorsBooks_Authors]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[AuthorsBooks] DROP CONSTRAINT [FK_AuthorsBooks_Authors];
GO
IF OBJECT_ID(N'[dbo].[FK_AuthorsBooks_Books]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[AuthorsBooks] DROP CONSTRAINT [FK_AuthorsBooks_Books];
GO
IF OBJECT_ID(N'[dbo].[FK_SalesBooks_Sales]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SalesBooks] DROP CONSTRAINT [FK_SalesBooks_Sales];
GO
IF OBJECT_ID(N'[dbo].[FK_SalesBooks_Books]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SalesBooks] DROP CONSTRAINT [FK_SalesBooks_Books];
GO
IF OBJECT_ID(N'[dbo].[FK_AkciiBooks]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BooksSet] DROP CONSTRAINT [FK_AkciiBooks];
GO
IF OBJECT_ID(N'[dbo].[FK_BooksBooks_Books]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BooksBooks] DROP CONSTRAINT [FK_BooksBooks_Books];
GO
IF OBJECT_ID(N'[dbo].[FK_BooksBooks_Books1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BooksBooks] DROP CONSTRAINT [FK_BooksBooks_Books1];
GO
IF OBJECT_ID(N'[dbo].[FK_PublisherBooks]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BooksSet] DROP CONSTRAINT [FK_PublisherBooks];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[UsersSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UsersSet];
GO
IF OBJECT_ID(N'[dbo].[BooksSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BooksSet];
GO
IF OBJECT_ID(N'[dbo].[AuthorsSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AuthorsSet];
GO
IF OBJECT_ID(N'[dbo].[GenreSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GenreSet];
GO
IF OBJECT_ID(N'[dbo].[SalesSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SalesSet];
GO
IF OBJECT_ID(N'[dbo].[AkciiSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AkciiSet];
GO
IF OBJECT_ID(N'[dbo].[PublisherSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PublisherSet];
GO
IF OBJECT_ID(N'[dbo].[AuthorsBooks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AuthorsBooks];
GO
IF OBJECT_ID(N'[dbo].[SalesBooks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SalesBooks];
GO
IF OBJECT_ID(N'[dbo].[BooksBooks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BooksBooks];
GO

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
    [Count] int  NOT NULL,
    [Cost_self] int  NULL,
    [Pages] int  NULL,
    [Users_Iduser] int  NULL,
    [Genre_IdGenre] int  NOT NULL,
    [Authors_IdAuthor] int  NOT NULL,
    [Akcii_Idakcii] int  NULL,
    [Publisher_Idpublisher] int  NOT NULL
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

-- Creating table 'PublisherSet'
CREATE TABLE [dbo].[PublisherSet] (
    [Idpublisher] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'SalesBooks'
CREATE TABLE [dbo].[SalesBooks] (
    [Sales_Idsale] int  NOT NULL,
    [Books_Idbook] int  NOT NULL
);
GO

-- Creating table 'BooksBooks'
CREATE TABLE [dbo].[BooksBooks] (
    [is_parts_Idbook] int  NOT NULL,
    [parts_Idbook] int  NOT NULL
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

-- Creating primary key on [Idpublisher] in table 'PublisherSet'
ALTER TABLE [dbo].[PublisherSet]
ADD CONSTRAINT [PK_PublisherSet]
    PRIMARY KEY CLUSTERED ([Idpublisher] ASC);
GO

-- Creating primary key on [Sales_Idsale], [Books_Idbook] in table 'SalesBooks'
ALTER TABLE [dbo].[SalesBooks]
ADD CONSTRAINT [PK_SalesBooks]
    PRIMARY KEY CLUSTERED ([Sales_Idsale], [Books_Idbook] ASC);
GO

-- Creating primary key on [is_parts_Idbook], [parts_Idbook] in table 'BooksBooks'
ALTER TABLE [dbo].[BooksBooks]
ADD CONSTRAINT [PK_BooksBooks]
    PRIMARY KEY CLUSTERED ([is_parts_Idbook], [parts_Idbook] ASC);
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

-- Creating foreign key on [Authors_IdAuthor] in table 'BooksSet'
ALTER TABLE [dbo].[BooksSet]
ADD CONSTRAINT [FK_AuthorsBooks]
    FOREIGN KEY ([Authors_IdAuthor])
    REFERENCES [dbo].[AuthorsSet]
        ([IdAuthor])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AuthorsBooks'
CREATE INDEX [IX_FK_AuthorsBooks]
ON [dbo].[BooksSet]
    ([Authors_IdAuthor]);
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

-- Creating foreign key on [is_parts_Idbook] in table 'BooksBooks'
ALTER TABLE [dbo].[BooksBooks]
ADD CONSTRAINT [FK_BooksBooks_Books]
    FOREIGN KEY ([is_parts_Idbook])
    REFERENCES [dbo].[BooksSet]
        ([Idbook])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [parts_Idbook] in table 'BooksBooks'
ALTER TABLE [dbo].[BooksBooks]
ADD CONSTRAINT [FK_BooksBooks_Books1]
    FOREIGN KEY ([parts_Idbook])
    REFERENCES [dbo].[BooksSet]
        ([Idbook])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BooksBooks_Books1'
CREATE INDEX [IX_FK_BooksBooks_Books1]
ON [dbo].[BooksBooks]
    ([parts_Idbook]);
GO

-- Creating foreign key on [Publisher_Idpublisher] in table 'BooksSet'
ALTER TABLE [dbo].[BooksSet]
ADD CONSTRAINT [FK_PublisherBooks]
    FOREIGN KEY ([Publisher_Idpublisher])
    REFERENCES [dbo].[PublisherSet]
        ([Idpublisher])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PublisherBooks'
CREATE INDEX [IX_FK_PublisherBooks]
ON [dbo].[BooksSet]
    ([Publisher_Idpublisher]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------
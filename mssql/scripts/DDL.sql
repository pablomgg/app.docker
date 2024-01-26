CREATE DATABASE [Example]; 
GO 

USE [Example]; 
GO  

-- DROP ALL TABLES -------------------------------------------------
-- BEGIN
-- 	BEGIN TRY
-- 		BEGIN TRANSACTION;
		    
-- 			DROP TABLE dbo.PersonEmail
-- 			DROP TABLE dbo.PersonEmailType
-- 			DROP TABLE dbo.PersonPhysicalCpf
-- 			DROP TABLE dbo.PersonPhysical
-- 			DROP TABLE dbo.PersonPhysicalGender
-- 			DROP TABLE dbo.PersonLegal
-- 			DROP TABLE dbo.PersonType
-- 			DROP TABLE dbo.Person

-- 		IF @@TRANCOUNT > 0
-- 			COMMIT;
-- 	END TRY
-- 	BEGIN CATCH
-- 		IF @@TRANCOUNT > 0
-- 			ROLLBACK;
-- 		SELECT ERROR_NUMBER() AS ErrorNumber;
-- 		SELECT ERROR_MESSAGE() AS ErrorMessage;
-- 	END CATCH;
-- END;
-- DROP ALL TABLES -------------------------------------------------

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PersonType'))
	BEGIN
		CREATE TABLE [PersonType] (
			[Id] int NOT NULL,
			[Name] varchar(25) NOT NULL,
		CONSTRAINT [PK_PersonType] PRIMARY KEY ([Id])
		);
		
		PRINT 'Created table PersonType';
	END
ELSE
	PRINT 'Table PersonType exist';
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Person'))
	BEGIN
		CREATE TABLE Person ( 
			Id int not null identity(1,1), 
			AggregateId uniqueidentifier not null, 
			CreatedAt dateTime not null, 
			Name varchar(255) not null,  
			TypeId int null, 
			Actived bit not null, 
			CONSTRAINT PK_Person PRIMARY KEY (Id),
			CONSTRAINT UK_Person UNIQUE(AggregateId)
		);
		
		PRINT 'Created table Person';
	END
ELSE
	PRINT 'Table Person exist';
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PersonPhysicalGender'))
	BEGIN
		CREATE TABLE [PersonPhysicalGender] ( 
			[Id] int NOT NULL, 
			[Name] varchar(255) NOT NULL, 
		  CONSTRAINT [PK_PersonPhysicalGender] PRIMARY KEY ([Id]) 
		);
		
		PRINT 'Created table PersonPhysicalGender';
	END
ELSE
	PRINT 'Table PersonPhysicalGender exist';
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PersonPhysical'))
	BEGIN
		CREATE TABLE [PersonPhysical] ( 
			[PersonId] int NOT NULL,  
			[NameSocial] varchar(255) NULL, 
			[GenderId] int NOT NULL, 
			[CreatedAt] datetime not null,
			CONSTRAINT [PK_PersonPhysical] PRIMARY KEY ([PersonId]), 
			CONSTRAINT [FK_PersonPhysical_Person] FOREIGN KEY ([PersonId]) REFERENCES [Person] ([Id]), 
			CONSTRAINT [FK_PersonPhysical_PersonPhysicalGender] FOREIGN KEY ([GenderId]) REFERENCES [PersonPhysicalGender] ([Id]) 
		);
		
		PRINT 'Created table PersonPhysical';
	END
ELSE
	PRINT 'Table PersonPhysical exist';
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PersonPhysicalCpf'))
	BEGIN
		CREATE TABLE [PersonPhysicalCpf] ( 
			[PersonId] int NOT NULL, 
			[Number] varchar(11) NOT NULL, 
			[CreatedAt] Datetime NOT NULL, 
			[Archive] VARCHAR(4000) NULL, 
			CONSTRAINT [PK_PersonPhysicalCpf] PRIMARY KEY ([PersonId]), 
			CONSTRAINT [FK_PersonPhysicalCpf_PersonPhysical] FOREIGN KEY ([PersonId]) REFERENCES [PersonPhysical] ([PersonId]) 
		);
		
		PRINT 'Created table PersonPhysicalCpf';
	END
ELSE
	PRINT 'Table PersonPhysicalCpf exist';
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PersonLegal'))
	BEGIN
		CREATE TABLE [PersonLegal] ( 
			[PersonId] int NOT NULL, 
			[Cnpj] VARCHAR(14) NULL, 
			[OpenedAt] DATE NULL, 
			[NameFantasy] VARCHAR(255) NULL, 
			[StateRegistration] VARCHAR(30) NULL, 
			[CountyRegistration] VARCHAR(30) NULL,
			[CreatedAt] Datetime NOT NULL,
			CONSTRAINT [PK_PersonLegal] PRIMARY KEY ([PersonId]), 
			CONSTRAINT [FK_PersonLegal_Person] FOREIGN KEY ([PersonId]) REFERENCES [Person] ([Id]) 
		);
		
		PRINT 'Created table PersonLegal';
	END
ELSE
	PRINT 'Table PersonLegal exist';
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PersonEmailType'))
	BEGIN
		CREATE TABLE PersonEmailType ( 
			Id int not null, 
			Name varchar(120) not null,
			Actived bit not null,
			CONSTRAINT PK_PersonEmailType PRIMARY KEY (Id) 
		);
		
		PRINT 'Created table PersonEmailType';
	END
ELSE
	PRINT 'Table PersonEmailType exist';
GO

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'PersonEmail'))
	BEGIN
		CREATE TABLE PersonEmail ( 
			Id int not null identity(1,1), 
			PersonId int not null, 
			Address varchar(120) not null, 
			TypeId int not null, 
			CONSTRAINT PK_PersonEmail PRIMARY KEY (Id), 
			CONSTRAINT FK_PersonEmail_Person FOREIGN KEY (PersonId) REFERENCES Person (Id), 
			CONSTRAINT FK_PersonEmail_PersonEmailType FOREIGN KEY (TypeId) REFERENCES PersonEmailType (Id) 
		);
		
		PRINT 'Created table PersonEmail';
	END
ELSE
	PRINT 'Table PersonEmail exist';
GO
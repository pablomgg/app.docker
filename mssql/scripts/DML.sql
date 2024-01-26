PRINT 'Generate values initial';
USE [Example]; 
GO

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
		    
            INSERT INTO [dbo].[PersonType] (Id, Name) values (1, 'Pessoa Fisica'), (2, 'Pessoa Juridica');
            INSERT INTO [dbo].[PersonPhysicalGender] (Id, Name) values (1, 'Feminino'), (2, 'Masculino');
            INSERT INTO [dbo].[PersonEmailType] (Id, Name, Actived) values (1, 'Particular', 1), (2, 'Funcional', 1);

            PRINT 'Generated successful';

		IF @@TRANCOUNT > 0
			COMMIT;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;
		SELECT ERROR_NUMBER() AS ErrorNumber;
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END;
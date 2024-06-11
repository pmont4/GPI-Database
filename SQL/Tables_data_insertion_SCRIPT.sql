-- Engineer insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_engineer
	@name VARCHAR(100),
	@contact VARCHAR(100)
AS
	BEGIN TRY
		INSERT INTO report.engineer_table (engineer_name, engineer_contact)
		VALUES (@name, @contact);
		BEGIN
			PRINT CONCAT('The engineer "', @name, '" was correctly saved in the database');
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the engineer "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;

CREATE OR ALTER TRIGGER report.trigger_engineer_null_verifications
ON report.engineer_table 
AFTER INSERT
AS
	DECLARE
		@id INT,
		@contact VARCHAR(100);
	BEGIN
		SET @contact = (SELECT i.engineer_contact FROM inserted i);
		SET @id = (SELECT i.id_engineer FROM inserted i);

		BEGIN
			IF (@contact = '')
				UPDATE report.engineer_table 
				SET engineer_contact = NULL 
				WHERE id_engineer = @id;
		END;
	END;

DECLARE @engineer_contact AS VARCHAR(100)
DECLARE @engineer_id AS INT

DECLARE cursor_data_verifiying_engineer CURSOR DYNAMIC FORWARD_ONLY
	FOR 
		SELECT e.id_engineer, e.engineer_contact FROM report.engineer_table e
		FOR UPDATE OF engineer_contact
OPEN cursor_data_verifiying_engineer
FETCH NEXT FROM cursor_data_verifiying_engineer INTO @engineer_id, @engineer_contact
WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@engineer_contact = '')
			UPDATE report.engineer_table SET engineer_contact = NULL WHERE CURRENT OF cursor_data_verifiying_engineer
		FETCH NEXT FROM cursor_data_verifiying_engineer INTO @engineer_id, @engineer_contact
	END;
CLOSE cursor_data_verifiying_engineer
DEALLOCATE cursor_data_verifiying_engineer
--
-- Executable insertion engineer data.

EXEC report.proc_insert_engineer 'Jorge Cifuentes Garcia', 'jcifuentes@gpiconsultingservices.com';

-- Client insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_client
	@name VARCHAR(100)
AS
	BEGIN TRY
		INSERT INTO report.client_table(client_name)
		VALUES (@name);
		BEGIN
			PRINT CONCAT('The client "', @name, '" was correctly saved in the database');
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the client "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion client data.

EXEC report.proc_insert_client 'Seguros Universales S.A.';

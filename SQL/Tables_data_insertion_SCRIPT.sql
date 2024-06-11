-- Engineer insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_engineer
	@name VARCHAR(100),
	@contact VARCHAR(100)
AS
	BEGIN TRY
		IF (@name != '')
			INSERT INTO report.engineer_table (engineer_name, engineer_contact)
			VALUES (@name, @contact);
			PRINT CONCAT('The engineer "', @name, '" was correctly saved in the database');
		IF (@name = '' OR @name IS NULL)
			PRINT 'You cannot left the engineer name in blank.';
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
		IF (@name != '')
			INSERT INTO report.client_table(client_name)
			VALUES (@name);
			PRINT CONCAT('The client "', @name, '" was correctly saved in the database');
		IF (@name = '' OR @name IS NULL)
			PRINT 'You cannot left the client name in blank.';
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the client "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion client data.

EXEC report.proc_insert_client 'Seguros Universales S.A.';

-- Capacity type insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_capacity_type
	@name VARCHAR(100)
AS
	BEGIN TRY
		BEGIN
			IF (@name != '')
				INSERT INTO report.capacity_type_table(capacity_type_name)
				VALUES (@name);
				PRINT CONCAT('The capacity type "', @name, '" was correctly saved in the database');
			IF (@name = '' OR @name IS NULL)
				PRINT 'You cannot left the capacity type name in blank.';
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the capacity type "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion capacity type data

EXEC report.proc_insert_capacity_type 'Tons / year';

-- Merchandise class insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_merchandise_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		BEGIN
			IF (@name != '')
				INSERT INTO report.merchandise_classification_type_table(merchandise_classification_type_name)
				VALUES (@name);
				PRINT CONCAT('The merchandise class "', @name, '" was correctly saved in the database');
			IF (@name = '' OR @name IS NULL)
				PRINT 'You cannot left the merchandise class name in blank.';
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the merchandise class "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion merchandise class data

EXEC report.proc_insert_merchandise_class 'I';
EXEC report.proc_insert_merchandise_class 'II';
EXEC report.proc_insert_merchandise_class 'III';
EXEC report.proc_insert_merchandise_class 'IV';

-- Hydrant protection clas data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_hydrant_protection_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		BEGIN
			IF (@name != '')
				INSERT INTO report.hydrant_protection_classification_table(hydrant_protection_classification_name)
				VALUES (@name);
				PRINT CONCAT('The hydrant protection class "', @name, '" was correctly saved in the database');
			IF (@name = '' OR @name IS NULL)
				PRINT 'You cannot left the hydrant protection class name in blank.';
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the hydrant protection class "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion hydrant protection class data

EXEC report.proc_insert_hydrant_protection_class 'Major fires';
EXEC report.proc_insert_hydrant_protection_class 'Minor fires';
EXEC report.proc_insert_hydrant_protection_class 'Major & Minor fires';

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

-- Hydrant protection class data scripts
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

-- Hydrant standpipe type data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_hydrant_standpipe_type
	@name VARCHAR(100)
AS
	BEGIN TRY
		BEGIN
			IF (@name != '')
				INSERT INTO report.hydrant_standpipe_system_type_table(hydrant_standpipe_system_type_name)
				VALUES (@name);
				PRINT CONCAT('The hydrant standpipe type "', @name, '" was correctly saved in the database');
			IF (@name = '' OR @name IS NULL)
				PRINT 'You cannot left the hydrant standpipe type  name in blank.';
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the hydrant standpipe type  "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion hydrant standpipe type data

EXEC report.proc_insert_hydrant_standpipe_type 'Automatic Dry';
EXEC report.proc_insert_hydrant_standpipe_type 'Automatic Wet';
EXEC report.proc_insert_hydrant_standpipe_type 'Manual Dry';
EXEC report.proc_insert_hydrant_standpipe_type 'Manual Wet';
EXEC report.proc_insert_hydrant_standpipe_type 'Semiautomatic Dry';

-- Hydrant standpipe class data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_hydrant_standpipe_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		BEGIN
			IF (@name != '')
				INSERT INTO report.hydrant_standpipe_system_class_table(hydrant_standpipe_system_class_name)
				VALUES (@name);
				PRINT CONCAT('The hydrant standpipe class "', @name, '" was correctly saved in the database');
			IF (@name = '' OR @name IS NULL)
				PRINT 'You cannot left the hydrant standpipe class  name in blank.';
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the hydrant standpipe class  "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion hydrant standpipe class data

EXEC report.proc_insert_hydrant_standpipe_class 'I';
EXEC report.proc_insert_hydrant_standpipe_class 'II';
EXEC report.proc_insert_hydrant_standpipe_class 'III';

-- Plant table date scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_plant
	@account_name AS VARCHAR(100),
	@name AS VARCHAR(100),
	@continent AS VARCHAR(100),
	@country AS VARCHAR(100),
	@state AS VARCHAR(100),
	@construction_year AS INT,
	@operation_startup_year AS INT,
	@address AS VARCHAR(100),
	@latitude AS VARCHAR(30),
	@longitude AS VARCHAR(30),
	@meters_above_sea_level AS INT
AS
	BEGIN TRY
		DECLARE
			@date_construction_year AS DATETIME,
			@date_operation_startup AS DATETIME
		BEGIN
			IF (@account_name != '' AND @continent != '' AND @country != '' AND @state != '')
				BEGIN
					IF (@name IS NULL)
						SET @name = @account_name;
					IF (@construction_year IS NOT NULL)
						SET @date_construction_year = DATEFROMPARTS(@construction_year, 1, 1);
					ELSE 
						SET @date_construction_year = NULL;
					IF (@operation_startup_year IS NOT NULL)
						SET @date_operation_startup = DATEFROMPARTS(@operation_startup_year, 1, 1);
					ELSE
						SET @date_construction_year = NULL;

					BEGIN
						INSERT INTO report.plant_table (plant_account_name, plant_name, plant_continent, plant_country, plant_country_state, 
														plant_construction_year, plant_operation_startup_year, plant_address, plant_latitude, plant_longitude, 
														plant_meters_above_sea_level)
														VALUES (@account_name, @name, @continent, @country, @state, @date_construction_year, @date_operation_startup,
																@address, @latitude, @longitude, @meters_above_sea_level);
						PRINT CONCAT('The plant "', @name, '" was correctly saved in the database');
					END;
				END;
			ELSE
				PRINT ('Cannot insert the data because there are some field left in blank.');
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the plant  "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;

EXEC report.proc_insert_plant 'TATA - Accesorios Globales, S.A.', null, 'C.A.', 'Guatemala', 'Guatemala', 1985, 1985, '2ª. Calle 1-11 y 1-25 Zona 8, Granjas Gerona, San Miguel Petapa, Guatemala, C.A.', 14.533944, -90.593765, 1274;
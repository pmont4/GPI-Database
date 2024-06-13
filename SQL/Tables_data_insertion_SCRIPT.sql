USE gpi_consulting_services_reports_db;

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

-- Type location classification data
--
CREATE OR ALTER PROCEDURE report.proc_type_location_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		BEGIN
			IF (@name != '')
				INSERT INTO report.type_location_classification_table(type_location_class_name)
				VALUES (@name);
				PRINT CONCAT('The type location class "', @name, '" was correctly saved in the database');
			IF (@name = '' OR @name IS NULL)
				PRINT 'You cannot left the type location class name in blank.';
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the type location class  "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;
--
-- Executable insertion type location class data

EXEC report.proc_type_location_class 'Industrial';
EXEC report.proc_type_location_class 'Comercial';
EXEC report.proc_type_location_class 'Residential';
EXEC report.proc_type_location_class 'Rural';

-- Plant table data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_plant
	@account_name AS VARCHAR(100),
	@name AS VARCHAR(100),
	@continent AS VARCHAR(100),
	@country AS VARCHAR(100),
	@state AS VARCHAR(100),
	@construction_year AS INT,
	@operation_startup_year AS INT,
	@certifications AS TEXT NULL,
	@business_turnover AS VARCHAR(50),
	@specific_turnover AS VARCHAR(150),
	@merchandise_classification AS VARCHAR(8),
	@type_location AS VARCHAR(150),
	@address AS VARCHAR(100),
	@latitude AS VARCHAR(30),
	@longitude AS VARCHAR(30),
	@meters_above_sea_level AS INT
AS
	BEGIN TRY
		DECLARE
			@date_construction_year AS DATETIME,
			@date_operation_startup AS DATETIME,
			@id_merchandise AS INT
		BEGIN
			IF (@account_name != '' AND @continent != '' AND @country != '' AND @state != '' AND @business_turnover != '' AND @specific_turnover != '')
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
						IF EXISTS(SELECT business_turnover_name FROM report.business_turnover_class_table WHERE business_turnover_name = @business_turnover)
							BEGIN
								IF EXISTS(SELECT id_merchandise_classification_type FROM report.merchandise_classification_type_table 
																				WHERE merchandise_classification_type_name = @merchandise_classification)
									SET @id_merchandise = (SELECT id_merchandise_classification_type FROM report.merchandise_classification_type_table
																									WHERE merchandise_classification_type_name = @merchandise_classification);
								ELSE
									SET @id_merchandise = null;
							END;
							INSERT INTO report.plant_table (plant_account_name, plant_name, plant_continent, plant_country, plant_country_state, 
															plant_construction_year, plant_operation_startup_year, plant_address, plant_latitude, plant_longitude, 
															plant_meters_above_sea_level, plant_certifications, plant_business_specific_turnover, plant_merchandise_class)
															VALUES (@account_name, @name, @continent, @country, @state, @date_construction_year, @date_operation_startup,
																	@address, @latitude, @longitude, @meters_above_sea_level, @certifications, @specific_turnover, @id_merchandise);
							BEGIN
								IF (@type_location IS NOT NULL)
									DECLARE @val AS VARCHAR(50);
									DECLARE cur CURSOR DYNAMIC FORWARD_ONLY
												FOR SELECT * FROM STRING_SPLIT(@type_location, ',');
									OPEN cur
									FETCH NEXT FROM cur INTO @val;
									WHILE @@FETCH_STATUS = 0
										BEGIN TRY
											IF EXISTS(SELECT type_location_class_name FROM report.type_location_classification_table 
																						WHERE type_location_class_name = @val)
												INSERT INTO report.type_location_table (id_plant, id_type_location_class)
												VALUES ((SELECT MAX(id_plant) FROM report.plant_table), 
														(SELECT id_type_location_class FROM report.type_location_classification_table WHERE type_location_class_name = @val));
											ELSE
												PRINT CONCAT('No values found in type location table for "', @val, '"');
										FETCH NEXT FROM cur INTO @val;
										END TRY
										BEGIN CATCH
											PRINT CONCAT('An error ocurred while trying to insert data in type location table (', ERROR_MESSAGE(), ')');
											CLOSE cur;
											DEALLOCATE cur;
										END CATCH;
									CLOSE cur;
									DEALLOCATE cur;
							END;
							BEGIN
								INSERT INTO report.business_turnover_table (id_plant, id_business_turnover)
								VALUES ((SELECT MAX(id_plant) FROM report.plant_table),
										(SELECT id_business_turnover FROM report.business_turnover_class_table WHERE business_turnover_name = @business_turnover))
							END;
							PRINT CONCAT('The plant "', @name, '" was correctly saved in the database');
						IF NOT EXISTS (SELECT business_turnover_name FROM report.business_turnover_class_table WHERE business_turnover_name = @business_turnover)
							PRINT CONCAT('The business turnover"', @business_turnover ,'" does not match with any existing business turnover on the table');
					END;
				END;
			ELSE
				PRINT ('Cannot insert the data because there are some field left in blank.');
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the plant  "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
	END CATCH;

CREATE OR ALTER TRIGGER trigger_null_verifiying_plant_table
ON report.plant_table
AFTER INSERT AS
	DECLARE
		@id AS INT = (SELECT id_plant FROM inserted),
		@plant_address AS VARCHAR(100),
		@plant_certification AS VARCHAR(200),
		@plant_latitude AS VARCHAR(30),
		@plant_longitude AS VARCHAR(30),
		@plant_meters_above_sea_level AS INT
	DECLARE cur CURSOR DYNAMIC FORWARD_ONLY
				FOR SELECT i.plant_address, i.plant_certifications, i.plant_latitude, i.plant_longitude, i.plant_meters_above_sea_level FROM inserted i;
	OPEN cur;
	FETCH NEXT FROM cur INTO @plant_address, @plant_certification, @plant_latitude, @plant_longitude, @plant_meters_above_sea_level
	WHILE @@FETCH_STATUS = 0
		BEGIN TRY
			IF (@plant_address IS NULL)
				SET @plant_address = 'No address';
			IF (@plant_certification IS NULL)
				SET @plant_certification = 'No certifications';
			IF (@plant_latitude IS NULL)
				SET @plant_latitude = 'No latitude';
			IF (@plant_longitude IS NULL)
				SET @plant_longitude = 'No longitude';
			IF (@plant_meters_above_sea_level IS NULL)
				SET @plant_meters_above_sea_level = 0;
			UPDATE plant_table SET plant_address = @plant_address, plant_certifications = @plant_certification, plant_latitude = @plant_latitude, 
									plant_longitude = @plant_longitude, plant_meters_above_sea_level = @plant_meters_above_sea_level
									WHERE id_plant = @id;
										
			FETCH NEXT FROM cur INTO @plant_address, @plant_certification, @plant_latitude, @plant_longitude, @plant_meters_above_sea_level
		END TRY
		BEGIN CATCH
			PRINT CONCAT('An error ocurred while attempting to update the plant table (', ERROR_MESSAGE(), ')');
			CLOSE cur;
			DEALLOCATE cur;
		END CATCH;
	CLOSE cur;
	DEALLOCATE cur;
--
-- Executable insertion plant data

EXEC report.proc_insert_plant 'TATA - Accesorios Globales, S.A.', null, 'C.A.', 'Guatemala', 'Guatemala', 1985, 1985, null, 'Production', 'Manufacture of natural and synthetic leather belts for export', 'III', 'Industrial,Residential', '2ª. Calle 1-11 y 1-25 Zona 8, Granjas Gerona, San Miguel Petapa, Guatemala, C.A.', 14.533944, -90.593765, 1274;
EXEC report.proc_insert_plant 'Sidegua Steel Park', null, 'C.A.', 'Guatemala', 'Escuintla', 1991, 1994, 'ASTM, COGUANOR, ACI, INTECO', 'Production', 'Steel Casting', '0','Industrial,Rural', 'Km 65.5 CA9-A Highway, Masagua, Escuintla, Guatemala, C.A.', 14.533944, -90.593765, 1274;
EXEC report.proc_insert_plant 'Industria de Tubos y Perfiles, S.A. - INTUPERSA', null, 'C.A.', 'Guatemala', 'Guatemala', 1961, 1961, null, 'Production', 'Manufacturing and commercialization of steel pipes and profiles', 'I','Industrial,Residential', '9ª. Avenida 3-17 Z.2 Mixco, Colonia Alvarado, Guatemala, Guatemala', 14.628646, -90.578844, 1596;

-- Report table data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_report
	@date AS VARCHAR(20),
	@id_client AS INT,
	@id_plant AS INT,
	@prepared_by AS VARCHAR(250)
AS
	BEGIN TRY
		IF EXISTS(SELECT id_client FROM report.client_table WHERE id_client = @id_client)
			IF EXISTS(SELECT id_plant FROM report.plant_table WHERE id_plant = @id_plant)
				IF (@prepared_by IS NOT NULL)
					BEGIN
						IF (@date LIKE '%/%')
							DECLARE 
								@day AS INT,
								@month AS VARCHAR(10),
								@year AS INT
							BEGIN
								DECLARE @date_to_save AS DATETIME;

								DECLARE @value_date AS INT;
								DECLARE cur_date CURSOR DYNAMIC FORWARD_ONLY
													FOR SELECT * FROM STRING_SPLIT(@date, '/');
								OPEN cur_date;
								FETCH NEXT FROM cur_date INTO @value_date;
								WHILE @@FETCH_STATUS = 0
									BEGIN TRY
										IF ((SELECT ISNUMERIC(@value_date)) = 1)
											IF (@value_date > 2000 AND @value_date < 2100)
												SET @year = @value_date;
											ELSE
												IF (@value_date >= 1 AND @value_date <= 31)
													SET @day = @value_date
										ELSE
											SET @month = (SELECT CASE 
																	WHEN @value_date = 'january' THEN '1'
																	WHEN @value_date = 'february' THEN '2'
																	WHEN @value_date = 'march' THEN '3'
																	WHEN @value_date = 'april' THEN '4'
																	WHEN @value_date = 'may' THEN '5'
																	WHEN @value_date = 'june' THEN '6'
																	WHEN @value_date = 'july' THEN '7'
																	WHEN @value_date = 'agost' THEN '8'
																	WHEN @value_date = 'september' THEN '9'
																	WHEN @value_date = 'october' THEN '10'
																	WHEN @value_date = 'november' THEN '11'
																	WHEN @value_date = 'december' THEN '12'
																	ELSE '1'
																 END);
										FETCH NEXT FROM cur_date INTO @value_date;
									END TRY
									BEGIN CATCH
										PRINT CONCAT('An error ocurred while attempting to save the report date (', ERROR_MESSAGE(), ')');
										CLOSE cur_date;
										DEALLOCATE cur_date;
									END CATCH;
								CLOSE cur_date;
								DEALLOCATE cur_date;

								SET @date_to_save = DATEFROMPARTS(@year, @month, @day);
								BEGIN
									INSERT INTO report.report_table (report_date, id_client, id_plant)
									VALUES (@date_to_save, @id_client, @id_plant);
								END;
							END;
					END;
				ELSE
					PRINT 'Cannot leave the engineer field empty.';
			ELSE
				PRINT CONCAT('The id (', @id_plant,') was not found in the plant table.');
		ELSE
			PRINT CONCAT('The id (', @id_client, ') was not found in the client table.');
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the report due to this error (', ERROR_MESSAGE(), ')');
	END CATCH;
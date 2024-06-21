USE gpi_consulting_services_reports_db;

-- Useful function for data insertion

CREATE OR ALTER FUNCTION report.REMOVE_EXTRA_SPACES(@input VARCHAR(150))
RETURNS VARCHAR(150)
AS
	BEGIN
		SET @input = LTRIM(RTRIM(@input));

		DECLARE @output VARCHAR(150);
		SET @output = '';
		DECLARE @i INT = 1;
		DECLARE @len INT = LEN(@input);
		DECLARE @prevChar VARCHAR(1) = '';

		WHILE @i <= @len
		BEGIN
			DECLARE @char VARCHAR(1) = SUBSTRING(@input, @i, 1);
			IF NOT(@char = ' ' AND @prevChar = ' ')
				SET @output = @output + @char;
				SET @prevChar = @char;
				SET @i = @i + 1;
		END;
		RETURN @output;
	END;

CREATE OR ALTER FUNCTION report.CORRECT_GRAMMAR(@text VARCHAR(150), @type_text VARCHAR(10))
RETURNS VARCHAR(150)
AS
	BEGIN
		DECLARE @type AS VARCHAR(10) = (SELECT CASE
												WHEN LOWER(@type_text) = 'name' THEN 'name'
												WHEN LOWER(@type_text) = 'paragraph' THEN 'paragraph'
												ELSE 'paragraph'
											END);

		DECLARE @toReturn AS VARCHAR(100);
		IF (@type = 'name')
			BEGIN
				IF (@text LIKE '% %')
					BEGIN
						SET @text = report.REMOVE_EXTRA_SPACES(@text);

						DECLARE @text_value AS VARCHAR(50);
						DECLARE text_cur CURSOR DYNAMIC FORWARD_ONLY
										FOR SELECT * FROM STRING_SPLIT(@text, ' ');
						OPEN text_cur;
						FETCH NEXT FROM text_cur INTO @text_value;
						WHILE @@FETCH_STATUS = 0
							BEGIN
								IF (@toReturn IS NULL) SET @toReturn = '';
						
								IF (UPPER(@text_value) = 'S.A.')
									SET @toReturn = CONCAT(@toReturn, UPPER(@text_value));

								SET @toReturn = CONCAT(@ToReturn, UPPER(LEFT(@text_value, 1)),
														LOWER(RIGHT(@text_value, LEN(@text_value) -1)), ' ');
								FETCH NEXT FROM text_cur INTO @text_value;
							END;
						CLOSE text_cur;
						DEALLOCATE text_cur;
					END;
				ELSE IF (@text NOT LIKE '% %')
					BEGIN
						SET @text = TRIM(@text);

						SET @toReturn = CONCAT(UPPER(LEFT(@text, 1)),
											LOWER(RIGHT(@text, LEN(@text) -1)));
					END;
			END;
		ELSE IF (@type = 'paragraph')
			BEGIN
				SET @text = report.REMOVE_EXTRA_SPACES(@text);
				SET @text = CONCAT(UPPER(LEFT(@text, 1)),
									LOWER(RIGHT(@text, LEN(@text) -1)));
				SET @toReturn = @text;
			END;
		RETURN @ToReturn;
	END;

CREATE OR ALTER FUNCTION report.CONSTRUCT_DATE(@date_to_parse VARCHAR(20))
RETURNS DATETIME
AS
	BEGIN
		DECLARE @to_return AS DATETIME;
		SET @date_to_parse = report.REMOVE_EXTRA_SPACES(@date_to_parse);

		IF (@date_to_parse IS NOT NULL)
			IF (@date_to_parse LIKE '%/%' OR @date_to_parse LIKE '%-%')
				BEGIN
					DECLARE
						@char_to_separate AS CHAR,
						@day AS INT,
						@month AS INT,
						@year AS INT;

					SET @char_to_separate = (SELECT CASE
														WHEN @date_to_parse LIKE '%/%' THEN '/'
														WHEN @date_to_parse LIKE '%-%' THEN '-'
													END);

					DECLARE @value AS VARCHAR(20);
					DECLARE cur_date CURSOR DYNAMIC FORWARD_ONLY
										FOR (SELECT * FROM STRING_SPLIT(@date_to_parse, @char_to_separate));
					OPEN cur_date
					FETCH NEXT FROM cur_date INTO @value
					WHILE @@FETCH_STATUS = 0
						BEGIN
							IF (@value != '')
								IF ((SELECT TRY_CAST(@value AS INT)) IS NOT NULL)
									BEGIN
										IF (CAST(@value AS INT) >= 1 AND CAST(@value AS INT) <= 31)
											SET @day = @value;
										ELSE
											SET @day = 1;
										IF (CAST(@value AS INT) >= 2010 AND CAST(@value AS INT) <= 2040)
											SET @year = @value;
										ELSE
											SET @year = 2010
									END;
								ELSE IF ((SELECT TRY_CAST(@value AS INT)) IS NULL)
									BEGIN
										SET @month = (SELECT CASE
																WHEN LOWER(@month) = 'january' OR LOWER(@month) = 'enero' THEN 1
																WHEN LOWER(@month) = 'february' OR LOWER(@month) = 'febrero' THEN 2
																WHEN LOWER(@month) = 'march' OR LOWER(@month) = 'marzo' THEN 3
																WHEN LOWER(@month) = 'april' OR LOWER(@month) = 'abril' THEN 4
																WHEN LOWER(@month) = 'may' OR LOWER(@month) = 'mayo' THEN 5
																WHEN LOWER(@month) = 'june' OR LOWER(@month) = 'junio' THEN 6
																WHEN LOWER(@month) = 'july' OR LOWER(@month) = 'julio' THEN 7
																WHEN LOWER(@month) = 'agost' OR LOWER(@month) = 'agosto' THEN 8
																WHEN LOWER(@month) = 'september' OR LOWER(@month) = 'septiembre' THEN 9
																WHEN LOWER(@month) = 'october' OR LOWER(@month) = 'octubre' THEN 10
																WHEN LOWER(@month) = 'november' OR LOWER(@month) = 'noviembre' THEN 11
																WHEN LOWER(@month) = 'december' OR LOWER(@month) = 'diciembre' THEN 12
																ELSE 1
															END);
									END;
						END;
						FETCH NEXT FROM cur_date INTO @value
					CLOSE cur_date;
					DEALLOCATE cur_date;
					SET @to_return = DATEFROMPARTS(@year, @day, @month);
				END;
			ELSE 
				SET @to_return = GETDATE();
		ELSE
			SET @to_return = GETDATE();
		RETURN @to_return;
	END;

CREATE OR ALTER FUNCTION report.DETERMINATE_RATE_OF_RISK(@rate AS VARCHAR(20))
RETURNS FLOAT
AS
	BEGIN
		SET @rate = report.REMOVE_EXTRA_SPACES(@rate);

		DECLARE @to_return AS FLOAT;
		IF (@rate IS NULL)
			SET @to_return = 0.0;
		IF ((SELECT TRY_CAST(@rate AS FLOAT)) IS NULL)
			BEGIN
				SET @to_return = (SELECT CASE
											WHEN LOWER(@rate) = 'none' THEN 0.0
											WHEN LOWER(@rate) = 'light' THEN 1.0
											WHEN LOWER(@rate) = 'light/moderate' THEN 1.5
											WHEN LOWER(@rate) = 'moderate' THEN 2.0
											WHEN LOWER(@rate) = 'moderate/severe' THEN 2.5
											WHEN LOWER(@rate) = 'severe' THEN 3.0
											ELSE 0.0
										END);
			END;
		ELSE IF ((SELECT TRY_CAST(@rate AS FLOAT)) IS NOT NULL)
			BEGIN
				SET @to_return = (SELECT CASE
											WHEN CAST(@rate AS FLOAT(2)) >= 0.0 AND CAST(@rate AS FLOAT(2)) < 1.0 THEN 0.0
											WHEN CAST(@rate AS FLOAT(2)) >= 1.0 AND CAST(@rate AS FLOAT(2)) < 1.5 THEN 1.0
											WHEN CAST(@rate AS FLOAT(2)) >= 1.5 AND CAST(@rate AS FLOAT(2)) < 2.0 THEN 1.5
											WHEN CAST(@rate AS FLOAT(2)) >= 2.0 AND CAST(@rate AS FLOAT(2)) < 2.5 THEN 2.0
											WHEN CAST(@rate AS FLOAT(2)) >= 2.5 AND CAST(@rate AS FLOAT(2)) < 3.0 THEN 2.5
											WHEN CAST(@rate AS FLOAT(2)) >= 3.0 THEN 3.0
											ELSE 0.0
										END);
			END;
		RETURN @to_return;
	END;

CREATE OR ALTER FUNCTION report.CALCULATE_BIT_TO_SAVE(@value VARCHAR(8))
RETURNS BIT
AS
	BEGIN
		DECLARE @to_return AS BIT;
		IF (@value IS NOT NULL)
			BEGIN
				IF ((SELECT TRY_CAST(@value AS INT)) IS NULL)
					BEGIN
						SET @to_return = (SELECT CASE
													WHEN LOWER(@value) = 'yes' OR LOWER(@value) = 'si' OR LOWER(@value) = 'true' OR LOWER(@value) = 'verdadero' THEN 1
													WHEN LOWER(@value) = 'no' OR LOWER(@value) = 'false' OR LOWER(@value) = 'falso' THEN 0
													ELSE 0
												END);
					END;
				ELSE IF ((SELECT TRY_CAST(@value AS INT)) IS NOT NULL)
					IF (CAST(@value AS INT) >= 0 AND CAST(@value AS INT) <= 1)
						BEGIN
							SET @to_return = CAST(@value AS BIT);
						END;
					ELSE
						SET @to_return = 0;
			END;
		RETURN @to_return;
	END;
-- ------------------------------------

-- Engineer insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_engineer
	@name VARCHAR(100),
	@contact VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_engineer AS VARCHAR(45) = 'insert_engineer';
		BEGIN TRANSACTION @tran_insert_engineer
			IF (@name != '')
				BEGIN
					INSERT INTO report.engineer_table (engineer_name, engineer_contact)
					VALUES (report.CORRECT_GRAMMAR(@name, 'name'), @contact);
					PRINT CONCAT('The engineer "', report.CORRECT_GRAMMAR(@name, 'name'), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_engineer;
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the engineer name in blank.';
					ROLLBACK TRANSACTION @tran_insert_engineer;
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the engineer "', report.CORRECT_GRAMMAR(@name, 'name'),'" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_engineer;
	END CATCH;
--

-- Client insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_client
	@name VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_client AS VARCHAR(45) = 'insert_client';
		BEGIN TRANSACTION @tran_insert_client
			IF (@name != '')
				BEGIN
					INSERT INTO report.client_table(client_name)
					VALUES (report.CORRECT_GRAMMAR(@name, 'name'));
					PRINT CONCAT('The client "', report.CORRECT_GRAMMAR(@name, 'name'), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_client;
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the client name in blank.';
					ROLLBACK TRANSACTION @tran_insert_client;
				END;
	END TRY
	BEGIN CATCH 
		PRINT CONCAT('Cannot insert the client "', report.CORRECT_GRAMMAR(@name, 'name'), '" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_client;
	END CATCH;
--

-- Capacity type insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_capacity_type
	@name VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_capacity_type AS VARCHAR(45) = 'insert_capacity_type'
		BEGIN TRANSACTION @tran_insert_capacity_type
			IF (@name != '')
				BEGIN
					INSERT INTO report.capacity_type_table(capacity_type_name)
					VALUES (@name);
					PRINT CONCAT('The capacity type "', @name, '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_capacity_type;
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the capacity type name in blank.';
					ROLLBACK TRANSACTION @tran_insert_capacity_type;
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the capacity type "', @name,'" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_capacity_type;
	END CATCH;
--

-- Merchandise class insertion data scripts.
--
CREATE OR ALTER PROCEDURE report.proc_insert_merchandise_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_merchandise_class AS VARCHAR(45) = 'insert_merchandise_class'
		BEGIN TRANSACTION @tran_insert_merchandise_class
			IF (@name != '')
				BEGIN
					INSERT INTO report.merchandise_classification_type_table(merchandise_classification_type_name)
					VALUES (UPPER(@name));
					PRINT CONCAT('The merchandise class "', UPPER(@name), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_merchandise_class;
				END;
			IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the merchandise class name in blank.';
					ROLLBACK TRANSACTION @tran_insert_merchandise_class;
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the merchandise class "', UPPER(@name),'" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_merchandise_class;
	END CATCH;
--

-- Hydrant protection class data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_hydrant_protection_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_hydrant_protection_class AS VARCHAR(45) = 'insert_hydrant_protection_class'
		BEGIN TRANSACTION @tran_insert_hydrant_protection_class
			IF (@name != '')
				BEGIN
					INSERT INTO report.hydrant_protection_classification_table(hydrant_protection_classification_name)
					VALUES (report.CORRECT_GRAMMAR(@name, 'name'));
					PRINT CONCAT('The hydrant protection class "', report.CORRECT_GRAMMAR(@name, 'name'), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_hydrant_protection_class;
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the hydrant protection class name in blank.';
					ROLLBACK TRANSACTION @tran_insert_hydrant_protection_class;
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the hydrant protection class "', report.CORRECT_GRAMMAR(@name, 'name'),'" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_hydrant_protection_class;
	END CATCH;
--

-- Hydrant standpipe type data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_hydrant_standpipe_type
	@name VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_hydrant_standpipe_type AS VARCHAR(45) = 'insert_hydrant_standpipe_type'
		BEGIN TRANSACTION @tran_insert_hydrant_standpipe_type
			IF (@name != '')
				BEGIN
					INSERT INTO report.hydrant_standpipe_system_type_table(hydrant_standpipe_system_type_name)
					VALUES (report.CORRECT_GRAMMAR(@name, 'name'));
					PRINT CONCAT('The hydrant standpipe type "', report.CORRECT_GRAMMAR(@name, 'name'), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_hydrant_standpipe_type;
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the hydrant standpipe type  name in blank.';
					ROLLBACK TRANSACTION @tran_insert_hydrant_standpipe_type;
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the hydrant standpipe type  "', report.CORRECT_GRAMMAR(@name, 'name'),'" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_hydrant_standpipe_type;
	END CATCH;
--

-- Hydrant standpipe class data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_hydrant_standpipe_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_hydrant_standpipe_class AS VARCHAR(45) = 'insert_hydrant_standpipe_class'
		BEGIN TRANSACTION @tran_insert_hydrant_standpipe_class
			IF (@name != '')
				BEGIN
					INSERT INTO report.hydrant_standpipe_system_class_table(hydrant_standpipe_system_class_name)
					VALUES (UPPER(@name));
					PRINT CONCAT('The hydrant standpipe class "', UPPER(@name), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_hydrant_standpipe_class;
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the hydrant standpipe class  name in blank.';
					COMMIT TRANSACTION @tran_insert_hydrant_standpipe_class;
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the hydrant standpipe class  "', UPPER(@name), '" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_hydrant_standpipe_class; 
	END CATCH;
--

-- Type location classification data
--
CREATE OR ALTER PROCEDURE report.proc_insert_type_location_class
	@name VARCHAR(100)
AS
	BEGIN TRY
		DECLARE @tran_insert_type_location_class AS VARCHAR(45) = 'insert_type_location_class'
		BEGIN TRANSACTION @tran_insert_type_location_class
			IF (@name != '')
				BEGIN
					INSERT INTO report.type_location_classification_table(type_location_class_name)
					VALUES (report.CORRECT_GRAMMAR(@name, 'name'));
					PRINT CONCAT('The type location class "', report.CORRECT_GRAMMAR(@name, 'name'), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_type_location_class
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the type location class name in blank.';
					ROLLBACK TRANSACTION @tran_insert_type_location_class
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the type location class  "', report.CORRECT_GRAMMAR(@name, 'name'),'" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_type_location_class;
	END CATCH;
--

-- Business turnover classification data
--
CREATE OR ALTER PROCEDURE report.proc_insert_business_turnover_class
	@name VARCHAR(50)
AS
	BEGIN TRY
		DECLARE @tran_insert_business AS VARCHAR(45) = 'insert_business';
		BEGIN TRANSACTION @tran_insert_business
			IF (@name != '')
				BEGIN
					INSERT INTO report.business_turnover_class_table(business_turnover_name)
					VALUES (report.CORRECT_GRAMMAR(@name, 'paragraph'));
					PRINT CONCAT('The business turnover classification "', report.CORRECT_GRAMMAR(@name, 'paragraph'), '" was correctly saved in the database');
					COMMIT TRANSACTION @tran_insert_business;
				END;
			ELSE IF (@name = '' OR @name IS NULL)
				BEGIN
					PRINT 'You cannot left the business turnover class name in blank';
					ROLLBACK TRANSACTION @tran_insert_business;
				END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the business turnover class "', report.CORRECT_GRAMMAR(@name, 'paragraph'), '" in the database due to this error: (', ERROR_MESSAGE(), ')');
		ROLLBACK TRANSACTION @tran_insert_business
	END CATCH;
--

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
						DECLARE @id_business_turnover_to_insert AS INT;
						IF ((SELECT TRY_CAST(@business_turnover AS INT)) IS NULL)
							BEGIN
								SET @id_business_turnover_to_insert = ISNULL((SELECT id_business_turnover FROM report.business_turnover_class_table WHERE business_turnover_name = report.CORRECT_GRAMMAR(@business_turnover, 'paragraph')), NULL)
							END;
						ELSE IF ((SELECT TRY_CAST(@business_turnover AS INT)) IS NOT NULL)
							BEGIN
								SET @id_business_turnover_to_insert = ISNULL((SELECT id_business_turnover FROM report.business_turnover_class_table WHERE id_business_turnover = CAST(@business_turnover AS INT)), null);
							END;
						IF (@id_business_turnover_to_insert IS NOT NULL)
							BEGIN
								IF ((SELECT TRY_CAST(@merchandise_classification AS INT)) IS NOT NULL)
									BEGIN;
										IF EXISTS(SELECT id_merchandise_classification_type FROM report.merchandise_classification_type_table 
																						WHERE id_merchandise_classification_type = @merchandise_classification)
											SET @id_merchandise = (SELECT id_merchandise_classification_type FROM report.merchandise_classification_type_table
																											WHERE id_merchandise_classification_type = @merchandise_classification);
										ELSE
											SET @id_merchandise = null;
									END;
								ELSE IF ((SELECT TRY_CAST(@merchandise_classification AS INT)) IS NULL)
									BEGIN
										IF EXISTS(SELECT id_merchandise_classification_type FROM report.merchandise_classification_type_table
																							WHERE merchandise_classification_type_name = UPPER(@merchandise_classification))
											SET @id_merchandise = (SELECT id_merchandise_classification_type FROM report.merchandise_classification_type_table
																											WHERE merchandise_classification_type_name = UPPER(@merchandise_classification));
										ELSE
											SET @id_merchandise = null;
									END;
							END;
							INSERT INTO report.plant_table (plant_account_name, plant_name, plant_continent, plant_country, plant_country_state, 
															plant_construction_year, plant_operation_startup_year, plant_address, plant_latitude, plant_longitude, 
															plant_meters_above_sea_level, plant_certifications, plant_business_specific_turnover, plant_merchandise_class)
															VALUES (@account_name, @name, @continent, report.CORRECT_GRAMMAR(@country, 'name'), report.CORRECT_GRAMMAR(@state, 'name'), @date_construction_year, @date_operation_startup,
																	@address, @latitude, @longitude, @meters_above_sea_level, @certifications, @specific_turnover, @id_merchandise);
							BEGIN
								IF (@type_location IS NOT NULL)
									IF (@type_location LIKE '%,%')
										BEGIN
											SET @type_location = report.REMOVE_EXTRA_SPACES(@type_location);

											DECLARE @val AS VARCHAR(50);
											DECLARE cur CURSOR DYNAMIC FORWARD_ONLY
														FOR SELECT * FROM STRING_SPLIT(@type_location, ',');
											OPEN cur
											FETCH NEXT FROM cur INTO @val;
											WHILE @@FETCH_STATUS = 0
												BEGIN TRY
													IF ((SELECT TRY_CAST(@val AS INT)) IS NULL)
														IF EXISTS(SELECT type_location_class_name FROM report.type_location_classification_table 
																									WHERE type_location_class_name = report.CORRECT_GRAMMAR(@val, 'name'))
															INSERT INTO report.type_location_table (id_plant, id_type_location_class)
															VALUES ((SELECT MAX(id_plant) FROM report.plant_table), 
																	(SELECT id_type_location_class FROM report.type_location_classification_table WHERE type_location_class_name = report.CORRECT_GRAMMAR(@val, 'name')));
														ELSE
															PRINT CONCAT('No values found in type location table for "', report.CORRECT_GRAMMAR(@val, 'name'), '"');
													IF ((SELECT TRY_CAST(@val AS INT)) IS NOT NULL)
														IF EXISTS(SELECT id_type_location_class FROM report.type_location_classification_table
																								WHERE id_type_location_class = @val)
															INSERT INTO report.type_location_table (id_plant, id_type_location_class)
															VALUES ((SELECT MAX(id_plant) FROM report.plant_table), 
																	(SELECT id_type_location_class FROM report.type_location_classification_table WHERE id_type_location_class = @val));
														ELSE
															PRINT CONCAT('No values found in type location table for the ID "', @val, '"');
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
									ELSE IF (@type_location NOT LIKE '%,%')
										BEGIN
											IF ((SELECT TRY_CAST(@type_location AS INT)) IS NULL)
												SET @type_location = report.REMOVE_EXTRA_SPACES(@type_location);
												IF EXISTS(SELECT type_location_class_name FROM report.type_location_classification_table
																							WHERE type_location_class_name = @type_location)
													INSERT INTO report.type_location_table (id_plant, id_type_location_class)
																	VALUES ((SELECT MAX(id_plant) FROM report.plant_table), 
																			(SELECT id_type_location_class FROM report.type_location_classification_table WHERE type_location_class_name = report.CORRECT_GRAMMAR(@type_location, 'name')));
												ELSE
													PRINT CONCAT('No values found in type location table for "', report.CORRECT_GRAMMAR(@type_location, 'name'), '"');
											IF ((SELECT TRY_CAST(@type_location AS INT)) IS NOT NULL)
												IF EXISTS(SELECT id_type_location_class FROM report.type_location_classification_table
																							WHERE id_type_location_class = @type_location)
													INSERT INTO report.type_location_table (id_plant, id_type_location_class)
																	VALUES ((SELECT MAX(id_plant) FROM report.plant_table), 
																			(SELECT id_type_location_class FROM report.type_location_classification_table WHERE id_type_location_class = @type_location));
												ELSE
													PRINT CONCAT('No values found in type location table for the ID "', @type_location, '"');
										END;
							END;
							BEGIN
								IF (@id_business_turnover_to_insert IS NOT NULL)
									INSERT INTO report.business_turnover_table (id_plant, id_business_turnover)
									VALUES ((SELECT MAX(id_plant) FROM report.plant_table),
											@id_business_turnover_to_insert);
							END;
							PRINT CONCAT('The plant "', report.CORRECT_GRAMMAR(@name, 'paragraph'), '" was correctly saved in the database');
						IF (@id_business_turnover_to_insert IS NULL)
							PRINT CONCAT('The business turnover "', @business_turnover ,'" does not match with any existing business turnover on the table');
					END;
				END;
			ELSE
				PRINT ('Cannot insert the data because there are some field left in blank.');
		END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the plant  "', report.CORRECT_GRAMMAR(@name, 'name'),'" in the database due to this error: (', ERROR_MESSAGE(), ')');
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
			BEGIN TRANSACTION
				UPDATE plant_table SET plant_address = @plant_address, plant_certifications = @plant_certification, plant_latitude = @plant_latitude, 
										plant_longitude = @plant_longitude, plant_meters_above_sea_level = @plant_meters_above_sea_level
										WHERE id_plant = @id;
										
			FETCH NEXT FROM cur INTO @plant_address, @plant_certification, @plant_latitude, @plant_longitude, @plant_meters_above_sea_level
		END TRY
		BEGIN CATCH
			PRINT CONCAT('An error ocurred while attempting to update the plant table (', ERROR_MESSAGE(), ')');
			ROLLBACK TRANSACTION;
			CLOSE cur;
			DEALLOCATE cur;
		END CATCH;
	CLOSE cur;
	DEALLOCATE cur;
--

-- Report table data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_report
	@date AS VARCHAR(20),
	@client AS VARCHAR(150),
	@plant AS VARCHAR(150),
	@prepared_by AS VARCHAR(250),
	@installed_capacity AS VARCHAR(70),
	@built_up AS FLOAT,
	@exposures AS VARCHAR(20),
	@has_hydrants AS VARCHAR(2),
	@hydrant_protection AS VARCHAR(20),
	@hydrant_standpipe_type AS VARCHAR(20),
	@hydrant_standpipe_class AS VARCHAR(20),
	@has_foam_suppression AS VARCHAR(8),
	@has_suppression AS VARCHAR(8),
	@has_sprinklers AS VARCHAR(8),
	@has_afds AS VARCHAR(8),
	@has_fire_detection_batteries AS VARCHAR(8),
	@has_private_brigade AS VARCHAR(8),
	@has_lighting_protection AS VARCHAR(8)
AS
	BEGIN TRY
		DECLARE
			@id_client AS INT,
			@id_plant AS INT;
		BEGIN
			IF (@client IS NOT NULL)
				BEGIN
					IF ((SELECT TRY_CAST(@client AS INT)) IS NULL)
						BEGIN
							SET @id_client = ISNULL((SELECT id_client FROM report.client_table WHERE client_name = report.CORRECT_GRAMMAR(@client, 'name')), 0);
						END;
					ELSE IF((SELECT TRY_CAST(@client AS INT)) IS NOT NULL)
						BEGIN
							SET @id_client = ISNULL((SELECT id_client FROM report.client_table WHERE id_client = @client), 0);
						END;
				END;
			ELSE IF (@client IS NULL)
				SET @id_client = 0;
			IF (@plant IS NOT NULL)
				BEGIN
					IF ((SELECT TRY_CAST(@plant AS INT)) IS NULL)
						BEGIN
							SET @id_plant = ISNULL((SELECT id_plant FROM report.plant_table WHERE plant_name = @plant), 0);
						END;
					ELSE IF ((SELECT TRY_CAST(@plant AS INT)) IS NOT NULL)
						BEGIN
							SET @id_plant = ISNULL((SELECT id_plant FROM report.plant_table WHERE id_plant = @plant), 0);
						END;
				END;
		END;
		IF (@id_client != 0)
			IF (@id_plant != 0)
				IF (@prepared_by IS NOT NULL)
					BEGIN
						INSERT INTO report.report_table (report_date, id_client, id_plant)
						VALUES (report.CONSTRUCT_DATE(@date), @id_client, @id_plant);
						BEGIN
							IF (@prepared_by LIKE '%,%')
								BEGIN
									DECLARE @value_engineer AS VARCHAR(60)
									DECLARE cur_engineer CURSOR DYNAMIC FORWARD_ONLY
															FOR SELECT * FROM STRING_SPLIT(@prepared_by, ',');
									OPEN cur_engineer;
									FETCH NEXT FROM cur_engineer INTO @value_engineer;
									WHILE @@FETCH_STATUS = 0
										BEGIN TRY
											SET @value_engineer = TRIM(@value_engineer);
											IF ((SELECT TRY_CAST(@value_engineer AS INT)) IS NULL)
												IF EXISTS(SELECT engineer_name FROM report.engineer_table WHERE engineer_name = report.CORRECT_GRAMMAR(@value_engineer, 'name'))
													INSERT INTO report.report_preparation_table(id_report, id_engineer)
													VALUES ((SELECT MAX(id_report) FROM report.report_table),
															(SELECT id_engineer FROM report.engineer_table WHERE engineer_name = report.CORRECT_GRAMMAR(@value_engineer, 'name')));
												ELSE
													PRINT CONCAT('Cannot find the engineer "', report.CORRECT_GRAMMAR(@value_engineer, 'name'), '" in the engineer table');
											ELSE IF ((SELECT TRY_CAST(@value_engineer AS INT)) IS NOT NULL)
												IF EXISTS(SELECT engineer_name FROM report.engineer_table WHERE id_engineer = @value_engineer)
													INSERT INTO report.report_preparation_table(id_report, id_engineer)
													VALUES ((SELECT MAX(id_report) FROM report.report_table),
															(SELECT id_engineer FROM report.engineer_table WHERE id_engineer = @value_engineer));
												ELSE
													PRINT CONCAT('Cannot find the engineer with the ID "', @value_engineer, '" in the engineer table');
													FETCH NEXT FROM cur_engineer INTO @value_engineer;
										END TRY
										BEGIN CATCH
											PRINT CONCAT('Cannot insert the engineer in the report preparation table due to this error (', ERROR_MESSAGE(), ')')
											CLOSE cur_engineer;
											DEALLOCATE cur_engineer;
										END CATCH;
									CLOSE cur_engineer;
									DEALLOCATE cur_engineer;
								END;
								IF (@prepared_by NOT LIKE '%,%')
									SET @prepared_by = TRIM(@prepared_by);  
									IF ((SELECT TRY_CAST(@prepared_by AS INT)) IS NULL)
										IF EXISTS(SELECT engineer_name FROM report.engineer_table WHERE engineer_name = report.CORRECT_GRAMMAR(@prepared_by, 'name'))
											INSERT INTO report.report_preparation_table(id_report, id_engineer)
											VALUES ((SELECT MAX(id_report) FROM report.report_table),
													(SELECT id_engineer FROM report.engineer_table WHERE engineer_name = report.CORRECT_GRAMMAR(@prepared_by, 'name')));
										ELSE
											PRINT CONCAT('Cannot find the engineer "', report.CORRECT_GRAMMAR(@prepared_by, 'name'), '" in the engineer table');
									ELSE IF ((SELECT TRY_CAST(@prepared_by AS INT)) IS NOT NULL)
										IF EXISTS(SELECT engineer_name FROM report.engineer_table WHERE id_engineer = @prepared_by)
											INSERT INTO report.report_preparation_table(id_report, id_engineer)
											VALUES ((SELECT MAX(id_report) FROM report.report_table),
													(SELECT id_engineer FROM report.engineer_table WHERE id_engineer = @prepared_by));
										ELSE
											PRINT CONCAT('Cannot find the engineer with the ID "', @prepared_by, '" in the engineer table');
						END;
						DECLARE @report_id AS INT = (SELECT MAX(id_report) FROM report.report_table);
						PRINT CONCAT('The report with the ID ("', @report_id, '") was correctly saved in the database.');
					END;
					DECLARE @installed_capacity_value AS FLOAT;
					DECLARE @installed_capacity_id AS INT;

					IF (@installed_capacity IS NOT NULL)
						DECLARE @value_capacity AS VARCHAR(70);
						DECLARE cur_capacity CURSOR DYNAMIC FORWARD_ONLY
											FOR SELECT * FROM STRING_SPLIT(@installed_capacity, ',');
						OPEN cur_capacity;
						FETCH NEXT FROM cur_capacity INTO @value_capacity
						WHILE @@FETCH_STATUS = 0 
							BEGIN TRY
								IF ((SELECT TRY_CAST(@value_capacity AS FLOAT)) IS NULL)
									IF EXISTS(SELECT id_capacity_type FROM report.capacity_type_table WHERE capacity_type_name = @value_capacity)
										SET @installed_capacity_id = ISNULL((SELECT id_capacity_type FROM report.capacity_type_table
																								WHERE capacity_type_name = @value_capacity), NULL);
									ELSE
										PRINT CONCAT('The capacity type ("', @value_capacity, '") was not found in the capacity type table');
								IF ((SELECT TRY_CAST(@value_capacity AS FLOAT)) IS NOT NULL)
									SET @installed_capacity_value = @value_capacity;
								ELSE
									SET @installed_capacity = 0;
							FETCH NEXT FROM cur_capacity INTO @value_capacity
							END TRY
							BEGIN CATCH
								PRINT CONCAT('Cannot set the values for the capacity type due to this error (', ERROR_MESSAGE(), ')');
								CLOSE cur_capacity;
								DEALLOCATE cur_capacity;
							END CATCH;
						CLOSE cur_capacity;
						DEALLOCATE cur_capacity;
					
					DECLARE @built_up_save AS FLOAT = ISNULL(@built_up, 0);

					DECLARE @exposures_save AS FLOAT = report.DETERMINATE_RATE_OF_RISK(@exposures);

					DECLARE @has_hydrants_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_hydrants);

					DECLARE @id_hydrant_protection_to_save AS INT;
					IF (@hydrant_protection IS NOT NULL)
						IF ((SELECT TRY_CAST(@hydrant_protection AS INT)) IS NOT NULL)
							IF (@hydrant_protection >= 1000)
								IF EXISTS(SELECT id_hydrant_protection_classification FROM report.hydrant_protection_classification_table
																						WHERE id_hydrant_protection_classification = @hydrant_protection)
									SET @id_hydrant_protection_to_save = (SELECT id_hydrant_protection_classification FROM report.hydrant_protection_classification_table
																													WHERE id_hydrant_protection_classification = @hydrant_protection)
								IF NOT EXISTS(SELECT id_hydrant_protection_classification FROM report.hydrant_protection_classification_table
																							WHERE id_hydrant_protection_classification = @hydrant_protection)
									SET @id_hydrant_protection_to_save = NULL;
									PRINT CONCAT('The id (', @hydrant_protection, ') was not found in the hydrant protection table.');
							IF (@hydrant_protection < 1000)
								SET @hydrant_protection = NULL;
						IF ((SELECT TRY_CAST(@hydrant_protection AS INT)) IS NULL)
							IF EXISTS(SELECT hydrant_protection_classification_name FROM report.hydrant_protection_classification_table
																					WHERE hydrant_protection_classification_name = report.CORRECT_GRAMMAR(@hydrant_protection, 'name'))
								SET @id_hydrant_protection_to_save = (SELECT id_hydrant_protection_classification FROM report.hydrant_protection_classification_table
																					WHERE hydrant_protection_classification_name = report.CORRECT_GRAMMAR(@hydrant_protection, 'name'))
							IF NOT EXISTS(SELECT hydrant_protection_classification_name FROM report.hydrant_protection_classification_table
																					WHERE hydrant_protection_classification_name = report.CORRECT_GRAMMAR(@hydrant_protection, 'name'))
								SET @id_hydrant_protection_to_save = NULL;
								PRINT CONCAT('The protection name (', report.CORRECT_GRAMMAR(@hydrant_protection, 'name'), ') was not found in the hydrant protection table.');
					IF (@hydrant_protection IS NULL OR @hydrant_protection = '')
						SET @id_hydrant_protection_to_save = NULL;

					DECLARE @id_hydrant_standpipe_type_to_save AS INT;
					IF (@hydrant_standpipe_type IS NOT NULL)
						IF ((SELECT TRY_CAST(@hydrant_standpipe_type AS INT)) IS NOT NULL)
							IF (@hydrant_standpipe_type >= 1000)
								IF EXISTS(SELECT id_hydrant_standpipe_system_type FROM report.hydrant_standpipe_system_type_table
																					WHERE id_hydrant_standpipe_system_type = @hydrant_standpipe_type)
									SET @id_hydrant_standpipe_type_to_save = (SELECT id_hydrant_standpipe_system_type FROM report.hydrant_standpipe_system_type_table
																														WHERE id_hydrant_standpipe_system_type = @hydrant_standpipe_type)
								IF NOT EXISTS(SELECT id_hydrant_standpipe_system_type FROM report.hydrant_standpipe_system_type_table
																						WHERE id_hydrant_standpipe_system_type = @hydrant_standpipe_type)
									SET @id_hydrant_standpipe_type_to_save = NULL;
									PRINT CONCAT('The id (', @hydrant_standpipe_type, ') was not found in the hydrant standpipe type table.');
							IF (@hydrant_standpipe_type < 1000)
								SET @hydrant_standpipe_type = NULL;
						IF ((SELECT TRY_CAST(@hydrant_standpipe_type AS INT)) IS NULL)
							IF EXISTS(SELECT id_hydrant_standpipe_system_type FROM report.hydrant_standpipe_system_type_table
																				WHERE hydrant_standpipe_system_type_name = report.CORRECT_GRAMMAR(@hydrant_standpipe_type, 'name'))
								SET @id_hydrant_standpipe_type_to_save = (SELECT id_hydrant_standpipe_system_type FROM report.hydrant_standpipe_system_type_table
																													WHERE hydrant_standpipe_system_type_name = report.CORRECT_GRAMMAR(@hydrant_standpipe_type, 'name'))
							IF NOT EXISTS(SELECT id_hydrant_standpipe_system_type FROM report.hydrant_standpipe_system_type_table
																				WHERE hydrant_standpipe_system_type_name = report.CORRECT_GRAMMAR(@hydrant_standpipe_type, 'name'))
								SET @id_hydrant_standpipe_type_to_save = NULL;
								PRINT CONCAT('The hydrant standpipe system type (', report.CORRECT_GRAMMAR(@hydrant_standpipe_type, 'name'), ') was not found in the hydrant standpipe type table.');
					IF (@hydrant_standpipe_type IS NULL OR @hydrant_standpipe_type = '')
						SET @id_hydrant_standpipe_type_to_save = NULL;

					DECLARE @id_hydrant_standpipe_class_to_save AS INT;
					IF (@hydrant_standpipe_class IS NOT NULL)
						IF ((SELECT TRY_CAST(@hydrant_standpipe_class AS INT)) IS NOT NULL)
							IF (@hydrant_standpipe_class >= 1000)
								IF EXISTS(SELECT id_hydrant_standpipe_system_class FROM report.hydrant_standpipe_system_class_table 
																					WHERE id_hydrant_standpipe_system_class = @hydrant_standpipe_class)
									SET @id_hydrant_standpipe_class_to_save = (SELECT id_hydrant_standpipe_system_class FROM report.hydrant_standpipe_system_class_table 
																														WHERE id_hydrant_standpipe_system_class = @hydrant_standpipe_class);
								IF NOT EXISTS(SELECT id_hydrant_standpipe_system_class FROM report.hydrant_standpipe_system_class_table 
																						WHERE id_hydrant_standpipe_system_class = @hydrant_standpipe_class)
									SET @id_hydrant_standpipe_class_to_save = NULL
									PRINT CONCAT('The id (', @hydrant_standpipe_class, ') was not found in the hydrant standpipe class table.')
							IF (@hydrant_standpipe_class < 1000)
								SET @id_hydrant_standpipe_class_to_save = NULL;
						IF ((SELECT TRY_CAST(@hydrant_standpipe_class AS INT)) IS NULL)
							IF EXISTS(SELECT id_hydrant_standpipe_system_class FROM report.hydrant_standpipe_system_class_table 
																				WHERE hydrant_standpipe_system_class_name = UPPER(@hydrant_standpipe_class))
								SET @id_hydrant_standpipe_class_to_save = (SELECT id_hydrant_standpipe_system_class FROM report.hydrant_standpipe_system_class_table 
																													WHERE hydrant_standpipe_system_class_name = UPPER(@hydrant_standpipe_class));
							IF NOT EXISTS(SELECT id_hydrant_standpipe_system_class FROM report.hydrant_standpipe_system_class_table 
																				WHERE hydrant_standpipe_system_class_name = UPPER(@hydrant_standpipe_class))
								SET @id_hydrant_standpipe_class_to_save = NULL
								PRINT CONCAT('The hydrant standpipe system class (', UPPER(@hydrant_standpipe_class), ') was not found in the hydrant standpipe class table.')
					IF (@hydrant_standpipe_class IS NULL OR @hydrant_standpipe_class = '')
						SET @id_hydrant_standpipe_class_to_save = NULL

					DECLARE @has_foam_suppression_sys_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_foam_suppression);

					DECLARE @has_suppression_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_suppression);

					DECLARE @has_sprinklers_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_sprinklers);

					DECLARE @has_afds_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_afds);

					DECLARE @has_fire_detetion_batteries_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_fire_detection_batteries);

					DECLARE @has_private_brigade_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_private_brigade);

					DECLARE @has_lighting_protection_to_save AS BIT = report.CALCULATE_BIT_TO_SAVE(@has_lighting_protection);

					BEGIN TRY
							INSERT INTO report.plant_parameters(id_report, id_plant, plant_parameters_installed_capacity, id_capacity_type, plant_parameters_built_up, plant_parameters_exposures,
																plant_parameters_has_hydrants, id_hydrant_protection, id_hydrant_standpipe_type, id_hydrant_standpipe_class,
																plant_parameters_has_foam_suppression_sys, plant_parameters_has_suppression_sys, plant_parameters_has_sprinklers,
																plant_parameters_has_afds, plant_parameters_has_fire_detection_batteries, plant_parameters_has_private_brigade,
																plant_parameters_has_lighting_protection)
																VALUES((SELECT MAX(id_report) FROM report.report_table), @id_plant, @installed_capacity_value, @installed_capacity_id, @built_up_save,
																		@exposures_save, @has_hydrants_to_save, @id_hydrant_protection_to_save, @id_hydrant_standpipe_type_to_save, @id_hydrant_standpipe_class_to_save,
																		@has_foam_suppression_sys_to_save, @has_suppression_to_save, @has_sprinklers_to_save, @has_afds_to_save, @has_fire_detetion_batteries_to_save,
																		@has_private_brigade_to_save, @has_lighting_protection_to_save);
					END TRY
					BEGIN CATCH
						PRINT CONCAT('Cannot insert into the plant parameters table due to this error (', ERROR_MESSAGE(), ')');
					END CATCH;

				IF (@prepared_by IS NULL)
					PRINT 'Cannot leave the engineer field empty.';
			IF (@id_plant = 0)
				PRINT CONCAT('The id (', @id_plant,') was not found in the plant table.');
		IF (@id_client = 0)
			PRINT CONCAT('The id (', @id_client, ') was not found in the client table.');
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert the report due to this error (', ERROR_MESSAGE(), ')');
	END CATCH;
--

-- Perils and risk table data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_perils_and_risk_table
	@id_report AS INT,
	@plant AS VARCHAR(100),
	@fire_explosion AS VARCHAR(20),
	@landslie_subsidence AS VARCHAR(20),
	@water_flooding AS VARCHAR(20),
	@wind_storm AS VARCHAR(20),
	@lighting AS VARCHAR(20),
	@earthquake AS VARCHAR(20),
	@tsunami AS VARCHAR(20),
	@collapse AS VARCHAR(20),
	@aircraft AS VARCHAR(20),
	@riot AS VARCHAR(20),
	@design_failure AS VARCHAR(20),
	@overall_rating AS VARCHAR(20)
AS
	BEGIN TRY
		DECLARE @tran_insert_perils_and_risk AS VARCHAR(45) = 'insert_perils_and_risk';
		BEGIN TRANSACTION @tran_insert_perils_and_risk
			IF (@id_report IS NOT NULL AND @plant IS NOT NULL AND (SELECT id_report FROM report.report_table WHERE id_report = @id_report) IS NOT NULL)
				BEGIN
					DECLARE @id_plant AS INT
					BEGIN
						IF ((SELECT TRY_CAST(@plant AS INT)) IS NULL)
							SET @id_plant = ISNULL((SELECT id_plant FROM report.plant_table WHERE plant_name = report.CORRECT_GRAMMAR(@plant, 'name')), null);
						IF ((SELECT TRY_CAST(@plant AS INT)) IS NOT NULL)
							SET @id_plant = ISNULL((SELECT id_plant FROM report.plant_table WHERE id_plant = @plant), null);
					END;
						IF (@id_plant IS NOT NULL)
							DECLARE @overall_rating_to_save AS FLOAT(2)

							IF (@overall_rating IS NULL OR @overall_rating = '0' OR LOWER(@overall_rating) = 'none')
								BEGIN
									DECLARE @temp_table AS TABLE
																(
																id_val INT IDENTITY(1,1),
																val FLOAT(2) NOT NULL
																);
									INSERT INTO @temp_table (val) 
															VALUES (report.DETERMINATE_RATE_OF_RISK(@fire_explosion)),
																	(report.DETERMINATE_RATE_OF_RISK(@landslie_subsidence)),
																	(report.DETERMINATE_RATE_OF_RISK(@water_flooding)),
																	(report.DETERMINATE_RATE_OF_RISK(@wind_storm)),
																	(report.DETERMINATE_RATE_OF_RISK(@lighting)),
																	(report.DETERMINATE_RATE_OF_RISK(@earthquake)),
																	(report.DETERMINATE_RATE_OF_RISK(@tsunami)),
																	(report.DETERMINATE_RATE_OF_RISK(@collapse)),
																	(report.DETERMINATE_RATE_OF_RISK(@aircraft)),
																	(report.DETERMINATE_RATE_OF_RISK(@riot)),
																	(report.DETERMINATE_RATE_OF_RISK(@design_failure))
									DECLARE @more_rep_item AS FLOAT(2);
									SET @more_rep_item = (SELECT TOP 1 val FROM @temp_table GROUP BY val ORDER BY COUNT(*) DESC);

									IF (@more_rep_item = 0)
										SET @overall_rating_to_save = 1
									ELSE
										SET @overall_rating_to_save = report.DETERMINATE_RATE_OF_RISK(@more_rep_item);
								END;
							ELSE
								SET @overall_rating_to_save = @overall_rating;
							BEGIN
								INSERT INTO report.perils_and_risk_table(id_report, id_plant, perils_and_risk_fire_explosion, perils_and_risk_landslide_subsidence, perils_and_risk_water_flooding, perils_and_risk_wind_storm, perils_and_risk_lighting,
																		perils_and_risk_earthquake, perils_and_risk_tsunami, perils_and_risk_collapse, perils_and_risk_aircraft, perils_and_risk_riot, perils_and_risk_design_failure, perils_and_risk_overall_rating)
																		VALUES (@id_report, @plant, report.DETERMINATE_RATE_OF_RISK(@fire_explosion), report.DETERMINATE_RATE_OF_RISK(@landslie_subsidence), report.DETERMINATE_RATE_OF_RISK(@water_flooding),
																				report.DETERMINATE_RATE_OF_RISK(@wind_storm), report.DETERMINATE_RATE_OF_RISK(@lighting), report.DETERMINATE_RATE_OF_RISK(@earthquake), report.DETERMINATE_RATE_OF_RISK(@tsunami),
																				report.DETERMINATE_RATE_OF_RISK(@collapse), report.DETERMINATE_RATE_OF_RISK(@aircraft), report.DETERMINATE_RATE_OF_RISK(@riot), report.DETERMINATE_RATE_OF_RISK(@design_failure),
																				report.DETERMINATE_RATE_OF_RISK(@overall_rating_to_save));
								PRINT CONCAT('Perils and risk for the ID report: (', @id_report,') and plant with the ID: (', @id_plant,') correctly saved');
								COMMIT TRANSACTION @tran_insert_perils_and_risk;
							END;
				END;
			ELSE
				PRINT ('Cannot insert in the perils and risk table because either the report or the plant cannot be found in the database');
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert into the perils and risk table due to this error: ("', ERROR_MESSAGE(), '")');
		ROLLBACK TRANSACTION @tran_insert_perils_and_risk;
	END CATCH;
--

-- Loss scenario table data scripts
--
CREATE OR ALTER PROCEDURE report.proc_insert_loss_scenario_table
	@id_report AS INT,
	@client AS VARCHAR(100),
	@plant AS VARCHAR(100),
	@material_damage_amount AS DECIMAL(19, 2),
	@material_damage_percentage AS FLOAT(2),
	@business_interruption_amount AS DECIMAL(19, 2),
	@business_interruption_percentage AS FLOAT(2),
	@buildings_amount AS DECIMAL(19, 2),
	@machinary_equipment AS DECIMAL(19, 2),
	@electronic_equipment AS DECIMAL(19, 2),
	@expansions_investment_works_amount AS DECIMAL(19, 2),
	@stock_amount AS DECIMAL(19, 2),
	@total_insured_values AS DECIMAL(19, 2),
	@pml_percentage AS FLOAT(2),
	@mfl AS FLOAT(2)
AS
	BEGIN TRY
		DECLARE @tran_insert_loss_scenario AS VARCHAR(45) = 'insert_loss_scenario';
		BEGIN TRANSACTION @tran_insert_loss_scenario
		IF (@client IS NOT NULL AND @plant IS NOT NULL)
			BEGIN
				DECLARE 
					@id_client AS INT,
					@id_plant AS INT
				
				SET @plant = report.REMOVE_EXTRA_SPACES(@plant);
				SET @client = report.REMOVE_EXTRA_SPACES(@client);

				BEGIN
					IF ((SELECT TRY_CAST(@client AS INT)) IS NOT NULL)
						SET @id_client = ISNULL((SELECT id_client FROM report.client_table WHERE id_client = CAST(@client AS INT)), null);
					ELSE IF ((SELECT TRY_CAST(@client AS INT)) IS NULL)
						SET @id_client = ISNULL((SELECT id_client FROM report.client_table WHERE client_name = report.CORRECT_GRAMMAR(@client, 'name')), null);
				END;
				BEGIN
					IF ((SELECT TRY_CAST(@plant AS INT)) IS NOT NULL)
						SET @id_plant = ISNULL((SELECT id_plant FROM report.plant_table WHERE id_plant = CAST(@plant AS INT)), null);
					ELSE IF ((SELECT TRY_CAST(@plant AS INT)) IS NULL)
						SET @id_plant = ISNULL((SELECT id_plant FROM report.plant_table WHERE plant_name = report.CORRECT_GRAMMAR(@plant, 'name')), null);
				END;

				IF (@id_client IS NOT NULL AND @id_plant IS NOT NULL)
					BEGIN
						DECLARE
							@material_damage_amount_to_save AS DECIMAL(19, 2),
							@material_damage_percentage_to_save AS FLOAT(2),
							@business_interruption_amount_to_save AS DECIMAL(19, 2),
							@business_interruption_percentage_to_save AS FLOAT(2),
							@buildings_amount_to_save AS DECIMAL(19, 2),
							@machinary_equipment_to_save AS DECIMAL(19, 2),
							@electronic_equipment_to_save AS DECIMAL(19, 2),
							@expansions_investment_works_amount_to_save AS DECIMAL(19, 2),
							@stock_amount_to_save AS DECIMAL(19, 2),
							@total_insured_values_to_save AS DECIMAL(19, 2),
							@pml_percentage_to_save AS FLOAT(2),
							@mfl_to_save AS FLOAT(2);

						SET @material_damage_amount_to_save = ISNULL(@material_damage_amount, 0);
						SET @material_damage_percentage_to_save = ISNULL(@material_damage_percentage, 0);
						SET @business_interruption_amount_to_save = ISNULL(@business_interruption_amount, 0);
						SET @business_interruption_percentage_to_save = ISNULL(@business_interruption_percentage, 0);
						SET @buildings_amount_to_save = ISNULL(@buildings_amount, 0);
						SET @machinary_equipment_to_save  = ISNULL(@machinary_equipment, 0);
						SET @electronic_equipment_to_save = ISNULL(@electronic_equipment, 0);
						SET @expansions_investment_works_amount_to_save = ISNULL(@expansions_investment_works_amount, 0);
						SET @stock_amount_to_save = ISNULL(@stock_amount, 0);
						SET @total_insured_values_to_save = ISNULL(@total_insured_values, 0);
						SET @pml_percentage_to_save = ISNULL(@pml_percentage, 0);
						SET @mfl_to_save = ISNULL(@mfl, 0);

						IF (@material_damage_amount_to_save = 0)
							SET @material_damage_amount_to_save = @buildings_amount_to_save + @machinary_equipment_to_save + @electronic_equipment_to_save + @expansions_investment_works_amount_to_save + @stock_amount_to_save
						IF (@total_insured_values_to_save = 0)
							SET @total_insured_values_to_save = @material_damage_amount_to_save + @business_interruption_amount_to_save;

						BEGIN
							INSERT INTO report.loss_scenario_table(id_report, id_client, id_plant, loss_scenario_material_damage_amount, loss_scenario_material_damage_percentage, loss_scenario_business_interruption_amount,
																	loss_scenario_business_interruption_percentage, loss_scenario_buildings_amount, loss_scenario_machinery_equipment_amount, loss_scenario_electronic_equipment_amount,
																	loss_scenario_expansions_investment_works_amount, loss_scenario_stock_amount, loss_scenario_total_insured_values, loss_scenario_pml_percentage,
																	loss_scenario_mfl)
																	VALUES (@id_report, @id_client, @id_plant, @material_damage_amount_to_save, @material_damage_percentage_to_save, @business_interruption_amount_to_save, @business_interruption_percentage_to_save,
																			@buildings_amount_to_save, @machinary_equipment_to_save, @electronic_equipment_to_save, @expansions_investment_works_amount_to_save, @stock_amount_to_save,
																			@total_insured_values_to_save, @pml_percentage_to_save, @mfl_to_save);
							PRINT CONCAT('The loss scenarios for the report with the ID: "', @id_report, '" was correctly saved in the database.');
							COMMIT TRANSACTION @tran_insert_loss_scenario;
						END;
					END;
			END;
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Cannot insert into the loss scenario table due to this error: ("', ERROR_MESSAGE(), '")');
		ROLLBACK TRANSACTION @tran_insert_loss_scenario;
	END CATCH;
--

USE gpi_consulting_services_reports_db;

CREATE OR ALTER PROCEDURE report.proc_tables_creation
AS
	IF OBJECT_ID('report.merchandise_classification_type_table', 'U') IS NULL AND
		OBJECT_ID('report.engineer_table', 'U') IS NULL AND
		OBJECT_ID('report.client_table', 'U') IS NULL AND
		OBJECT_ID('report.hydrant_protection_classification_table', 'U') IS NULL AND
		OBJECT_ID('report.hydrant_standpipe_system_class_table', 'U') IS NULL AND
		OBJECT_ID('report.hydrant_standpipe_system_type_table', 'U') IS NULL AND
		OBJECT_ID('report.type_location_classification_table', 'U') IS NULL AND
		OBJECT_ID('report.business_turnover_class_table', 'U') IS NULL AND
		OBJECT_ID('report.plant_table', 'U') IS NULL AND
		OBJECT_ID('report.report_table', 'U') IS NULL AND
		OBJECT_ID('report.report_preparation_table', 'U') IS NULL AND
		OBJECT_ID('report.business_turnover_table', 'U') IS NULL AND
		OBJECT_ID('report.type_location_table', 'U') IS NULL AND
		OBJECT_ID('report.plant_parameters', 'U') IS NULL AND
		OBJECT_ID('report.loss_scenario_table', 'U') IS NULL AND
		OBJECT_ID('report.perils_and_risk_table', 'U') IS NULL
		BEGIN
			IF OBJECT_ID('report.merchandise_classification_type_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.merchandise_classification_type_table(
						id_merchandise_classification_type INT IDENTITY(1000, 1),
						merchandise_classification_type_name VARCHAR(10) NOT NULL,
						CONSTRAINT pk_merchandise_classification_type_table
							PRIMARY KEY(id_merchandise_classification_type),
						CONSTRAINT uq_merchandise_classification_type
							UNIQUE(merchandise_classification_type_name)
					);
					PRINT('The table merchandise classification type table was correctly created.');
				END;
			ELSE
				PRINT('The merchandise classification type table already exists');
			IF OBJECT_ID('report.engineer_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.engineer_table(
						id_engineer INT IDENTITY(1000, 1),
						engineer_name VARCHAR(100) NOT NULL,
						engineer_contact VARCHAR(100) NULL,
						CONSTRAINT pk_engineer_table
							PRIMARY KEY(id_engineer),
						CONSTRAINT uq_engineer_table
							UNIQUE(engineer_name)
					);
					PRINT('The engineer table was correctly created.');
				END;
			ELSE
				PRINT('The engineer table already exists');
			IF OBJECT_ID('report.client_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.client_table(
						id_client INT IDENTITY(1000, 1),
						client_name VARCHAR(150) NOT NULL
						CONSTRAINT pk_client_table
							PRIMARY KEY(id_client),
						CONSTRAINT uq_client_table
							UNIQUE(client_name)
					);
					PRINT('The client table was correctly created.');
				END;
			ELSE
				PRINT('The client table already exists');
			IF OBJECT_ID('report.hydrant_protection_classification_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.hydrant_protection_classification_table(
						id_hydrant_protection_classification INT IDENTITY(1000, 1),
						hydrant_protection_classification_name VARCHAR(10) NOT NULL,
						CONSTRAINT pk_hydrant_protection_classification_table
							PRIMARY KEY(id_hydrant_protection_classification),
						CONSTRAINT uq_hydrant_protection_classification_table
							UNIQUE(hydrant_protection_classification_name)
					);
					PRINT('The hydrant protection classification table was correctly created.');
				END;
			ELSE
				PRINT('The hydrant protection classification table already exists');
			IF OBJECT_ID('report.hydrant_standpipe_system_class_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.hydrant_standpipe_system_class_table(
						id_hydrant_standpipe_system_class INT IDENTITY(1000, 1),
						hydrant_standpipe_system_class_name VARCHAR(15) NOT NULL
						CONSTRAINT pk_hydrant_standpipe_system_class_table
							PRIMARY KEY(id_hydrant_standpipe_system_class),
						CONSTRAINT uq_hydrant_standpipe_system_class
							UNIQUE(hydrant_standpipe_system_class_name)
					);
					PRINT('The hydrant standpipe system classification table was correctly created.');
				END;
			ELSE
				PRINT('The hydrant standpipe system classification table already exists');
			IF OBJECT_ID('report.hydrant_standpipe_system_type_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.hydrant_standpipe_system_type_table(
						id_hydrant_standpipe_system_type INT IDENTITY(1000, 1),
						hydrant_standpipe_system_type_name VARCHAR(15) NOT NULL,
						CONSTRAINT pk_hydrant_standpipe_system_type_table
							PRIMARY KEY(id_hydrant_standpipe_system_type),
						CONSTRAINT uq_hydrant_standpipe_system_type
							UNIQUE(hydrant_standpipe_system_type_name)
					);
				END;
			ELSE
				PRINT('The hydrant standpipe system type table already exists')
			IF OBJECT_ID('report.type_location_classification_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.type_location_classification_table(
						id_type_location_class INT IDENTITY(1000, 1),
						type_location_class_name VARCHAR(20) NOT NULL,
						CONSTRAINT pk_type_location_classification_table
							PRIMARY KEY(id_type_location_class),
						CONSTRAINT uq_type_location_classification_table
							UNIQUE(type_location_class_name)
					);
					PRINT('The type location classification table was correctly created.');
				END;
			ELSE
				PRINT('The type location classification table already exists');
			IF OBJECT_ID('report.business_turnover_class_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.business_turnover_class_table(
						id_business_turnover INT IDENTITY(1000, 1),
						business_turnover_name VARCHAR(25) NOT NULL,
						CONSTRAINT pk_business_turnover_class_table
							PRIMARY KEY(id_business_turnover),
						CONSTRAINT uq_business_turnover_table
							UNIQUE(business_turnover_name)
					);
					PRINT('The business turnover classification table was correctly created.');
				END;
			ELSE
				PRINT('The business turnover classification table already exists');
			IF OBJECT_ID('report.plant_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.plant_table(
						id_plant INT IDENTITY(1000, 1),
						plant_account_name VARCHAR(150) NOT NULL,
						plant_name VARCHAR(150) NULL,
						plant_continent VARCHAR(5) NOT NULL,
						plant_country VARCHAR(15) NOT NULL,
						plant_country_state VARCHAR(15) NOT NULL,
						plant_construction_year DATETIME NULL,
						plant_operation_startup_year DATETIME NULL,
						plant_address VARCHAR(100) NULL,
						plant_latitude VARCHAR(50) NULL,
						plant_longitude VARCHAR(50) NULL,
						plant_meters_above_sea_level INT NULL,
						plant_certifications VARCHAR(150) NULL,
						plant_business_specific_turnover VARCHAR(15) NOT NULL,
						plant_merchandise_class INT NULL,
						CONSTRAINT pk_plant_table
							PRIMARY KEY(id_plant),
						CONSTRAINT fk_plant_table_merchandise_class
							FOREIGN KEY(plant_merchandise_class)
							REFERENCES report.merchandise_classification_type_table(id_merchandise_classification_type)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The plant table was correctly created.');
				END;
			ELSE
				PRINT('The plant table already exists.');
			IF OBJECT_ID('report.report_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.report_table(
						id_report INT IDENTITY(1000, 1),
						report_date DATETIME NOT NULL,
						id_client INT NOT NULL,
						id_plant INT NOT NULL,
						CONSTRAINT pk_report_table
							PRIMARY KEY(id_report),
						CONSTRAINT fk_report_table_client
							FOREIGN KEY(id_client)
							REFERENCES report.client_table(id_client)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_report_table_plant
							FOREIGN KEY(id_plant)
							REFERENCES report.plant_table(id_plant)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The report table was correctly created.');
				END;
			ELSE
				PRINT('The report table already exists.');
			IF OBJECT_ID('report.report_preparation_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.report_preparation_table(
						id_report_preparation INT IDENTITY(1000, 1),
						id_report INT NOT NULL,
						id_engineer INT NOT NULL,
						CONSTRAINT pk_report_preparation_table
							PRIMARY KEY(id_report_preparation),
						CONSTRAINT fk_report_preparation_report
							FOREIGN KEY(id_report)
							REFERENCES report.report_table(id_report)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_report_preparation_engineer
							FOREIGN KEY(id_engineer)
							REFERENCES report.engineer_table(id_engineer)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The report preparation table was correctly created.');
				END;
			ELSE
				PRINT('The report preparation table already exists');
			IF OBJECT_ID('report.business_turnover_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.business_turnover_table(
						id_business_turnover_table INT IDENTITY(1000, 1),
						id_plant INT NOT NULL,
						id_business_turnover INT NOT NULL,
						CONSTRAINT pk_business_turnover_table
							PRIMARY KEY(id_business_turnover_table),
						CONSTRAINT fk_business_turnover_table_plant
							FOREIGN KEY(id_plant)
							REFERENCES report.plant_table(id_plant)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_business_turnover_business_type
							FOREIGN KEY(id_business_turnover)
							REFERENCES report.business_turnover_class_table(id_business_turnover)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The business turnover table was correctly created.');
				END;
			ELSE
				PRINT('The business turnover table already exists');
			IF OBJECT_ID('report.type_location_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.type_location_table(
						id_type_location INT IDENTITY(1000, 1),
						id_plant INT NOT NULL,
						id_type_location_class INT NOT NULL,
						CONSTRAINT pk_type_location_table
							PRIMARY KEY(id_type_location),
						CONSTRAINT fk_type_location_table_plant
							FOREIGN KEY(id_plant)
							REFERENCES report.plant_table(id_plant)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The type location table was correctly created.');
				END;
			ELSE
				PRINT('The type location table already exists');
			IF OBJECT_ID('report.plant_parameters', 'U') IS NULL
				BEGIN
					CREATE TABLE report.plant_parameters(
						id_plant_parameters INT IDENTITY(1000, 1),
						id_report INT NOT NULL,
						id_plant INT NOT NULL,
						plant_parameters_installed_capacity FLOAT NULL,
						id_capacity_type INT NULL,
						plant_parameters_built_up FLOAT NULL,
						plant_parameters_exposures FLOAT NULL,
						plant_parameters_has_hydrants BIT NOT NULL,
						id_hydrant_protection INT NULL,
						id_hydrant_standpipe_type INT NULL,
						id_hydrant_standpipe_class INT NULL,
						plant_parameters_has_foam_suppression_sys BIT NULL,
						plant_parameters_has_suppresion_sys BIT NULL,
						plant_parameters_has_sprinklers BIT NULL,
						plant_parameters_has_afds BIT NULL,
						plant_parameters_has_fire_detection_batteries BIT NULL,
						plant_parameters_has_private_brigade BIT NULL,
						plant_parameters_has_lighting_protection BIT NULL,
						CONSTRAINT pk_plant_parameters
							PRIMARY KEY(id_plant_parameters),
						CONSTRAINT fk_plant_parameters_report
							FOREIGN KEY(id_report)
							REFERENCES report.report_table(id_report)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_plant_parameters_plant
							FOREIGN KEY(id_plant)
							REFERENCES report.plant_table(id_plant)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_plant_parameters_capacity_type
							FOREIGN KEY(id_capacity_type)
							REFERENCES report.capacity_type_table(id_capacity_type)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_plant_parameters_hydrant_protection
							FOREIGN KEY(id_hydrant_protection)
							REFERENCES report.hydrant_protection_classification_table(id_hydrant_protection_classification)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_plant_parameters_hydrant_standpipe_type
							FOREIGN KEY(id_hydrant_standpipe_type)
							REFERENCES report.hydrant_standpipe_system_type_table(id_hydrant_standpipe_system_type)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_plant_parameters_hydrant_standpipe_class
							FOREIGN KEY(id_hydrant_standpipe_class)
							REFERENCES report.hydrant_standpipe_system_class_table(id_hydrant_standpipe_system_class)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The plant parameters table was correctly created.');
				END;
			ELSE
				PRINT('The plant parameters table already exists');
			IF OBJECT_ID('report.perils_and_risk_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.perils_and_risk_table(
						id_perils_and_risk INT IDENTITY(1000, 1),
						id_report INT NOT NULL,
						id_plant INT NOT NULL,
						perils_and_risk_fire_explosion FLOAT(2) NOT NULL,
						perils_and_risk_landslide_subsidence FLOAT(2) NOT NULL,
						perils_and_risk_water_flooding FLOAT(2) NOT NULL,
						perils_and_risk_wind_storm FLOAT(2) NOT NULL,
						perils_and_risk_lighting FLOAT(2) NOT NULL,
						perils_and_risk_earthquake FLOAT(2) NOT NULL,
						perils_and_risk_tsunami FLOAT(2) NOT NULL,
						perils_and_risk_collapse FLOAT(2) NOT NULL,
						perils_and_risk_aircraft FLOAT(2) NOT NULL,
						perils_and_risk_riot FLOAT(2) NOT NULL,
						perils_and_risk_design_failure FLOAT(2) NOT NULL,
						perils_and_risk_overall_rating FLOAT(2) NOT NULL,
						CONSTRAINT pk_perils_and_risk_table
							PRIMARY KEY(id_perils_and_risk),
						CONSTRAINT fk_perils_and_risk_report
							FOREIGN KEY(id_report)
							REFERENCES report.report_table(id_report)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_perils_and_risk_plant
							FOREIGN KEY(id_plant)
							REFERENCES report.plant_table(id_plant)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The perils and risk table was correctly created.');
				END;
			ELSE
				PRINT('The perils and risk table already exists');
			IF OBJECT_ID('report.loss_scenario_table', 'U') IS NULL
				BEGIN
					CREATE TABLE report.loss_scenario_table(
						id_loss_scenario INT IDENTITY(1000, 1),
						id_report INT NOT NULL,
						id_client INT NOT NULL,
						id_plant INT NOT NULL,
						loss_scenario_material_damage_amount NUMERIC NULL,
						loss_scenario_material_damage_percentage DECIMAL NULL,
						loss_scenario_business_interruption_amount NUMERIC NULL,
						loss_scenario_business_interruption_percentage DECIMAL NULL,
						loss_scenario_building_amount NUMERIC NULL,
						loss_scenario_machinary_equipment_amount NUMERIC NULL,
						loss_scenario_electronic_equipment_amount NUMERIC NULL,
						loss_scenario_expansions_investment_works_amount NUMERIC NULL,
						loss_scenario_stock_amount NUMERIC NULL,
						loss_scenario_total_insured_values NUMERIC NULL,
						loss_scenario_pml_percentage DECIMAL NULL,
						loss_scenario_mfl DECIMAL NULL,
						CONSTRAINT pk_loss_scenario_table
							PRIMARY KEY(id_loss_scenario),
						CONSTRAINT fk_loss_scenario_report
							FOREIGN KEY(id_report)
							REFERENCES report.report_table(id_report)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_loss_scenario_client
							FOREIGN KEY(id_client)
							REFERENCES report.client_table(id_client)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION,
						CONSTRAINT fk_loss_scenario_plant
							FOREIGN KEY(id_plant)
							REFERENCES report.plant_table(id_plant)
							ON DELETE NO ACTION
							ON UPDATE NO ACTION
					);
					PRINT('The loss scenario table was correctly created.');
				END;
			ELSE
				PRINT('The loss scenario table already exists');
		END;
	ELSE
		PRINT('All tables of the database are already created');

EXEC report.proc_tables_creation;
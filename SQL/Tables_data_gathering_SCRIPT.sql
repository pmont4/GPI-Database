USE gpi_consulting_services_reports_db;

CREATE OR ALTER PROCEDURE view_table
	@Table VARCHAR(100)
	AS
		BEGIN
			IF (@Table = 'plant' OR @Table = 'p')
				SELECT p.* FROM report.plant_table p ORDER BY p.id_plant ASC;
			ELSE IF (@Table = 'report table' OR @Table = 'r')
				SELECT r.* FROM report.report_table r ORDER BY r.id_report ASC;
			ELSE IF (@Table = 'report prep' OR @Table = 'rp')
				SELECT rp.* FROM report.report_preparation_table rp ORDER BY rp.id_report_preparation ASC;
			ELSE IF (@Table = 'plant params' OR @Table = 'pp')
				SELECT pp.* FROM report.plant_parameters pp ORDER BY pp.id_plant_parameters ASC;
			ELSE IF (@Table = 'perils and risk' OR @Table = 'pr')
				SELECT pr.* FROM report.perils_and_risk_table pr ORDER BY pr.id_perils_and_risk ASC;
			ELSE IF (@Table = 'merchandise class' OR @Table = 'mc')
				SELECT mc.* FROM report.merchandise_classification_type_table mc ORDER BY mc.id_merchandise_classification_type ASC;
			ELSE IF (@Table = 'loss scenario' OR @Table = 'ls')
				SELECT ls.* FROM report.loss_scenario_table ls ORDER BY ls.id_loss_scenario ASC;
			ELSE IF (@Table = 'client' OR @Table = 'c')
				SELECT c.* FROM report.client_table c ORDER BY c.id_client ASC;
			ELSE IF (@Table = 'engineer' OR @Table = 'e')
				SELECT e.* FROM report.engineer_table e ORDER BY e.id_engineer ASC;
			ELSE IF (@Table = 'hydrant protect class' OR @Table = 'hpc')
				SELECT hpc.* FROM report.hydrant_protection_classification_table hpc ORDER BY hpc.id_hydrant_protection_classification ASC;
			ELSE IF (@Table = 'hydrant standpipe class' OR @Table = 'hsc')
				SELECT hsc.* FROM report.hydrant_standpipe_system_class_table hsc ORDER BY hsc.id_hydrant_standpipe_system_class ASC;
			ELSE IF (@Table = 'hydrant standpipe type' OR @Table = 'hst')
				SELECT hst.* FROM report.hydrant_standpipe_system_type_table hst ORDER BY hst.id_hydrant_standpipe_system_type ASC;
			ELSE IF (@Table = 'capacity type' OR @Table = 'ct')
				SELECT ct.* FROM report.capacity_type_table ct ORDER BY ct.id_capacity_type ASC;
			ELSE IF (@Table = 'type location class' OR @Table = 'tlc')
				SELECT tlc.* FROM report.type_location_classification_table tlc ORDER BY tlc.id_type_location_class ASC;
			ELSE IF (@Table = 'type location' OR @Table = 'tl')
				SELECT tl.* FROM report.type_location_table	tl ORDER BY tl.id_type_location ASC;
			ELSE IF (@Table = 'business turnover class' OR @Table = 'btc')
				SELECT btc.* FROM report.business_turnover_class_table btc ORDER BY btc.id_business_turnover ASC;
			ELSE IF (@Table = 'business turnover' OR @Table = 'bt')
				SELECT bt.* FROM report.business_turnover_table bt ORDER BY bt.id_business_turnover_table ASC;
			ELSE
				PRINT CONCAT('The table with name ', @Table, ' was not found');
		END;

-- Engineer executable
EXEC view_table 'e';
-- Report executable
EXEC view_table 'r';
-- Report preparation executable
EXEC view_table 'rp';
-- Client executable
EXEC view_table 'c';
-- Plant executable
EXEC view_table 'p';
-- Plant parameters executable
EXEC view_table 'pp';
-- Type location executable
EXEC view_table 'tl';
-- Type location class executable
EXEC view_table 'tlc';
-- Merchandise classification executable
EXEC view_table 'mc';
-- Hydrant protection class executable
EXEC view_table 'hpc';
-- Hydrant standpipe type executable
EXEC view_table 'hst';
-- Hydrant standpipe class executable
EXEC view_table 'hsc';
-- Business turnover class executable
EXEC view_table 'btc';
-- Business turnover executable
EXEC view_table 'bt';
-- Capacity type executable
EXEC view_table 'ct';
-- Perils and risk executable
EXEC view_table 'pr';
-- Loss scenario executable
EXEC view_table 'ls';


DELETE FROM report.report_table;
DELETE FROM report.plant_table WHERE id_plant = 1002;

-- Columns
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'plant_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'report_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'engineer_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'report_preparation_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'plant_parameters';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'perils_and_risk_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'merchandise_classification_type_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'loss_scenario_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'client_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'hydrant_protection_classification_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'hydrant_standpipe_system_class_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'hydrant_standpipe_system_type_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'capacity_type_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'type_location_classification_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'type_location_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'business_turnover_class_table';
SELECT C.COLUMN_NAME AS 'Nombre de la columna', C.DATA_TYPE AS 'Tipo de la columna' FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'business_turnover_table';

-- Triggers for restarting the id count 

CREATE OR ALTER TRIGGER trigger_ident_plant ON report.plant_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.plant_table)
			DBCC CHECKIDENT('report.plant_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_report ON report.report_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.report_table)
			DBCC CHECKIDENT('report.report_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_report_preparation ON report.report_preparation_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.report_preparation_table)
			DBCC CHECKIDENT('report.report_preparation_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_plant_parameters ON report.plant_parameters
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.plant_parameters)
			DBCC CHECKIDENT('report.plant_parameters', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_type_location ON report.type_location_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.type_location_table)
			DBCC CHECKIDENT('report.type_location_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_business_turnover ON report.business_turnover_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.business_turnover_table)
			DBCC CHECKIDENT('report.business_turnover_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_perils_and_risk ON report.perils_and_risk_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.perils_and_risk_table)
			DBCC CHECKIDENT('report.perils_and_risk_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_loss_scenario ON report.loss_scenario_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.loss_scenario_table)
			DBCC CHECKIDENT('report.loss_scenario_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_engineer ON report.engineer_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.engineer_table)
			DBCC CHECKIDENT('report.engineer_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_client ON report.client_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.client_table)
			DBCC CHECKIDENT('report.client_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_merchandise_classification_type ON report.merchandise_classification_type_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.merchandise_classification_type_table)
			DBCC CHECKIDENT('report.merchandise_classification_type_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_hydrant_protection_classification ON report.hydrant_protection_classification_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.hydrant_protection_classification_table)
			DBCC CHECKIDENT('report.hydrant_protection_classification_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_hydrant_standpipe_system_class ON report.hydrant_standpipe_system_class_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.hydrant_standpipe_system_class_table)
			DBCC CHECKIDENT('report.hydrant_standpipe_system_class_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_hydrant_standpipe_system_type ON report.hydrant_standpipe_system_type_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.hydrant_standpipe_system_type_table)
			DBCC CHECKIDENT('report.hydrant_standpipe_system_type_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_capacity_type ON report.capacity_type_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.capacity_type_table)
			DBCC CHECKIDENT('report.capacity_type_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_type_location_classification_type ON report.type_location_classification_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.type_location_classification_table)
			DBCC CHECKIDENT('report.type_location_classification_table', RESEED, 1000);
	END;

CREATE OR ALTER TRIGGER trigger_ident_business_turnover_classification_type ON report.business_turnover_class_table
AFTER DELETE AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM report.business_turnover_class_table)
			DBCC CHECKIDENT('report.business_turnover_class_table', RESEED, 1000);
	END;
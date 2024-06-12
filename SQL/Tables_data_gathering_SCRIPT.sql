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
			ELSE IF (@Table = 'merchandise' OR @Table = 'm')
				SELECT m.* FROM report.merchandise_table m ORDER BY m.id_merchandise ASC;
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
			ELSE
				PRINT CONCAT('The table with name ', @Table, ' was not found');
		END;

-- Engineer executable
EXEC view_table 'e';
-- Client executable
EXEC view_table 'c';
-- Plant executable
EXEC view_table 'p';
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

SELECT C.COLUMN_NAME, C.DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'plant_table';
SELECT C.COLUMN_NAME, C.DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS C WHERE TABLE_NAME = 'report_table';
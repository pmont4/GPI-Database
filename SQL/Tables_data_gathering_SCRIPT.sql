CREATE OR ALTER PROCEDURE view_table
	@Table VARCHAR(100)
	AS
		BEGIN
			IF (@Table = 'plant' OR @Table = 'p')
				SELECT p.* FROM report.plant_table p;
			ELSE IF (@Table = 'report table' OR @Table = 'r')
				SELECT r.* FROM report.report_table r;
			ELSE IF (@Table = 'report prep' OR @Table = 'rp')
				SELECT rp.* FROM report.report_preparation_table rp;
			ELSE IF (@Table = 'plant params' OR @Table = 'pp')
				SELECT pp.* FROM report.plant_parameters pp;
			ELSE IF (@Table = 'perils and risk' OR @Table = 'pr')
				SELECT pr.* FROM report.perils_and_risk_table pr;
			ELSE IF (@Table = 'merchandise' OR @Table = 'm')
				SELECT m.* FROM report.merchandise_table m;
			ELSE IF (@Table = 'merchandise class' OR @Table = 'mc')
				SELECT mc.* FROM report.merchandise_classification_type_table mc;
			ELSE IF (@Table = 'loss scenario' OR @Table = 'ls')
				SELECT ls.* FROM report.loss_scenario_table ls;
			ELSE IF (@Table = 'client' OR @Table = 'c')
				SELECT c.* FROM report.client_table c;
			ELSE IF (@Table = 'engineer' OR @Table = 'e')
				SELECT e.* FROM report.engineer_table e;
			ELSE IF (@Table = 'hydrant protect class' OR @Table = 'hpc')
				SELECT hpc.* FROM report.hydrant_protection_classification_table hpc;
			ELSE IF (@Table = 'hydrant standpipe class' OR @Table = 'hsc')
				SELECT hsc.* FROM report.hydrant_standpipe_system_class_table hsc;
			ELSE IF (@Table = 'hydrant standpipe type' OR @Table = 'hst')
				SELECT hst.* FROM report.hydrant_standpipe_system_type_table hst;
			ELSE IF (@Table = 'capacity type' OR @Table = 'ct')
				SELECT ct.* FROM report.capacity_type_table ct;
			ELSE IF (@Table = 'type location class' OR @Table = 'tlc')
				SELECT tlc.* FROM report.type_location_classification_table tlc;
			ELSE IF (@Table = 'type location' OR @Table = 'tl')
				SELECT tl.* FROM report.type_location_table	 tl;
			ELSE
				PRINT CONCAT('The table with name ', @Table, ' was not found');
		END;

EXEC view_table 'e';

	
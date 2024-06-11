CREATE OR ALTER PROCEDURE view_table
	@Table VARCHAR(100)
	AS
		BEGIN
			IF (@Table = 'plant' OR @Table = 'p')
				SELECT p.* FROM report.plant_table p;
			IF (@Table = 'report table' OR @Table = 'r')
				SELECT r.* FROM report.report_table r;
			IF (@Table = 'report prep' OR @Table = 'rp')
				SELECT rp.* FROM report.report_preparation_table rp;
			IF (@Table = 'plant params' OR @Table = 'pp')
				SELECT pp.* FROM report.plant_parameters pp;
		END;
	
CREATE OR ALTER PROCEDURE insert_engineer
	@name VARCHAR(100),
	@contact VARCHAR(100)
AS
	BEGIN
		INSERT INTO report.engineer_table (engineer_name, engineer_contact)
		VALUES (@name, @contact);
		BEGIN
			PRINT CONCAT('The engineer ', @name, ' was correctly saved in the database');
		END;
	END;

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

EXEC insert_engineer 'Juan Jose Lira', '';

USE gpi_consulting_services_reports_db;

-- Plant query

SELECT 
	p.id_plant AS 'ID plant',
	p.plant_account_name AS 'Account name',
	p.plant_name AS 'Plant name',
	CONCAT(p.plant_continent, ' - ', p.plant_country, ' - ', p.plant_country_state) AS 'Country and state',

	YEAR(p.plant_construction_year) AS 'Construction year',
	YEAR(p.plant_operation_startup_year) AS 'Operation startup year',
	CONCAT('Latitude: ', CAST(p.plant_latitude AS VARCHAR(20)), ' Longitude: ', CAST(p.plant_longitude AS VARCHAR(20))) AS 'Latitude and longitude',
	p.plant_meters_above_sea_level AS 'Meters above sea level',
	p.plant_address AS 'Address',
	mc.merchandise_classification_type_name AS 'Merchandise classification',
	btc.business_turnover_name AS 'Business turnover',
	p.plant_business_specific_turnover AS 'Specific business turnover',
	STRING_AGG(tlc.type_location_class_name, ', ') AS 'Location description'
FROM report.plant_table p
	LEFT JOIN report.merchandise_classification_type_table mc ON p.plant_merchandise_class = mc.id_merchandise_classification_type
	LEFT JOIN report.business_turnover_table bt ON bt.id_plant = p.id_plant
	LEFT JOIN report.business_turnover_class_table btc ON bt.id_business_turnover = btc.id_business_turnover
	LEFT JOIN report.type_location_table tl ON p.id_plant = tl.id_plant
	LEFT JOIN report.type_location_classification_table tlc ON tl.id_type_location_class = tlc.id_type_location_class
GROUP BY p.id_plant, p.plant_account_name, p.plant_name, p.plant_country, p.plant_continent, p.plant_country_state, p.plant_construction_year, p.plant_operation_startup_year,
p.plant_latitude, p.plant_longitude, p.plant_meters_above_sea_level, p.plant_address, mc.merchandise_classification_type_name, btc.business_turnover_name, p.plant_business_specific_turnover;

-- Report query

SELECT
	r.id_report AS 'ID report',
	CAST(r.report_date AS DATE) AS 'Date',
	c.client_name AS 'Client',
	p.plant_name AS 'Plant name',
	STRING_AGG(e.engineer_name, ', ') AS 'Prepared by'
FROM report.report_table r
	LEFT JOIN report.client_table c ON r.id_client = c.id_client
	LEFT JOIN report.plant_table p ON r.id_plant = p.id_plant
	LEFT JOIN report.report_preparation_table rp ON r.id_report = rp.id_report
	LEFT JOIN report.engineer_table e ON e.id_engineer = rp.id_engineer
GROUP BY r.id_report, r.report_date, c.client_name, p.plant_name
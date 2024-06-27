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
p.plant_latitude, p.plant_longitude, p.plant_meters_above_sea_level, p.plant_address, mc.merchandise_classification_type_name, btc.business_turnover_name, p.plant_business_specific_turnover
ORDER BY p.id_plant;

-- Report query

CREATE OR ALTER FUNCTION report.CALCULATE_RISK_FOR_QUERY(@risk FLOAT(2))
RETURNS VARCHAR(25)
AS
	BEGIN
		DECLARE @to_return AS VARCHAR(25) = (SELECT CASE
														WHEN @risk >= 1 AND @risk < 1.5 THEN 'Light'
														WHEN @risk >= 1.5 AND @risk < 2 THEN 'Light / Moderate'
														WHEN @risk >= 2 AND @risk < 2.5 THEN 'Moderate'
														WHEN @risk >= 2.5 AND @risk < 3 THEN 'Moderate / Severe'
														WHEN @risk >= 3 THEN 'Severe'
														ELSE 'No risk'
													END);
		RETURN @to_return;
	END;

CREATE OR ALTER FUNCTION report.HAVE_OR_NOT(@value BIT)
RETURNS VARCHAR(3)
AS
	BEGIN
		DECLARE @to_return AS VARCHAR(3) = IIF(@value = 1, 'Yes', 'No');
		RETURN @to_return;
	END;

SELECT
	r.id_report AS 'ID report',
	CAST(r.report_date AS DATE) AS 'Date',
	c.client_name AS 'Client',
	STRING_AGG(e.engineer_name, ', ') AS 'Prepared by',
	p.plant_name AS 'Plant name',
	pp.plant_certifications AS 'Certifications',
	CONCAT(pp.plant_parameters_installed_capacity, ' ', ct.capacity_type_name) AS 'Installed capacity',
	pp.plant_parameters_built_up AS 'Built-up area',

	report.CALCULATE_RISK_FOR_QUERY(pp.plant_parameters_exposures) AS 'Area exposures',

	report.HAVE_OR_NOT(pp.plant_parameters_has_hydrants) AS 'Has hydrants?',

	IIF(pp.id_hydrant_protection IS NOT NULL, hdp.hydrant_protection_classification_name, 'No hydrant protection classification saved') AS 'Hydrant protection classification',
	IIF(pp.id_hydrant_standpipe_type IS NOT NULL, hst.hydrant_standpipe_system_type_name, 'No hydrant standpipe type saved') AS 'Hydrant standpipe type',
	IIF(pp.id_hydrant_standpipe_class IS NOT NULL, hsc.hydrant_standpipe_system_class_name, 'No hydrant standpipe classification saved') AS 'Hydrant standpipe classification',

	report.HAVE_OR_NOT(pp.plant_parameters_has_foam_suppression_sys) AS 'Has a foam suppression system?', 
	report.HAVE_OR_NOT(pp.plant_parameters_has_suppresion_sys) AS 'Has a suppression system?',
	report.HAVE_OR_NOT(pp.plant_parameters_has_sprinklers) AS 'Has sprinklers?',
	report.HAVE_OR_NOT(pp.plant_parameters_has_afds) AS 'Has an automatic fire detection system?',
	report.HAVE_OR_NOT(pp.plant_parameters_has_fire_detection_batteries) AS 'Has battery fire detectors?',
	report.HAVE_OR_NOT(pp.plant_parameters_has_private_brigade) AS 'Has a private brigade?',
	report.HAVE_OR_NOT(pp.plant_parameters_has_lighting_protection) AS 'Has lighting protection?',

	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_fire_explosion) AS 'Fire / Explosion risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_landslide_subsidence) AS 'Landslide / Subsidence risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_water_flooding) AS 'Water flooding risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_wind_storm) AS 'Wind / Storm risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_lighting) AS 'Lighting risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_earthquake) AS 'Earthquake risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_tsunami) AS 'Tsunami risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_collapse) AS 'Collapse risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_aircraft) AS 'Aircraft risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_riot) AS 'Riot risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_design_failure) AS 'Design failure risk',
	report.CALCULATE_RISK_FOR_QUERY(pr.perils_and_risk_overall_rating) AS 'Overall rating'
FROM report.report_table r
	LEFT JOIN report.client_table c ON r.id_client = c.id_client
	LEFT JOIN report.plant_table p ON r.id_plant = p.id_plant
	LEFT JOIN report.report_preparation_table rp ON r.id_report = rp.id_report
	LEFT JOIN report.engineer_table e ON e.id_engineer = rp.id_engineer
	LEFT JOIN report.plant_parameters pp ON r.id_report = pp.id_report
	LEFT JOIN report.capacity_type_table ct ON pp.id_capacity_type = ct.id_capacity_type
	LEFT JOIN report.hydrant_protection_classification_table hdp ON pp.id_hydrant_protection = hdp.id_hydrant_protection_classification
	LEFT JOIN report.hydrant_standpipe_system_type_table hst ON pp.id_hydrant_standpipe_type = hst.id_hydrant_standpipe_system_type
	LEFT JOIN report.hydrant_standpipe_system_class_table hsc ON pp.id_hydrant_standpipe_class = hsc.id_hydrant_standpipe_system_class
	LEFT JOIN report.perils_and_risk_table pr ON r.id_report = pr.id_report
GROUP BY r.id_report, r.report_date, c.client_name, p.plant_name, pp.plant_certifications, pp.plant_parameters_installed_capacity, ct.capacity_type_name, pp.plant_parameters_built_up,
pp.plant_parameters_exposures, pp.plant_parameters_has_hydrants, pp.id_hydrant_protection, hdp.hydrant_protection_classification_name, pp.id_hydrant_standpipe_type, hst.hydrant_standpipe_system_type_name,
pp.id_hydrant_standpipe_class, hsc.hydrant_standpipe_system_class_name, pp.plant_parameters_has_foam_suppression_sys, pp.plant_parameters_has_suppresion_sys, pp.plant_parameters_has_sprinklers,
pp.plant_parameters_has_afds, pp.plant_parameters_has_fire_detection_batteries, pp.plant_parameters_has_private_brigade, pp.plant_parameters_has_lighting_protection, pr.perils_and_risk_fire_explosion,
pr.perils_and_risk_landslide_subsidence, pr.perils_and_risk_water_flooding, pr.perils_and_risk_wind_storm, pr.perils_and_risk_lighting, pr.perils_and_risk_earthquake, pr.perils_and_risk_tsunami,
pr.perils_and_risk_collapse, pr.perils_and_risk_aircraft, pr.perils_and_risk_riot, pr.perils_and_risk_design_failure, pr.perils_and_risk_overall_rating
ORDER BY r.id_report;
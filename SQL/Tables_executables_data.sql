USE gpi_consulting_services_reports_db;

-- Plant table executables for data insertion
-- Data is being inserted in the following order:
--
-- Account name, name of the plant, continent, country, state of the country, plant year construction, plant operation startup year, plant certifications, plant business turnover, plant specific business turnover,
-- plant merchandise classification, plant type of location, plant address, plant latitude, plant longitude and plant meters above the sea level.

EXEC report.proc_insert_plant 'TATA - Accesorios Globales, S.A.', null, 'C.A.', 'Guatemala', 'Guatemala', 1985, 1985, null, 'Production', 'Manufacture of natural and synthetic leather belts for export', 'III', 'Industrial,Residential', '2ª. Calle 1-11 y 1-25 Zona 8, Granjas Gerona, San Miguel Petapa, Guatemala, C.A.', 14.533944, -90.593765, 1274;
EXEC report.proc_insert_plant 'Sidegua Steel Park', null, 'C.A.', 'Guatemala', 'Escuintla', 1991, 1994, 'ASTM, COGUANOR, ACI, INTECO', 'Production', 'Steel Casting', '0','Industrial,Rural', 'Km 65.5 CA9-A Highway, Masagua, Escuintla, Guatemala, C.A.', 14.533944, -90.593765, 1274;
EXEC report.proc_insert_plant 'Industria de Tubos y Perfiles, S.A. - INTUPERSA', null, 'C.A.', 'Guatemala', 'Guatemala', 1961, 1961, null, 'Production', 'Manufacturing and commercialization of steel pipes and profiles', 'I','Industrial,Residential', '9ª. Avenida 3-17 Z.2 Mixco, Colonia Alvarado, Guatemala, Guatemala', 14.628646, -90.578844, 1596;

-- Report table executables for data insertion
-- Data is being inserted in the following order:
--
-- Date of the report, id or name of the client who requested the report, id or name of the plant, id or name of the engineer who prepared the report (in case there are more than one engineer, add the name or the id followed by a ,)
-- the installed capacity (first write the amount, then the classification followeb by a /, classification can be write by id or name), the plant built-up area, the rate of risk that the plant is expose to by it's location,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) Plant has hydrants?, id or name of the hydrant protection classification, id or name of the hydrant standpipe system type, id or name of the hydrant standpipe system classification,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) Does the plant has a foam suppresion system? (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) does the plant has a suppression system?,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) Does the plant has sprinklers? (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) does the plant has a automatic fire detection system (afds)?,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) Does the plant has fire detector that work with batteries? (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) Does the plant has a private brigade?
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no) Does the plant has lighting protection?

EXEC report.proc_insert_report '1/november/2019', '1000', '1029', '1000', '240000.00,units/Month', 12850.00, 'Light', 1, null, null, null, 0, 0, 0, 1, 0, 1, 1;

-- Perils and risk executables for data insertion
-- Data is being inserted in the following order:
--
-- To rate the level of risk, use a 1 to 3 scale, 1 is for light, 1.5 is for light/moderate, 2 is for moderate, 2.5 is for moderate/severe and 3 is for sever, any number beyond 3 will be considered by the database as severe
-- Or you could write the classification without numbers: light, light/moderate, moderate, moderate/severe, severe
--
-- The id of the report, the id or name of the plant, fire/explosion risk rate, landslide/subsidence risk rate, water flooding risk rate, wind/storm risk rate, lighting risk rate, earthquake risk rate, tsunami risk rate,
-- collapse risk rate, aircraft risk rate, riot risk rate, design failure risk rate and a overall risk rate

EXEC report.proc_insert_perils_and_risk_table 1005, '1029', '2.5', 'light', 'light', '2', 'severe', null, 'none', '0', 'light', '1', 'LIGHT ', 'lIgHt';

-- Loss scenario executables for data insertion
-- Data is being inserted in the following order:
--
-- The id of the report, the id or name of the client who requested the report, the id or name of the plant, the amount of material damage estimated, the percentage of material damage estimated, the business interruption amount estimated,
-- The business interruption percentage estimated, the building value estimated for the material damage calculation, the machinary and equipment value estimated for the material damage calculation, the electronic equipment value for the material damage calculation,
-- The expansion works or investment amount for the material damage calculation, the total value of the stock of the plant for the material damage calculation, the value of the total insured values (MD + BI), the pml percentage, and the mfl percentage (If exists in the report)

EXEC report.proc_insert_loss_scenario_table 1005, 1000, 1029, 15963716.63, 85, 9129876, 75, 2343287.10, 3620429.53, null, null, 0, 25093592.63, 82, null;

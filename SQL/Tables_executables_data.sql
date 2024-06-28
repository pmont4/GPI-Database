USE gpi_consulting_services_reports_db;

-- Engineer table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the engineer and the contact of the engineer (could be email or phone number)

EXEC report.proc_insert_engineer 'Marlon Lira', 'mlira@gpiconsultingservices.com';
EXEC report.proc_insert_engineer 'Jorge Cifuentes Garcia', 'jcifuentes@gpiconsultingservices.com';
EXEC report.proc_insert_engineer 'Carlos Grajeda', null;
EXEC report.proc_insert_engineer 'Rafael Grajeda', null;
EXEC report.proc_insert_engineer 'Juan Jose Lira', null;
EXEC report.proc_insert_engineer 'Juan Diego Lacayo', 'jdlacayo@gpiconsultingservices.com';
EXEC report.proc_insert_engineer 'Eduardo Bracamonte', null;

-- Client table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the company

EXEC report.proc_insert_client 'Unity Promotores, S.A.';
EXEC report.proc_insert_client 'Reasinter, Intermadiario de Reaseguro, S.A.';
EXEC report.proc_insert_client 'Tecniseguros, Corredores de Seguros, S.A.';
EXEC report.proc_insert_client 'Seguros Mapfre - Guatemala';
EXEC report.proc_insert_client 'Seguros Agromercantil, S.A.';
EXEC report.proc_insert_client 'Grupo Protegemos Asesores';
EXEC report.proc_insert_client 'Redbridge | assurance business support.';
EXEC report.proc_insert_client 'Almacenadora Integrada, S.A.';
EXEC report.proc_insert_client 'Grupo Cemaco';
EXEC report.proc_insert_client 'Generali Global Corporate & Commercial';
EXEC report.proc_insert_client 'Técnicos en Seguros, S.A.';
EXEC report.proc_insert_client 'Aseguradora Mundial, S.A.';
EXEC report.proc_insert_client 'Corporación Arcenillas, S.A.';
EXEC report.proc_insert_client 'Alimentos S.A.';
EXEC report.proc_insert_client 'Cerveceria Centro Americana S.A.';
EXEC report.proc_insert_client 'Conseguros, Corredor de Seguros, S.A.';
EXEC report.proc_insert_client 'Seguros Universales S.A.';


-- Capacity type table executables for data insertion
-- Data is being inserted in the following order
-- 
-- Name of the type

EXEC report.proc_insert_capacity_type 'Tons / year';
EXEC report.proc_insert_capacity_type 'Kilograms/Month';
EXEC report.proc_insert_capacity_type 'Metric tons/Hour';
EXEC report.proc_insert_capacity_type 'Metric tons/Day';
EXEC report.proc_insert_capacity_type 'Metric tons/Year';
EXEC report.proc_insert_capacity_type 'Metric tons/Month';
EXEC report.proc_insert_capacity_type 'Liters/year';
EXEC report.proc_insert_capacity_type 'Hectoliters/Year';
EXEC report.proc_insert_capacity_type 'Short tons/Day';
EXEC report.proc_insert_capacity_type 'Pounds/Week';
EXEC report.proc_insert_capacity_type 'Tons/Hour';
EXEC report.proc_insert_capacity_type 'Tons/Day';
EXEC report.proc_insert_capacity_type 'Tons/Month';
EXEC report.proc_insert_capacity_type 'qq/Day';
EXEC report.proc_insert_capacity_type 'qq/Hour';
EXEC report.proc_insert_capacity_type 'units/Week';
EXEC report.proc_insert_capacity_type 'units/Month';
EXEC report.proc_insert_capacity_type 'MW';
EXEC report.proc_insert_capacity_type 'KVA';
EXEC report.proc_insert_capacity_type 'Flights/Month';
EXEC report.proc_insert_capacity_type 'Board foot/Month';
EXEC report.proc_insert_capacity_type 'Parking/Locals';
EXEC report.proc_insert_capacity_type 'People';
EXEC report.proc_insert_capacity_type 'Barrels';
EXEC report.proc_insert_capacity_type 'Bins/Pallets';
EXEC report.proc_insert_capacity_type 'Seats';
EXEC report.proc_insert_capacity_type 'Tons';
EXEC report.proc_insert_capacity_type 'Metric tons';


-- Merchandise classification table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the merchandise classification

EXEC report.proc_insert_merchandise_class 'I';
EXEC report.proc_insert_merchandise_class 'II';
EXEC report.proc_insert_merchandise_class 'III';
EXEC report.proc_insert_merchandise_class 'IV';

-- Hydrant protection classification table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the classification

EXEC report.proc_insert_hydrant_protection_class 'Major fires';
EXEC report.proc_insert_hydrant_protection_class 'Minor fires';
EXEC report.proc_insert_hydrant_protection_class 'Major & Minor fires';

-- Hydrant standpipe system type table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the type

EXEC report.proc_insert_hydrant_standpipe_type 'Automatic Dry';
EXEC report.proc_insert_hydrant_standpipe_type 'Automatic Wet';
EXEC report.proc_insert_hydrant_standpipe_type 'Manual Dry';
EXEC report.proc_insert_hydrant_standpipe_type 'Manual Wet';
EXEC report.proc_insert_hydrant_standpipe_type 'Semiautomatic Dry';

-- Hydrant standpipe system classificatioon table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the classification

EXEC report.proc_insert_hydrant_standpipe_class 'I';
EXEC report.proc_insert_hydrant_standpipe_class 'II';
EXEC report.proc_insert_hydrant_standpipe_class 'III';

-- Type of location table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the type location

EXEC report.proc_insert_type_location_class 'Industrial';
EXEC report.proc_insert_type_location_class 'Comercial';
EXEC report.proc_insert_type_location_class 'Residential';
EXEC report.proc_insert_type_location_class 'Rural';

-- Business turnover classification table executables for data insertion
-- Data is being inserted in the following order
--
-- Name of the business turnover classification

EXEC report.proc_insert_business_turnover_class 'Production';
EXEC report.proc_insert_business_turnover_class 'Electricity generation';
EXEC report.proc_insert_business_turnover_class 'Storage';
EXEC report.proc_insert_business_turnover_class 'Distribution';
EXEC report.proc_insert_business_turnover_class 'Real state';
EXEC report.proc_insert_business_turnover_class 'Retail';
EXEC report.proc_insert_business_turnover_class 'Aeronautical revenue';
EXEC report.proc_insert_business_turnover_class 'Production and electricity generation';

-- Plant table executables for data insertion
-- Data is being inserted in the following order:
--
-- Account name, name of the plant, continent, country, state of the country, plant year construction, plant operation startup year, plant certifications, plant business turnover, plant specific business turnover,
-- plant merchandise classification, plant type of location, plant address, plant latitude, plant longitude and plant meters above the sea level.

EXEC report.proc_insert_plant 'TATA - Accesorios Globales, S.A.', null, 'C.A.', 'Guatemala', 'Guatemala', 1985, 1985, 'Production', 'Manufacture of natural and synthetic leather belts for export', 'III', 'Industrial,Residential', '2ª. Calle 1-11 y 1-25 Zona 8, Granjas Gerona, San Miguel Petapa, Guatemala, C.A.', 14.533944, -90.593765, 1274;
EXEC report.proc_insert_plant 'Corporacion AG', 'Sidegua Steel Park', 'C.A.', 'Guatemala', 'Escuintla', 1991, 1994, 'Production', 'Steel Casting', 'I','Industrial,Rural', 'Km 65.5 CA9-A Highway, Masagua, Escuintla, Guatemala, C.A.', 14.235620, -90.818210, 175;
EXEC report.proc_insert_plant 'Industria de Tubos y Perfiles, S.A. - INTUPERSA', 'Industria de Tubos y Perfiles, S.A. - INTUPERSA', 'C.A.', 'Guatemala', 'Guatemala', 1961, 1961, 'Production', 'Manufacturing and commercialization of steel pipes and profiles', 'I','Industrial,Residential', '9ª. Avenida 3-17 Z.2 Mixco, Colonia Alvarado, Guatemala, Guatemala', 14.628646, -90.578844, 1596;
EXEC report.proc_insert_plant 'Ramón Villeda Morales International Airport', null, 'C.A.', 'Honduras', 'Cortes', 1963, 1965, 'Aeronautical revenue', 'International and Domestic Flights, including commercial, cargo, pri-vate, military, diplomatic and humanitarian flights.', null,'Residential,Rural', '9ª. Avenida 3-17 Z.2 Mixco, Colonia Alvarado, Guatemala, Guatemala', 15.455727, -87.927497, 28;
EXEC report.proc_insert_plant 'Agregados de Guatemala, S.A. – AGREGUA', 'AGREGUA Zona 6', 'C.A.', 'Guatemala', 'Guatemala', null, null, 'Production', 'Extracción, trituración, clasificación y comercialización de piedra', 'I','Industrial,Residential', '15 Avenida 22-01, Zona 6, Interior Finca La Pedrera','14°40m15.51s', '90°29m33.55s', 1456;
EXEC report.proc_insert_plant 'Agroamérica – Proyecto Extractora Agroaceite', null, 'C.A.', 'Guatemala', 'Quetzaltenango', 2011, 2012, 'Production', 'Planta de recepción, extracción, procesamiento y almacenamiento de aceite de palma africana.', 'IV','Rural', 'Km. 26.4 Carretera a Mojarras, Coatepeque, Quetzaltenango, Guatemala, C.A.','14°33m24.94s', '92°00m20.98s', 19;
EXEC report.proc_insert_plant 'Agrocaribe – Extractora del Atlántico', null, 'C.A.', 'Guatemala', 'Izabal', null, null, 'Production', 'Planta de recepción, extracción, procesamiento y almacenamiento de aceite de palma africana.', 'IV','Rural', 'Km. 276 Carretera al Atlántico, Izabal, Guatemala, C.A.', null, null, 24;


-- Report table executables for data insertion
-- Data is being inserted in the following order:
--
-- Date of the report, id or name of the client who requested the report, id or name of the plant, id or name of the engineer who prepared the report (in case there are more than one engineer, add the name or the id followed by a ,)
-- the certifications that the plant has (write null if the plant has no certifications) the installed capacity (first write the amount, then the classification followeb by a /, classification can be write by id or name), the plant built-up area, the rate of risk that the plant is expose to by it's location,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) Plant has hydrants?, id or name of the hydrant protection classification, id or name of the hydrant standpipe system type, id or name of the hydrant standpipe system classification,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) Does the plant has a foam suppresion system? (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) does the plant has a suppression system?,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) Does the plant has sprinklers? (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) does the plant has a automatic fire detection system (afds)?,
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) Does the plant has fire detector that work with batteries? (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) Does the plant has a private brigade?
-- (Here we add 0 or 1, 1 is yes and 0 is no, or you could write yes or no, true or false) Does the plant has lighting protection?

EXEC report.proc_insert_report_table '1/november/2019', 1000, 1001, 'Marlon lira', null, '240000,units/month', 12850.00, 'light', 1, null, null, null, 'no', 0, 'si', 1, 'no', 'si', 'si';
EXEC report.proc_insert_report_table '29/july/2020', 'Tecniseguros, Corredores de Seguros, S.A.', 1003, 'Rafael Grajeda', 'ASTM, COGUANOR, ACI and INTECO', '500000,metric tons/year', 152829.70, 'light', 1, 'minor fire', 'manual dry', 'II', 'no', 'no', 'no', 'no', 'si', 'si', 'si';
EXEC report.proc_insert_report_table '10/agosto/2020', 'Tecniseguros, Corredores de Seguros, S.A.', 1004, 'Rafael Grajeda', null, '3610,metric tons/month', 13450, 'light', 1, '1001', 'Automatic Wet', 'II', 'no', 'no', 'no', 'si', 'no', 'si', 'si';
EXEC report.proc_insert_report_table '18/agosto/2021', 'Reasinter, Intermadiario de Reaseguro, S.A.', 1005, 'Rafael Grajeda', 'Class B: IFR, SVFR, or VFR', '284,flights/month', 12575, 'light', 1, 1000, 'manual dry', 'III', 'si', 'no', 'no', 'si', 'si', 'si', 'si';
EXEC report.proc_insert_report_table '13/noviembre/2012', 'Seguros Mapfre - Guatemala', 1009, 'Marlon Lira', null, '220,tons/hour', null, 'moderate', 'no', null, null, null, 'no', 'no', 'no', 'no', 'no', 'si', 'si';
EXEC report.proc_insert_report_table '14/noviembre/2012', 'Seguros Mapfre - Guatemala', 1010, 'Marlon Lira', null, '80,metric tons/hour', 10500, 'moderate', 'si', null, null, null, 'no', 'no', 'no', 'no', 'no', 'si', 'si';
EXEC report.proc_insert_report_table '14/septiembre/2011', 'Seguros Mapfre - Guatemala', 2009, 'Marlon Lira', null, '53,metric tons/hour', 62000, 'moderate / severe', 'no', null, null, null, 'no', 'no', 'no', 'no', 'no', 'no', 'si';

-- Perils and risk executables for data insertion
-- Data is being inserted in the following order:
--
-- To rate the level of risk, use a 1 to 3 scale, 1 is for light, 1.5 is for light/moderate, 2 is for moderate, 2.5 is for moderate/severe and 3 is for sever, any number beyond 3 will be considered by the database as severe
-- Or you could write the classification without numbers: light, light/moderate, moderate, moderate/severe, severe
--
-- The id of the report, the id or name of the plant, fire/explosion risk rate, landslide/subsidence risk rate, water flooding risk rate, wind/storm risk rate, lighting risk rate, earthquake risk rate, tsunami risk rate,
-- collapse risk rate, aircraft risk rate, riot risk rate, design failure risk rate and a overall risk rate, if you leave the overall risk field empty, the database will automatically calculate the overall risk.

EXEC report.proc_insert_perils_and_risk_table 1001, '1001', '2.5', 'light', 'light', '2', 'severe', null, 'none', '0', 'light', '1', 'LIGHT ', null;
EXEC report.proc_insert_perils_and_risk_table 1006, '1003', '2.5', 'none', '1', '2.5', '2', 2.5, 'none', '1', '1', '1', 'LIGHT ', 1;
EXEC report.proc_insert_perils_and_risk_table 1008, 1004, 1, 2, 1, 2, 2, 2.5, 'none', 1, 1, 1, 1, 1;
EXEC report.proc_insert_perils_and_risk_table 1010, 1005, 1.5, 'none', 2.5, 1, 2, 2, 'none', 1, 3, 2.5, 1, 2;
EXEC report.proc_insert_perils_and_risk_table 1011, 1009, 'none', 1, 1, 1, 1.5, 2.5, 'none', 1, 'none', 1, 'none', 1.5;
EXEC report.proc_insert_perils_and_risk_table 2007, 1010, 'none', 1, 2, 2, 2, 2, 'none', 1, 1, 'none', 'none', 1.5;
EXEC report.proc_insert_perils_and_risk_table 2008, 2009, 'none', 1, 3, 3, 2.5, 2.5, 'none', 1, 1, 'none', 'none', 2.5;

-- Loss scenario executables for data insertion
-- Data is being inserted in the following order:
--
-- The id of the report, the id or name of the client who requested the report, the id or name of the plant, the amount of material damage estimated, the percentage of material damage estimated, the business interruption amount estimated,
-- The business interruption percentage estimated, the building value estimated for the material damage calculation, the machinary and equipment value estimated for the material damage calculation, the electronic equipment value for the material damage calculation,
-- The expansion works or investment amount for the material damage calculation, the total value of the stock of the plant for the material damage calculation, the value of the total insured values (MD + BI), the pml percentage, and the mfl percentage (If exists in the report)
--
-- You can leave the material damage and the total insured values in blank if you want, just be aware of giving all the values to the command so the database can calculate those values for you.

EXEC report.proc_insert_loss_scenario_table 1001, 'Unity Promotores, S.A.', 1001, 15963716.63, 85, 9129876, 75, 2343287.10, 3620429.53, null, null, 0, 25093592.63, 82, null;
EXEC report.proc_insert_loss_scenario_table 1006, 'Tecniseguros, Corredores de Seguros, S.A.', 1003, 331598607.86, 100, 82150542.25, 100, 57169151.84, 274429456.02, null, null, 0, 413749150.11, 100, null;
EXEC report.proc_insert_loss_scenario_table 1008, 'Tecniseguros, Corredores de Seguros, S.A.', 1004, 331598607.86, 100, 82150542.25, 100, 57169151.84, 274429456.02, null, null, 0, 413749150.11, 100, null;
EXEC report.proc_insert_loss_scenario_table 1010, 'Reasinter, Intermadiario de Reaseguro, S.A.', 1005, 68358191, 100, 18916000, null, 0, 0, null, null, 0, 0, 100, null;
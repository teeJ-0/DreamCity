INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Wegenwacht', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Wegenwacht', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Wegenwacht'),
	('offmechanic', 'Wegenwacht')
;

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (37, 'mechanic', 0, 'stagair', 'Stagair', 200, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (38, 'mechanic', 1, 'monteur', 'Monteur', 300, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (39, 'mechanic', 2, 'eerstemonteur', 'Eerste Monteur', 400, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (40, 'mechanic', 3, 'hoofdmonteur', 'Hoofd Monteur', 500, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (41, 'mechanic', 4, 'autotechnicus', 'Autotechnicus', 600, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (42, 'mechanic', 5, 'autotechnischspecialist', 'Autotechnisch Specialist', 700, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (43, 'mechanic', 6, 'autotechnischingenieur', 'Autotechnisch Ingenieur', 800, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (44, 'mechanic', 7, 'teamleider', 'Teamleider', 900, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (45, 'mechanic', 8, 'manager', 'Manager', 1000, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (46, 'mechanic', 9, 'directeur', 'Directeur', 1100, '{}', '{}');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (47, 'offmechanic', 0, 'stagair', 'Stagair (Uit-Dienst)', 100, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (48, 'offmechanic', 1, 'monteur', 'Monteur (Uit-Dienst)', 150, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (49, 'offmechanic', 2, 'eerstemonteur', 'Eerste Monteur (Uit-Dienst)', 200, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (50, 'offmechanic', 3, 'hoofdmonteur', 'Hoofd Monteur (Uit-Dienst)', 250, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (51, 'offmechanic', 4, 'autotechnicus', 'Autotechnicus (Uit-Dienst)', 300, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (52, 'offmechanic', 5, 'autotechnischspecialist', 'Autotechnisch Specialist (Uit-Dienst)', 350, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (53, 'offmechanic', 6, 'autotechnischingenieur', 'Autotechnisch Ingenieur (Uit-Dienst)', 400, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (54, 'offmechanic', 7, 'teamleider', 'Teamleider (Uit-Dienst)', 450, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (55, 'offmechanic', 8, 'manager', 'Manager (Uit-Dienst)', 500, '{}', '{}');
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (56, 'offmechanic', 8, 'directeur', 'Directeur (Uit-Dienst)', 550, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('blowpipe', 'blowpipe', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('carokit', 'Carrosserie Kit', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('carotool', 'Carrosserie Gereedschap', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('fixkit', 'Reparatie Kit', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('fixtool', 'Reparatie Gereedschap', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('gazbottle', 'Gas Fles', 2, 0, 1)
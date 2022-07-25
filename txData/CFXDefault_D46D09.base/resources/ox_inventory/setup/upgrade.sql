-- Update existing linden_inventory table to new name and indexes
USE `essentialmode`
CREATE TABLE `ox_inventory`,
	`owner` VARCHAR(60) NULL FIRST,
	`name` VARCHAR(100) NOT NULL AFTER `owner`,
	`data` LONGTEXT NULL AFTER `name`,
ADD UNIQUE INDEX `owner` (`owner`, `name`);

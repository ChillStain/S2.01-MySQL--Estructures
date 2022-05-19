-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Customers` (
  `idCustomers` INT NOT NULL AUTO_INCREMENT,
  `nameCust` VARCHAR(45) NOT NULL,
  `surnameCust` VARCHAR(45) NOT NULL,
  `addCust` VARCHAR(90) NOT NULL,
  `zipCode` INT NOT NULL,
  `nPhone` INT(9) NOT NULL,
  PRIMARY KEY (`idCustomers`),
  UNIQUE INDEX `idCustomers_UNIQUE` (`idCustomers` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Shop` (
  `idShop` INT NOT NULL AUTO_INCREMENT,
  `addressShop` VARCHAR(45) NOT NULL,
  `zipCode` INT NOT NULL,
  PRIMARY KEY (`idShop`),
  UNIQUE INDEX `idShop_UNIQUE` (`idShop` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Province` (
  `idProvince` INT NOT NULL AUTO_INCREMENT,
  `nameProvince` VARCHAR(45) NOT NULL,
  `Customers_idCustomers` INT NOT NULL,
  `Shop_idShop` INT NOT NULL,
  UNIQUE INDEX `idProvince_UNIQUE` (`idProvince` ASC) VISIBLE,
  PRIMARY KEY (`idProvince`, `Customers_idCustomers`, `Shop_idShop`),
  INDEX `fk_Province_Customers1_idx` (`Customers_idCustomers` ASC) VISIBLE,
  INDEX `fk_Province_Shop1_idx` (`Shop_idShop` ASC) VISIBLE,
  CONSTRAINT `fk_Province_Customers1`
    FOREIGN KEY (`Customers_idCustomers`)
    REFERENCES `Pizzeria`.`Customers` (`idCustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Province_Shop1`
    FOREIGN KEY (`Shop_idShop`)
    REFERENCES `Pizzeria`.`Shop` (`idShop`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Location` (
  `idLocation` INT NOT NULL AUTO_INCREMENT,
  `nameLocation` VARCHAR(45) NOT NULL,
  `Province_idProvince` INT NOT NULL,
  PRIMARY KEY (`idLocation`, `Province_idProvince`),
  UNIQUE INDEX `idLocation_UNIQUE` (`idLocation` ASC) VISIBLE,
  INDEX `fk_Location_Province_idx` (`Province_idProvince` ASC) VISIBLE,
  CONSTRAINT `fk_Location_Province`
    FOREIGN KEY (`Province_idProvince`)
    REFERENCES `Pizzeria`.`Province` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Employees` (
  `idEmployees` INT NOT NULL AUTO_INCREMENT,
  `nameEmployees` VARCHAR(45) NOT NULL,
  `surnameEmployees` VARCHAR(45) NOT NULL,
  `empNIF` VARCHAR(9) NOT NULL,
  `empPhone` INT(9) NOT NULL,
  `empKind` ENUM("Delivery", "Cook") NOT NULL,
  `ifDelivery` INT NULL,
  `ifDeliveryTime` DATETIME GENERATED ALWAYS AS () VIRTUAL,
  PRIMARY KEY (`idEmployees`),
  UNIQUE INDEX `idEmployees_UNIQUE` (`idEmployees` ASC) VISIBLE,
  UNIQUE INDEX `ifDelivery_UNIQUE` (`ifDelivery` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Orders` (
  `idOrders` INT NOT NULL AUTO_INCREMENT,
  `whenOrder` DATETIME NOT NULL,
  `kindOrder` SET("Shop", "domicilio") NOT NULL DEFAULT 'Shop',
  `nProductsOrder` INT NOT NULL,
  `priceOrder` DOUBLE NOT NULL,
  `Customers_idCustomers` INT NOT NULL,
  `Shop_idShop` INT NOT NULL,
  `Employees_idEmployees` INT NOT NULL,
  PRIMARY KEY (`idOrders`, `Shop_idShop`),
  UNIQUE INDEX `idOrders_UNIQUE` (`idOrders` ASC) VISIBLE,
  INDEX `fk_Orders_Customers1_idx` (`Customers_idCustomers` ASC) VISIBLE,
  INDEX `fk_Orders_Shop1_idx` (`Shop_idShop` ASC) VISIBLE,
  INDEX `fk_Orders_Employees1_idx` (`Employees_idEmployees` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_idCustomers`)
    REFERENCES `Pizzeria`.`Customers` (`idCustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Shop1`
    FOREIGN KEY (`Shop_idShop`)
    REFERENCES `Pizzeria`.`Shop` (`idShop`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Employees1`
    FOREIGN KEY (`Employees_idEmployees`)
    REFERENCES `Pizzeria`.`Employees` (`idEmployees`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk:Orders_Del`
    FOREIGN KEY (`idOrders`)
    REFERENCES `Pizzeria`.`Employees` (`ifDelivery`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Products` (
  `idProducts` INT NOT NULL AUTO_INCREMENT,
  `kindProduct` ENUM("Pizza", "Hamburguer", "Drink") NOT NULL,
  `nameProduct` VARCHAR(45) NOT NULL,
  `descriptionProduct` VARCHAR(90) NULL,
  `imageProduct` LONGBLOB NULL,
  `priceProduct` DOUBLE NOT NULL,
  `Productscol` VARCHAR(45) NULL,
  `Orders_idOrders` INT NOT NULL,
  PRIMARY KEY (`idProducts`, `Orders_idOrders`),
  UNIQUE INDEX `idProducts_UNIQUE` (`idProducts` ASC) VISIBLE,
  INDEX `fk_Products_Orders1_idx` (`Orders_idOrders` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Orders1`
    FOREIGN KEY (`Orders_idOrders`)
    REFERENCES `Pizzeria`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Pizzeria`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Category` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `nameCat` ENUM("Clássic", "Super", "Fantastic") NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizza` (
  `idPizza` INT NOT NULL AUTO_INCREMENT,
  `namePizza` VARCHAR(45) NOT NULL,
  `Products_idProducts` INT NOT NULL,
  `Products_Orders_idOrders` INT NOT NULL,
  `Category_idCategory` INT NOT NULL,
  PRIMARY KEY (`idPizza`, `Products_idProducts`, `Products_Orders_idOrders`),
  INDEX `fk_Pizza_Products1_idx` (`Products_idProducts` ASC, `Products_Orders_idOrders` ASC) VISIBLE,
  INDEX `fk_Pizza_Category1_idx` (`Category_idCategory` ASC) VISIBLE,
  CONSTRAINT `fk_Pizza_Products1`
    FOREIGN KEY (`Products_idProducts` , `Products_Orders_idOrders`)
    REFERENCES `Pizzeria`.`Products` (`idProducts` , `Orders_idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_Category1`
    FOREIGN KEY (`Category_idCategory`)
    REFERENCES `Pizzeria`.`Category` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

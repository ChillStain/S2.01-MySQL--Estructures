-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optical_Bottle_Ass
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optical_Bottle_Ass
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optical_Bottle_Ass` DEFAULT CHARACTER SET utf8 ;
USE `Optical_Bottle_Ass` ;

-- -----------------------------------------------------
-- Table `Optical_Bottle_Ass`.`Suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optical_Bottle_Ass`.`Suppliers` (
  `idSuppliers` INT NOT NULL AUTO_INCREMENT,
  `nameSuppliers` VARCHAR(45) NOT NULL,
  `nPhone` INT NOT NULL,
  `nFax` INT NOT NULL,
  `nNIF` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idSuppliers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optical_Bottle_Ass`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optical_Bottle_Ass`.`Address` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `nameRoad` VARCHAR(100) NOT NULL,
  `nStreet` INT NOT NULL,
  `nFlat` INT NOT NULL,
  `nDoor` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zipCode` INT NOT NULL,
  `Suppliers_idSuppliers` INT NOT NULL,
  PRIMARY KEY (`idAddress`),
  INDEX `fk_Address_Suppliers_idx` (`Suppliers_idSuppliers` ASC) VISIBLE,
  CONSTRAINT `fk_Address_Suppliers`
    FOREIGN KEY (`Suppliers_idSuppliers`)
    REFERENCES `Optical_Bottle_Ass`.`Suppliers` (`idSuppliers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optical_Bottle_Ass`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optical_Bottle_Ass`.`Customers` (
  `idCustomers` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `zipCode` INT NOT NULL,
  `nPhone` INT NULL DEFAULT "-",
  `email` VARCHAR(45) NULL DEFAULT '-',
  PRIMARY KEY (`idCustomers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optical_Bottle_Ass`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optical_Bottle_Ass`.`Glasses` (
  `idGlasses` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(45) NOT NULL,
  `izqGraduation` INT NOT NULL,
  `derGraduacion` INT NOT NULL,
  `Mounting` ENUM("Pasta", "Metal", "Flotante") NOT NULL,
  `color` ENUM("Blanco", "Negro", "Rojo", "Amarillo", "Azul", "Chromo") NOT NULL,
  `glassColour` ENUM("Transparentes", "Antireflectantes", "Tintados") NOT NULL,
  `Precio` DOUBLE NOT NULL,
  `Suppliers_idSuppliers1` INT NOT NULL,
  `idCostumers` INT NOT NULL,
  PRIMARY KEY (`idGlasses`, `idCostumers`),
  INDEX `fk_Gafas_Suppliers2_idx` (`Suppliers_idSuppliers1` ASC) VISIBLE,
  INDEX `fk_Gafas_Clientes1_idx` (`idCostumers` ASC) VISIBLE,
  CONSTRAINT `fk_Gafas_Suppliers2`
    FOREIGN KEY (`Suppliers_idSuppliers1`)
    REFERENCES `Optical_Bottle_Ass`.`Suppliers` (`idSuppliers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Clientes1`
    FOREIGN KEY (`idCostumers`)
    REFERENCES `Optical_Bottle_Ass`.`Customers` (`idCustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optical_Bottle_Ass`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optical_Bottle_Ass`.`Employees` (
  `idEmployees` INT NOT NULL,
  `name` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`idEmployees`));


-- -----------------------------------------------------
-- Table `Optical_Bottle_Ass`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optical_Bottle_Ass`.`Sales` (
  `idSales` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NULL,
  `idGlasses` INT NULL,
  `idEmployees` INT NULL,
  `dataSale` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ifRefCustomer` SET("Yes", "No") NOT NULL,
  `idRefCustomer` INT NULL DEFAULT NULL,
  `Employees_idEmployees` INT NOT NULL,
  `Suppliers_idSuppliers` INT NOT NULL,
  `Customers_idCustomers` INT NOT NULL,
  PRIMARY KEY (`idSales`),
  INDEX `fk_Sales_Employees1_idx` (`Employees_idEmployees` ASC) VISIBLE,
  INDEX `fk_Sales_Suppliers1_idx` (`Suppliers_idSuppliers` ASC) VISIBLE,
  INDEX `fk_Sales_Customers1_idx` (`Customers_idCustomers` ASC) VISIBLE,
  INDEX `fk_idRefCustomer_idx` (`idRefCustomer` ASC) VISIBLE,
  CONSTRAINT `fk_Sales_Employees1`
    FOREIGN KEY (`Employees_idEmployees`)
    REFERENCES `Optical_Bottle_Ass`.`Employees` (`idEmployees`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Suppliers1`
    FOREIGN KEY (`Suppliers_idSuppliers`)
    REFERENCES `Optical_Bottle_Ass`.`Suppliers` (`idSuppliers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Customers1`
    FOREIGN KEY (`Customers_idCustomers`)
    REFERENCES `Optical_Bottle_Ass`.`Customers` (`idCustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idRefCustomer`
    FOREIGN KEY (`idRefCustomer`)
    REFERENCES `Optical_Bottle_Ass`.`Customers` (`idCustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

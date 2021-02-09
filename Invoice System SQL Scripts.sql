-- MySQL Script generated by MySQL Workbench
-- Wed Feb 10 00:11:43 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema invoicesystemdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema invoicesystemdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `invoicesystemdb` DEFAULT CHARACTER SET utf8 ;
USE `invoicesystemdb` ;

-- -----------------------------------------------------
-- Table `invoicesystemdb`.`UserMaintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`UserMaintenance` (
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Role` ENUM('A', 'E') NOT NULL DEFAULT 'E' COMMENT '\"A\" - Admin\n\"E\" - Employee',
  `Email` VARCHAR(45) NOT NULL,
  `Status` ENUM('A', 'I') NOT NULL DEFAULT 'A' COMMENT '\"A\"- Active\n\"I\" - Inactive',
  PRIMARY KEY (`UserName`),
  UNIQUE INDEX `UserName_UNIQUE` (`UserName`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invoicesystemdb`.`ProductInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`ProductInformation` (
  `Product Name` VARCHAR(45) NOT NULL,
  `Product Description` VARCHAR(100) NULL,
  `In Stock` ENUM('Y', 'N') NOT NULL DEFAULT 'Y' COMMENT '\'Y\' - Item is in stock\n\"N\' - Item is not in stock',
  `Price` DOUBLE UNSIGNED NOT NULL,
  `Inventory` INT UNSIGNED NOT NULL,
  `PI_CreatedBy` VARCHAR(45) NOT NULL,
  `PI_UpdatedBy` VARCHAR(45) NULL,
  `PI_DateCreated` DATETIME NULL,
  `PI_DateUpdated` DATETIME NULL,
  PRIMARY KEY (`Product Name`),
  INDEX `fk_ProductInformation_UserMaintenance1_idx` (`PI_CreatedBy`) ,
  INDEX `fk_ProductInformation_UserMaintenance2_idx` (`PI_UpdatedBy`) ,
  UNIQUE INDEX `Product Name_UNIQUE` (`Product Name`) ,
  CONSTRAINT `fk_ProductInformation_UserMaintenance1`
    FOREIGN KEY (`PI_CreatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductInformation_UserMaintenance2`
    FOREIGN KEY (`PI_UpdatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invoicesystemdb`.`CustomerInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`CustomerInformation` (
  `CustomerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CustomerFirstName` VARCHAR(45) NOT NULL,
  `CustomerLastName` VARCHAR(45) NOT NULL,
  `CustomerAddress` VARCHAR(100) NOT NULL,
  `CustomerContactNo` VARCHAR(45) NOT NULL,
  `CI_CreatedBy` VARCHAR(45) NOT NULL,
  `CI_UpdatedBy` VARCHAR(45) NULL,
  `CI_DateCreated` DATETIME NOT NULL,
  `CI_DateUpdated` DATETIME NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `fk_CustomerInformation_UserMaintenance1_idx` (`CI_CreatedBy`) ,
  INDEX `fk_CustomerInformation_UserMaintenance2_idx` (`CI_UpdatedBy`) ,
  CONSTRAINT `fk_CustomerInformation_UserMaintenance1`
    FOREIGN KEY (`CI_CreatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerInformation_UserMaintenance2`
    FOREIGN KEY (`CI_UpdatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invoicesystemdb`.`InvoiceHeader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`InvoiceHeader` (
  `InvoiceNo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `InvoiceDate` DATE NULL,
  `TotalDue` DOUBLE NULL,
  `CustomerInformation_CustomerID` INT UNSIGNED NOT NULL,
  `IH_CreatedBy` VARCHAR(45) NOT NULL,
  `IH_UpdatedBy` VARCHAR(45) NULL,
  `IH_DateCreated` DATETIME NULL,
  `IH_DateUpdated` DATETIME NULL,
  PRIMARY KEY (`InvoiceNo`),
  UNIQUE INDEX `InvoiceNo_UNIQUE` (`InvoiceNo`),
  INDEX `fk_InvoiceHeader_CustomerInformation1_idx` (`CustomerInformation_CustomerID`),
  INDEX `fk_InvoiceHeader_UserMaintenance1_idx` (`IH_CreatedBy`) ,
  INDEX `fk_InvoiceHeader_UserMaintenance2_idx` (`IH_UpdatedBy`) ,
  CONSTRAINT `fk_InvoiceHeader_CustomerInformation1`
    FOREIGN KEY (`CustomerInformation_CustomerID`)
    REFERENCES `invoicesystemdb`.`CustomerInformation` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceHeader_UserMaintenance1`
    FOREIGN KEY (`IH_CreatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceHeader_UserMaintenance2`
    FOREIGN KEY (`IH_UpdatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invoicesystemdb`.`InvoiceDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`InvoiceDetails` (
  `InvoiceDetailsID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Quantity` VARCHAR(45) NOT NULL,
  `Subtotal` DOUBLE NULL,
  `InvoiceHeader_InvoiceNo` INT UNSIGNED NOT NULL,
  `ProductInformation_Product Name` VARCHAR(45) NOT NULL,
  `InvD_CreatedBy` VARCHAR(45) NOT NULL,
  `InvD_UpdatedBy` VARCHAR(45) NULL,
  `InvD_DateCreated` DATETIME NOT NULL,
  `InvD_DateUpdated` DATETIME NULL,
  PRIMARY KEY (`InvoiceDetailsID`),
  UNIQUE INDEX `InvoiceDetailsID_UNIQUE` (`InvoiceDetailsID`) ,
  INDEX `fk_InvoiceDetails_InvoiceHeader_idx` (`InvoiceHeader_InvoiceNo`),
  INDEX `fk_InvoiceDetails_ProductInformation1_idx` (`ProductInformation_Product Name`),
  INDEX `fk_InvoiceDetails_UserMaintenance1_idx` (`InvD_CreatedBy`) ,
  INDEX `fk_InvoiceDetails_UserMaintenance2_idx` (`InvD_UpdatedBy`) ,
  CONSTRAINT `fk_InvoiceDetails_InvoiceHeader`
    FOREIGN KEY (`InvoiceHeader_InvoiceNo`)
    REFERENCES `invoicesystemdb`.`InvoiceHeader` (`InvoiceNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceDetails_ProductInformation1`
    FOREIGN KEY (`ProductInformation_Product Name`)
    REFERENCES `invoicesystemdb`.`ProductInformation` (`Product Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceDetails_UserMaintenance1`
    FOREIGN KEY (`InvD_CreatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceDetails_UserMaintenance2`
    FOREIGN KEY (`InvD_UpdatedBy`)
    REFERENCES `invoicesystemdb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `invoicesystemdb` ;

-- -----------------------------------------------------
-- Placeholder table for view `invoicesystemdb`.`DailySalesReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`DailySalesReport` (`Col_placeholder1` INT);

-- -----------------------------------------------------
-- Placeholder table for view `invoicesystemdb`.`MonthlySalesReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`MonthlySalesReport` (`Col_placeholder1` INT);

-- -----------------------------------------------------
-- Placeholder table for view `invoicesystemdb`.`YearlySalesReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoicesystemdb`.`YearlySalesReport` (`Col_placeholder1` INT);

-- -----------------------------------------------------
-- View `invoicesystemdb`.`DailySalesReport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invoicesystemdb`.`DailySalesReport`;
USE `invoicesystemdb`;
CREATE  OR REPLACE VIEW `DailySalesReport` AS
    SELECT 
        InvoiceHeader.InvoiceNo , CustomerInformation.CustomerFirstname,
            CustomerInformation.CustomerLastname,
            InvoiceHeader.TotalDue 
    FROM
        InvoiceHeader
            INNER JOIN
        CustomerInformation ON InvoiceHeader.CustomerInformation_CustomerID = CustomerInformation.CustomerID
    WHERE
        InvoiceDate = current_date();

-- -----------------------------------------------------
-- View `invoicesystemdb`.`MonthlySalesReport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invoicesystemdb`.`MonthlySalesReport`;
USE `invoicesystemdb`;
CREATE  OR REPLACE VIEW `MonthlySalesReport` AS
    SELECT 
        InvoiceHeader.InvoiceNo , CustomerInformation.CustomerFirstname,
            CustomerInformation.CustomerLastname,
            InvoiceHeader.TotalDue
    FROM
        InvoiceHeader
            INNER JOIN
        CustomerInformation ON InvoiceHeader.CustomerInformation_CustomerID = CustomerInformation.CustomerID
    WHERE
        month (InvoiceDate) = month(current_date());

-- -----------------------------------------------------
-- View `invoicesystemdb`.`YearlySalesReport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invoicesystemdb`.`YearlySalesReport`;
USE `invoicesystemdb`;
CREATE  OR REPLACE VIEW `YearlySalesReport` AS
    SELECT 
        InvoiceHeader.InvoiceNo , CustomerInformation.CustomerFirstname,
            CustomerInformation.CustomerLastname,
            InvoiceHeader.TotalDue
    FROM
        InvoiceHeader
            INNER JOIN
        CustomerInformation ON InvoiceHeader.CustomerInformation_CustomerID = CustomerInformation.CustomerID
    WHERE
        year (InvoiceDate) = year(current_date());

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

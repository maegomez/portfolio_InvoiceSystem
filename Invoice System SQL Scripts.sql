-- MySQL Script generated by MySQL Workbench
-- Tue Feb  9 17:47:25 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`UserMaintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`UserMaintenance` (
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Role` ENUM('A', 'E') NOT NULL DEFAULT 'E' COMMENT '\"A\" - Admin\n\"E\" - Employee',
  `Email` VARCHAR(45) NOT NULL,
  `Status` ENUM('A', 'I') NOT NULL DEFAULT 'A' COMMENT '\"A\"- Active\n\"I\" - Inactive',
  PRIMARY KEY (`UserName`),
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductInformation` (
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
  INDEX `fk_ProductInformation_UserMaintenance1_idx` (`PI_CreatedBy` ASC) VISIBLE,
  INDEX `fk_ProductInformation_UserMaintenance2_idx` (`PI_UpdatedBy` ASC) VISIBLE,
  UNIQUE INDEX `Product Name_UNIQUE` (`Product Name` ASC) VISIBLE,
  CONSTRAINT `fk_ProductInformation_UserMaintenance1`
    FOREIGN KEY (`PI_CreatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductInformation_UserMaintenance2`
    FOREIGN KEY (`PI_UpdatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CustomerInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CustomerInformation` (
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
  INDEX `fk_CustomerInformation_UserMaintenance1_idx` (`CI_CreatedBy` ASC) VISIBLE,
  INDEX `fk_CustomerInformation_UserMaintenance2_idx` (`CI_UpdatedBy` ASC) VISIBLE,
  CONSTRAINT `fk_CustomerInformation_UserMaintenance1`
    FOREIGN KEY (`CI_CreatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerInformation_UserMaintenance2`
    FOREIGN KEY (`CI_UpdatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InvoiceHeader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InvoiceHeader` (
  `InvoiceNo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `InvoiceDate` DATE NULL,
  `TotalDue` DOUBLE NULL,
  `CustomerInformation_CustomerID` INT UNSIGNED NOT NULL,
  `IH_CreatedBy` VARCHAR(45) NOT NULL,
  `IH_UpdatedBy` VARCHAR(45) NULL,
  `IH_DateCreated` DATETIME NULL,
  `IH_DateUpdated` DATETIME NULL,
  PRIMARY KEY (`InvoiceNo`),
  UNIQUE INDEX `InvoiceNo_UNIQUE` (`InvoiceNo` ASC) VISIBLE,
  INDEX `fk_InvoiceHeader_CustomerInformation1_idx` (`CustomerInformation_CustomerID` ASC) VISIBLE,
  INDEX `fk_InvoiceHeader_UserMaintenance1_idx` (`IH_CreatedBy` ASC) VISIBLE,
  INDEX `fk_InvoiceHeader_UserMaintenance2_idx` (`IH_UpdatedBy` ASC) VISIBLE,
  CONSTRAINT `fk_InvoiceHeader_CustomerInformation1`
    FOREIGN KEY (`CustomerInformation_CustomerID`)
    REFERENCES `mydb`.`CustomerInformation` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceHeader_UserMaintenance1`
    FOREIGN KEY (`IH_CreatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceHeader_UserMaintenance2`
    FOREIGN KEY (`IH_UpdatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`InvoiceDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InvoiceDetails` (
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
  UNIQUE INDEX `InvoiceDetailsID_UNIQUE` (`InvoiceDetailsID` ASC) VISIBLE,
  INDEX `fk_InvoiceDetails_InvoiceHeader_idx` (`InvoiceHeader_InvoiceNo` ASC) VISIBLE,
  INDEX `fk_InvoiceDetails_ProductInformation1_idx` (`ProductInformation_Product Name` ASC) VISIBLE,
  INDEX `fk_InvoiceDetails_UserMaintenance1_idx` (`InvD_CreatedBy` ASC) VISIBLE,
  INDEX `fk_InvoiceDetails_UserMaintenance2_idx` (`InvD_UpdatedBy` ASC) VISIBLE,
  CONSTRAINT `fk_InvoiceDetails_InvoiceHeader`
    FOREIGN KEY (`InvoiceHeader_InvoiceNo`)
    REFERENCES `mydb`.`InvoiceHeader` (`InvoiceNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceDetails_ProductInformation1`
    FOREIGN KEY (`ProductInformation_Product Name`)
    REFERENCES `mydb`.`ProductInformation` (`Product Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceDetails_UserMaintenance1`
    FOREIGN KEY (`InvD_CreatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceDetails_UserMaintenance2`
    FOREIGN KEY (`InvD_UpdatedBy`)
    REFERENCES `mydb`.`UserMaintenance` (`UserName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`DailySalesReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DailySalesReport` (`Col_placeholder1` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`MonthlySalesReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MonthlySalesReport` (`Col_placeholder1` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`YearlySalesReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`YearlySalesReport` (`Col_placeholder1` INT);

-- -----------------------------------------------------
-- View `mydb`.`DailySalesReport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DailySalesReport`;
USE `mydb`;
CREATE  OR REPLACE VIEW `DailySalesReport` AS
    SELECT 
        (InvoiceHeader.InvoiceNo , CustomerInformation.CustomerFirstname,
            CustomerInformation.CustomerLastname,
            InvoiceHeader.TotalDue) AS 'Col_placeholder1' 
    FROM
        InvoiceHeader
            INNER JOIN
        CustomerInformation ON InvoiceHeader.CustomerInformation_CustomerID = CustomerInformation.CustomerID
    WHERE
        InvoiceDate = datespecified; --???;

-- -----------------------------------------------------
-- View `mydb`.`MonthlySalesReport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MonthlySalesReport`;
USE `mydb`;
CREATE  OR REPLACE VIEW `MonthlySalesReport` AS
    SELECT 
        (InvoiceHeader.InvoiceNo , CustomerInformation.CustomerFirstname,
            CustomerInformation.CustomerLastname,
            InvoiceHeader.TotalDue) AS 'Col_placeholder1' 
    FROM
        InvoiceHeader
            INNER JOIN
        CustomerInformation ON InvoiceHeader.CustomerInformation_CustomerID = CustomerInformation.CustomerID
    WHERE
        month (InvoiceDate) = monthspecified;

-- -----------------------------------------------------
-- View `mydb`.`YearlySalesReport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`YearlySalesReport`;
USE `mydb`;
CREATE  OR REPLACE VIEW `YearlySalesReport` AS
    SELECT 
        (InvoiceHeader.InvoiceNo , CustomerInformation.CustomerFirstname,
            CustomerInformation.CustomerLastname,
            InvoiceHeader.TotalDue) AS 'Col_placeholder1' 
    FROM
        InvoiceHeader
            INNER JOIN
        CustomerInformation ON InvoiceHeader.CustomerInformation_CustomerID = CustomerInformation.CustomerID
    WHERE
        year (InvoiceDate) = yearspecified;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

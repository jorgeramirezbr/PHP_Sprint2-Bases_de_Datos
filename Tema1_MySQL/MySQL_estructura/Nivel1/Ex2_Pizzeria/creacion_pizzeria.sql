-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ex2_Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ex2_Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ex2_Pizzeria` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `ex2_Pizzeria` ;

-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Clientes` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(12) NOT NULL,
  `localidad` VARCHAR(20) NOT NULL,
  `provincia` VARCHAR(20) NOT NULL,
  `telefono` INT NOT NULL,
  PRIMARY KEY (`cliente_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Tiendas` (
  `tienda_id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(12) NULL,
  `localidad` VARCHAR(20) NULL,
  `provincia` VARCHAR(20) NULL,
  PRIMARY KEY (`tienda_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Empleados` (
  `empleado_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  `telefono` INT NULL,
  `cargo` ENUM('cocinero', 'repartidor') NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`empleado_id`),
  INDEX `tienda_id_idx` (`tienda_id` ASC) ,
  CONSTRAINT `tienda_id`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `ex2_Pizzeria`.`Tiendas` (`tienda_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Pedidos` (
  `pedido_id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `id_tienda` INT NOT NULL,
  `fecha_hora` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_de_entrega` ENUM('tienda', 'domicilio') NOT NULL,
  `precio_total` FLOAT NOT NULL,
  `repartidor_id` INT NULL,
  `fecha_hora_entrega` DATETIME NULL,
  PRIMARY KEY (`pedido_id`),
  INDEX `fk_cliente_id_idx` (`cliente_id` ASC) ,
  INDEX `tienda_id_idx` (`id_tienda` ASC) ,
  INDEX `repartidor_id_idx` (`repartidor_id` ASC) ,
  CONSTRAINT `cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `ex2_Pizzeria`.`Clientes` (`cliente_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `ex2_Pizzeria`.`Tiendas` (`tienda_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `repartidor_id`
    FOREIGN KEY (`repartidor_id`)
    REFERENCES `ex2_Pizzeria`.`Empleados` (`empleado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Categorias_Pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Categorias_Pizzas` (
  `categoria_pizza_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoria_pizza_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Tipo_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Tipo_Producto` (
  `tipo_producto_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `categoria_pizza_id` INT NULL COMMENT 'solo en las pizzas',
  PRIMARY KEY (`tipo_producto_id`),
  INDEX `categoria_id_idx` (`categoria_pizza_id` ASC) ,
  CONSTRAINT `categoria_pizza_id`
    FOREIGN KEY (`categoria_pizza_id`)
    REFERENCES `ex2_Pizzeria`.`Categorias_Pizzas` (`categoria_pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Producto` (
  `Producto_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `descripcion` VARCHAR(80) NULL,
  `imagen` VARCHAR(80) NULL,
  `tipo_producto_id` INT NOT NULL,
  PRIMARY KEY (`Producto_id`),
  INDEX `tipo_producto_id_idx` (`tipo_producto_id` ASC) ,
  CONSTRAINT `tipo_producto_id`
    FOREIGN KEY (`tipo_producto_id`)
    REFERENCES `ex2_Pizzeria`.`Tipo_Producto` (`tipo_producto_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex2_Pizzeria`.`Detalle_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex2_Pizzeria`.`Detalle_Pedido` (
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `cantidad` TINYINT NOT NULL,
  PRIMARY KEY (`pedido_id`, `producto_id`),
  INDEX `producto_id_idx` (`producto_id` ASC) ,
  CONSTRAINT `pedido_id`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `ex2_Pizzeria`.`Pedidos` (`pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `producto_id`
    FOREIGN KEY (`producto_id`)
    REFERENCES `ex2_Pizzeria`.`Producto` (`Producto_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

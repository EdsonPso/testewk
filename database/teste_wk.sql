-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema teste_wk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema teste_wk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `teste_wk` DEFAULT CHARACTER SET utf8 ;
USE `teste_wk` ;

-- -----------------------------------------------------
-- Table `teste_wk`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teste_wk`.`clientes` ;

CREATE TABLE IF NOT EXISTS `teste_wk`.`clientes` (
  `idclientes` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  UNIQUE INDEX `idclientes_UNIQUE` (`idclientes` ASC) VISIBLE,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teste_wk`.`produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teste_wk`.`produtos` ;

CREATE TABLE IF NOT EXISTS `teste_wk`.`produtos` (
  `idprodutos` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `preco_venda` DECIMAL(12,2) NOT NULL,
  UNIQUE INDEX `idprodutos_UNIQUE` (`idprodutos` ASC) VISIBLE,
  PRIMARY KEY (`idprodutos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teste_wk`.`pedidos_dados_gerais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teste_wk`.`pedidos_dados_gerais` ;

CREATE TABLE IF NOT EXISTS `teste_wk`.`pedidos_dados_gerais` (
  `numero_pedido` INT NOT NULL,
  `data_emissao` DATETIME NOT NULL,
  `valor_total` DECIMAL(12,2) NOT NULL,
  `clientes_idclientes` INT NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  UNIQUE INDEX `numero_pedido_UNIQUE` (`numero_pedido` ASC) VISIBLE,
  INDEX `fk_pedidos_dados_gerais_clientes_idx` (`clientes_idclientes` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_dados_gerais_clientes`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `teste_wk`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teste_wk`.`pedidos_produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `teste_wk`.`pedidos_produtos` ;

CREATE TABLE IF NOT EXISTS `teste_wk`.`pedidos_produtos` (
  `idpedidos_produtos` INT NOT NULL AUTO_INCREMENT,
  `quantidade` DECIMAL(12,2) NOT NULL,
  `vlr_unitario` DECIMAL(12,2) NOT NULL,
  `vlr_total` DECIMAL(12,2) NOT NULL,
  `pedidos_dados_gerais_numero_pedido` INT NOT NULL,
  `produtos_idprodutos` INT NOT NULL,
  PRIMARY KEY (`idpedidos_produtos`),
  INDEX `fk_pedidos_produtos_pedidos_dados_gerais1_idx` (`pedidos_dados_gerais_numero_pedido` ASC) VISIBLE,
  INDEX `fk_pedidos_produtos_produtos1_idx` (`produtos_idprodutos` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_produtos_pedidos_dados_gerais1`
    FOREIGN KEY (`pedidos_dados_gerais_numero_pedido`)
    REFERENCES `teste_wk`.`pedidos_dados_gerais` (`numero_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_produtos_produtos1`
    FOREIGN KEY (`produtos_idprodutos`)
    REFERENCES `teste_wk`.`produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

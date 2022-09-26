-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE `oficina` ;

-- -----------------------------------------------------
-- Table `oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `placa` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `idCliente`),
  INDEX `fk_Veiculo_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Funcionario` (
  `idFuncionario` INT NOT NULL,
  `codigo` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `especialização` VARCHAR(45) NULL,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idEquipe`, `idFuncionario`),
  INDEX `fk_Equipe_Funcionario1_idx` (`idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_Funcionario1`
    FOREIGN KEY (`idFuncionario`)
    REFERENCES `oficina`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Ordem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Ordem` (
  `idOrdem` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `total` FLOAT NULL,
  `dataAvaliacao` DATE NULL,
  `dataInicio` DATE NULL,
  `dataEntrega` DATE NULL,
  `idEquipe` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idVeiculo` INT NOT NULL,
  PRIMARY KEY (`idOrdem`, `idEquipe`, `idCliente`, `idVeiculo`),
  INDEX `fk_Ordem_Equipe1_idx` (`idEquipe` ASC) VISIBLE,
  INDEX `fk_Ordem_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  INDEX `fk_Ordem_Veiculo1_idx` (`idVeiculo` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_Equipe1`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `oficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_Veiculo1`
    FOREIGN KEY (`idVeiculo`)
    REFERENCES `oficina`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Servico` (
  `idServico` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `valor` FLOAT NOT NULL,
  `idOrdem` INT NOT NULL,
  PRIMARY KEY (`idServico`, `idOrdem`),
  INDEX `fk_Servico_Ordem1_idx` (`idOrdem` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Ordem1`
    FOREIGN KEY (`idOrdem`)
    REFERENCES `oficina`.`Ordem` (`idOrdem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Peça` (
  `idPeça` INT NOT NULL,
  `quantidade` VARCHAR(45) NULL,
  `valor` VARCHAR(45) NULL,
  `idOrdem` INT NOT NULL,
  PRIMARY KEY (`idPeça`, `idOrdem`),
  INDEX `fk_Peça_Ordem1_idx` (`idOrdem` ASC) VISIBLE,
  CONSTRAINT `fk_Peça_Ordem1`
    FOREIGN KEY (`idOrdem`)
    REFERENCES `oficina`.`Ordem` (`idOrdem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `endereco` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Disponibilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Disponibilidade` (
  `idFornecedor` INT NOT NULL,
  `idPeça` INT NOT NULL,
  PRIMARY KEY (`idFornecedor`, `idPeça`),
  INDEX `fk_Disponibilidade_Peça1_idx` (`idPeça` ASC) VISIBLE,
  CONSTRAINT `fk_Disponibilidade_Fornecedor1`
    FOREIGN KEY (`idFornecedor`)
    REFERENCES `oficina`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disponibilidade_Peça1`
    FOREIGN KEY (`idPeça`)
    REFERENCES `oficina`.`Peça` (`idPeça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Vendedor` (
  `idVendedor` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idVendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Pessoa Física`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Pessoa Física` (
  `idPessoaFisica` INT NOT NULL,
  `cpf` VARCHAR(45) NULL,
  PRIMARY KEY (`idPessoaFisica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Pessoa Jurídica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Pessoa Jurídica` (
  `idPessoaJuridica` INT NOT NULL,
  `cnpj` VARCHAR(45) NULL,
  PRIMARY KEY (`idPessoaJuridica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `identificacao` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `idPessoaFisica` INT NULL,
  `idPessoaJuridica` INT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Pessoa Física_idx` (`idPessoaFisica` ASC) VISIBLE,
  INDEX `fk_Cliente_Pessoa Jurídica1_idx` (`idPessoaJuridica` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pessoa Física`
    FOREIGN KEY (`idPessoaFisica`)
    REFERENCES `ecommerce`.`Pessoa Física` (`idPessoaFisica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Pessoa Jurídica1`
    FOREIGN KEY (`idPessoaJuridica`)
    REFERENCES `ecommerce`.`Pessoa Jurídica` (`idPessoaJuridica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `codigoRastreio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Pedido` (
  `idPedido` INT NOT NULL,
  `statusPedido` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `frete` VARCHAR(45) NULL,
  `idCliente` INT NOT NULL,
  `idEntrega` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `idCliente`, `idEntrega`),
  INDEX `fk_Pedido_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecommerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`idEntrega`)
    REFERENCES `ecommerce`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Produto` (
  `idProduto` INT NOT NULL,
  `categoria` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `quantidade` VARCHAR(45) NULL,
  `preco` FLOAT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `validade` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagamento`, `idCliente`),
  INDEX `fk_Pagamento_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecommerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Produtos por Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Produtos por Vendedor` (
  `quantidade` INT NULL,
  `idVendedor` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`idVendedor`, `idProduto`),
  INDEX `fk_Produtos por Vendedor_Produto1_idx` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos por Vendedor_Vendedor1`
    FOREIGN KEY (`idVendedor`)
    REFERENCES `ecommerce`.`Vendedor` (`idVendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos por Vendedor_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Produto por Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Produto por Pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto por Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Produto por Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto por Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `ecommerce`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Disponibilidade do Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Disponibilidade do Produto` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Disponibilidade do Produto_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  CONSTRAINT `fk_Disponibilidade do Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disponibilidade do Produto_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `ecommerce`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `razaoSocial` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Disponibilizando Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Disponibilizando Produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Disponibilizando Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Disponibilizando Produto_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `ecommerce`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disponibilizando Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;













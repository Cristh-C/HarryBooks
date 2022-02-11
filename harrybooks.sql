-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema harrybooks
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `harrybooks` ;

-- -----------------------------------------------------
-- Schema harrybooks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `harrybooks` DEFAULT CHARACTER SET utf8 ;
USE `harrybooks` ;

-- -----------------------------------------------------
-- Table `harrybooks`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `harrybooks`.`cliente` ;

CREATE TABLE IF NOT EXISTS `harrybooks`.`cliente` (
  `idcliente` INT(11) NOT NULL AUTO_INCREMENT,
  `documento` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `documento_UNIQUE` ON `harrybooks`.`cliente` (`documento` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `harrybooks`.`pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `harrybooks`.`pago` ;

CREATE TABLE IF NOT EXISTS `harrybooks`.`pago` (
  `idpago` INT(11) NOT NULL AUTO_INCREMENT,
  `monto` DOUBLE NOT NULL,
  PRIMARY KEY (`idpago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `harrybooks`.`compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `harrybooks`.`compras` ;

CREATE TABLE IF NOT EXISTS `harrybooks`.`compras` (
  `idcompras` INT(11) NOT NULL AUTO_INCREMENT,
  `idcliente` INT(11) NOT NULL,
  `idpago` INT(11) NOT NULL,
  `fechacompra` VARCHAR(45) NOT NULL,
  `monto` DOUBLE NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcompras`),
  CONSTRAINT `fk_compras_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `harrybooks`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_pago1`
    FOREIGN KEY (`idpago`)
    REFERENCES `harrybooks`.`pago` (`idpago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_compras_cliente1_idx` ON `harrybooks`.`compras` (`idcliente` ASC) VISIBLE;

CREATE INDEX `fk_compras_pago1_idx` ON `harrybooks`.`compras` (`idpago` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `harrybooks`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `harrybooks`.`producto` ;

CREATE TABLE IF NOT EXISTS `harrybooks`.`producto` (
  `idproducto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `precio` DOUBLE NOT NULL,
  `stock` INT(11) NOT NULL,
  `imagen` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idproducto`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `harrybooks`.`detalle_compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `harrybooks`.`detalle_compras` ;

CREATE TABLE IF NOT EXISTS `harrybooks`.`detalle_compras` (
  `iddetalle` INT(11) NOT NULL AUTO_INCREMENT,
  `idproducto` INT(11) NOT NULL,
  `idcompras` INT(11) NOT NULL,
  `cantidad` INT(11) NOT NULL,
  `preciocompra` DOUBLE NOT NULL,
  PRIMARY KEY (`iddetalle`),
  CONSTRAINT `fk_detalle_compras_compras1`
    FOREIGN KEY (`idcompras`)
    REFERENCES `harrybooks`.`compras` (`idcompras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_compras_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `harrybooks`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_detalle_compras_producto_idx` ON `harrybooks`.`detalle_compras` (`idproducto` ASC) VISIBLE;

CREATE INDEX `fk_detalle_compras_compras1_idx` ON `harrybooks`.`detalle_compras` (`idcompras` ASC) VISIBLE;

USE `harrybooks` ;

-- -----------------------------------------------------
-- procedure CambiarStock
-- -----------------------------------------------------

USE `harrybooks`;
DROP procedure IF EXISTS `harrybooks`.`CambiarStock`;

DELIMITER $$
USE `harrybooks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarStock`(in idProducto int)
BEGIN
	DECLARE Stock int;
    SET Stock = (SELECT p.stock FROM harrybooks.producto as p WHERE p.idproducto = idProducto);
    SET Stock = Stock - 1;
    UPDATE harrybooks.producto as p SET p.stock = Stock WHERE p.idproducto = idProducto;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `harrybooks`.`producto`
-- -----------------------------------------------------
START TRANSACTION;
USE `harrybooks`;
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (1, 'HARRY POTTER Y LA PIEDRA FILOSOFAL', 'Harry Potter se ha quedado huérfano y vive en casa de<br> sus abominables tíos y el insoportable primo Dudley.<br> Harry se siente muy triste y solo, hasta que un buen<br>  día recibe una carta que cambiará su vida para siempre.<br> En ella le comunican que ha sido aceptado como alumno<br> en el Colegio Hogwarts de Magia.', 35000, 20, 'img/img_books/harry_1.png');
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (2, 'HARRY POTTER Y LA CAMARA SECRETA', 'Tras derrotar una vez más a lord Voldemort, su siniestro<br> enemigo en Harry Potter y la piedra filosofal, Harry espera<br> impaciente encasa de sus insoportables tíos el inicio del<br> segundo curso del Colegio.', 35000, 20, 'img/img_books/harry_2.png');
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (3, 'HARRY POTTER Y EL PRISIONERO DE AZKABAN', 'Igual que en las dos primeras partes de la serie, Harry<br> aguarda con impaciencia el inicio del tercer curso en el<br> Colegio Hogwarts de Magia. Tras haber cumplido los trece<br> años, solo y lejos de sus amigos, Harry se pelea con su<br>  bigotuda tía Marge, a la que convierte en globo, y debe<br> huir en un autobús mágico. Mientras tanto, de la prisión de <br>  Azkaban se ha escapado un terrible villano, Sirius Black,<br> un asesino en serie con poderes mágicos que fue cómplice<br> de lord Voldemort y que parece dispuesto a borrar a Harry<br> del mapa.', 55000, 20, 'img/img_books/harry_3.png');
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (4, 'HARRY POTTER Y EL CALIZ DE FUEGO', 'A sus catorce años, a Harry le gustaría ser un joven mago<br> como los demás y dedicarse a aprender nuevos sortilegios,<br> encontrarse con sus amigos Ron y Hermione y asistir con<br> ellos a los Mundiales de quidditch. Sin embargo, al llegar<br> al colegio le espera una gran sorpresa que lo obligará a<br> enfrentarse a los desafíos más temibles de toda su vida.', 55000, 20, 'img/img_books/harry_4.png');
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (5, 'HARRY POTTER Y LA ORDEN DEL FÉNIX', 'El Ministerio de Magia niega que Voldemort haya regresado<br> y ha iniciado una campaña de desprestigio contra Harry y<br> Dumbledore, para lo cual ha asignado a la horrible profesora<br> Dolores Umbridge la tarea de vigilar<br> todos sus movimientos. ', 50000, 20, 'img/img_books/harry_5.png');
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (6, 'HARRY POTTER Y EL MISTERIO DEL PRINCIPE', 'Harry, que comienza su sexto año en la escuela de magia de<br> Hogwarts, descubre un misterioso libro propiedad de \"El<br> Príncipe Mestizo\" con el cual aprende nuevos trucos.<br> Voldemort va tomando control tanto del mundo Muggle<br> como del mundo de la magia, y Hogwarts ya no es el <br> lugar seguro que solía ser. Harry sospecha que tal <br> vez hasta el castillo sea peligroso. Dumbledore sabe<br> que la batalla final se aproxima rápidamente, y por<br> eso se preocupa mucho más por preparar a Harry para<br> ello.', 55000, 20, 'img/img_books/harry_6.png');
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (7, 'HARRY POTTER Y LAS RELIQUIAS DE LA MUERTE', 'La fecha de acerca. Cuando cumpla diecisiete años, Harry<br> perderá el encantamiento protector que lo mantiene a salvo.<br> El anunciado duelo a muerte con lord Voldemort es <br>  inminente,y la casi imposible misión de encontrar y<br> destruir los restantes Horrocruxes, más urgente que <br> nunca. Ha llegado la hora final, el momento de tomar<br>  decisiones difíciles. ', 65000, 20, 'img/img_books/harry_7.jpg');
INSERT INTO `harrybooks`.`producto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES (8, 'HARRY POTTER Y EL LEGADO MALDITO', 'Siempre fue difícil ser Harry Potter y no es mucho más<br> fácil ahora que es un empleado con exceso de trabajo del<br> Ministerio de Magia, un marido y padre de tres niños en<br> edad escolar.', 75000, 20, 'img/img_books/harry_8.jpg');

COMMIT;


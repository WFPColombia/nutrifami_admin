-- phpMyAdmin SQL Dump
-- version 3.5.6
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 27-06-2014 a las 13:48:51
-- Versión del servidor: 5.6.19
-- Versión de PHP: 5.3.28

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `pmacolombia_dev`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`app`@`%` PROCEDURE `raise_error`( MESSAGE VARCHAR(255))
    DETERMINISTIC
BEGIN
    DECLARE ERROR   INTEGER;
    SET ERROR := MESSAGE;
  END$$

--
-- Funciones
--
CREATE DEFINER=`app`@`%` FUNCTION `F_Check_Codes`(
  par_type  varchar(120)
 ,par_id    int) RETURNS tinyint(1)
BEGIN
    DECLARE var_existe   int DEFAULT 0;

    SELECT
      COUNT( *)
    INTO
      var_existe
    FROM
      LUT_CODES
    WHERE
      LUT_COD_TYPE = par_type AND
      LUT_COD_ID = par_id;

    IF var_existe = 1
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_ceilings`
--

CREATE TABLE IF NOT EXISTS `buss_ceilings` (
  `BUS_CEI_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL TECHO',
  `LUD_COD_DIVIPOLA` int(11) NOT NULL COMMENT 'IDENTIFICADOR DEL DEPARTAMENTO',
  `BUS_CEI_NAME` varchar(20) DEFAULT NULL COMMENT 'NOMBRE DEL TECHO',
  `BUS_CEI_DESCRIPTION` varchar(100) DEFAULT NULL,
  `LUT_COD_STATUS` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR DEL ESTADO',
  PRIMARY KEY (`BUS_CEI_ID`),
  KEY `FK_LUD_COD_DIVIPOLA` (`LUD_COD_DIVIPOLA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_commodities`
--

CREATE TABLE IF NOT EXISTS `buss_commodities` (
  `BUS_COM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL PRODUCTO',
  `BUS_COM_NAME` varchar(20) DEFAULT NULL COMMENT 'NOMBRE DEL PRODUCTO',
  `BUS_COM_DESCRIPTION` text CHARACTER SET latin1 COMMENT 'DESCRIPCION DEL PRODUCTO',
  `BUS_COM_IMAGE` varchar(100) DEFAULT NULL COMMENT 'URL DE LA IMAGEN (NO ABSOLUTA)',
  `LUT_COD_COM_TYPE` int(11) DEFAULT NULL COMMENT 'TIPO DE PRODUCTO',
  PRIMARY KEY (`BUS_COM_ID`),
  KEY `FK_LUT_COD_COM_TYPE` (`LUT_COD_COM_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_commodity_attribute`
--

CREATE TABLE IF NOT EXISTS `buss_commodity_attribute` (
  `BUS_COM_ATT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL ATRIBUTO DEL PRODUCTO',
  `BUS_COM_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DEL PRODUCTO',
  `BUS_COM_ATT_PRICE` int(11) DEFAULT NULL COMMENT 'PRECIO DEL PRODUCTO POR UNIDAD',
  `BUS_COM_ATT_WEIGHT` int(11) DEFAULT NULL COMMENT 'PESO O VALOR DE LA UNIDAD (2 KG, 1 T, 10 MTS)',
  `BUS_COM_ATT_QUANTITY` int(11) DEFAULT NULL COMMENT 'CANTIDAD DE UNIDADES',
  `LUT_COD_STATUS` int(11) NOT NULL COMMENT 'IDENTIFICADOR DEL ESTADO',
  `LUT_COD_CURRENCY` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR DEL TIPO DE MONEDA',
  `LUT_COD_UNIT` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR DE LA UNIDAD',
  PRIMARY KEY (`BUS_COM_ATT_ID`),
  KEY `FK_BUS_COM_ID` (`BUS_COM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_com_by_kit`
--

CREATE TABLE IF NOT EXISTS `buss_com_by_kit` (
  `BUS_COM_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DEL PRODUCTO',
  `BUSS_KIT_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DEL KIT',
  PRIMARY KEY (`BUS_COM_ID`,`BUSS_KIT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_framework`
--

CREATE TABLE IF NOT EXISTS `buss_framework` (
  `BUS_FRA_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL PROYECTO',
  `BUS_FRA_ABBREVIATION` varchar(20) NOT NULL COMMENT 'ABREVIATURA ASIGNADA AL PROYECTO',
  `BUS_FRA_NAME` varchar(250) NOT NULL COMMENT 'NOMBRE ASIGNADO AL PROYECTO',
  `BUS_FRA_DESCRIPTION` varchar(250) DEFAULT NULL COMMENT 'DESCRIPCION DEL PROYECTO',
  `BUS_FRA_DATE_INIT` date NOT NULL COMMENT 'FECHA DE INICIO DEL PROYECTO',
  `BUS_FRA_DATE_END` date NOT NULL COMMENT 'FECHA DE FINALIZACION DEL PROYECTO',
  PRIMARY KEY (`BUS_FRA_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='TABLA QUE ALMACENA LA INFORMACION DE LOS PROYECTOS QUE SE TRABAJAN EN PMA' AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `buss_framework`
--

INSERT INTO `buss_framework` (`BUS_FRA_ID`, `BUS_FRA_ABBREVIATION`, `BUS_FRA_NAME`, `BUS_FRA_DESCRIPTION`, `BUS_FRA_DATE_INIT`, `BUS_FRA_DATE_END`) VALUES
(1, 'OPSR-200148', 'Operación Prolongada de Socorro y Recuperación 200148', 'Operación Prolongada de Socorro y Recuperación 200148', '2012-01-01', '2014-12-31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_frm_by_mod`
--

CREATE TABLE IF NOT EXISTS `buss_frm_by_mod` (
  `BUS_MOD_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DE MODALIDAD',
  `BUS_FRA_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DE FRAMEWORK',
  KEY `FK_BUS_MOD_ID` (`BUS_MOD_ID`),
  KEY `FK_BUS_FRA_ID` (`BUS_FRA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_kits`
--

CREATE TABLE IF NOT EXISTS `buss_kits` (
  `BUS_KIT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL KIT',
  `BUS_KIT_NAME` varchar(20) DEFAULT NULL COMMENT 'NOMBRE DEL KIT',
  `BUS_KIT_DESCRIPTION` varchar(100) DEFAULT NULL COMMENT 'DESCRIPCION DEL KIT',
  `BUS_KIT_ABBREVIATION` varchar(10) DEFAULT NULL COMMENT 'NOMBRE QUE IDENTIFICA AL KIT',
  `LUT_COD_STATUS` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR DEL ESTADO',
  `BUS_KIT_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE CREACION DEL KIT',
  PRIMARY KEY (`BUS_KIT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_kit_by_mod`
--

CREATE TABLE IF NOT EXISTS `buss_kit_by_mod` (
  `BUSS_KIT_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DEL KIT',
  `BUSS_MOD_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DE LA MODALIDAD',
  KEY `FK_BUSS_KIT_ID` (`BUSS_KIT_ID`),
  KEY `FK_BUSS_MOD_ID` (`BUSS_MOD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_kit_by_sea`
--

CREATE TABLE IF NOT EXISTS `buss_kit_by_sea` (
  `BUSS_KIT_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR DEL KIT',
  `BUSS_SEA_ID` int(11) NOT NULL COMMENT 'IDENTIFICADO DE LA CAMPAÑA',
  PRIMARY KEY (`BUSS_KIT_ID`,`BUSS_SEA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_modalities`
--

CREATE TABLE IF NOT EXISTS `buss_modalities` (
  `BUS_MOD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DE LA MODALIDAD',
  `BUS_MOD_ABBREVIATION` varchar(20) NOT NULL COMMENT 'ABREVIATURA UNICA ASIGNADA A LA MODALIDAD',
  `BUS_MOD_NAME` varchar(250) NOT NULL COMMENT 'NOMBRE DE LA MODALIDAD',
  `BUS_MOD_DESCRIPTION` varchar(250) DEFAULT NULL COMMENT 'DESCRIPCION DE LA MODALIDAD',
  `BUS_MOD_MIN_DELIVERIES` int(11) NOT NULL COMMENT 'MINIMA CANTIDAD DE ENTREGAS QUE SE REALIZAN POR LA MODALIDAD',
  `BUS_MOD_MAX_DELIVERIES` int(11) NOT NULL COMMENT 'MAXIMA CANTIDAD DE ENTREGAS QUE SE REALIZAN POR LA MODALIDAD',
  `BUS_MOD_TIMEFRAME` int(11) NOT NULL COMMENT 'PERIODICIDAD DE ENTREGA, POR EJEMPLO CADA 30 DIAS',
  `LUT_COD_TIMEFRAME_UNIT` int(11) NOT NULL COMMENT 'UNIDAD PARA LA PERIODICIDAD DE LA ENTREGA, POR EJEMPLO: DIAS, MESES, AÑOS',
  `LUT_COD_STATUS` int(11) NOT NULL COMMENT 'ESTADO DE LA MODALIDAD, POR EJEMPLO: ACTIVO, INACTIVO.',
  `LUT_COD_MOD_TYPE` int(11) NOT NULL COMMENT 'TIPO DE MODALIDAD, POR EJEMPLO: ALIMENTOS, NO ALIMENTOS',
  PRIMARY KEY (`BUS_MOD_ID`,`BUS_MOD_ABBREVIATION`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='MODALIDADES DISPONIBLES PARA SER IMPLEMENTADAS EN LAS DIFERENTES OPERACIONES' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `buss_modalities`
--

INSERT INTO `buss_modalities` (`BUS_MOD_ID`, `BUS_MOD_ABBREVIATION`, `BUS_MOD_NAME`, `BUS_MOD_DESCRIPTION`, `BUS_MOD_MIN_DELIVERIES`, `BUS_MOD_MAX_DELIVERIES`, `BUS_MOD_TIMEFRAME`, `LUT_COD_TIMEFRAME_UNIT`, `LUT_COD_STATUS`, `LUT_COD_MOD_TYPE`) VALUES
(1, 'SOC', 'Distribución General de Alimentos- Socorro', 'Distribución General de Alimentos- Socorro', 1, 3, 40, 1982, 1986, 1989),
(2, 'ESC', 'Alimentación Escolar', 'Alimentación Escolar', 1, 7, 30, 1982, 1986, 1989),
(3, 'MGL', 'Alimentación Complementaria (Madres Gestantes y en periodo de Lactancia)', 'Alimentación Complementaria (Madres Gestantes y en periodo de Lactancia)', 1, 9, 30, 1982, 1986, 1989),
(4, 'RN', 'Alimentación Complementaria (Niños 2-5 años)', 'Alimentación Complementaria (Niños 2-5 años)', 1, 9, 30, 1982, 1986, 1989);

--
-- Disparadores `buss_modalities`
--
DROP TRIGGER IF EXISTS `TR_BI_BUSS_MODALITIES`;
DELIMITER //
CREATE TRIGGER `TR_BI_BUSS_MODALITIES` BEFORE INSERT ON `buss_modalities`
 FOR EACH ROW BEGIN
  IF (NEW.LUT_COD_TIMEFRAME_UNIT IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'TIMEFRAME_UNIT'
             ,NEW.LUT_COD_TIMEFRAME_UNIT))
    THEN
      CALL raise_error( 'Problemas con el código de TIMEFRAME_UNIT en la tabla lut_codes');
    END IF;
  END IF;
  IF (NEW.LUT_COD_STATUS IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'STATUS'
             ,NEW.LUT_COD_STATUS))
    THEN
      CALL raise_error( 'Problemas con el código de STATUS en la tabla lut_codes');
    END IF;
  END IF;
  IF (NEW.LUT_COD_MOD_TYPE IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'MOD_TYPE'
             ,NEW.LUT_COD_MOD_TYPE))
    THEN
      CALL raise_error( 'Problemas con el código de MOD_TYPE en la tabla lut_codes');
    END IF;
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buss_season`
--

CREATE TABLE IF NOT EXISTS `buss_season` (
  `BUS_SEA_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DE LA CAMPAÑA',
  `BUS_SEA_NAME` varchar(20) DEFAULT NULL COMMENT 'NOMBRE DE LA CAMPAÑA',
  `BUS_SEA_DESCRIPTION` varchar(100) DEFAULT NULL COMMENT 'DESCRIPCION DE LA CAMPAÑA',
  `BUS_SEA_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE CREACION',
  `BUS_SEA_START_DATE` date DEFAULT NULL COMMENT 'FECHA DE INICIO DE LA CAMPAÑA',
  `BUS_SEA_END_DATE` date DEFAULT NULL COMMENT 'FECHA DE TERMINACION DE LA CAMPAÑA',
  `LUT_COD_STATUS` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR DEL ESTADO',
  PRIMARY KEY (`BUS_SEA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_contract`
--

CREATE TABLE IF NOT EXISTS `core_contract` (
  `COR_CON_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL CONTRATO',
  `COR_USR_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR UNICO DE USUARIO AL QUE ESTA RELACIONADO EL CONTRATO',
  `COR_CONSECUTIVE` varchar(25) DEFAULT NULL COMMENT 'CONSECUTIVO DEL CONTRATO EN RRHH - EN LOS CASOS QUE APLIQUE',
  `COR_DATE_START` date NOT NULL COMMENT 'FECHA DE INICIO',
  `COR_DATE_END` date NOT NULL COMMENT 'FECHA DE TERMINACION',
  PRIMARY KEY (`COR_CON_ID`),
  KEY `FK_CORE_CONTRACT1` (`COR_USR_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='TABLA EN LA QUE SE ALMACENAN LAS VIGENCIAS DE LOS CONTRATOS DE LOS USUARIOS, O EN SU DEFECTO EL PERIODO DE ACCESO QUE ES OTORGADO AL USUARIO' AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `core_contract`
--

INSERT INTO `core_contract` (`COR_CON_ID`, `COR_USR_ID`, `COR_CONSECUTIVE`, `COR_DATE_START`, `COR_DATE_END`) VALUES
(1, 6, '2014-054', '2014-02-20', '2014-08-31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_dpto_by_ofc`
--

CREATE TABLE IF NOT EXISTS `core_dpto_by_ofc` (
  `LUT_COD_OFFICES` int(11) DEFAULT NULL COMMENT 'CODIGO UNICO DE OFICINAS/SUBOFICINAS/OFICINAS SATELITE',
  `LUT_COD_DIVIPOLA` int(11) DEFAULT NULL COMMENT 'CODIGO UNICO DE DEPARTAMENTO QUE SE RELACIONA A LA COBERTURA DE LA SUBOFICINA',
  KEY `FK_CORE_DPTO_BY_OFC_01` (`LUT_COD_OFFICES`),
  KEY `FK_CORE_DPTO_BY_OFC_02` (`LUT_COD_DIVIPOLA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='RELACION DE LAS SUBOFICINAS CON LOS DEPARTAMENTOS INDICANDO LA COBERTURA';

--
-- Volcado de datos para la tabla `core_dpto_by_ofc`
--

INSERT INTO `core_dpto_by_ofc` (`LUT_COD_OFFICES`, `LUT_COD_DIVIPOLA`) VALUES
(1964, 37),
(1964, 22),
(1964, 31),
(1964, 42),
(1968, 34),
(1968, 30),
(1965, 26),
(1966, 24),
(1966, 35),
(1969, 43),
(1970, 32),
(1971, 15),
(1967, 27),
(1967, 14);

--
-- Disparadores `core_dpto_by_ofc`
--
DROP TRIGGER IF EXISTS `TR_BI_CORE_DPTO_BY_OFC`;
DELIMITER //
CREATE TRIGGER `TR_BI_CORE_DPTO_BY_OFC` BEFORE INSERT ON `core_dpto_by_ofc`
 FOR EACH ROW BEGIN
  IF (NEW.LUT_COD_OFFICES IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'OFFICES'
             ,NEW.LUT_COD_OFFICES))
    THEN
      CALL raise_error( 'Problemas con el código de OFFICES en la tabla lut_codes');
    END IF;
  END IF;
  IF (NEW.LUT_COD_DIVIPOLA IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'DIVIPOLA'
             ,NEW.LUT_COD_DIVIPOLA))
    THEN
      CALL raise_error( 'Problemas con el código de DIVIPOLA en la tabla lut_codes');
    END IF;
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_modules`
--

CREATE TABLE IF NOT EXISTS `core_modules` (
  `COR_MOD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL MODULO',
  `COR_MOD_PID` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR UNICO DEL MODULO PADRE',
  `COR_MOD_NAME` varchar(30) NOT NULL COMMENT 'NOMBRE DEL MODULO QUE SERA DESPLEGADO EN LA INTERFAZ',
  `COR_MOD_DESCRIPTION` varchar(250) DEFAULT NULL COMMENT 'DESCRIPCION DEL MODULO QUE SERA UTILIZADA COMO TOOL TIP EN LA ACCION MOUSE OVER',
  `COR_MOD_URL` varchar(500) NOT NULL COMMENT 'URL DE ACCESO AL MODULO',
  `COR_MOD_ICON` varchar(200) DEFAULT NULL COMMENT 'UBICACION ICONO ASOCIADO AL MODULO',
  `LUT_COD_STATUS` int(11) NOT NULL,
  PRIMARY KEY (`COR_MOD_ID`),
  KEY `SR_CORE_MODULES` (`COR_MOD_PID`),
  KEY `FK_LUT_COD_STATUS` (`LUT_COD_STATUS`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='TABLA DE ADMINISTRACIÓN DE MODULOS DE APLICACION' AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `core_modules`
--

INSERT INTO `core_modules` (`COR_MOD_ID`, `COR_MOD_PID`, `COR_MOD_NAME`, `COR_MOD_DESCRIPTION`, `COR_MOD_URL`, `COR_MOD_ICON`, `LUT_COD_STATUS`) VALUES
(1, NULL, 'Menú', 'Menú de menús', '', '', 1986),
(2, 1, 'Administración', 'Módulo Administrativo del Sistema de Información de la Operación', '', '', 1986),
(3, 2, 'Usuarios', 'Módulo de administración de usuarios', '/admin/user/list', '', 1986),
(4, 2, 'Módulos', 'Módulo de administración de módulos.', '/admin/modules/list', '', 1986),
(5, 1, 'Kits', 'Módulo kits.', '', '', 1986),
(7, 2, 'Roles', 'Módulo de administración de roles.', '/admin/roles/list', '', 1986);

--
-- Disparadores `core_modules`
--
DROP TRIGGER IF EXISTS `TR_BI_CORE_MODULES`;
DELIMITER //
CREATE TRIGGER `TR_BI_CORE_MODULES` BEFORE INSERT ON `core_modules`
 FOR EACH ROW BEGIN
  IF (NEW.LUT_COD_STATUS IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'STATUS'
             ,NEW.LUT_COD_STATUS))
    THEN
      CALL raise_error( 'Problemas con el código de STATUS en la tabla lut_codes');
    END IF;
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_mod_by_rol_priv`
--

CREATE TABLE IF NOT EXISTS `core_mod_by_rol_priv` (
  `COR_MOD_ID` int(11) NOT NULL,
  `COR_ROL_ID` int(11) NOT NULL,
  `LUT_COD_PRIVILEGE` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR UNICO DE CODIGOS DE PRIVILEGIOS',
  `COR_MRP_VALUE` int(1) DEFAULT '0' COMMENT 'VALOR BOOLEANO QUE IDENTIFICA SI TIENE O NO PRIVILEGIOS CONCEDIDOS',
  KEY `FK_core_mod_by_rol_priv_01` (`LUT_COD_PRIVILEGE`),
  KEY `FK_COR_MOD_ID` (`COR_MOD_ID`),
  KEY `FK_COR_ROL_ID` (`COR_ROL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TABLA DE PRIVILEGIOS A LOS MODULOS PARA CADA ROL';

--
-- Volcado de datos para la tabla `core_mod_by_rol_priv`
--

INSERT INTO `core_mod_by_rol_priv` (`COR_MOD_ID`, `COR_ROL_ID`, `LUT_COD_PRIVILEGE`, `COR_MRP_VALUE`) VALUES
(5, 2, 11, 1),
(2, 4, 11, 1),
(3, 4, 11, 1),
(4, 4, 11, 1),
(7, 4, 11, 1),
(5, 4, 11, 1),
(2, 1, 11, 1),
(3, 1, 11, 1),
(4, 1, 11, 1),
(7, 1, 11, 1),
(5, 1, 11, 1),
(2, 1, 1978, 1),
(3, 1, 1978, 1),
(4, 1, 1978, 1),
(7, 1, 1978, 1),
(5, 1, 1978, 1),
(2, 1, 1979, 1),
(3, 1, 1979, 1),
(4, 1, 1979, 1),
(7, 1, 1979, 1),
(5, 1, 1979, 1),
(2, 1, 1980, 1),
(3, 1, 1980, 1),
(4, 1, 1980, 1),
(7, 1, 1980, 1),
(5, 1, 1980, 1);

--
-- Disparadores `core_mod_by_rol_priv`
--
DROP TRIGGER IF EXISTS `TR_BI_CORE_MOD_BY_ROL_PRIV`;
DELIMITER //
CREATE TRIGGER `TR_BI_CORE_MOD_BY_ROL_PRIV` BEFORE INSERT ON `core_mod_by_rol_priv`
 FOR EACH ROW BEGIN
  IF (NEW.LUT_COD_PRIVILEGE IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'PRIVILEGES'
             ,NEW.LUT_COD_PRIVILEGE))
    THEN
      CALL raise_error( 'Problemas con el código de PRIVILEGES en la tabla lut_codes');
    END IF;
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_ofc_by_usr`
--

CREATE TABLE IF NOT EXISTS `core_ofc_by_usr` (
  `COR_USR_ID` int(11) NOT NULL DEFAULT '0' COMMENT 'IDENTIFICADOR UNICO DEL USUARIO',
  `LUT_COD_OFFICES` int(11) NOT NULL DEFAULT '0' COMMENT 'IDENTIFICADOR UNICO DE OFICINA(S) A LAS QUE SE RELACIONA EL USUARIO',
  PRIMARY KEY (`COR_USR_ID`,`LUT_COD_OFFICES`),
  KEY `FK_CORE_OFC_BY_USR_02` (`LUT_COD_OFFICES`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TABLA QUE ESTABLECE LA RELACION DE LOS USUARIOS CON LAS SUBOFICINAS PARA DETERMINAR LA INFORMACION A LA QUE TENDRAN ACCESO';

--
-- Disparadores `core_ofc_by_usr`
--
DROP TRIGGER IF EXISTS `TR_BI_CORE_OFC_BY_USR`;
DELIMITER //
CREATE TRIGGER `TR_BI_CORE_OFC_BY_USR` BEFORE INSERT ON `core_ofc_by_usr`
 FOR EACH ROW BEGIN
  IF (NEW.LUT_COD_OFFICES IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'OFFICES'
             ,NEW.LUT_COD_OFFICES))
    THEN
      CALL raise_error( 'Problemas con el código de OFFICES en la tabla lut_codes');
    END IF;
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_roles`
--

CREATE TABLE IF NOT EXISTS `core_roles` (
  `COR_ROL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL ROL',
  `COR_ROL_NAME` varchar(250) NOT NULL COMMENT 'NOMBRE DEL ROL',
  `COR_ROL_DESCRIPTION` varchar(250) DEFAULT NULL COMMENT 'DESCRIPCION DEL ROL',
  `LUT_COD_STATUS` int(11) NOT NULL,
  PRIMARY KEY (`COR_ROL_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='TABLA DE ALMACENAMIENTO DE ROLES' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `core_roles`
--

INSERT INTO `core_roles` (`COR_ROL_ID`, `COR_ROL_NAME`, `COR_ROL_DESCRIPTION`, `LUT_COD_STATUS`) VALUES
(1, 'Administrador', 'Administrador del Sistema de Información de la Operación', 1986),
(2, 'Test', 'Pruebas', 1986),
(4, 'Socios implementadores.', 'Socios implementadores. ', 1986);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_roles_by_user`
--

CREATE TABLE IF NOT EXISTS `core_roles_by_user` (
  `COR_ROL_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR UNICO DEL ROL',
  `COR_USR_ID` int(11) NOT NULL COMMENT 'IDENTIFICADOR UNICO DEL USUARIO',
  PRIMARY KEY (`COR_USR_ID`,`COR_ROL_ID`),
  KEY `FK_CORE_ROLES_BY_USER_01` (`COR_ROL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TABLA DE ALMACENAMIENTO DE LA RELACION ENTRE USUARIOS Y ROLES';

--
-- Volcado de datos para la tabla `core_roles_by_user`
--

INSERT INTO `core_roles_by_user` (`COR_ROL_ID`, `COR_USR_ID`) VALUES
(1, 1),
(1, 6),
(2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_users`
--

CREATE TABLE IF NOT EXISTS `core_users` (
  `COR_USR_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL USUARIO',
  `COR_USR_NAME` varchar(20) NOT NULL COMMENT 'NOMBRE DE USUARIO EN LA APLICACION',
  `COR_USR_FIRST_NAME` varchar(120) NOT NULL COMMENT 'NOMBRES DEL USUARIO',
  `COR_USR_LAST_NAME` varchar(120) NOT NULL COMMENT 'APELLIDOS DEL USUARIO',
  `LUT_COD_ORGANIZATION` int(11) NOT NULL COMMENT 'ORGANIZACION A LA QUE ESTA VINCULADO EL USUARIO',
  `LUT_COD_POSITION` int(11) NOT NULL COMMENT 'CARGO QUE OCUPA',
  `COR_USR_PWD` varchar(200) NOT NULL COMMENT 'CLAVE DE USUARIO ENCRIPTADA MD5',
  `COR_USR_EMAIL` varchar(250) NOT NULL COMMENT 'CORREO ELECTRONICO DEL USUARIO',
  `COR_USR_DATE_CREATION` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE CREACION DEL USUARIO',
  `COR_USR_DATE_CONTRACT_END` date NOT NULL COMMENT 'FECHA DE FINALIZACION DEL CONTRATO VIGENTE',
  `LUT_COD_USERSTATUS` int(11) NOT NULL DEFAULT '5',
  PRIMARY KEY (`COR_USR_ID`),
  KEY `FK_CORE_USERS_01` (`LUT_COD_ORGANIZATION`),
  KEY `FK_CORE_USERS_02` (`LUT_COD_POSITION`),
  KEY `FK_CORE_USERS_03` (`LUT_COD_USERSTATUS`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='TABLA DE USUARIOS' AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `core_users`
--

INSERT INTO `core_users` (`COR_USR_ID`, `COR_USR_NAME`, `COR_USR_FIRST_NAME`, `COR_USR_LAST_NAME`, `LUT_COD_ORGANIZATION`, `LUT_COD_POSITION`, `COR_USR_PWD`, `COR_USR_EMAIL`, `COR_USR_DATE_CREATION`, `COR_USR_DATE_CONTRACT_END`, `LUT_COD_USERSTATUS`) VALUES
(1, 'admin', 'Admin', 'PMA Colombia', 8, 9, 'e10adc3949ba59abbe56e057f20f883e', 'moreno.abel@gmail.com', '2014-06-09 20:07:41', '2014-07-31', 5),
(2, 'test', 'Nombre', 'Apellido', 8, 9, 'e10adc3949ba59abbe56e057f20f883e', 'aaa@aaa.com', '2014-06-11 20:09:13', '2014-06-30', 5),
(3, 'test2', 'aaa', 'bbb', 8, 9, 'e10adc3949ba59abbe56e057f20f883e', 'eee@eee.com', '2014-06-11 20:18:06', '2014-06-30', 5),
(4, 'test3', 'rrr', 'tttt', 8, 9, 'e10adc3949ba59abbe56e057f20f883e', 'ddd@ddd.com', '2014-06-11 20:25:17', '2014-06-30', 5),
(5, 'test4', 'werwet', 'fhjfgh', 8, 9, 'e10adc3949ba59abbe56e057f20f883e', 'qqq@aaa.com', '2014-06-11 20:26:51', '2014-06-30', 5),
(6, 'marcela.sanchez', 'Marcela Inés', 'Sánchez Ecima', 8, 9, '2ba4146a907134516a52a8ea3fe6ea03', 'marcela.sanchez@wfp.org', '2014-06-11 21:13:12', '2014-08-31', 5);

--
-- Disparadores `core_users`
--
DROP TRIGGER IF EXISTS `TR_BI_CORE_USERS_CODES`;
DELIMITER //
CREATE TRIGGER `TR_BI_CORE_USERS_CODES` BEFORE INSERT ON `core_users`
 FOR EACH ROW BEGIN
  IF (NEW.LUT_COD_USERSTATUS IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'USERSTATUS'
             ,NEW.LUT_COD_USERSTATUS))
    THEN
      CALL raise_error( 'Problemas con el código de USERSTATUS en la tabla lut_codes');
    END IF;
  END IF;
  IF (NEW.LUT_COD_USERSTATUS IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'POSITION'
             ,NEW.LUT_COD_POSITION))
    THEN
      CALL raise_error( 'Problemas con el código de POSITION en la tabla lut_codes');
    END IF;
  END IF;
  IF (NEW.LUT_COD_USERSTATUS IS NOT NULL)
  THEN
    IF (NOT F_Check_Codes(
              'ORGANIZATION'
             ,NEW.LUT_COD_ORGANIZATION))
    THEN
      CALL raise_error( 'Problemas con el código de ORGANIZATION en la tabla lut_codes');
    END IF;
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lut_codes`
--

CREATE TABLE IF NOT EXISTS `lut_codes` (
  `LUT_COD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IDENTIFICADOR UNICO DEL CODIGO',
  `LUT_COD_PID` int(11) DEFAULT NULL COMMENT 'IDENTIFICADOR DEL PADRE',
  `LUT_COD_NAME` varchar(250) NOT NULL COMMENT 'NOMBRE DEL CODIGO',
  `LUT_COD_PNAME` varchar(250) DEFAULT NULL COMMENT 'NOMBRE DEL CODIGO PADRE',
  `LUT_COD_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT 'DESCRIPCION DEL CODIGO',
  `LUT_COD_ABBREVIATION` varchar(120) NOT NULL COMMENT 'ABREVIATURA ASIGNADA AL CODIGO',
  `LUT_COD_OTHER1` varchar(20) DEFAULT NULL COMMENT 'CODIGO ALTERNO 1',
  `LUT_COD_OTHER2` varchar(20) DEFAULT NULL COMMENT 'CODIGO ALTERNO 2',
  `LUT_COD_OTHER3` varchar(20) DEFAULT NULL COMMENT 'CODIGO ALTERNO 3',
  `LUT_COD_TYPE` varchar(20) DEFAULT NULL COMMENT 'TIPO DE CODIGO',
  PRIMARY KEY (`LUT_COD_ID`),
  KEY `SR_LUT_CODES` (`LUT_COD_PID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='TABLA DE CODIFICACION' AUTO_INCREMENT=1994 ;

--
-- Volcado de datos para la tabla `lut_codes`
--

INSERT INTO `lut_codes` (`LUT_COD_ID`, `LUT_COD_PID`, `LUT_COD_NAME`, `LUT_COD_PNAME`, `LUT_COD_DESCRIPTION`, `LUT_COD_ABBREVIATION`, `LUT_COD_OTHER1`, `LUT_COD_OTHER2`, `LUT_COD_OTHER3`, `LUT_COD_TYPE`) VALUES
(0, NULL, 'CODIGOS', NULL, NULL, 'CODIGOS', NULL, NULL, NULL, 'CODIGOS'),
(3, 0, 'Distribución política', '', 'Distribución política del mundo', 'DIVIPOLA', 'DIVIPOLA', '', '', 'DIVIPOLA'),
(4, 0, 'Estados de usuario', '', 'Estados de los usuarios', 'USERSTATUS', '', '', '', 'USERSTATUS'),
(5, 4, 'Activo', 'Estados de usuario', '', 'ACTIVE', '', '', '', 'USERSTATUS'),
(6, 0, 'Organización', '', 'Empresas o compañías que se requieren mostrar en listas desplegables', 'ORGANIZATION', '', '', '', 'ORGANIZATION'),
(7, 0, 'Cargo', '', 'Cargos disponibles para listas desplegables que lo requieran', 'POSITION', '', '', '', 'POSITION'),
(8, 6, 'PMA Colombia', 'Organización', '', 'PMACOLOMBIA', '', '', '', 'ORGANIZATION'),
(9, 7, 'Gerente', 'Cargo', '', 'MANAGER', '', '', '', 'POSITION'),
(10, 0, 'Privilegios', NULL, 'Privilegios de los usuarios de la aplicación', 'PRIVILEGES', NULL, NULL, NULL, 'PRIVILEGES'),
(11, 10, 'Solo Lectura', NULL, NULL, 'READONLY', NULL, NULL, NULL, 'PRIVILEGES'),
(12, 3, 'Colombia', 'Distribución Política', NULL, 'COL', '57', NULL, NULL, 'DIVIPOLA'),
(13, 12, 'Amazonas', 'Colombia', 'Departamento', 'COL_AMA', '91', '57', '', 'DIVIPOLA'),
(14, 12, 'Antioquia', 'Colombia', 'Departamento', 'COL_ANT', '05', '57', '', 'DIVIPOLA'),
(15, 12, 'Arauca', 'Colombia', 'Departamento', 'COL_ARA', '81', '57', '', 'DIVIPOLA'),
(16, 12, 'Archipiélago De San Andrés, Providencia Y ', 'Colombia', 'Departamento', 'COL_ARC', '88', '57', '', 'DIVIPOLA'),
(17, 12, 'Atlántico', 'Colombia', 'Departamento', 'COL_ATL', '08', '57', '', 'DIVIPOLA'),
(18, 12, 'Bogotá, D. C.', 'Colombia', 'Departamento', 'COL_BOG', '11', '57', '', 'DIVIPOLA'),
(19, 12, 'Bolívar', 'Colombia', 'Departamento', 'COL_BOL', '13', '57', '', 'DIVIPOLA'),
(20, 12, 'Boyacá', 'Colombia', 'Departamento', 'COL_BOY', '15', '57', '', 'DIVIPOLA'),
(21, 12, 'Caldas', 'Colombia', 'Departamento', 'COL_CAL', '17', '57', '', 'DIVIPOLA'),
(22, 12, 'Caquetá', 'Colombia', 'Departamento', 'COL_CAQ', '18', '57', '', 'DIVIPOLA'),
(23, 12, 'Casanare', 'Colombia', 'Departamento', 'COL_CAS', '85', '57', '', 'DIVIPOLA'),
(24, 12, 'Cauca', 'Colombia', 'Departamento', 'COL_CAU', '19', '57', '', 'DIVIPOLA'),
(25, 12, 'Cesar', 'Colombia', 'Departamento', 'COL_CES', '20', '57', '', 'DIVIPOLA'),
(26, 12, 'Chocó', 'Colombia', 'Departamento', 'COL_CHO', '27', '57', '', 'DIVIPOLA'),
(27, 12, 'Córdoba', 'Colombia', 'Departamento', 'COL_CÓR', '23', '57', '', 'DIVIPOLA'),
(28, 12, 'Cundinamarca', 'Colombia', 'Departamento', 'COL_CUN', '25', '57', '', 'DIVIPOLA'),
(29, 12, 'Guainía', 'Colombia', 'Departamento', 'COL_GUA', '94', '57', '', 'DIVIPOLA'),
(30, 12, 'Guaviare', 'Colombia', 'Departamento', 'COL_GUV', '95', '57', '', 'DIVIPOLA'),
(31, 12, 'Huila', 'Colombia', 'Departamento', 'COL_HUI', '41', '57', '', 'DIVIPOLA'),
(32, 12, 'La Guajira', 'Colombia', 'Departamento', 'COL_LA ', '44', '57', '', 'DIVIPOLA'),
(33, 12, 'Magdalena', 'Colombia', 'Departamento', 'COL_MAG', '47', '57', '', 'DIVIPOLA'),
(34, 12, 'Meta', 'Colombia', 'Departamento', 'COL_MET', '50', '57', '', 'DIVIPOLA'),
(35, 12, 'Nariño', 'Colombia', 'Departamento', 'COL_NAR', '52', '57', '', 'DIVIPOLA'),
(36, 12, 'Norte De Santander', 'Colombia', 'Departamento', 'COL_NOR', '54', '57', '', 'DIVIPOLA'),
(37, 12, 'Putumayo', 'Colombia', 'Departamento', 'COL_PUT', '86', '57', '', 'DIVIPOLA'),
(38, 12, 'Quindío', 'Colombia', 'Departamento', 'COL_QUI', '63', '57', '', 'DIVIPOLA'),
(39, 12, 'Risaralda', 'Colombia', 'Departamento', 'COL_RIS', '66', '57', '', 'DIVIPOLA'),
(40, 12, 'Santander', 'Colombia', 'Departamento', 'COL_SAN', '68', '57', '', 'DIVIPOLA'),
(41, 12, 'Sucre', 'Colombia', 'Departamento', 'COL_SUC', '70', '57', '', 'DIVIPOLA'),
(42, 12, 'Tolima', 'Colombia', 'Departamento', 'COL_TOL', '73', '57', '', 'DIVIPOLA'),
(43, 12, 'Valle Del Cauca', 'Colombia', 'Departamento', 'COL_VAL', '76', '57', '', 'DIVIPOLA'),
(44, 12, 'Vaupés', 'Colombia', 'Departamento', 'COL_VAU', '97', '57', '', 'DIVIPOLA'),
(45, 12, 'Vichada', 'Colombia', 'Departamento', 'COL_VIC', '99', '57', '', 'DIVIPOLA'),
(46, 13, 'Leticia', 'Amazonas', 'Municipio', 'AMA_LET', '91001', '91', '', 'DIVIPOLA'),
(47, 13, 'Puerto Nariño', 'Amazonas', 'Municipio', 'AMA_PUE', '91540', '91', '', 'DIVIPOLA'),
(48, 14, 'Abejorral', 'Antioquia', 'Municipio', 'ANT_ABE', '05002', '05', '', 'DIVIPOLA'),
(49, 14, 'Abriaqui', 'Antioquia', 'Municipio', 'ANT_ABR', '05004', '05', '', 'DIVIPOLA'),
(50, 14, 'Alejandria', 'Antioquia', 'Municipio', 'ANT_ALE', '05021', '05', '', 'DIVIPOLA'),
(51, 14, 'Andes', 'Antioquia', 'Municipio', 'ANT_AND', '05034', '05', '', 'DIVIPOLA'),
(52, 14, 'Amaga', 'Antioquia', 'Municipio', 'ANT_AMG', '05030', '05', '', 'DIVIPOLA'),
(53, 14, 'Amalfi', 'Antioquia', 'Municipio', 'ANT_AMA', '05031', '05', '', 'DIVIPOLA'),
(54, 14, 'Anori', 'Antioquia', 'Municipio', 'ANT_ANO', '05040', '05', '', 'DIVIPOLA'),
(55, 14, 'Anza', 'Antioquia', 'Municipio', 'ANT_ANZ', '05044', '05', '', 'DIVIPOLA'),
(56, 14, 'Apartado', 'Antioquia', 'Municipio', 'ANT_APA', '05045', '05', '', 'DIVIPOLA'),
(57, 14, 'Arboletes', 'Antioquia', 'Municipio', 'ANT_ARB', '05051', '05', '', 'DIVIPOLA'),
(58, 14, 'Argelia', 'Antioquia', 'Municipio', 'ANT_ARG', '05055', '05', '', 'DIVIPOLA'),
(59, 14, 'Armenia', 'Antioquia', 'Municipio', 'ANT_ARM', '05059', '05', '', 'DIVIPOLA'),
(60, 14, 'San Andres', 'Antioquia', 'Municipio', 'ANT_ANR', '05647', '05', '', 'DIVIPOLA'),
(61, 14, 'Angelopolis', 'Antioquia', 'Municipio', 'ANT_ANL', '05036', '05', '', 'DIVIPOLA'),
(62, 14, 'Angostura', 'Antioquia', 'Municipio', 'ANT_ANG', '05038', '05', '', 'DIVIPOLA'),
(63, 14, 'Briceño', 'Antioquia', 'Municipio', 'ANT_BRI', '05107', '05', '', 'DIVIPOLA'),
(64, 14, 'Buritica', 'Antioquia', 'Municipio', 'ANT_BUR', '05113', '05', '', 'DIVIPOLA'),
(65, 14, 'Caceres', 'Antioquia', 'Municipio', 'ANT_CAC', '05120', '05', '', 'DIVIPOLA'),
(66, 14, 'Caicedo', 'Antioquia', 'Municipio', 'ANT_CAI', '05125', '05', '', 'DIVIPOLA'),
(67, 14, 'Caldas', 'Antioquia', 'Municipio', 'ANT_CAL', '05129', '05', '', 'DIVIPOLA'),
(68, 14, 'Campamento', 'Antioquia', 'Municipio', 'ANT_CAM', '05134', '05', '', 'DIVIPOLA'),
(69, 14, 'Cañasgordas', 'Antioquia', 'Municipio', 'ANT_CAÑ', '05138', '05', '', 'DIVIPOLA'),
(70, 14, 'Barbosa', 'Antioquia', 'Municipio', 'ANT_BAB', '05079', '05', '', 'DIVIPOLA'),
(71, 14, 'Caucasia', 'Antioquia', 'Municipio', 'ANT_CAU', '05154', '05', '', 'DIVIPOLA'),
(72, 14, 'Chigorodo', 'Antioquia', 'Municipio', 'ANT_CHI', '05172', '05', '', 'DIVIPOLA'),
(73, 14, 'Cisneros', 'Antioquia', 'Municipio', 'ANT_CIS', '05190', '05', '', 'DIVIPOLA'),
(74, 14, 'Ciudad Bolivar', 'Antioquia', 'Municipio', 'ANT_CIU', '05101', '05', '', 'DIVIPOLA'),
(75, 14, 'Cocorna', 'Antioquia', 'Municipio', 'ANT_COC', '05197', '05', '', 'DIVIPOLA'),
(76, 14, 'Bello', 'Antioquia', 'Municipio', 'ANT_BEL', '05088', '05', '', 'DIVIPOLA'),
(77, 14, 'Belmira', 'Antioquia', 'Municipio', 'ANT_BEM', '05086', '05', '', 'DIVIPOLA'),
(78, 14, 'Copacabana', 'Antioquia', 'Municipio', 'ANT_COP', '05212', '05', '', 'DIVIPOLA'),
(79, 14, 'Dabeiba', 'Antioquia', 'Municipio', 'ANT_DAB', '05234', '05', '', 'DIVIPOLA'),
(80, 14, 'Don Matias', 'Antioquia', 'Municipio', 'ANT_DON', '05237', '05', '', 'DIVIPOLA'),
(81, 14, 'Ebejico', 'Antioquia', 'Municipio', 'ANT_EBE', '05240', '05', '', 'DIVIPOLA'),
(82, 14, 'El Bagre', 'Antioquia', 'Municipio', 'ANT_EL ', '05250', '05', '', 'DIVIPOLA'),
(83, 14, 'Entrerrios', 'Antioquia', 'Municipio', 'ANT_ENT', '05264', '05', '', 'DIVIPOLA'),
(84, 14, 'Envigado', 'Antioquia', 'Municipio', 'ANT_ENV', '05266', '05', '', 'DIVIPOLA'),
(85, 14, 'Fredonia', 'Antioquia', 'Municipio', 'ANT_FRE', '05282', '05', '', 'DIVIPOLA'),
(86, 14, 'Frontino', 'Antioquia', 'Municipio', 'ANT_FRO', '05284', '05', '', 'DIVIPOLA'),
(87, 14, 'Betania', 'Antioquia', 'Municipio', 'ANT_BET', '05091', '05', '', 'DIVIPOLA'),
(88, 14, 'Betulia', 'Antioquia', 'Municipio', 'ANT_BEU', '05093', '05', '', 'DIVIPOLA'),
(89, 14, 'Gomez Plata', 'Antioquia', 'Municipio', 'ANT_GOM', '05310', '05', '', 'DIVIPOLA'),
(90, 14, 'Granada', 'Antioquia', 'Municipio', 'ANT_GRA', '05313', '05', '', 'DIVIPOLA'),
(91, 14, 'Heliconia', 'Antioquia', 'Municipio', 'ANT_HEL', '05347', '05', '', 'DIVIPOLA'),
(92, 14, 'Hispania', 'Antioquia', 'Municipio', 'ANT_HIS', '05353', '05', '', 'DIVIPOLA'),
(93, 14, 'Itagui', 'Antioquia', 'Municipio', 'ANT_ITA', '05360', '05', '', 'DIVIPOLA'),
(94, 14, 'Ituango', 'Antioquia', 'Municipio', 'ANT_ITU', '05361', '05', '', 'DIVIPOLA'),
(95, 14, 'Jardin', 'Antioquia', 'Municipio', 'ANT_JAR', '05364', '05', '', 'DIVIPOLA'),
(96, 14, 'Jerico', 'Antioquia', 'Municipio', 'ANT_JER', '05368', '05', '', 'DIVIPOLA'),
(97, 14, 'Liborina', 'Antioquia', 'Municipio', 'ANT_LIB', '05411', '05', '', 'DIVIPOLA'),
(98, 14, 'Maceo', 'Antioquia', 'Municipio', 'ANT_MAC', '05425', '05', '', 'DIVIPOLA'),
(99, 14, 'Marinilla', 'Antioquia', 'Municipio', 'ANT_MAR', '05440', '05', '', 'DIVIPOLA'),
(100, 14, 'Medellin', 'Antioquia', 'Municipio', 'ANT_MED', '05001', '05', '', 'DIVIPOLA'),
(101, 14, 'Montebello', 'Antioquia', 'Municipio', 'ANT_MON', '05467', '05', '', 'DIVIPOLA'),
(102, 14, 'Murindo', 'Antioquia', 'Municipio', 'ANT_MUR', '05475', '05', '', 'DIVIPOLA'),
(103, 14, 'Mutata', 'Antioquia', 'Municipio', 'ANT_MUT', '05480', '05', '', 'DIVIPOLA'),
(104, 14, 'Nariño', 'Antioquia', 'Municipio', 'ANT_NAR', '05483', '05', '', 'DIVIPOLA'),
(105, 14, 'Caracoli', 'Antioquia', 'Municipio', 'ANT_CAR', '05142', '05', '', 'DIVIPOLA'),
(106, 14, 'Olaya', 'Antioquia', 'Municipio', 'ANT_OLA', '05501', '05', '', 'DIVIPOLA'),
(107, 14, 'Peñol', 'Antioquia', 'Municipio', 'ANT_PEÑ', '05541', '05', '', 'DIVIPOLA'),
(108, 14, 'Peque', 'Antioquia', 'Municipio', 'ANT_PEQ', '05543', '05', '', 'DIVIPOLA'),
(109, 14, 'Caramanta', 'Antioquia', 'Municipio', 'ANT_CAT', '05145', '05', '', 'DIVIPOLA'),
(110, 14, 'Carepa', 'Antioquia', 'Municipio', 'ANT_CAP', '05147', '05', '', 'DIVIPOLA'),
(111, 14, 'Carmen De Viboral', 'Antioquia', 'Municipio', 'ANT_CAV', '05148', '05', '', 'DIVIPOLA'),
(112, 14, 'Carolina', 'Antioquia', 'Municipio', 'ANT_CAO', '05150', '05', '', 'DIVIPOLA'),
(113, 14, 'Remedios', 'Antioquia', 'Municipio', 'ANT_REM', '05604', '05', '', 'DIVIPOLA'),
(114, 14, 'Retiro', 'Antioquia', 'Municipio', 'ANT_RET', '05607', '05', '', 'DIVIPOLA'),
(115, 14, 'Rionegro', 'Antioquia', 'Municipio', 'ANT_RIO', '05615', '05', '', 'DIVIPOLA'),
(116, 14, 'Salgar', 'Antioquia', 'Municipio', 'ANT_SAL', '05642', '05', '', 'DIVIPOLA'),
(117, 14, 'Segovia', 'Antioquia', 'Municipio', 'ANT_SEG', '05736', '05', '', 'DIVIPOLA'),
(118, 14, 'Sonson', 'Antioquia', 'Municipio', 'ANT_SON', '05756', '05', '', 'DIVIPOLA'),
(119, 14, 'Sopetran', 'Antioquia', 'Municipio', 'ANT_SOP', '05761', '05', '', 'DIVIPOLA'),
(120, 14, 'Tamesis', 'Antioquia', 'Municipio', 'ANT_TAM', '05789', '05', '', 'DIVIPOLA'),
(121, 14, 'Titiribi', 'Antioquia', 'Municipio', 'ANT_TIT', '05809', '05', '', 'DIVIPOLA'),
(122, 14, 'Toledo', 'Antioquia', 'Municipio', 'ANT_TOL', '05819', '05', '', 'DIVIPOLA'),
(123, 14, 'Turbo', 'Antioquia', 'Municipio', 'ANT_TUR', '05837', '05', '', 'DIVIPOLA'),
(124, 14, 'Uramita', 'Antioquia', 'Municipio', 'ANT_URA', '05842', '05', '', 'DIVIPOLA'),
(125, 14, 'Urrao', 'Antioquia', 'Municipio', 'ANT_URR', '05847', '05', '', 'DIVIPOLA'),
(126, 14, 'Concepcion', 'Antioquia', 'Municipio', 'ANT_COE', '05206', '05', '', 'DIVIPOLA'),
(127, 14, 'Vegachi', 'Antioquia', 'Municipio', 'ANT_VEG', '05858', '05', '', 'DIVIPOLA'),
(128, 14, 'Venecia', 'Antioquia', 'Municipio', 'ANT_VEN', '05861', '05', '', 'DIVIPOLA'),
(129, 14, 'Vigia Del Fuerte', 'Antioquia', 'Municipio', 'ANT_VIG', '05873', '05', '', 'DIVIPOLA'),
(130, 14, 'Yali', 'Antioquia', 'Municipio', 'ANT_YAL', '05885', '05', '', 'DIVIPOLA'),
(131, 14, 'Yarumal', 'Antioquia', 'Municipio', 'ANT_YAR', '05887', '05', '', 'DIVIPOLA'),
(132, 14, 'Yolombo', 'Antioquia', 'Municipio', 'ANT_YOL', '05890', '05', '', 'DIVIPOLA'),
(133, 14, 'Yondo', 'Antioquia', 'Municipio', 'ANT_YON', '05893', '05', '', 'DIVIPOLA'),
(134, 14, 'Zaragoza', 'Antioquia', 'Municipio', 'ANT_ZAR', '05895', '05', '', 'DIVIPOLA'),
(135, 14, 'Concordia', 'Antioquia', 'Municipio', 'ANT_CON', '05209', '05', '', 'DIVIPOLA'),
(136, 14, 'Santa Barbara', 'Antioquia', 'Municipio', 'ANT_BAR', '05679', '05', '', 'DIVIPOLA'),
(137, 14, 'San Pedro', 'Antioquia', 'Municipio', 'ANT_PED', '05664', '05', '', 'DIVIPOLA'),
(138, 14, 'San Pedro De Uraba', 'Antioquia', 'Municipio', 'ANT_PEU', '05665', '05', '', 'DIVIPOLA'),
(139, 14, 'Giraldo', 'Antioquia', 'Municipio', 'ANT_GIR', '05306', '05', '', 'DIVIPOLA'),
(140, 14, 'Girardota', 'Antioquia', 'Municipio', 'ANT_GID', '05308', '05', '', 'DIVIPOLA'),
(141, 14, 'Guadalupe', 'Antioquia', 'Municipio', 'ANT_GUD', '05315', '05', '', 'DIVIPOLA'),
(142, 14, 'Guarne', 'Antioquia', 'Municipio', 'ANT_GUR', '05318', '05', '', 'DIVIPOLA'),
(143, 14, 'Guatape', 'Antioquia', 'Municipio', 'ANT_GUA', '05321', '05', '', 'DIVIPOLA'),
(144, 14, 'San Roque', 'Antioquia', 'Municipio', 'ANT_ROQ', '05670', '05', '', 'DIVIPOLA'),
(145, 14, 'La Ceja', 'Antioquia', 'Municipio', 'ANT_CEJ', '05376', '05', '', 'DIVIPOLA'),
(146, 14, 'La Estrella', 'Antioquia', 'Municipio', 'ANT_EST', '05380', '05', '', 'DIVIPOLA'),
(147, 14, 'Santa Rosa De Osos', 'Antioquia', 'Municipio', 'ANT_ROS', '05686', '05', '', 'DIVIPOLA'),
(148, 14, 'La Pintada', 'Antioquia', 'Municipio', 'ANT_PIN', '05390', '05', '', 'DIVIPOLA'),
(149, 14, 'La Union', 'Antioquia', 'Municipio', 'ANT_UNI', '05400', '05', '', 'DIVIPOLA'),
(150, 14, 'Taraza', 'Antioquia', 'Municipio', 'ANT_TAZ', '05790', '05', '', 'DIVIPOLA'),
(151, 14, 'Tarso', 'Antioquia', 'Municipio', 'ANT_TAR', '05792', '05', '', 'DIVIPOLA'),
(152, 14, 'Valdivia', 'Antioquia', 'Municipio', 'ANT_VAL', '05854', '05', '', 'DIVIPOLA'),
(153, 14, 'Nechi', 'Antioquia', 'Municipio', 'ANT_NEH', '05495', '05', '', 'DIVIPOLA'),
(154, 14, 'Necocli', 'Antioquia', 'Municipio', 'ANT_NEC', '05490', '05', '', 'DIVIPOLA'),
(155, 14, 'Pueblorrico', 'Antioquia', 'Municipio', 'ANT_PUL', '05576', '05', '', 'DIVIPOLA'),
(156, 14, 'Valparaiso', 'Antioquia', 'Municipio', 'ANT_VAP', '05856', '05', '', 'DIVIPOLA'),
(157, 14, 'Puerto Berrio', 'Antioquia', 'Municipio', 'ANT_PUT', '05579', '05', '', 'DIVIPOLA'),
(158, 14, 'Puerto Nare', 'Antioquia', 'Municipio', 'ANT_NAE', '05585', '05', '', 'DIVIPOLA'),
(159, 14, 'Puerto Triunfo', 'Antioquia', 'Municipio', 'ANT_PUE', '05591', '05', '', 'DIVIPOLA'),
(160, 14, 'Sabanalarga', 'Antioquia', 'Municipio', 'ANT_SAR', '05628', '05', '', 'DIVIPOLA'),
(161, 14, 'Sabaneta', 'Antioquia', 'Municipio', 'ANT_SAB', '05631', '05', '', 'DIVIPOLA'),
(162, 14, 'San Carlos', 'Antioquia', 'Municipio', 'ANT_CAS', '05649', '05', '', 'DIVIPOLA'),
(163, 14, 'San Francisco', 'Antioquia', 'Municipio', 'ANT_FRA', '05652', '05', '', 'DIVIPOLA'),
(164, 14, 'San Jeronimo', 'Antioquia', 'Municipio', 'ANT_JEO', '05656', '05', '', 'DIVIPOLA'),
(165, 14, 'San Jose De La Montaña', 'Antioquia', 'Municipio', 'ANT_JOS', '05658', '05', '', 'DIVIPOLA'),
(166, 14, 'San Juan De Uraba', 'Antioquia', 'Municipio', 'ANT_JUA', '05659', '05', '', 'DIVIPOLA'),
(167, 14, 'San Luis', 'Antioquia', 'Municipio', 'ANT_LUI', '05660', '05', '', 'DIVIPOLA'),
(168, 14, 'San Rafael', 'Antioquia', 'Municipio', 'ANT_RAF', '05667', '05', '', 'DIVIPOLA'),
(169, 14, 'San Vicente', 'Antioquia', 'Municipio', 'ANT_VIC', '05674', '05', '', 'DIVIPOLA'),
(170, 14, 'Santafe De Antioquia', 'Antioquia', 'Municipio', 'ANT_ANT', '05042', '05', '', 'DIVIPOLA'),
(171, 14, 'Santo Domingo', 'Antioquia', 'Municipio', 'ANT_DOM', '05690', '05', '', 'DIVIPOLA'),
(172, 14, 'Santuario', 'Antioquia', 'Municipio', 'ANT_SAN', '05697', '05', '', 'DIVIPOLA'),
(173, 15, 'Arauca', 'Arauca', 'Municipio', 'ARA_ARA', '81001', '81', '', 'DIVIPOLA'),
(174, 15, 'Arauquita', 'Arauca', 'Municipio', 'ARA_ARQ', '81065', '81', '', 'DIVIPOLA'),
(177, 15, 'Cravo Norte', 'Arauca', 'Municipio', 'ARA_CRA', '81220', '81', '', 'DIVIPOLA'),
(180, 15, 'Fortul', 'Arauca', 'Municipio', 'ARA_FOR', '81300', '81', '', 'DIVIPOLA'),
(183, 15, 'Puerto Rondon', 'Arauca', 'Municipio', 'ARA_PUE', '81591', '81', '', 'DIVIPOLA'),
(186, 15, 'Saravena', 'Arauca', 'Municipio', 'ARA_SAR', '81736', '81', '', 'DIVIPOLA'),
(189, 15, 'Tame', 'Arauca', 'Municipio', 'ARA_TAM', '81794', '81', '', 'DIVIPOLA'),
(192, 16, 'Providencia', 'Archipiélago De San Andrés, Providencia Y ', 'Municipio', 'ARC_PRO', '88564', '88', '', 'DIVIPOLA'),
(193, 16, 'San Andres', 'Archipiélago De San Andrés, Providencia Y ', 'Municipio', 'ARC_SAN', '88001', '88', '', 'DIVIPOLA'),
(194, 17, 'Baranoa', 'Atlántico', 'Municipio', 'ATL_BAN', '08078', '08', '', 'DIVIPOLA'),
(195, 17, 'Barranquilla', 'Atlántico', 'Municipio', 'ATL_BAR', '08001', '08', '', 'DIVIPOLA'),
(196, 17, 'Campo De La Cruz', 'Atlántico', 'Municipio', 'ATL_CAM', '08137', '08', '', 'DIVIPOLA'),
(197, 17, 'Candelaria', 'Atlántico', 'Municipio', 'ATL_CAN', '08141', '08', '', 'DIVIPOLA'),
(198, 17, 'Galapa', 'Atlántico', 'Municipio', 'ATL_GAL', '08296', '08', '', 'DIVIPOLA'),
(199, 17, 'Juan De Acosta', 'Atlántico', 'Municipio', 'ATL_JUA', '08372', '08', '', 'DIVIPOLA'),
(200, 17, 'Luruaco', 'Atlántico', 'Municipio', 'ATL_LUR', '08421', '08', '', 'DIVIPOLA'),
(201, 17, 'Malambo', 'Atlántico', 'Municipio', 'ATL_MAL', '08433', '08', '', 'DIVIPOLA'),
(202, 17, 'Manati', 'Atlántico', 'Municipio', 'ATL_MAN', '08436', '08', '', 'DIVIPOLA'),
(203, 17, 'Palmar De Varela', 'Atlántico', 'Municipio', 'ATL_PAL', '08520', '08', '', 'DIVIPOLA'),
(204, 17, 'Piojo', 'Atlántico', 'Municipio', 'ATL_PIO', '08549', '08', '', 'DIVIPOLA'),
(205, 17, 'Polonuevo', 'Atlántico', 'Municipio', 'ATL_POL', '08558', '08', '', 'DIVIPOLA'),
(206, 17, 'Ponedera', 'Atlántico', 'Municipio', 'ATL_PON', '08560', '08', '', 'DIVIPOLA'),
(207, 17, 'Puerto Colombia', 'Atlántico', 'Municipio', 'ATL_PUE', '08573', '08', '', 'DIVIPOLA'),
(208, 17, 'Repelon', 'Atlántico', 'Municipio', 'ATL_REP', '08606', '08', '', 'DIVIPOLA'),
(209, 17, 'Soledad', 'Atlántico', 'Municipio', 'ATL_SOL', '08758', '08', '', 'DIVIPOLA'),
(210, 17, 'Suan', 'Atlántico', 'Municipio', 'ATL_SUA', '08770', '08', '', 'DIVIPOLA'),
(211, 17, 'Tubara', 'Atlántico', 'Municipio', 'ATL_TUB', '08832', '08', '', 'DIVIPOLA'),
(212, 17, 'Usiacuri', 'Atlántico', 'Municipio', 'ATL_USI', '08849', '08', '', 'DIVIPOLA'),
(213, 17, 'Sabanagrande', 'Atlántico', 'Municipio', 'ATL_SAB', '08634', '08', '', 'DIVIPOLA'),
(214, 17, 'Sabanalarga', 'Atlántico', 'Municipio', 'ATL_SAL', '08638', '08', '', 'DIVIPOLA'),
(215, 17, 'Santa Lucia', 'Atlántico', 'Municipio', 'ATL_LUC', '08675', '08', '', 'DIVIPOLA'),
(216, 17, 'Santo Tomas', 'Atlántico', 'Municipio', 'ATL_SAN', '08685', '08', '', 'DIVIPOLA'),
(217, 18, 'Bogota D.C.', 'Bogotá, D. C.', 'Municipio', 'BOG_BOG', '11001', '11', '', 'DIVIPOLA'),
(218, 19, 'Achi', 'Bolívar', 'Municipio', 'BOL_ACH', '13006', '13', '', 'DIVIPOLA'),
(219, 19, 'Altos Del Rosario', 'Bolívar', 'Municipio', 'BOL_ALT', '13030', '13', '', 'DIVIPOLA'),
(220, 19, 'Arenal', 'Bolívar', 'Municipio', 'BOL_ARE', '13042', '13', '', 'DIVIPOLA'),
(221, 19, 'Arjona', 'Bolívar', 'Municipio', 'BOL_ARJ', '13052', '13', '', 'DIVIPOLA'),
(222, 19, 'Arroyohondo', 'Bolívar', 'Municipio', 'BOL_ARR', '13062', '13', '', 'DIVIPOLA'),
(223, 19, 'Barranco De Loba', 'Bolívar', 'Municipio', 'BOL_BAR', '13074', '13', '', 'DIVIPOLA'),
(224, 19, 'Calamar', 'Bolívar', 'Municipio', 'BOL_CAL', '13140', '13', '', 'DIVIPOLA'),
(225, 19, 'Cantagallo', 'Bolívar', 'Municipio', 'BOL_CAN', '13160', '13', '', 'DIVIPOLA'),
(226, 19, 'Cartagena', 'Bolívar', 'Municipio', 'BOL_CAR', '13001', '13', '', 'DIVIPOLA'),
(227, 19, 'Cicuco', 'Bolívar', 'Municipio', 'BOL_CIC', '13188', '13', '', 'DIVIPOLA'),
(228, 19, 'Clemencia', 'Bolívar', 'Municipio', 'BOL_CLE', '13222', '13', '', 'DIVIPOLA'),
(229, 19, 'Cordoba', 'Bolívar', 'Municipio', 'BOL_COR', '13212', '13', '', 'DIVIPOLA'),
(230, 19, 'Hatillo De Loba', 'Bolívar', 'Municipio', 'BOL_HAT', '13300', '13', '', 'DIVIPOLA'),
(231, 19, 'Mahates', 'Bolívar', 'Municipio', 'BOL_MAH', '13433', '13', '', 'DIVIPOLA'),
(232, 19, 'Mompos', 'Bolívar', 'Municipio', 'BOL_MOM', '13468', '13', '', 'DIVIPOLA'),
(233, 19, 'Montecristo', 'Bolívar', 'Municipio', 'BOL_MON', '13458', '13', '', 'DIVIPOLA'),
(234, 19, 'Morales', 'Bolívar', 'Municipio', 'BOL_MOR', '13473', '13', '', 'DIVIPOLA'),
(235, 19, 'Norosi', 'Bolívar', 'Municipio', 'BOL_NOR', '13490', '13', '', 'DIVIPOLA'),
(236, 19, 'Pinillos', 'Bolívar', 'Municipio', 'BOL_PIN', '13549', '13', '', 'DIVIPOLA'),
(237, 19, 'Regidor', 'Bolívar', 'Municipio', 'BOL_REG', '13580', '13', '', 'DIVIPOLA'),
(238, 19, 'Rio Viejo', 'Bolívar', 'Municipio', 'BOL_RIO', '13600', '13', '', 'DIVIPOLA'),
(239, 19, 'El Carmen De Bolivar', 'Bolívar', 'Municipio', 'BOL_ELB', '13244', '13', '', 'DIVIPOLA'),
(240, 19, 'Simiti', 'Bolívar', 'Municipio', 'BOL_SIM', '13744', '13', '', 'DIVIPOLA'),
(241, 19, 'Soplaviento', 'Bolívar', 'Municipio', 'BOL_SOP', '13760', '13', '', 'DIVIPOLA'),
(242, 19, 'Talaigua Nuevo', 'Bolívar', 'Municipio', 'BOL_TAL', '13780', '13', '', 'DIVIPOLA'),
(243, 19, 'Tiquisio', 'Bolívar', 'Municipio', 'BOL_TIQ', '13810', '13', '', 'DIVIPOLA'),
(244, 19, 'Villanueva', 'Bolívar', 'Municipio', 'BOL_VIL', '13873', '13', '', 'DIVIPOLA'),
(245, 19, 'Zambrano', 'Bolívar', 'Municipio', 'BOL_ZAM', '13894', '13', '', 'DIVIPOLA'),
(246, 19, 'El Guamo', 'Bolívar', 'Municipio', 'BOL_ELG', '13248', '13', '', 'DIVIPOLA'),
(247, 19, 'El Peñon', 'Bolívar', 'Municipio', 'BOL_ELP', '13268', '13', '', 'DIVIPOLA'),
(248, 19, 'Maria La Baja', 'Bolívar', 'Municipio', 'BOL_MAR', '13442', '13', '', 'DIVIPOLA'),
(249, 19, 'Magangue', 'Bolívar', 'Municipio', 'BOL_MAG', '13430', '13', '', 'DIVIPOLA'),
(250, 19, 'San Cristobal', 'Bolívar', 'Municipio', 'BOL_CRI', '13620', '13', '', 'DIVIPOLA'),
(251, 19, 'San Estanislao', 'Bolívar', 'Municipio', 'BOL_EST', '13647', '13', '', 'DIVIPOLA'),
(252, 19, 'San Fernando', 'Bolívar', 'Municipio', 'BOL_FER', '13650', '13', '', 'DIVIPOLA'),
(253, 19, 'San Jacinto', 'Bolívar', 'Municipio', 'BOL_JAC', '13654', '13', '', 'DIVIPOLA'),
(254, 19, 'San Jacinto Del Cauca', 'Bolívar', 'Municipio', 'BOL_JDC', '13655', '13', '', 'DIVIPOLA'),
(255, 19, 'Margarita', 'Bolívar', 'Municipio', 'BOL_MAI', '13440', '13', '', 'DIVIPOLA'),
(256, 19, 'San Juan Nepomuceno', 'Bolívar', 'Municipio', 'BOL_JUA', '13657', '13', '', 'DIVIPOLA'),
(257, 19, 'Turbaco', 'Bolívar', 'Municipio', 'BOL_TUC', '13836', '13', '', 'DIVIPOLA'),
(258, 19, 'San Martin De Loba', 'Bolívar', 'Municipio', 'BOL_LOB', '13667', '13', '', 'DIVIPOLA'),
(259, 19, 'San Pablo', 'Bolívar', 'Municipio', 'BOL_PAB', '13670', '13', '', 'DIVIPOLA'),
(260, 19, 'Turbana', 'Bolívar', 'Municipio', 'BOL_TUR', '13838', '13', '', 'DIVIPOLA'),
(261, 19, 'Santa Catalina', 'Bolívar', 'Municipio', 'BOL_CAT', '13673', '13', '', 'DIVIPOLA'),
(262, 19, 'Santa Rosa', 'Bolívar', 'Municipio', 'BOL_ROS', '13683', '13', '', 'DIVIPOLA'),
(263, 19, 'Santa Rosa Del Sur', 'Bolívar', 'Municipio', 'BOL_SAN', '13688', '13', '', 'DIVIPOLA'),
(264, 20, 'Chinavita', 'Boyacá', 'Municipio', 'BOY_CHN', '15172', '15', '', 'DIVIPOLA'),
(265, 20, 'Chiquinquira', 'Boyacá', 'Municipio', 'BOY_CHQ', '15176', '15', '', 'DIVIPOLA'),
(266, 20, 'Chiquiza', 'Boyacá', 'Municipio', 'BOY_CHZ', '15232', '15', '', 'DIVIPOLA'),
(267, 20, 'Chiscas', 'Boyacá', 'Municipio', 'BOY_CHS', '15180', '15', '', 'DIVIPOLA'),
(268, 20, 'Chita', 'Boyacá', 'Municipio', 'BOY_CHT', '15183', '15', '', 'DIVIPOLA'),
(269, 20, 'Chitaraque', 'Boyacá', 'Municipio', 'BOY_CHR', '15185', '15', '', 'DIVIPOLA'),
(270, 20, 'Chivata', 'Boyacá', 'Municipio', 'BOY_CHV', '15187', '15', '', 'DIVIPOLA'),
(271, 20, 'Chivor', 'Boyacá', 'Municipio', 'BOY_CHI', '15236', '15', '', 'DIVIPOLA'),
(272, 20, 'El Cocuy', 'Boyacá', 'Municipio', 'BOY_ELC', '15244', '15', '', 'DIVIPOLA'),
(273, 20, 'Almeida', 'Boyacá', 'Municipio', 'BOY_ALM', '15022', '15', '', 'DIVIPOLA'),
(274, 20, 'Aquitania', 'Boyacá', 'Municipio', 'BOY_AQU', '15047', '15', '', 'DIVIPOLA'),
(275, 20, 'Arcabuco', 'Boyacá', 'Municipio', 'BOY_ARC', '15051', '15', '', 'DIVIPOLA'),
(276, 20, 'Belen', 'Boyacá', 'Municipio', 'BOY_BEL', '15087', '15', '', 'DIVIPOLA'),
(277, 20, 'Berbeo', 'Boyacá', 'Municipio', 'BOY_BER', '15090', '15', '', 'DIVIPOLA'),
(278, 20, 'Beteitiva', 'Boyacá', 'Municipio', 'BOY_BET', '15092', '15', '', 'DIVIPOLA'),
(279, 20, 'Boavita', 'Boyacá', 'Municipio', 'BOY_BOA', '15097', '15', '', 'DIVIPOLA'),
(280, 20, 'Boyaca', 'Boyacá', 'Municipio', 'BOY_BOY', '15104', '15', '', 'DIVIPOLA'),
(281, 20, 'Briceño', 'Boyacá', 'Municipio', 'BOY_BRI', '15106', '15', '', 'DIVIPOLA'),
(284, 20, 'Buenavista', 'Boyacá', 'Municipio', 'BOY_BUE', '15109', '15', '', 'DIVIPOLA'),
(287, 20, 'Busbanza', 'Boyacá', 'Municipio', 'BOY_BUS', '15114', '15', '', 'DIVIPOLA'),
(290, 20, 'Caldas', 'Boyacá', 'Municipio', 'BOY_CAL', '15131', '15', '', 'DIVIPOLA'),
(293, 20, 'Campohermoso', 'Boyacá', 'Municipio', 'BOY_CAM', '15135', '15', '', 'DIVIPOLA'),
(296, 20, 'Cerinza', 'Boyacá', 'Municipio', 'BOY_CER', '15162', '15', '', 'DIVIPOLA'),
(299, 20, 'El Espino', 'Boyacá', 'Municipio', 'BOY_ELE', '15248', '15', '', 'DIVIPOLA'),
(302, 20, 'Cienega', 'Boyacá', 'Municipio', 'BOY_CIE', '15189', '15', '', 'DIVIPOLA'),
(305, 20, 'Combita', 'Boyacá', 'Municipio', 'BOY_COM', '15204', '15', '', 'DIVIPOLA'),
(308, 20, 'Coper', 'Boyacá', 'Municipio', 'BOY_COP', '15212', '15', '', 'DIVIPOLA'),
(311, 20, 'Corrales', 'Boyacá', 'Municipio', 'BOY_COR', '15215', '15', '', 'DIVIPOLA'),
(314, 20, 'Covarachia', 'Boyacá', 'Municipio', 'BOY_COV', '15218', '15', '', 'DIVIPOLA'),
(317, 20, 'Cubara', 'Boyacá', 'Municipio', 'BOY_CUB', '15223', '15', '', 'DIVIPOLA'),
(320, 20, 'Cucaita', 'Boyacá', 'Municipio', 'BOY_CUC', '15224', '15', '', 'DIVIPOLA'),
(323, 20, 'Cuitiva', 'Boyacá', 'Municipio', 'BOY_CUI', '15226', '15', '', 'DIVIPOLA'),
(326, 20, 'Duitama', 'Boyacá', 'Municipio', 'BOY_DUI', '15238', '15', '', 'DIVIPOLA'),
(329, 20, 'Firavitoba', 'Boyacá', 'Municipio', 'BOY_FIR', '15272', '15', '', 'DIVIPOLA'),
(332, 20, 'Floresta', 'Boyacá', 'Municipio', 'BOY_FLO', '15276', '15', '', 'DIVIPOLA'),
(335, 20, 'Gachantiva', 'Boyacá', 'Municipio', 'BOY_GAC', '15293', '15', '', 'DIVIPOLA'),
(338, 20, 'Gameza', 'Boyacá', 'Municipio', 'BOY_GAM', '15296', '15', '', 'DIVIPOLA'),
(341, 20, 'Garagoa', 'Boyacá', 'Municipio', 'BOY_GAR', '15299', '15', '', 'DIVIPOLA'),
(344, 20, 'Guican', 'Boyacá', 'Municipio', 'BOY_GUI', '15332', '15', '', 'DIVIPOLA'),
(347, 20, 'Iza', 'Boyacá', 'Municipio', 'BOY_IZA', '15362', '15', '', 'DIVIPOLA'),
(350, 20, 'Jenesano', 'Boyacá', 'Municipio', 'BOY_JEN', '15367', '15', '', 'DIVIPOLA'),
(353, 20, 'Jerico', 'Boyacá', 'Municipio', 'BOY_JER', '15368', '15', '', 'DIVIPOLA'),
(356, 20, 'Labranzagrande', 'Boyacá', 'Municipio', 'BOY_LAB', '15377', '15', '', 'DIVIPOLA'),
(359, 20, 'Macanal', 'Boyacá', 'Municipio', 'BOY_MAC', '15425', '15', '', 'DIVIPOLA'),
(362, 20, 'Miraflores', 'Boyacá', 'Municipio', 'BOY_MIR', '15455', '15', '', 'DIVIPOLA'),
(365, 20, 'Motavita', 'Boyacá', 'Municipio', 'BOY_MOT', '15476', '15', '', 'DIVIPOLA'),
(368, 20, 'Muzo', 'Boyacá', 'Municipio', 'BOY_MUZ', '15480', '15', '', 'DIVIPOLA'),
(371, 20, 'Nobsa', 'Boyacá', 'Municipio', 'BOY_NOB', '15491', '15', '', 'DIVIPOLA'),
(374, 20, 'Nuevo Colon', 'Boyacá', 'Municipio', 'BOY_NUE', '15494', '15', '', 'DIVIPOLA'),
(377, 20, 'Oicata', 'Boyacá', 'Municipio', 'BOY_OIC', '15500', '15', '', 'DIVIPOLA'),
(380, 20, 'Otanche', 'Boyacá', 'Municipio', 'BOY_OTA', '15507', '15', '', 'DIVIPOLA'),
(383, 20, 'Pachavita', 'Boyacá', 'Municipio', 'BOY_PAC', '15511', '15', '', 'DIVIPOLA'),
(386, 20, 'Paez', 'Boyacá', 'Municipio', 'BOY_PAE', '15514', '15', '', 'DIVIPOLA'),
(389, 20, 'Paipa', 'Boyacá', 'Municipio', 'BOY_PAI', '15516', '15', '', 'DIVIPOLA'),
(392, 20, 'Pajarito', 'Boyacá', 'Municipio', 'BOY_PAJ', '15518', '15', '', 'DIVIPOLA'),
(395, 20, 'Panqueba', 'Boyacá', 'Municipio', 'BOY_PAN', '15522', '15', '', 'DIVIPOLA'),
(398, 20, 'Pauna', 'Boyacá', 'Municipio', 'BOY_PAU', '15531', '15', '', 'DIVIPOLA'),
(401, 20, 'Paya', 'Boyacá', 'Municipio', 'BOY_PAY', '15533', '15', '', 'DIVIPOLA'),
(404, 20, 'Paz De Rio', 'Boyacá', 'Municipio', 'BOY_PAZ', '15537', '15', '', 'DIVIPOLA'),
(407, 20, 'Pesca', 'Boyacá', 'Municipio', 'BOY_PES', '15542', '15', '', 'DIVIPOLA'),
(410, 20, 'Pisba', 'Boyacá', 'Municipio', 'BOY_PIS', '15550', '15', '', 'DIVIPOLA'),
(413, 20, 'Puerto Boyaca', 'Boyacá', 'Municipio', 'BOY_PUE', '15572', '15', '', 'DIVIPOLA'),
(416, 20, 'Quipama', 'Boyacá', 'Municipio', 'BOY_QUI', '15580', '15', '', 'DIVIPOLA'),
(419, 20, 'Ramiriqui', 'Boyacá', 'Municipio', 'BOY_RAM', '15599', '15', '', 'DIVIPOLA'),
(422, 20, 'Raquira', 'Boyacá', 'Municipio', 'BOY_RAQ', '15600', '15', '', 'DIVIPOLA'),
(425, 20, 'Rondon', 'Boyacá', 'Municipio', 'BOY_RON', '15621', '15', '', 'DIVIPOLA'),
(428, 20, 'Saboya', 'Boyacá', 'Municipio', 'BOY_SAB', '15632', '15', '', 'DIVIPOLA'),
(431, 20, 'Sachica', 'Boyacá', 'Municipio', 'BOY_SAC', '15638', '15', '', 'DIVIPOLA'),
(434, 20, 'Samaca', 'Boyacá', 'Municipio', 'BOY_SAM', '15646', '15', '', 'DIVIPOLA'),
(437, 20, 'Guacamayas', 'Boyacá', 'Municipio', 'BOY_GUY', '15317', '15', '', 'DIVIPOLA'),
(440, 20, 'Siachoque', 'Boyacá', 'Municipio', 'BOY_SIA', '15740', '15', '', 'DIVIPOLA'),
(443, 20, 'Soata', 'Boyacá', 'Municipio', 'BOY_SOA', '15753', '15', '', 'DIVIPOLA'),
(446, 20, 'Sogamoso', 'Boyacá', 'Municipio', 'BOY_SOG', '15759', '15', '', 'DIVIPOLA'),
(449, 20, 'Somondoco', 'Boyacá', 'Municipio', 'BOY_SOM', '15761', '15', '', 'DIVIPOLA'),
(452, 20, 'Sotaquira', 'Boyacá', 'Municipio', 'BOY_SOT', '15763', '15', '', 'DIVIPOLA'),
(455, 20, 'Susacon', 'Boyacá', 'Municipio', 'BOY_SUS', '15774', '15', '', 'DIVIPOLA'),
(458, 20, 'Tasco', 'Boyacá', 'Municipio', 'BOY_TAS', '15790', '15', '', 'DIVIPOLA'),
(461, 20, 'Tenza', 'Boyacá', 'Municipio', 'BOY_TEN', '15798', '15', '', 'DIVIPOLA'),
(464, 20, 'Tinjaca', 'Boyacá', 'Municipio', 'BOY_TIN', '15808', '15', '', 'DIVIPOLA'),
(467, 20, 'Tipacoque', 'Boyacá', 'Municipio', 'BOY_TIP', '15810', '15', '', 'DIVIPOLA'),
(470, 20, 'Toca', 'Boyacá', 'Municipio', 'BOY_TOC', '15814', '15', '', 'DIVIPOLA'),
(473, 20, 'Togui', 'Boyacá', 'Municipio', 'BOY_TOG', '15816', '15', '', 'DIVIPOLA'),
(476, 20, 'Topaga', 'Boyacá', 'Municipio', 'BOY_TOP', '15820', '15', '', 'DIVIPOLA'),
(479, 20, 'Tota', 'Boyacá', 'Municipio', 'BOY_TOT', '15822', '15', '', 'DIVIPOLA'),
(482, 20, 'Turmeque', 'Boyacá', 'Municipio', 'BOY_TUR', '15835', '15', '', 'DIVIPOLA'),
(485, 20, 'Umbita', 'Boyacá', 'Municipio', 'BOY_UMB', '15842', '15', '', 'DIVIPOLA'),
(488, 20, 'Ventaquemada', 'Boyacá', 'Municipio', 'BOY_VEN', '15861', '15', '', 'DIVIPOLA'),
(491, 20, 'Villa De Leyva', 'Boyacá', 'Municipio', 'BOY_VIL', '15407', '15', '', 'DIVIPOLA'),
(494, 20, 'Viracacha', 'Boyacá', 'Municipio', 'BOY_VIR', '15879', '15', '', 'DIVIPOLA'),
(497, 20, 'Zetaquira', 'Boyacá', 'Municipio', 'BOY_ZET', '15897', '15', '', 'DIVIPOLA'),
(500, 20, 'Guateque', 'Boyacá', 'Municipio', 'BOY_GUQ', '15322', '15', '', 'DIVIPOLA'),
(503, 20, 'Guayata', 'Boyacá', 'Municipio', 'BOY_GUA', '15325', '15', '', 'DIVIPOLA'),
(506, 20, 'La Capilla', 'Boyacá', 'Municipio', 'BOY_CAP', '15380', '15', '', 'DIVIPOLA'),
(509, 20, 'La Uvita', 'Boyacá', 'Municipio', 'BOY_UVI', '15403', '15', '', 'DIVIPOLA'),
(512, 20, 'La Victoria', 'Boyacá', 'Municipio', 'BOY_VIC', '15401', '15', '', 'DIVIPOLA'),
(515, 20, 'Mongua', 'Boyacá', 'Municipio', 'BOY_MON', '15464', '15', '', 'DIVIPOLA'),
(518, 20, 'Mongui', 'Boyacá', 'Municipio', 'BOY_MOG', '15466', '15', '', 'DIVIPOLA'),
(521, 20, 'Moniquira', 'Boyacá', 'Municipio', 'BOY_MOQ', '15469', '15', '', 'DIVIPOLA'),
(524, 20, 'San Eduardo', 'Boyacá', 'Municipio', 'BOY_EDU', '15660', '15', '', 'DIVIPOLA'),
(527, 20, 'San Jose De Pare', 'Boyacá', 'Municipio', 'BOY_JOS', '15664', '15', '', 'DIVIPOLA'),
(530, 20, 'San Mateo', 'Boyacá', 'Municipio', 'BOY_MAT', '15673', '15', '', 'DIVIPOLA'),
(533, 20, 'San Miguel De Sema', 'Boyacá', 'Municipio', 'BOY_MIG', '15676', '15', '', 'DIVIPOLA'),
(536, 20, 'San Pablo Borbur', 'Boyacá', 'Municipio', 'BOY_PAB', '15681', '15', '', 'DIVIPOLA'),
(539, 20, 'Maripi', 'Boyacá', 'Municipio', 'BOY_MAI', '15442', '15', '', 'DIVIPOLA'),
(542, 20, 'Santa Maria', 'Boyacá', 'Municipio', 'BOY_MAR', '15690', '15', '', 'DIVIPOLA'),
(545, 20, 'San Rosa Viterbo', 'Boyacá', 'Municipio', 'BOY_ROS', '15693', '15', '', 'DIVIPOLA'),
(548, 20, 'San Luis De Gaceno', 'Boyacá', 'Municipio', 'BOY_LUI', '15667', '15', '', 'DIVIPOLA'),
(551, 20, 'Santana', 'Boyacá', 'Municipio', 'BOY_SAN', '15686', '15', '', 'DIVIPOLA'),
(554, 20, 'Sativanorte', 'Boyacá', 'Municipio', 'BOY_SAI', '15720', '15', '', 'DIVIPOLA'),
(557, 20, 'Sativasur', 'Boyacá', 'Municipio', 'BOY_SAT', '15723', '15', '', 'DIVIPOLA'),
(560, 20, 'Socha', 'Boyacá', 'Municipio', 'BOY_SOH', '15757', '15', '', 'DIVIPOLA'),
(563, 20, 'Socota', 'Boyacá', 'Municipio', 'BOY_SOC', '15755', '15', '', 'DIVIPOLA'),
(566, 20, 'Sora', 'Boyacá', 'Municipio', 'BOY_SOR', '15762', '15', '', 'DIVIPOLA'),
(569, 20, 'Santa Sofia', 'Boyacá', 'Municipio', 'BOY_SOF', '15696', '15', '', 'DIVIPOLA'),
(572, 20, 'Soraca', 'Boyacá', 'Municipio', 'BOY_ORA', '15764', '15', '', 'DIVIPOLA'),
(575, 20, 'Sutamarchan', 'Boyacá', 'Municipio', 'BOY_SUM', '15776', '15', '', 'DIVIPOLA'),
(578, 20, 'Sutatenza', 'Boyacá', 'Municipio', 'BOY_SUT', '15778', '15', '', 'DIVIPOLA'),
(581, 20, 'Tibana', 'Boyacá', 'Municipio', 'BOY_TIB', '15804', '15', '', 'DIVIPOLA'),
(584, 20, 'Tibasosa', 'Boyacá', 'Municipio', 'BOY_TIS', '15806', '15', '', 'DIVIPOLA'),
(587, 20, 'Tunja', 'Boyacá', 'Municipio', 'BOY_TUN', '15001', '15', '', 'DIVIPOLA'),
(590, 20, 'Tunungua', 'Boyacá', 'Municipio', 'BOY_TUU', '15832', '15', '', 'DIVIPOLA'),
(593, 20, 'Tuta', 'Boyacá', 'Municipio', 'BOY_TUA', '15837', '15', '', 'DIVIPOLA'),
(596, 20, 'Tutaza', 'Boyacá', 'Municipio', 'BOY_TUT', '15839', '15', '', 'DIVIPOLA'),
(599, 21, 'Aguadas', 'Caldas', 'Municipio', 'CAL_AGU', '17013', '17', '', 'DIVIPOLA'),
(606, 21, 'Anserma', 'Caldas', 'Municipio', 'CAL_ANS', '17042', '17', '', 'DIVIPOLA'),
(613, 21, 'Aranzazu', 'Caldas', 'Municipio', 'CAL_ARA', '17050', '17', '', 'DIVIPOLA'),
(620, 21, 'Belalcazar', 'Caldas', 'Municipio', 'CAL_BEL', '17088', '17', '', 'DIVIPOLA'),
(627, 21, 'Chinchina', 'Caldas', 'Municipio', 'CAL_CHI', '17174', '17', '', 'DIVIPOLA'),
(634, 21, 'Filadelfia', 'Caldas', 'Municipio', 'CAL_FIL', '17272', '17', '', 'DIVIPOLA'),
(641, 21, 'Neira', 'Caldas', 'Municipio', 'CAL_NEI', '17486', '17', '', 'DIVIPOLA'),
(648, 21, 'Norcasia', 'Caldas', 'Municipio', 'CAL_NOR', '17495', '17', '', 'DIVIPOLA'),
(655, 21, 'Pacora', 'Caldas', 'Municipio', 'CAL_PAC', '17513', '17', '', 'DIVIPOLA'),
(662, 21, 'Palestina', 'Caldas', 'Municipio', 'CAL_PAL', '17524', '17', '', 'DIVIPOLA'),
(669, 21, 'Pensilvania', 'Caldas', 'Municipio', 'CAL_PEN', '17541', '17', '', 'DIVIPOLA'),
(676, 21, 'Riosucio', 'Caldas', 'Municipio', 'CAL_RIO', '17614', '17', '', 'DIVIPOLA'),
(683, 21, 'Risaralda', 'Caldas', 'Municipio', 'CAL_RIS', '17616', '17', '', 'DIVIPOLA'),
(690, 21, 'Salamina', 'Caldas', 'Municipio', 'CAL_SAL', '17653', '17', '', 'DIVIPOLA'),
(697, 21, 'Samana', 'Caldas', 'Municipio', 'CAL_SAM', '17662', '17', '', 'DIVIPOLA'),
(704, 21, 'San Jose', 'Caldas', 'Municipio', 'CAL_SAN', '17665', '17', '', 'DIVIPOLA'),
(711, 21, 'Supia', 'Caldas', 'Municipio', 'CAL_SUP', '17777', '17', '', 'DIVIPOLA'),
(718, 21, 'Victoria', 'Caldas', 'Municipio', 'CAL_VIC', '17867', '17', '', 'DIVIPOLA'),
(725, 21, 'Villamaria', 'Caldas', 'Municipio', 'CAL_VIL', '17873', '17', '', 'DIVIPOLA'),
(732, 21, 'Viterbo', 'Caldas', 'Municipio', 'CAL_VIT', '17877', '17', '', 'DIVIPOLA'),
(739, 21, 'La Dorada', 'Caldas', 'Municipio', 'CAL_DOR', '17380', '17', '', 'DIVIPOLA'),
(746, 21, 'La Merced', 'Caldas', 'Municipio', 'CAL_MER', '17388', '17', '', 'DIVIPOLA'),
(753, 21, 'Manizales', 'Caldas', 'Municipio', 'CAL_MAN', '17001', '17', '', 'DIVIPOLA'),
(760, 21, 'Manzanares', 'Caldas', 'Municipio', 'CAL_MAZ', '17433', '17', '', 'DIVIPOLA'),
(767, 21, 'Marmato', 'Caldas', 'Municipio', 'CAL_MAM', '17442', '17', '', 'DIVIPOLA'),
(774, 21, 'Marquetalia', 'Caldas', 'Municipio', 'CAL_MAQ', '17444', '17', '', 'DIVIPOLA'),
(781, 21, 'Marulanda', 'Caldas', 'Municipio', 'CAL_MAR', '17446', '17', '', 'DIVIPOLA'),
(788, 22, 'El Doncello', 'Caquetá', 'Municipio', 'CAQ_ELD', '18247', '18', '', 'DIVIPOLA'),
(789, 22, 'El Paujil', 'Caquetá', 'Municipio', 'CAQ_ELP', '18256', '18', '', 'DIVIPOLA'),
(790, 22, 'Albania', 'Caquetá', 'Municipio', 'CAQ_ALB', '18029', '18', '', 'DIVIPOLA'),
(791, 22, 'Belen De Los Andaquies', 'Caquetá', 'Municipio', 'CAQ_BEL', '18094', '18', '', 'DIVIPOLA'),
(792, 22, 'Cartagena Del Chaira', 'Caquetá', 'Municipio', 'CAQ_CAR', '18150', '18', '', 'DIVIPOLA'),
(793, 22, 'Currillo', 'Caquetá', 'Municipio', 'CAQ_CUR', '18205', '18', '', 'DIVIPOLA'),
(794, 22, 'Florencia', 'Caquetá', 'Municipio', 'CAQ_FLO', '18001', '18', '', 'DIVIPOLA'),
(795, 22, 'La Montañita', 'Caquetá', 'Municipio', 'CAQ_LA ', '18410', '18', '', 'DIVIPOLA'),
(796, 22, 'Milan', 'Caquetá', 'Municipio', 'CAQ_MIL', '18460', '18', '', 'DIVIPOLA'),
(797, 22, 'Morelia', 'Caquetá', 'Municipio', 'CAQ_MOR', '18479', '18', '', 'DIVIPOLA'),
(798, 22, 'Puerto Rico', 'Caquetá', 'Municipio', 'CAQ_PUE', '18592', '18', '', 'DIVIPOLA'),
(799, 22, 'Valparaiso', 'Caquetá', 'Municipio', 'CAQ_VAL', '18860', '18', '', 'DIVIPOLA'),
(800, 22, 'San Jose Del Fragua', 'Caquetá', 'Municipio', 'CAQ_JOS', '18610', '18', '', 'DIVIPOLA'),
(801, 22, 'San Vicente Del Caguan', 'Caquetá', 'Municipio', 'CAQ_SAN', '18753', '18', '', 'DIVIPOLA'),
(802, 22, 'Solano', 'Caquetá', 'Municipio', 'CAQ_SOL', '18756', '18', '', 'DIVIPOLA'),
(803, 22, 'Solita', 'Caquetá', 'Municipio', 'CAQ_SOI', '18785', '18', '', 'DIVIPOLA'),
(804, 23, 'Aguazul', 'Casanare', 'Municipio', 'CAS_AGU', '85010', '85', '', 'DIVIPOLA'),
(805, 23, 'Chameza', 'Casanare', 'Municipio', 'CAS_CHA', '85015', '85', '', 'DIVIPOLA'),
(806, 23, 'Hato Corozal', 'Casanare', 'Municipio', 'CAS_HAT', '85125', '85', '', 'DIVIPOLA'),
(807, 23, 'La Salina', 'Casanare', 'Municipio', 'CAS_LA ', '85136', '85', '', 'DIVIPOLA'),
(808, 23, 'Mani', 'Casanare', 'Municipio', 'CAS_MAN', '85139', '85', '', 'DIVIPOLA'),
(809, 23, 'Monterrey', 'Casanare', 'Municipio', 'CAS_MON', '85162', '85', '', 'DIVIPOLA'),
(810, 23, 'Nunchia', 'Casanare', 'Municipio', 'CAS_NUN', '85225', '85', '', 'DIVIPOLA'),
(811, 23, 'Orocue', 'Casanare', 'Municipio', 'CAS_ORO', '85230', '85', '', 'DIVIPOLA'),
(812, 23, 'Paz De Ariporo', 'Casanare', 'Municipio', 'CAS_PAZ', '85250', '85', '', 'DIVIPOLA'),
(813, 23, 'Pore', 'Casanare', 'Municipio', 'CAS_POR', '85263', '85', '', 'DIVIPOLA'),
(814, 23, 'Recetor', 'Casanare', 'Municipio', 'CAS_REC', '85279', '85', '', 'DIVIPOLA'),
(815, 23, 'Sabanalarga', 'Casanare', 'Municipio', 'CAS_SAB', '85300', '85', '', 'DIVIPOLA'),
(816, 23, 'Sacama', 'Casanare', 'Municipio', 'CAS_SAC', '85315', '85', '', 'DIVIPOLA'),
(817, 23, 'San Luis De Palenque', 'Casanare', 'Municipio', 'CAS_SAN', '85325', '85', '', 'DIVIPOLA'),
(818, 23, 'Tamara', 'Casanare', 'Municipio', 'CAS_TAM', '85400', '85', '', 'DIVIPOLA'),
(819, 23, 'Tauramena', 'Casanare', 'Municipio', 'CAS_TAU', '85410', '85', '', 'DIVIPOLA'),
(820, 23, 'Trinidad', 'Casanare', 'Municipio', 'CAS_TRI', '85430', '85', '', 'DIVIPOLA'),
(821, 23, 'Villanueva', 'Casanare', 'Municipio', 'CAS_VIL', '85440', '85', '', 'DIVIPOLA'),
(822, 23, 'Yopal', 'Casanare', 'Municipio', 'CAS_YOP', '85001', '85', '', 'DIVIPOLA'),
(823, 24, 'Caldono', 'Cauca', 'Municipio', 'CAU_CAD', '19137', '19', '', 'DIVIPOLA'),
(824, 24, 'Caloto', 'Cauca', 'Municipio', 'CAU_CAL', '19142', '19', '', 'DIVIPOLA'),
(825, 24, 'Guachene', 'Cauca', 'Municipio', 'CAU_GUC', '19300', '19', '', 'DIVIPOLA'),
(826, 24, 'Guapi', 'Cauca', 'Municipio', 'CAU_GUA', '19318', '19', '', 'DIVIPOLA'),
(827, 24, 'Almaguer', 'Cauca', 'Municipio', 'CAU_ALM', '19022', '19', '', 'DIVIPOLA'),
(828, 24, 'Argelia', 'Cauca', 'Municipio', 'CAU_ARG', '19050', '19', '', 'DIVIPOLA'),
(829, 24, 'Balboa', 'Cauca', 'Municipio', 'CAU_BAL', '19075', '19', '', 'DIVIPOLA'),
(830, 24, 'Bolivar', 'Cauca', 'Municipio', 'CAU_BOL', '19100', '19', '', 'DIVIPOLA'),
(831, 24, 'Buenos Aires', 'Cauca', 'Municipio', 'CAU_BUE', '19110', '19', '', 'DIVIPOLA'),
(832, 24, 'Cajibio', 'Cauca', 'Municipio', 'CAU_CAJ', '19130', '19', '', 'DIVIPOLA'),
(833, 24, 'Corinto', 'Cauca', 'Municipio', 'CAU_COR', '19212', '19', '', 'DIVIPOLA'),
(834, 24, 'El Tambo', 'Cauca', 'Municipio', 'CAU_EL ', '19256', '19', '', 'DIVIPOLA'),
(835, 24, 'Florencia', 'Cauca', 'Municipio', 'CAU_FLO', '19290', '19', '', 'DIVIPOLA'),
(836, 24, 'Inza', 'Cauca', 'Municipio', 'CAU_INZ', '19355', '19', '', 'DIVIPOLA'),
(837, 24, 'Jambalo', 'Cauca', 'Municipio', 'CAU_JAM', '19364', '19', '', 'DIVIPOLA'),
(838, 24, 'Lopez', 'Cauca', 'Municipio', 'CAU_LOP', '19418', '19', '', 'DIVIPOLA'),
(839, 24, 'Mercaderes', 'Cauca', 'Municipio', 'CAU_MER', '19450', '19', '', 'DIVIPOLA'),
(840, 24, 'Miranda', 'Cauca', 'Municipio', 'CAU_MIR', '19455', '19', '', 'DIVIPOLA'),
(841, 24, 'Morales', 'Cauca', 'Municipio', 'CAU_MOR', '19473', '19', '', 'DIVIPOLA'),
(842, 24, 'Padilla', 'Cauca', 'Municipio', 'CAU_PAD', '19513', '19', '', 'DIVIPOLA'),
(843, 24, 'Paez', 'Cauca', 'Municipio', 'CAU_PAE', '19517', '19', '', 'DIVIPOLA'),
(844, 24, 'Patia', 'Cauca', 'Municipio', 'CAU_PAT', '19532', '19', '', 'DIVIPOLA'),
(845, 24, 'Piamonte', 'Cauca', 'Municipio', 'CAU_PIA', '19533', '19', '', 'DIVIPOLA'),
(846, 24, 'Piendamo', 'Cauca', 'Municipio', 'CAU_PIE', '19548', '19', '', 'DIVIPOLA'),
(847, 24, 'Popayan', 'Cauca', 'Municipio', 'CAU_POP', '19001', '19', '', 'DIVIPOLA'),
(848, 24, 'Puerto Tejada', 'Cauca', 'Municipio', 'CAU_PUE', '19573', '19', '', 'DIVIPOLA'),
(849, 24, 'Purace', 'Cauca', 'Municipio', 'CAU_PUR', '19585', '19', '', 'DIVIPOLA'),
(850, 24, 'Silvia', 'Cauca', 'Municipio', 'CAU_SIL', '19743', '19', '', 'DIVIPOLA'),
(851, 24, 'Sotara', 'Cauca', 'Municipio', 'CAU_SOT', '19760', '19', '', 'DIVIPOLA'),
(852, 24, 'Suarez', 'Cauca', 'Municipio', 'CAU_SUA', '19780', '19', '', 'DIVIPOLA'),
(853, 24, 'Sucre', 'Cauca', 'Municipio', 'CAU_SUC', '19785', '19', '', 'DIVIPOLA'),
(854, 24, 'Toribio', 'Cauca', 'Municipio', 'CAU_TOR', '19821', '19', '', 'DIVIPOLA'),
(855, 24, 'Totoro', 'Cauca', 'Municipio', 'CAU_TOT', '19824', '19', '', 'DIVIPOLA'),
(856, 24, 'Villa Rica', 'Cauca', 'Municipio', 'CAU_VIL', '19845', '19', '', 'DIVIPOLA'),
(857, 24, 'La Sierra', 'Cauca', 'Municipio', 'CAU_SIE', '19392', '19', '', 'DIVIPOLA'),
(858, 24, 'La Vega', 'Cauca', 'Municipio', 'CAU_VEG', '19397', '19', '', 'DIVIPOLA'),
(859, 24, 'San Sebastian', 'Cauca', 'Municipio', 'CAU_SEB', '19693', '19', '', 'DIVIPOLA'),
(860, 24, 'Santander De Quilichao', 'Cauca', 'Municipio', 'CAU_SAN', '19698', '19', '', 'DIVIPOLA'),
(861, 24, 'Rosas', 'Cauca', 'Municipio', 'CAU_ROA', '19622', '19', '', 'DIVIPOLA'),
(862, 24, 'Santa Rosa', 'Cauca', 'Municipio', 'CAU_ROS', '19701', '19', '', 'DIVIPOLA'),
(863, 24, 'Timbio', 'Cauca', 'Municipio', 'CAU_TIM', '19807', '19', '', 'DIVIPOLA'),
(864, 24, 'Timbiqui', 'Cauca', 'Municipio', 'CAU_TIQ', '19809', '19', '', 'DIVIPOLA'),
(865, 25, 'Aguachica', 'Cesar', 'Municipio', 'CES_ACH', '20011', '20', '', 'DIVIPOLA'),
(866, 25, 'Agustin Codazzi', 'Cesar', 'Municipio', 'CES_AGU', '20013', '20', '', 'DIVIPOLA'),
(867, 25, 'Chimichagua', 'Cesar', 'Municipio', 'CES_CHM', '20175', '20', '', 'DIVIPOLA'),
(868, 25, 'Chiriguana', 'Cesar', 'Municipio', 'CES_CHI', '20178', '20', '', 'DIVIPOLA'),
(869, 25, 'El Copey', 'Cesar', 'Municipio', 'CES_ELC', '20238', '20', '', 'DIVIPOLA'),
(870, 25, 'El Paso', 'Cesar', 'Municipio', 'CES_ELP', '20250', '20', '', 'DIVIPOLA'),
(871, 25, 'La Gloria', 'Cesar', 'Municipio', 'CES_GLO', '20383', '20', '', 'DIVIPOLA'),
(872, 25, 'La Jagua De Ibirico', 'Cesar', 'Municipio', 'CES_JAG', '20400', '20', '', 'DIVIPOLA'),
(873, 25, 'Astrea', 'Cesar', 'Municipio', 'CES_AST', '20032', '20', '', 'DIVIPOLA'),
(874, 25, 'Becerril', 'Cesar', 'Municipio', 'CES_BEC', '20045', '20', '', 'DIVIPOLA'),
(875, 25, 'Bosconia', 'Cesar', 'Municipio', 'CES_BOS', '20060', '20', '', 'DIVIPOLA'),
(876, 25, 'La Paz', 'Cesar', 'Municipio', 'CES_PAZ', '20621', '20', '', 'DIVIPOLA'),
(877, 25, 'Curumani', 'Cesar', 'Municipio', 'CES_CUR', '20228', '20', '', 'DIVIPOLA'),
(878, 25, 'Gamarra', 'Cesar', 'Municipio', 'CES_GAM', '20295', '20', '', 'DIVIPOLA'),
(879, 25, 'Gonzalez', 'Cesar', 'Municipio', 'CES_GON', '20310', '20', '', 'DIVIPOLA'),
(880, 25, 'Manaure', 'Cesar', 'Municipio', 'CES_MAN', '20443', '20', '', 'DIVIPOLA'),
(881, 25, 'Pailitas', 'Cesar', 'Municipio', 'CES_PAI', '20517', '20', '', 'DIVIPOLA'),
(882, 25, 'Pelaya', 'Cesar', 'Municipio', 'CES_PEL', '20550', '20', '', 'DIVIPOLA'),
(883, 25, 'Pueblo Bello', 'Cesar', 'Municipio', 'CES_PUE', '20570', '20', '', 'DIVIPOLA'),
(884, 25, 'Rio De Oro', 'Cesar', 'Municipio', 'CES_RIO', '20614', '20', '', 'DIVIPOLA'),
(885, 25, 'Tamalameque', 'Cesar', 'Municipio', 'CES_TAM', '20787', '20', '', 'DIVIPOLA'),
(886, 25, 'Valledupar', 'Cesar', 'Municipio', 'CES_VAL', '20001', '20', '', 'DIVIPOLA'),
(887, 25, 'San Alberto', 'Cesar', 'Municipio', 'CES_ALB', '20710', '20', '', 'DIVIPOLA'),
(888, 25, 'San Diego', 'Cesar', 'Municipio', 'CES_DIE', '20750', '20', '', 'DIVIPOLA'),
(889, 25, 'San Martin', 'Cesar', 'Municipio', 'CES_SAN', '20770', '20', '', 'DIVIPOLA'),
(890, 26, 'El Carmen De Atrato', 'Chocó', 'Municipio', 'CHO_EAT', '27245', '27', '', 'DIVIPOLA'),
(891, 26, 'El Litoral Del San Juan', 'Chocó', 'Municipio', 'CHO_ELL', '27250', '27', '', 'DIVIPOLA'),
(892, 26, 'Acandi', 'Chocó', 'Municipio', 'CHO_ACA', '27006', '27', '', 'DIVIPOLA'),
(893, 26, 'Alto Baudo', 'Chocó', 'Municipio', 'CHO_ALT', '27025', '27', '', 'DIVIPOLA'),
(894, 26, 'Bagado', 'Chocó', 'Municipio', 'CHO_BAG', '27073', '27', '', 'DIVIPOLA'),
(895, 26, 'Bahia Solano', 'Chocó', 'Municipio', 'CHO_BAH', '27075', '27', '', 'DIVIPOLA'),
(896, 26, 'Bajo Baudo', 'Chocó', 'Municipio', 'CHO_BAJ', '27077', '27', '', 'DIVIPOLA'),
(897, 26, 'Bojaya', 'Chocó', 'Municipio', 'CHO_BOJ', '27099', '27', '', 'DIVIPOLA'),
(898, 26, 'Canton De San Pablo', 'Chocó', 'Municipio', 'CHO_CAN', '27135', '27', '', 'DIVIPOLA'),
(899, 26, 'Carmen Del Darien', 'Chocó', 'Municipio', 'CHO_CAR', '27150', '27', '', 'DIVIPOLA'),
(900, 26, 'Certegui', 'Chocó', 'Municipio', 'CHO_CER', '27160', '27', '', 'DIVIPOLA'),
(901, 26, 'Condoto', 'Chocó', 'Municipio', 'CHO_CON', '27205', '27', '', 'DIVIPOLA'),
(902, 26, 'Itsmina', 'Chocó', 'Municipio', 'CHO_ITS', '27361', '27', '', 'DIVIPOLA'),
(903, 26, 'Jurado', 'Chocó', 'Municipio', 'CHO_JUR', '27372', '27', '', 'DIVIPOLA'),
(904, 26, 'Lloro', 'Chocó', 'Municipio', 'CHO_LLO', '27413', '27', '', 'DIVIPOLA'),
(905, 26, 'Novita', 'Chocó', 'Municipio', 'CHO_NOV', '27491', '27', '', 'DIVIPOLA'),
(906, 26, 'Nuqui', 'Chocó', 'Municipio', 'CHO_NUQ', '27495', '27', '', 'DIVIPOLA'),
(907, 26, 'Quibdo', 'Chocó', 'Municipio', 'CHO_QUI', '27001', '27', '', 'DIVIPOLA'),
(908, 26, 'San Jose Del Palmar', 'Chocó', 'Municipio', 'CHO_SAN', '27660', '27', '', 'DIVIPOLA'),
(909, 26, 'Sipi', 'Chocó', 'Municipio', 'CHO_SIP', '27745', '27', '', 'DIVIPOLA'),
(910, 26, 'Tado', 'Chocó', 'Municipio', 'CHO_TAD', '27787', '27', '', 'DIVIPOLA'),
(911, 26, 'Unguia', 'Chocó', 'Municipio', 'CHO_UNG', '27800', '27', '', 'DIVIPOLA'),
(912, 26, 'Union Panamericana', 'Chocó', 'Municipio', 'CHO_UNI', '27810', '27', '', 'DIVIPOLA'),
(913, 26, 'Medio Baudó', 'Chocó', 'Municipio', 'CHO_BAU', '27430', '27', '', 'DIVIPOLA'),
(914, 26, 'Medio San Juan', 'Chocó', 'Municipio', 'CHO_MED', '27450', '27', '', 'DIVIPOLA'),
(915, 26, 'Rio Iro', 'Chocó', 'Municipio', 'CHO_IRO', '27580', '27', '', 'DIVIPOLA'),
(916, 26, 'Rio Quito', 'Chocó', 'Municipio', 'CHO_QUT', '27600', '27', '', 'DIVIPOLA'),
(917, 26, 'Riosucio', 'Chocó', 'Municipio', 'CHO_RIO', '27615', '27', '', 'DIVIPOLA'),
(918, 26, 'Atrato', 'Chocó', 'Municipio', 'CHO_ATR', '27050', '27', '', 'DIVIPOLA'),
(919, 26, 'Medio Atrato', 'Chocó', 'Municipio', 'CHO_MEI', '27425', '27', '', 'DIVIPOLA'),
(920, 27, 'Chima', 'Córdoba', 'Municipio', 'CÓR_CHM', '23168', '23', '', 'DIVIPOLA'),
(923, 27, 'Chinu', 'Córdoba', 'Municipio', 'CÓR_CHI', '23182', '23', '', 'DIVIPOLA'),
(926, 27, 'Ayapel', 'Córdoba', 'Municipio', 'CÓR_AYA', '23068', '23', '', 'DIVIPOLA'),
(929, 27, 'Buenavista', 'Córdoba', 'Municipio', 'CÓR_BUE', '23079', '23', '', 'DIVIPOLA'),
(932, 27, 'Canalete', 'Córdoba', 'Municipio', 'CÓR_CAN', '23090', '23', '', 'DIVIPOLA'),
(935, 27, 'Cerete', 'Córdoba', 'Municipio', 'CÓR_CER', '23162', '23', '', 'DIVIPOLA'),
(938, 27, 'Cienaga De Oro', 'Córdoba', 'Municipio', 'CÓR_CIE', '23189', '23', '', 'DIVIPOLA'),
(941, 27, 'Cotorra', 'Córdoba', 'Municipio', 'CÓR_COT', '23300', '23', '', 'DIVIPOLA'),
(944, 27, 'La Apartada', 'Córdoba', 'Municipio', 'CÓR_LA ', '23350', '23', '', 'DIVIPOLA'),
(947, 27, 'Lorica', 'Córdoba', 'Municipio', 'CÓR_LOR', '23417', '23', '', 'DIVIPOLA'),
(950, 27, 'Los Cordobas', 'Córdoba', 'Municipio', 'CÓR_LOS', '23419', '23', '', 'DIVIPOLA'),
(953, 27, 'Momil', 'Córdoba', 'Municipio', 'CÓR_MOM', '23464', '23', '', 'DIVIPOLA'),
(956, 27, 'Moñitos', 'Córdoba', 'Municipio', 'CÓR_MOÑ', '23500', '23', '', 'DIVIPOLA'),
(959, 27, 'Planeta Rica', 'Córdoba', 'Municipio', 'CÓR_PLA', '23555', '23', '', 'DIVIPOLA'),
(962, 27, 'Purisima', 'Córdoba', 'Municipio', 'CÓR_PUR', '23586', '23', '', 'DIVIPOLA'),
(965, 27, 'Sahagun', 'Córdoba', 'Municipio', 'CÓR_SAH', '23660', '23', '', 'DIVIPOLA'),
(968, 27, 'Tierralta', 'Córdoba', 'Municipio', 'CÓR_TIE', '23807', '23', '', 'DIVIPOLA'),
(971, 27, 'Tuchin', 'Córdoba', 'Municipio', 'CÓR_TUC', '23815', '23', '', 'DIVIPOLA'),
(974, 27, 'Valencia', 'Córdoba', 'Municipio', 'CÓR_VAL', '23855', '23', '', 'DIVIPOLA'),
(977, 27, 'Montelibano', 'Córdoba', 'Municipio', 'CÓR_MOT', '23466', '23', '', 'DIVIPOLA'),
(980, 27, 'Monteria', 'Córdoba', 'Municipio', 'CÓR_MON', '23001', '23', '', 'DIVIPOLA'),
(983, 27, 'Pueblo Nuevo', 'Córdoba', 'Municipio', 'CÓR_PUB', '23570', '23', '', 'DIVIPOLA'),
(986, 27, 'Puerto Escondido', 'Córdoba', 'Municipio', 'CÓR_PUS', '23574', '23', '', 'DIVIPOLA'),
(989, 27, 'Puerto Libertador', 'Córdoba', 'Municipio', 'CÓR_PUE', '23580', '23', '', 'DIVIPOLA'),
(992, 27, 'San Andres Sotavento', 'Córdoba', 'Municipio', 'CÓR_AND', '23670', '23', '', 'DIVIPOLA'),
(995, 27, 'San Antero', 'Córdoba', 'Municipio', 'CÓR_ANT', '23672', '23', '', 'DIVIPOLA'),
(998, 27, 'San Bernardo Del Viento', 'Córdoba', 'Municipio', 'CÓR_BER', '23675', '23', '', 'DIVIPOLA'),
(1001, 27, 'San Carlos', 'Córdoba', 'Municipio', 'CÓR_CAR', '23678', '23', '', 'DIVIPOLA'),
(1004, 27, 'San Jose De Ure', 'Córdoba', 'Municipio', 'CÓR_JOS', '23682', '23', '', 'DIVIPOLA'),
(1007, 27, 'San Pelayo', 'Córdoba', 'Municipio', 'CÓR_SAN', '23686', '23', '', 'DIVIPOLA');
INSERT INTO `lut_codes` (`LUT_COD_ID`, `LUT_COD_PID`, `LUT_COD_NAME`, `LUT_COD_PNAME`, `LUT_COD_DESCRIPTION`, `LUT_COD_ABBREVIATION`, `LUT_COD_OTHER1`, `LUT_COD_OTHER2`, `LUT_COD_OTHER3`, `LUT_COD_TYPE`) VALUES
(1010, 28, 'Chia', 'Cundinamarca', 'Municipio', 'CUN_CHI', '25175', '25', '', 'DIVIPOLA'),
(1011, 28, 'Chipaque', 'Cundinamarca', 'Municipio', 'CUN_CHP', '25178', '25', '', 'DIVIPOLA'),
(1012, 28, 'Choachi', 'Cundinamarca', 'Municipio', 'CUN_CHC', '25181', '25', '', 'DIVIPOLA'),
(1013, 28, 'Choconta', 'Cundinamarca', 'Municipio', 'CUN_CHO', '25183', '25', '', 'DIVIPOLA'),
(1014, 28, 'El Colegio', 'Cundinamarca', 'Municipio', 'CUN_ELC', '25245', '25', '', 'DIVIPOLA'),
(1015, 28, 'El Peñon', 'Cundinamarca', 'Municipio', 'CUN_ELP', '25258', '25', '', 'DIVIPOLA'),
(1016, 28, 'El Rosal', 'Cundinamarca', 'Municipio', 'CUN_ELR', '25260', '25', '', 'DIVIPOLA'),
(1017, 28, 'Gachala', 'Cundinamarca', 'Municipio', 'CUN_GAC', '25293', '25', '', 'DIVIPOLA'),
(1018, 28, 'Gachancipa', 'Cundinamarca', 'Municipio', 'CUN_GAH', '25295', '25', '', 'DIVIPOLA'),
(1019, 28, 'Gacheta', 'Cundinamarca', 'Municipio', 'CUN_GAT', '25297', '25', '', 'DIVIPOLA'),
(1020, 28, 'Guacheta', 'Cundinamarca', 'Municipio', 'CUN_GUH', '25317', '25', '', 'DIVIPOLA'),
(1021, 28, 'Guaduas', 'Cundinamarca', 'Municipio', 'CUN_GUD', '25320', '25', '', 'DIVIPOLA'),
(1022, 28, 'Guasca', 'Cundinamarca', 'Municipio', 'CUN_GUS', '25322', '25', '', 'DIVIPOLA'),
(1023, 28, 'Guatavita', 'Cundinamarca', 'Municipio', 'CUN_GUV', '25326', '25', '', 'DIVIPOLA'),
(1024, 28, 'Guayabal De Siquima', 'Cundinamarca', 'Municipio', 'CUN_GUQ', '25328', '25', '', 'DIVIPOLA'),
(1025, 28, 'Guayabetal', 'Cundinamarca', 'Municipio', 'CUN_GUA', '25335', '25', '', 'DIVIPOLA'),
(1026, 28, 'La Calera', 'Cundinamarca', 'Municipio', 'CUN_CAL', '25377', '25', '', 'DIVIPOLA'),
(1027, 28, 'La Mesa', 'Cundinamarca', 'Municipio', 'CUN_MES', '25386', '25', '', 'DIVIPOLA'),
(1028, 28, 'La Palma', 'Cundinamarca', 'Municipio', 'CUN_PAL', '25394', '25', '', 'DIVIPOLA'),
(1029, 28, 'La Peña', 'Cundinamarca', 'Municipio', 'CUN_PEÑ', '25398', '25', '', 'DIVIPOLA'),
(1030, 28, 'La Vega', 'Cundinamarca', 'Municipio', 'CUN_VEG', '25402', '25', '', 'DIVIPOLA'),
(1031, 28, 'Agua De Dios', 'Cundinamarca', 'Municipio', 'CUN_AGU', '25001', '25', '', 'DIVIPOLA'),
(1032, 28, 'Alban', 'Cundinamarca', 'Municipio', 'CUN_ALB', '25019', '25', '', 'DIVIPOLA'),
(1033, 28, 'Anapoima', 'Cundinamarca', 'Municipio', 'CUN_ANA', '25035', '25', '', 'DIVIPOLA'),
(1034, 28, 'Anolaima', 'Cundinamarca', 'Municipio', 'CUN_ANO', '25040', '25', '', 'DIVIPOLA'),
(1035, 28, 'Apulo', 'Cundinamarca', 'Municipio', 'CUN_APU', '25599', '25', '', 'DIVIPOLA'),
(1036, 28, 'Arbelaez', 'Cundinamarca', 'Municipio', 'CUN_ARB', '25053', '25', '', 'DIVIPOLA'),
(1037, 28, 'Beltran', 'Cundinamarca', 'Municipio', 'CUN_BEL', '25086', '25', '', 'DIVIPOLA'),
(1038, 28, 'Bituima', 'Cundinamarca', 'Municipio', 'CUN_BIT', '25095', '25', '', 'DIVIPOLA'),
(1039, 28, 'Bojaca', 'Cundinamarca', 'Municipio', 'CUN_BOJ', '25099', '25', '', 'DIVIPOLA'),
(1040, 28, 'Cabrera', 'Cundinamarca', 'Municipio', 'CUN_CAB', '25120', '25', '', 'DIVIPOLA'),
(1041, 28, 'Cachipay', 'Cundinamarca', 'Municipio', 'CUN_CAC', '25123', '25', '', 'DIVIPOLA'),
(1042, 28, 'Cajica', 'Cundinamarca', 'Municipio', 'CUN_CAJ', '25126', '25', '', 'DIVIPOLA'),
(1043, 28, 'Caparrapi', 'Cundinamarca', 'Municipio', 'CUN_CAP', '25148', '25', '', 'DIVIPOLA'),
(1044, 28, 'Caqueza', 'Cundinamarca', 'Municipio', 'CUN_CAQ', '25151', '25', '', 'DIVIPOLA'),
(1045, 28, 'Carmen De Carupa', 'Cundinamarca', 'Municipio', 'CUN_CAR', '25154', '25', '', 'DIVIPOLA'),
(1046, 28, 'Chaguani', 'Cundinamarca', 'Municipio', 'CUN_CHA', '25168', '25', '', 'DIVIPOLA'),
(1047, 28, 'Cogua', 'Cundinamarca', 'Municipio', 'CUN_COG', '25200', '25', '', 'DIVIPOLA'),
(1048, 28, 'Cota', 'Cundinamarca', 'Municipio', 'CUN_COT', '25214', '25', '', 'DIVIPOLA'),
(1049, 28, 'Cucunuba', 'Cundinamarca', 'Municipio', 'CUN_CUC', '25224', '25', '', 'DIVIPOLA'),
(1050, 28, 'Facatativa', 'Cundinamarca', 'Municipio', 'CUN_FAC', '25269', '25', '', 'DIVIPOLA'),
(1051, 28, 'Fomeque', 'Cundinamarca', 'Municipio', 'CUN_FOM', '25279', '25', '', 'DIVIPOLA'),
(1052, 28, 'Fosca', 'Cundinamarca', 'Municipio', 'CUN_FOS', '25281', '25', '', 'DIVIPOLA'),
(1053, 28, 'Funza', 'Cundinamarca', 'Municipio', 'CUN_FUN', '25286', '25', '', 'DIVIPOLA'),
(1054, 28, 'Fuquene', 'Cundinamarca', 'Municipio', 'CUN_FUQ', '25288', '25', '', 'DIVIPOLA'),
(1055, 28, 'Fusagasuga', 'Cundinamarca', 'Municipio', 'CUN_FUS', '25290', '25', '', 'DIVIPOLA'),
(1056, 28, 'Gama', 'Cundinamarca', 'Municipio', 'CUN_GAM', '25299', '25', '', 'DIVIPOLA'),
(1057, 28, 'Girardot', 'Cundinamarca', 'Municipio', 'CUN_GIR', '25307', '25', '', 'DIVIPOLA'),
(1058, 28, 'Granada', 'Cundinamarca', 'Municipio', 'CUN_GRA', '25312', '25', '', 'DIVIPOLA'),
(1059, 28, 'Jerusalen', 'Cundinamarca', 'Municipio', 'CUN_JER', '25368', '25', '', 'DIVIPOLA'),
(1060, 28, 'Junin', 'Cundinamarca', 'Municipio', 'CUN_JUN', '25372', '25', '', 'DIVIPOLA'),
(1061, 28, 'Lenguazaque', 'Cundinamarca', 'Municipio', 'CUN_LEN', '25407', '25', '', 'DIVIPOLA'),
(1062, 28, 'Macheta', 'Cundinamarca', 'Municipio', 'CUN_MAC', '25426', '25', '', 'DIVIPOLA'),
(1063, 28, 'Madrid', 'Cundinamarca', 'Municipio', 'CUN_MAD', '25430', '25', '', 'DIVIPOLA'),
(1064, 28, 'Manta', 'Cundinamarca', 'Municipio', 'CUN_MAN', '25436', '25', '', 'DIVIPOLA'),
(1065, 28, 'Medina', 'Cundinamarca', 'Municipio', 'CUN_MED', '25438', '25', '', 'DIVIPOLA'),
(1066, 28, 'Mosquera', 'Cundinamarca', 'Municipio', 'CUN_MOS', '25473', '25', '', 'DIVIPOLA'),
(1067, 28, 'Nariño', 'Cundinamarca', 'Municipio', 'CUN_NAR', '25483', '25', '', 'DIVIPOLA'),
(1068, 28, 'Nemocon', 'Cundinamarca', 'Municipio', 'CUN_NEM', '25486', '25', '', 'DIVIPOLA'),
(1069, 28, 'Nilo', 'Cundinamarca', 'Municipio', 'CUN_NIL', '25488', '25', '', 'DIVIPOLA'),
(1070, 28, 'Nimaima', 'Cundinamarca', 'Municipio', 'CUN_NIM', '25489', '25', '', 'DIVIPOLA'),
(1071, 28, 'Nocaima', 'Cundinamarca', 'Municipio', 'CUN_NOC', '25491', '25', '', 'DIVIPOLA'),
(1072, 28, 'Pacho', 'Cundinamarca', 'Municipio', 'CUN_PAC', '25513', '25', '', 'DIVIPOLA'),
(1073, 28, 'Paime', 'Cundinamarca', 'Municipio', 'CUN_PAI', '25518', '25', '', 'DIVIPOLA'),
(1074, 28, 'Pandi', 'Cundinamarca', 'Municipio', 'CUN_PAN', '25524', '25', '', 'DIVIPOLA'),
(1075, 28, 'Paratebueno', 'Cundinamarca', 'Municipio', 'CUN_PAR', '25530', '25', '', 'DIVIPOLA'),
(1076, 28, 'Pasca', 'Cundinamarca', 'Municipio', 'CUN_PAS', '25535', '25', '', 'DIVIPOLA'),
(1077, 28, 'Puerto Salgar', 'Cundinamarca', 'Municipio', 'CUN_PUE', '25572', '25', '', 'DIVIPOLA'),
(1078, 28, 'Puli', 'Cundinamarca', 'Municipio', 'CUN_PUL', '25580', '25', '', 'DIVIPOLA'),
(1079, 28, 'Quipile', 'Cundinamarca', 'Municipio', 'CUN_QUI', '25596', '25', '', 'DIVIPOLA'),
(1080, 28, 'Ricaurte', 'Cundinamarca', 'Municipio', 'CUN_RIC', '25612', '25', '', 'DIVIPOLA'),
(1081, 28, 'Sasaima', 'Cundinamarca', 'Municipio', 'CUN_SAS', '25718', '25', '', 'DIVIPOLA'),
(1082, 28, 'Sesquile', 'Cundinamarca', 'Municipio', 'CUN_SES', '25736', '25', '', 'DIVIPOLA'),
(1083, 28, 'Sibate', 'Cundinamarca', 'Municipio', 'CUN_SIB', '25740', '25', '', 'DIVIPOLA'),
(1084, 28, 'Silvania', 'Cundinamarca', 'Municipio', 'CUN_SIL', '25743', '25', '', 'DIVIPOLA'),
(1085, 28, 'Simijaca', 'Cundinamarca', 'Municipio', 'CUN_SIM', '25745', '25', '', 'DIVIPOLA'),
(1086, 28, 'Soacha', 'Cundinamarca', 'Municipio', 'CUN_SOA', '25754', '25', '', 'DIVIPOLA'),
(1087, 28, 'Sopo', 'Cundinamarca', 'Municipio', 'CUN_SOP', '25758', '25', '', 'DIVIPOLA'),
(1088, 28, 'Subachoque', 'Cundinamarca', 'Municipio', 'CUN_SUB', '25769', '25', '', 'DIVIPOLA'),
(1089, 28, 'Suesca', 'Cundinamarca', 'Municipio', 'CUN_SUE', '25772', '25', '', 'DIVIPOLA'),
(1090, 28, 'Supata', 'Cundinamarca', 'Municipio', 'CUN_SUP', '25777', '25', '', 'DIVIPOLA'),
(1091, 28, 'Susa', 'Cundinamarca', 'Municipio', 'CUN_SUS', '25779', '25', '', 'DIVIPOLA'),
(1092, 28, 'Sutatausa', 'Cundinamarca', 'Municipio', 'CUN_SUT', '25781', '25', '', 'DIVIPOLA'),
(1093, 28, 'Tabio', 'Cundinamarca', 'Municipio', 'CUN_TAB', '25785', '25', '', 'DIVIPOLA'),
(1094, 28, 'Tausa', 'Cundinamarca', 'Municipio', 'CUN_TAU', '25793', '25', '', 'DIVIPOLA'),
(1095, 28, 'Quebradanegra', 'Cundinamarca', 'Municipio', 'CUN_QUB', '25592', '25', '', 'DIVIPOLA'),
(1096, 28, 'Quetame', 'Cundinamarca', 'Municipio', 'CUN_QUE', '25594', '25', '', 'DIVIPOLA'),
(1097, 28, 'Topaipi', 'Cundinamarca', 'Municipio', 'CUN_TOP', '25823', '25', '', 'DIVIPOLA'),
(1098, 28, 'Une', 'Cundinamarca', 'Municipio', 'CUN_UNE', '25845', '25', '', 'DIVIPOLA'),
(1099, 28, 'Utica', 'Cundinamarca', 'Municipio', 'CUN_UTI', '25851', '25', '', 'DIVIPOLA'),
(1100, 28, 'Venecia', 'Cundinamarca', 'Municipio', 'CUN_VEN', '25506', '25', '', 'DIVIPOLA'),
(1101, 28, 'Vergara', 'Cundinamarca', 'Municipio', 'CUN_VER', '25862', '25', '', 'DIVIPOLA'),
(1102, 28, 'Viani', 'Cundinamarca', 'Municipio', 'CUN_VIA', '25867', '25', '', 'DIVIPOLA'),
(1103, 28, 'Viota', 'Cundinamarca', 'Municipio', 'CUN_VIO', '25878', '25', '', 'DIVIPOLA'),
(1104, 28, 'Yacopi', 'Cundinamarca', 'Municipio', 'CUN_YAC', '25885', '25', '', 'DIVIPOLA'),
(1105, 28, 'San Antonio De Tequendama', 'Cundinamarca', 'Municipio', 'CUN_ANT', '25645', '25', '', 'DIVIPOLA'),
(1106, 28, 'San Bernardo', 'Cundinamarca', 'Municipio', 'CUN_BER', '25649', '25', '', 'DIVIPOLA'),
(1107, 28, 'San Cayetano', 'Cundinamarca', 'Municipio', 'CUN_CAY', '25653', '25', '', 'DIVIPOLA'),
(1108, 28, 'San Francisco', 'Cundinamarca', 'Municipio', 'CUN_FRA', '25658', '25', '', 'DIVIPOLA'),
(1109, 28, 'San Juan De Rio Seco', 'Cundinamarca', 'Municipio', 'CUN_JUA', '25662', '25', '', 'DIVIPOLA'),
(1110, 28, 'Guataqui', 'Cundinamarca', 'Municipio', 'CUN_GUU', '25324', '25', '', 'DIVIPOLA'),
(1111, 28, 'Gutierrez', 'Cundinamarca', 'Municipio', 'CUN_GUT', '25339', '25', '', 'DIVIPOLA'),
(1112, 28, 'Tena', 'Cundinamarca', 'Municipio', 'CUN_TEA', '25797', '25', '', 'DIVIPOLA'),
(1113, 28, 'Tenjo', 'Cundinamarca', 'Municipio', 'CUN_TEN', '25799', '25', '', 'DIVIPOLA'),
(1114, 28, 'Tibacuy', 'Cundinamarca', 'Municipio', 'CUN_TIY', '25805', '25', '', 'DIVIPOLA'),
(1115, 28, 'Tibirita', 'Cundinamarca', 'Municipio', 'CUN_TIB', '25807', '25', '', 'DIVIPOLA'),
(1116, 28, 'Tocaima', 'Cundinamarca', 'Municipio', 'CUN_TOI', '25815', '25', '', 'DIVIPOLA'),
(1117, 28, 'Tocancipa', 'Cundinamarca', 'Municipio', 'CUN_TOC', '25817', '25', '', 'DIVIPOLA'),
(1118, 28, 'Ubala', 'Cundinamarca', 'Municipio', 'CUN_UBL', '25839', '25', '', 'DIVIPOLA'),
(1119, 28, 'Ubaque', 'Cundinamarca', 'Municipio', 'CUN_UBQ', '25841', '25', '', 'DIVIPOLA'),
(1120, 28, 'Ubate', 'Cundinamarca', 'Municipio', 'CUN_UBT', '25843', '25', '', 'DIVIPOLA'),
(1121, 28, 'Villagomez', 'Cundinamarca', 'Municipio', 'CUN_VIG', '25871', '25', '', 'DIVIPOLA'),
(1122, 28, 'Villapinzon', 'Cundinamarca', 'Municipio', 'CUN_VIP', '25873', '25', '', 'DIVIPOLA'),
(1123, 28, 'Villeta', 'Cundinamarca', 'Municipio', 'CUN_VIL', '25875', '25', '', 'DIVIPOLA'),
(1124, 28, 'Zipacon', 'Cundinamarca', 'Municipio', 'CUN_ZIC', '25898', '25', '', 'DIVIPOLA'),
(1125, 28, 'Zipaquira', 'Cundinamarca', 'Municipio', 'CUN_ZIP', '25899', '25', '', 'DIVIPOLA'),
(1126, 29, 'Inirida', 'Guainía', 'Municipio', 'GUA_INI', '94001', '94', '', 'DIVIPOLA'),
(1127, 30, 'Calamar', 'Guaviare', 'Municipio', 'GUV_CAL', '95015', '95', '', 'DIVIPOLA'),
(1128, 30, 'El Retorno', 'Guaviare', 'Municipio', 'GUV_EL ', '95025', '95', '', 'DIVIPOLA'),
(1129, 30, 'Miraflores', 'Guaviare', 'Municipio', 'GUV_MIR', '95200', '95', '', 'DIVIPOLA'),
(1130, 30, 'San Jose Del Guaviare', 'Guaviare', 'Municipio', 'GUV_SAN', '95001', '95', '', 'DIVIPOLA'),
(1131, 31, 'La Argentina', 'Huila', 'Municipio', 'HUI_ARG', '41378', '41', '', 'DIVIPOLA'),
(1132, 31, 'La Plata', 'Huila', 'Municipio', 'HUI_PLA', '41396', '41', '', 'DIVIPOLA'),
(1133, 31, 'Palermo', 'Huila', 'Municipio', 'HUI_PAL', '41524', '41', '', 'DIVIPOLA'),
(1134, 31, 'Palestina', 'Huila', 'Municipio', 'HUI_PAE', '41530', '41', '', 'DIVIPOLA'),
(1135, 31, 'Pital', 'Huila', 'Municipio', 'HUI_PIA', '41548', '41', '', 'DIVIPOLA'),
(1136, 31, 'Pitalito', 'Huila', 'Municipio', 'HUI_PIT', '41551', '41', '', 'DIVIPOLA'),
(1137, 31, 'San Agustin', 'Huila', 'Municipio', 'HUI_AGU', '41668', '41', '', 'DIVIPOLA'),
(1138, 31, 'Acevedo', 'Huila', 'Municipio', 'HUI_ACE', '41006', '41', '', 'DIVIPOLA'),
(1139, 31, 'Agrado', 'Huila', 'Municipio', 'HUI_AGR', '41013', '41', '', 'DIVIPOLA'),
(1140, 31, 'Aipe', 'Huila', 'Municipio', 'HUI_AIP', '41016', '41', '', 'DIVIPOLA'),
(1141, 31, 'Algeciras', 'Huila', 'Municipio', 'HUI_ALG', '41020', '41', '', 'DIVIPOLA'),
(1142, 31, 'Altamira', 'Huila', 'Municipio', 'HUI_ALT', '41026', '41', '', 'DIVIPOLA'),
(1143, 31, 'Baraya', 'Huila', 'Municipio', 'HUI_BAR', '41078', '41', '', 'DIVIPOLA'),
(1144, 31, 'Campoalegre', 'Huila', 'Municipio', 'HUI_CAM', '41132', '41', '', 'DIVIPOLA'),
(1145, 31, 'Colombia', 'Huila', 'Municipio', 'HUI_COL', '41206', '41', '', 'DIVIPOLA'),
(1146, 31, 'Elias', 'Huila', 'Municipio', 'HUI_ELI', '41244', '41', '', 'DIVIPOLA'),
(1147, 31, 'Garzon', 'Huila', 'Municipio', 'HUI_GAR', '41298', '41', '', 'DIVIPOLA'),
(1148, 31, 'Gigante', 'Huila', 'Municipio', 'HUI_GIG', '41306', '41', '', 'DIVIPOLA'),
(1149, 31, 'Guadalupe', 'Huila', 'Municipio', 'HUI_GUA', '41319', '41', '', 'DIVIPOLA'),
(1150, 31, 'Hobo', 'Huila', 'Municipio', 'HUI_HOB', '41349', '41', '', 'DIVIPOLA'),
(1151, 31, 'Iquira', 'Huila', 'Municipio', 'HUI_IQU', '41357', '41', '', 'DIVIPOLA'),
(1152, 31, 'Isnos', 'Huila', 'Municipio', 'HUI_ISN', '41359', '41', '', 'DIVIPOLA'),
(1153, 31, 'Nataga', 'Huila', 'Municipio', 'HUI_NAT', '41483', '41', '', 'DIVIPOLA'),
(1154, 31, 'Neiva', 'Huila', 'Municipio', 'HUI_NEI', '41001', '41', '', 'DIVIPOLA'),
(1155, 31, 'Oporapa', 'Huila', 'Municipio', 'HUI_OPO', '41503', '41', '', 'DIVIPOLA'),
(1156, 31, 'Paicol', 'Huila', 'Municipio', 'HUI_PAI', '41518', '41', '', 'DIVIPOLA'),
(1157, 31, 'Rivera', 'Huila', 'Municipio', 'HUI_RIV', '41615', '41', '', 'DIVIPOLA'),
(1158, 31, 'Saladoblanco', 'Huila', 'Municipio', 'HUI_SAL', '41660', '41', '', 'DIVIPOLA'),
(1159, 31, 'Suaza', 'Huila', 'Municipio', 'HUI_SUA', '41770', '41', '', 'DIVIPOLA'),
(1160, 31, 'Tarqui', 'Huila', 'Municipio', 'HUI_TAR', '41791', '41', '', 'DIVIPOLA'),
(1161, 31, 'Tello', 'Huila', 'Municipio', 'HUI_TEL', '41799', '41', '', 'DIVIPOLA'),
(1162, 31, 'Teruel', 'Huila', 'Municipio', 'HUI_TER', '41801', '41', '', 'DIVIPOLA'),
(1163, 31, 'Tesalia', 'Huila', 'Municipio', 'HUI_TES', '41797', '41', '', 'DIVIPOLA'),
(1164, 31, 'Timana', 'Huila', 'Municipio', 'HUI_TIM', '41807', '41', '', 'DIVIPOLA'),
(1165, 31, 'Villavieja', 'Huila', 'Municipio', 'HUI_VIL', '41872', '41', '', 'DIVIPOLA'),
(1166, 31, 'Yaguara', 'Huila', 'Municipio', 'HUI_YAG', '41885', '41', '', 'DIVIPOLA'),
(1167, 31, 'Santa Maria', 'Huila', 'Municipio', 'HUI_SAN', '41676', '41', '', 'DIVIPOLA'),
(1168, 32, 'Albania', 'La Guajira', 'Municipio', 'LA _ALB', '44035', '44', '', 'DIVIPOLA'),
(1169, 32, 'Barrancas', 'La Guajira', 'Municipio', 'LA _BAR', '44078', '44', '', 'DIVIPOLA'),
(1170, 32, 'Dibulla', 'La Guajira', 'Municipio', 'LA _DIB', '44090', '44', '', 'DIVIPOLA'),
(1171, 32, 'Distraccion', 'La Guajira', 'Municipio', 'LA _DIS', '44098', '44', '', 'DIVIPOLA'),
(1172, 32, 'El Molino', 'La Guajira', 'Municipio', 'LA _EL ', '44110', '44', '', 'DIVIPOLA'),
(1173, 32, 'Fonseca', 'La Guajira', 'Municipio', 'LA _FON', '44279', '44', '', 'DIVIPOLA'),
(1174, 32, 'Hatonuevo', 'La Guajira', 'Municipio', 'LA _HAT', '44378', '44', '', 'DIVIPOLA'),
(1175, 32, 'La Jagua Del Pilar', 'La Guajira', 'Municipio', 'LA _LA ', '44420', '44', '', 'DIVIPOLA'),
(1176, 32, 'Maicao', 'La Guajira', 'Municipio', 'LA _MAI', '44430', '44', '', 'DIVIPOLA'),
(1177, 32, 'Manaure', 'La Guajira', 'Municipio', 'LA _MAN', '44560', '44', '', 'DIVIPOLA'),
(1178, 32, 'Riohacha', 'La Guajira', 'Municipio', 'LA _RIO', '44001', '44', '', 'DIVIPOLA'),
(1179, 32, 'San Juan Del Cesar', 'La Guajira', 'Municipio', 'LA _SAN', '44650', '44', '', 'DIVIPOLA'),
(1180, 32, 'Uribia', 'La Guajira', 'Municipio', 'LA _URI', '44847', '44', '', 'DIVIPOLA'),
(1181, 32, 'Urumita', 'La Guajira', 'Municipio', 'LA _URU', '44855', '44', '', 'DIVIPOLA'),
(1182, 32, 'Villanueva', 'La Guajira', 'Municipio', 'LA _VIL', '44874', '44', '', 'DIVIPOLA'),
(1183, 33, 'El Banco', 'Magdalena', 'Municipio', 'MAG_BAN', '47245', '47', '', 'DIVIPOLA'),
(1184, 33, 'El Piñon', 'Magdalena', 'Municipio', 'MAG_ELP', '47258', '47', '', 'DIVIPOLA'),
(1185, 33, 'El Reten', 'Magdalena', 'Municipio', 'MAG_ELR', '47268', '47', '', 'DIVIPOLA'),
(1186, 33, 'Algarrobo', 'Magdalena', 'Municipio', 'MAG_ALG', '47030', '47', '', 'DIVIPOLA'),
(1187, 33, 'Aracataca', 'Magdalena', 'Municipio', 'MAG_ARA', '47053', '47', '', 'DIVIPOLA'),
(1188, 33, 'Ariguani', 'Magdalena', 'Municipio', 'MAG_ARI', '47058', '47', '', 'DIVIPOLA'),
(1189, 33, 'Cerro San Antonio', 'Magdalena', 'Municipio', 'MAG_CER', '47161', '47', '', 'DIVIPOLA'),
(1190, 33, 'Chivolo', 'Magdalena', 'Municipio', 'MAG_CHI', '47170', '47', '', 'DIVIPOLA'),
(1191, 33, 'Cienaga', 'Magdalena', 'Municipio', 'MAG_CIE', '47189', '47', '', 'DIVIPOLA'),
(1192, 33, 'Concordia', 'Magdalena', 'Municipio', 'MAG_CON', '47205', '47', '', 'DIVIPOLA'),
(1193, 33, 'Fundacion', 'Magdalena', 'Municipio', 'MAG_FUN', '47288', '47', '', 'DIVIPOLA'),
(1194, 33, 'Guamal', 'Magdalena', 'Municipio', 'MAG_GUA', '47318', '47', '', 'DIVIPOLA'),
(1195, 33, 'Nueva Granada', 'Magdalena', 'Municipio', 'MAG_NUE', '47460', '47', '', 'DIVIPOLA'),
(1196, 33, 'Pedraza', 'Magdalena', 'Municipio', 'MAG_PED', '47541', '47', '', 'DIVIPOLA'),
(1197, 33, 'Pijiño Del Carmen', 'Magdalena', 'Municipio', 'MAG_PIJ', '47545', '47', '', 'DIVIPOLA'),
(1198, 33, 'Pivijay', 'Magdalena', 'Municipio', 'MAG_PIV', '47551', '47', '', 'DIVIPOLA'),
(1199, 33, 'Plato', 'Magdalena', 'Municipio', 'MAG_PLA', '47555', '47', '', 'DIVIPOLA'),
(1200, 33, 'Puebloviejo', 'Magdalena', 'Municipio', 'MAG_PUE', '47570', '47', '', 'DIVIPOLA'),
(1201, 33, 'Remolino', 'Magdalena', 'Municipio', 'MAG_REM', '47605', '47', '', 'DIVIPOLA'),
(1202, 33, 'Sabanas De San Angel', 'Magdalena', 'Municipio', 'MAG_SAB', '47660', '47', '', 'DIVIPOLA'),
(1203, 33, 'Salamina', 'Magdalena', 'Municipio', 'MAG_SAL', '47675', '47', '', 'DIVIPOLA'),
(1204, 33, 'Sitionuevo', 'Magdalena', 'Municipio', 'MAG_SIT', '47745', '47', '', 'DIVIPOLA'),
(1205, 33, 'Tenerife', 'Magdalena', 'Municipio', 'MAG_TEN', '47798', '47', '', 'DIVIPOLA'),
(1206, 33, 'Zapayan', 'Magdalena', 'Municipio', 'MAG_ZAP', '47960', '47', '', 'DIVIPOLA'),
(1207, 33, 'Zona Bananera', 'Magdalena', 'Municipio', 'MAG_ZON', '47980', '47', '', 'DIVIPOLA'),
(1208, 33, 'San Sebastian De Buenavista', 'Magdalena', 'Municipio', 'MAG_SEB', '47692', '47', '', 'DIVIPOLA'),
(1209, 33, 'San Zenon', 'Magdalena', 'Municipio', 'MAG_ZEN', '47703', '47', '', 'DIVIPOLA'),
(1210, 33, 'Santa Ana', 'Magdalena', 'Municipio', 'MAG_ANA', '47707', '47', '', 'DIVIPOLA'),
(1211, 33, 'Santa Barbara De Pinto', 'Magdalena', 'Municipio', 'MAG_BAR', '47720', '47', '', 'DIVIPOLA'),
(1212, 33, 'Santa Marta', 'Magdalena', 'Municipio', 'MAG_SAN', '47001', '47', '', 'DIVIPOLA'),
(1213, 34, 'El Calvario', 'Meta', 'Municipio', 'MET_ELC', '50245', '50', '', 'DIVIPOLA'),
(1214, 34, 'El Castillo', 'Meta', 'Municipio', 'MET_CAT', '50251', '50', '', 'DIVIPOLA'),
(1215, 34, 'El Dorado', 'Meta', 'Municipio', 'MET_ELD', '50270', '50', '', 'DIVIPOLA'),
(1216, 34, 'La Macarena', 'Meta', 'Municipio', 'MET_MAC', '50350', '50', '', 'DIVIPOLA'),
(1217, 34, 'La Uribe', 'Meta', 'Municipio', 'MET_URI', '50370', '50', '', 'DIVIPOLA'),
(1218, 34, 'Puerto Concordia', 'Meta', 'Municipio', 'MET_PUC', '50450', '50', '', 'DIVIPOLA'),
(1219, 34, 'Puerto Gaitan', 'Meta', 'Municipio', 'MET_PUG', '50568', '50', '', 'DIVIPOLA'),
(1220, 34, 'Puerto Lleras', 'Meta', 'Municipio', 'MET_LLE', '50577', '50', '', 'DIVIPOLA'),
(1221, 34, 'Puerto Lopez', 'Meta', 'Municipio', 'MET_LOP', '50573', '50', '', 'DIVIPOLA'),
(1222, 34, 'Puerto Rico', 'Meta', 'Municipio', 'MET_PUE', '50590', '50', '', 'DIVIPOLA'),
(1223, 34, 'San Carlos Guaroa', 'Meta', 'Municipio', 'MET_CAR', '50680', '50', '', 'DIVIPOLA'),
(1224, 34, 'Acacias', 'Meta', 'Municipio', 'MET_ACA', '50006', '50', '', 'DIVIPOLA'),
(1225, 34, 'Barranca De Upia', 'Meta', 'Municipio', 'MET_BAR', '50110', '50', '', 'DIVIPOLA'),
(1226, 34, 'Cabuyaro', 'Meta', 'Municipio', 'MET_CAB', '50124', '50', '', 'DIVIPOLA'),
(1227, 34, 'Castilla La Nueva', 'Meta', 'Municipio', 'MET_CAS', '50150', '50', '', 'DIVIPOLA'),
(1228, 34, 'Cubarral', 'Meta', 'Municipio', 'MET_CUB', '50223', '50', '', 'DIVIPOLA'),
(1229, 34, 'Cumaral', 'Meta', 'Municipio', 'MET_CUM', '50226', '50', '', 'DIVIPOLA'),
(1230, 34, 'Fuente De Oro', 'Meta', 'Municipio', 'MET_FUE', '50287', '50', '', 'DIVIPOLA'),
(1231, 34, 'Granada', 'Meta', 'Municipio', 'MET_GRA', '50313', '50', '', 'DIVIPOLA'),
(1232, 34, 'Guamal', 'Meta', 'Municipio', 'MET_GUA', '50318', '50', '', 'DIVIPOLA'),
(1233, 34, 'Lejanias', 'Meta', 'Municipio', 'MET_LEJ', '50400', '50', '', 'DIVIPOLA'),
(1234, 34, 'Mapiripan', 'Meta', 'Municipio', 'MET_MAP', '50325', '50', '', 'DIVIPOLA'),
(1235, 34, 'Mesetas', 'Meta', 'Municipio', 'MET_MES', '50330', '50', '', 'DIVIPOLA'),
(1236, 34, 'Restrepo', 'Meta', 'Municipio', 'MET_RES', '50606', '50', '', 'DIVIPOLA'),
(1237, 34, 'Villavicencio', 'Meta', 'Municipio', 'MET_VIL', '50001', '50', '', 'DIVIPOLA'),
(1238, 34, 'Vista Hermosa', 'Meta', 'Municipio', 'MET_VIS', '50711', '50', '', 'DIVIPOLA'),
(1239, 34, 'San Juan De Arama', 'Meta', 'Municipio', 'MET_JUA', '50683', '50', '', 'DIVIPOLA'),
(1240, 34, 'San Juanito', 'Meta', 'Municipio', 'MET_JUN', '50686', '50', '', 'DIVIPOLA'),
(1241, 34, 'San Martin', 'Meta', 'Municipio', 'MET_SAN', '50689', '50', '', 'DIVIPOLA'),
(1242, 35, 'Consaca', 'Nariño', 'Municipio', 'NAR_COS', '52207', '52', '', 'DIVIPOLA'),
(1245, 35, 'Contadero', 'Nariño', 'Municipio', 'NAR_CON', '52210', '52', '', 'DIVIPOLA'),
(1248, 35, 'Cumbal', 'Nariño', 'Municipio', 'NAR_CUB', '52227', '52', '', 'DIVIPOLA'),
(1251, 35, 'Cumbitara', 'Nariño', 'Municipio', 'NAR_CUM', '52233', '52', '', 'DIVIPOLA'),
(1254, 35, 'El Charco', 'Nariño', 'Municipio', 'NAR_ELC', '52250', '52', '', 'DIVIPOLA'),
(1257, 35, 'El Peñol', 'Nariño', 'Municipio', 'NAR_ELP', '52254', '52', '', 'DIVIPOLA'),
(1260, 35, 'El Rosario', 'Nariño', 'Municipio', 'NAR_ELR', '52256', '52', '', 'DIVIPOLA'),
(1263, 35, 'El Tablon De Gomez', 'Nariño', 'Municipio', 'NAR_ELT', '52258', '52', '', 'DIVIPOLA'),
(1266, 35, 'El Tambo', 'Nariño', 'Municipio', 'NAR_EL ', '52260', '52', '', 'DIVIPOLA'),
(1269, 35, 'Guachucal', 'Nariño', 'Municipio', 'NAR_GUU', '52317', '52', '', 'DIVIPOLA'),
(1272, 35, 'Guaitarilla', 'Nariño', 'Municipio', 'NAR_GUI', '52320', '52', '', 'DIVIPOLA'),
(1275, 35, 'Gualmatan', 'Nariño', 'Municipio', 'NAR_GUA', '52323', '52', '', 'DIVIPOLA'),
(1278, 35, 'La Cruz', 'Nariño', 'Municipio', 'NAR_CRU', '52378', '52', '', 'DIVIPOLA'),
(1281, 35, 'La Florida', 'Nariño', 'Municipio', 'NAR_FLO', '52381', '52', '', 'DIVIPOLA'),
(1284, 35, 'La Llanada', 'Nariño', 'Municipio', 'NAR_LLA', '52385', '52', '', 'DIVIPOLA'),
(1287, 35, 'La Tola', 'Nariño', 'Municipio', 'NAR_TOL', '52390', '52', '', 'DIVIPOLA'),
(1290, 35, 'La Union', 'Nariño', 'Municipio', 'NAR_UNI', '52399', '52', '', 'DIVIPOLA'),
(1293, 35, 'San Bernardo', 'Nariño', 'Municipio', 'NAR_BER', '52685', '52', '', 'DIVIPOLA'),
(1296, 35, 'Alban', 'Nariño', 'Municipio', 'NAR_ALB', '52019', '52', '', 'DIVIPOLA'),
(1299, 35, 'Aldana', 'Nariño', 'Municipio', 'NAR_ALD', '52022', '52', '', 'DIVIPOLA'),
(1302, 35, 'Ancuya', 'Nariño', 'Municipio', 'NAR_ANC', '52036', '52', '', 'DIVIPOLA'),
(1305, 35, 'Arboleda', 'Nariño', 'Municipio', 'NAR_ARB', '52051', '52', '', 'DIVIPOLA'),
(1308, 35, 'Belen', 'Nariño', 'Municipio', 'NAR_BEL', '52083', '52', '', 'DIVIPOLA'),
(1311, 35, 'Buesaco', 'Nariño', 'Municipio', 'NAR_BUE', '52110', '52', '', 'DIVIPOLA'),
(1314, 35, 'Chachagui', 'Nariño', 'Municipio', 'NAR_CHA', '52240', '52', '', 'DIVIPOLA'),
(1317, 35, 'Colon', 'Nariño', 'Municipio', 'NAR_COL', '52203', '52', '', 'DIVIPOLA'),
(1320, 35, 'Cordoba', 'Nariño', 'Municipio', 'NAR_COR', '52215', '52', '', 'DIVIPOLA'),
(1323, 35, 'Cuaspud', 'Nariño', 'Municipio', 'NAR_CUA', '52224', '52', '', 'DIVIPOLA'),
(1326, 35, 'Francisco Pizarro', 'Nariño', 'Municipio', 'NAR_FRA', '52520', '52', '', 'DIVIPOLA'),
(1329, 35, 'Funes', 'Nariño', 'Municipio', 'NAR_FUN', '52287', '52', '', 'DIVIPOLA'),
(1332, 35, 'San Lorenzo', 'Nariño', 'Municipio', 'NAR_LOR', '52687', '52', '', 'DIVIPOLA'),
(1335, 35, 'Iles', 'Nariño', 'Municipio', 'NAR_ILE', '52352', '52', '', 'DIVIPOLA'),
(1338, 35, 'Imues', 'Nariño', 'Municipio', 'NAR_IMU', '52354', '52', '', 'DIVIPOLA'),
(1341, 35, 'Ipiales', 'Nariño', 'Municipio', 'NAR_IPI', '52356', '52', '', 'DIVIPOLA'),
(1344, 35, 'Leiva', 'Nariño', 'Municipio', 'NAR_LEI', '52405', '52', '', 'DIVIPOLA'),
(1347, 35, 'Linares', 'Nariño', 'Municipio', 'NAR_LIN', '52411', '52', '', 'DIVIPOLA'),
(1350, 35, 'Los Andes', 'Nariño', 'Municipio', 'NAR_LOS', '52418', '52', '', 'DIVIPOLA'),
(1353, 35, 'Magui', 'Nariño', 'Municipio', 'NAR_MAG', '52427', '52', '', 'DIVIPOLA'),
(1356, 35, 'Mallama', 'Nariño', 'Municipio', 'NAR_MAL', '52435', '52', '', 'DIVIPOLA'),
(1359, 35, 'Mosquera', 'Nariño', 'Municipio', 'NAR_MOS', '52473', '52', '', 'DIVIPOLA'),
(1362, 35, 'Nariño', 'Nariño', 'Municipio', 'NAR_NAR', '52480', '52', '', 'DIVIPOLA'),
(1365, 35, 'Olaya Herrera', 'Nariño', 'Municipio', 'NAR_OLA', '52490', '52', '', 'DIVIPOLA'),
(1372, 35, 'Ospina', 'Nariño', 'Municipio', 'NAR_OSP', '52506', '52', '', 'DIVIPOLA'),
(1379, 35, 'Pasto', 'Nariño', 'Municipio', 'NAR_PAS', '52001', '52', '', 'DIVIPOLA'),
(1386, 35, 'Policarpa', 'Nariño', 'Municipio', 'NAR_POL', '52540', '52', '', 'DIVIPOLA'),
(1393, 35, 'Potosi', 'Nariño', 'Municipio', 'NAR_POT', '52560', '52', '', 'DIVIPOLA'),
(1400, 35, 'Providencia', 'Nariño', 'Municipio', 'NAR_PRO', '52565', '52', '', 'DIVIPOLA'),
(1407, 35, 'Puerres', 'Nariño', 'Municipio', 'NAR_PUE', '52573', '52', '', 'DIVIPOLA'),
(1414, 35, 'Pupiales', 'Nariño', 'Municipio', 'NAR_PUP', '52585', '52', '', 'DIVIPOLA'),
(1421, 35, 'Ricaurte', 'Nariño', 'Municipio', 'NAR_RIC', '52612', '52', '', 'DIVIPOLA'),
(1428, 35, 'Roberto Payan', 'Nariño', 'Municipio', 'NAR_ROB', '52621', '52', '', 'DIVIPOLA'),
(1435, 35, 'Samaniego', 'Nariño', 'Municipio', 'NAR_SAM', '52678', '52', '', 'DIVIPOLA'),
(1442, 35, 'Sapuyes', 'Nariño', 'Municipio', 'NAR_SAP', '52720', '52', '', 'DIVIPOLA'),
(1449, 35, 'Taminango', 'Nariño', 'Municipio', 'NAR_TAM', '52786', '52', '', 'DIVIPOLA'),
(1456, 35, 'Tangua', 'Nariño', 'Municipio', 'NAR_TAN', '52788', '52', '', 'DIVIPOLA'),
(1463, 35, 'Tumaco', 'Nariño', 'Municipio', 'NAR_TUM', '52835', '52', '', 'DIVIPOLA'),
(1470, 35, 'Tuquerres', 'Nariño', 'Municipio', 'NAR_TUQ', '52838', '52', '', 'DIVIPOLA'),
(1477, 35, 'Yacuanquer', 'Nariño', 'Municipio', 'NAR_YAC', '52885', '52', '', 'DIVIPOLA'),
(1484, 35, 'San Pablo', 'Nariño', 'Municipio', 'NAR_PAB', '52693', '52', '', 'DIVIPOLA'),
(1491, 35, 'San Pedro De Cartago', 'Nariño', 'Municipio', 'NAR_PED', '52694', '52', '', 'DIVIPOLA'),
(1498, 35, 'Barbacoas', 'Nariño', 'Municipio', 'NAR_BAB', '52079', '52', '', 'DIVIPOLA'),
(1505, 35, 'Santa Barbara', 'Nariño', 'Municipio', 'NAR_BAR', '52696', '52', '', 'DIVIPOLA'),
(1512, 35, 'Sandona', 'Nariño', 'Municipio', 'NAR_SAD', '52683', '52', '', 'DIVIPOLA'),
(1519, 35, 'Santacruz', 'Nariño', 'Municipio', 'NAR_SAN', '52699', '52', '', 'DIVIPOLA'),
(1526, 36, 'Cachira', 'Norte De Santander', 'Municipio', 'NOR_CAH', '54128', '54', '', 'DIVIPOLA'),
(1527, 36, 'Cacota', 'Norte De Santander', 'Municipio', 'NOR_CAC', '54125', '54', '', 'DIVIPOLA'),
(1528, 36, 'Chinacota', 'Norte De Santander', 'Municipio', 'NOR_CHN', '54172', '54', '', 'DIVIPOLA'),
(1529, 36, 'Chitaga', 'Norte De Santander', 'Municipio', 'NOR_CHI', '54174', '54', '', 'DIVIPOLA'),
(1530, 36, 'Cucuta', 'Norte De Santander', 'Municipio', 'NOR_CUC', '54001', '54', '', 'DIVIPOLA'),
(1531, 36, 'Cucutilla', 'Norte De Santander', 'Municipio', 'NOR_CUT', '54223', '54', '', 'DIVIPOLA'),
(1532, 36, 'El Tarra', 'Norte De Santander', 'Municipio', 'NOR_ELT', '54250', '54', '', 'DIVIPOLA'),
(1533, 36, 'El Zulia', 'Norte De Santander', 'Municipio', 'NOR_ELZ', '54261', '54', '', 'DIVIPOLA'),
(1534, 36, 'La Esperanza', 'Norte De Santander', 'Municipio', 'NOR_ESP', '54385', '54', '', 'DIVIPOLA'),
(1535, 36, 'La Playa', 'Norte De Santander', 'Municipio', 'NOR_PLA', '54398', '54', '', 'DIVIPOLA'),
(1536, 36, 'Pamplona', 'Norte De Santander', 'Municipio', 'NOR_PAP', '54518', '54', '', 'DIVIPOLA'),
(1537, 36, 'Pamplonita', 'Norte De Santander', 'Municipio', 'NOR_PAM', '54520', '54', '', 'DIVIPOLA'),
(1538, 36, 'San Calixto', 'Norte De Santander', 'Municipio', 'NOR_CAL', '54670', '54', '', 'DIVIPOLA'),
(1539, 36, 'San Cayetano', 'Norte De Santander', 'Municipio', 'NOR_CAY', '54673', '54', '', 'DIVIPOLA'),
(1540, 36, 'Abrego', 'Norte De Santander', 'Municipio', 'NOR_ABR', '54003', '54', '', 'DIVIPOLA'),
(1541, 36, 'Arboledas', 'Norte De Santander', 'Municipio', 'NOR_ARB', '54051', '54', '', 'DIVIPOLA'),
(1542, 36, 'Bochalema', 'Norte De Santander', 'Municipio', 'NOR_BOC', '54099', '54', '', 'DIVIPOLA'),
(1543, 36, 'Bucarasica', 'Norte De Santander', 'Municipio', 'NOR_BUC', '54109', '54', '', 'DIVIPOLA'),
(1544, 36, 'Convencion', 'Norte De Santander', 'Municipio', 'NOR_CON', '54206', '54', '', 'DIVIPOLA'),
(1545, 36, 'Durania', 'Norte De Santander', 'Municipio', 'NOR_DUR', '54239', '54', '', 'DIVIPOLA'),
(1546, 36, 'Gramalote', 'Norte De Santander', 'Municipio', 'NOR_GRA', '54313', '54', '', 'DIVIPOLA'),
(1547, 36, 'Hacari', 'Norte De Santander', 'Municipio', 'NOR_HAC', '54344', '54', '', 'DIVIPOLA'),
(1548, 36, 'Herran', 'Norte De Santander', 'Municipio', 'NOR_HER', '54347', '54', '', 'DIVIPOLA'),
(1549, 36, 'Labateca', 'Norte De Santander', 'Municipio', 'NOR_LAB', '54377', '54', '', 'DIVIPOLA'),
(1550, 36, 'Los Patios', 'Norte De Santander', 'Municipio', 'NOR_LOS', '54405', '54', '', 'DIVIPOLA'),
(1551, 36, 'Lourdes', 'Norte De Santander', 'Municipio', 'NOR_LOU', '54418', '54', '', 'DIVIPOLA'),
(1552, 36, 'Mutiscua', 'Norte De Santander', 'Municipio', 'NOR_MUT', '54480', '54', '', 'DIVIPOLA'),
(1553, 36, 'Ocaña', 'Norte De Santander', 'Municipio', 'NOR_OCA', '54498', '54', '', 'DIVIPOLA'),
(1554, 36, 'Puerto Santander', 'Norte De Santander', 'Municipio', 'NOR_PUE', '54553', '54', '', 'DIVIPOLA'),
(1555, 36, 'Ragonvalia', 'Norte De Santander', 'Municipio', 'NOR_RAG', '54599', '54', '', 'DIVIPOLA'),
(1556, 36, 'Salazar', 'Norte De Santander', 'Municipio', 'NOR_SAL', '54660', '54', '', 'DIVIPOLA'),
(1557, 36, 'Sardinata', 'Norte De Santander', 'Municipio', 'NOR_SAR', '54720', '54', '', 'DIVIPOLA'),
(1558, 36, 'Silos', 'Norte De Santander', 'Municipio', 'NOR_SIL', '54743', '54', '', 'DIVIPOLA'),
(1559, 36, 'Teorama', 'Norte De Santander', 'Municipio', 'NOR_TEO', '54800', '54', '', 'DIVIPOLA'),
(1560, 36, 'Tibu', 'Norte De Santander', 'Municipio', 'NOR_TIB', '54810', '54', '', 'DIVIPOLA'),
(1561, 36, 'Toledo', 'Norte De Santander', 'Municipio', 'NOR_TOL', '54820', '54', '', 'DIVIPOLA'),
(1562, 36, 'Santiago', 'Norte De Santander', 'Municipio', 'NOR_SAN', '54680', '54', '', 'DIVIPOLA'),
(1563, 36, 'El Carmen', 'Norte De Santander', 'Municipio', 'NOR_CAM', '54245', '54', '', 'DIVIPOLA'),
(1564, 36, 'Villa Del Rosario', 'Norte De Santander', 'Municipio', 'NOR_ROS', '54874', '54', '', 'DIVIPOLA'),
(1565, 36, 'Villa Caro', 'Norte De Santander', 'Municipio', 'NOR_CAR', '54871', '54', '', 'DIVIPOLA'),
(1566, 37, 'Puerto Asis', 'Putumayo', 'Municipio', 'PUT_PUR', '86568', '86', '', 'DIVIPOLA'),
(1567, 37, 'Puerto Caicedo', 'Putumayo', 'Municipio', 'PUT_PUO', '86569', '86', '', 'DIVIPOLA'),
(1568, 37, 'Puerto Guzman', 'Putumayo', 'Municipio', 'PUT_PUE', '86571', '86', '', 'DIVIPOLA'),
(1569, 37, 'San Francisco', 'Putumayo', 'Municipio', 'PUT_FRA', '86755', '86', '', 'DIVIPOLA'),
(1570, 37, 'San Miguel', 'Putumayo', 'Municipio', 'PUT_MIG', '86757', '86', '', 'DIVIPOLA'),
(1571, 37, 'Colon', 'Putumayo', 'Municipio', 'PUT_COL', '86219', '86', '', 'DIVIPOLA'),
(1572, 37, 'Leguizamo', 'Putumayo', 'Municipio', 'PUT_LEG', '86573', '86', '', 'DIVIPOLA'),
(1573, 37, 'Mocoa', 'Putumayo', 'Municipio', 'PUT_MOC', '86001', '86', '', 'DIVIPOLA'),
(1574, 37, 'Orito', 'Putumayo', 'Municipio', 'PUT_ORI', '86320', '86', '', 'DIVIPOLA'),
(1575, 37, 'Sibundoy', 'Putumayo', 'Municipio', 'PUT_SIB', '86749', '86', '', 'DIVIPOLA'),
(1576, 37, 'Valle Del Guamuez', 'Putumayo', 'Municipio', 'PUT_VAL', '86865', '86', '', 'DIVIPOLA'),
(1577, 37, 'Villagarzon', 'Putumayo', 'Municipio', 'PUT_VIL', '86885', '86', '', 'DIVIPOLA'),
(1578, 37, 'Santiago', 'Putumayo', 'Municipio', 'PUT_SAN', '86760', '86', '', 'DIVIPOLA'),
(1579, 38, 'Armenia', 'Quindío', 'Municipio', 'QUI_ARM', '63001', '63', '', 'DIVIPOLA'),
(1580, 38, 'Buenavista', 'Quindío', 'Municipio', 'QUI_BUE', '63111', '63', '', 'DIVIPOLA'),
(1581, 38, 'Calarca', 'Quindío', 'Municipio', 'QUI_CAL', '63130', '63', '', 'DIVIPOLA'),
(1582, 38, 'Circasia', 'Quindío', 'Municipio', 'QUI_CIR', '63190', '63', '', 'DIVIPOLA'),
(1583, 38, 'Cordoba', 'Quindío', 'Municipio', 'QUI_COR', '63212', '63', '', 'DIVIPOLA'),
(1584, 38, 'Filandia', 'Quindío', 'Municipio', 'QUI_FIL', '63272', '63', '', 'DIVIPOLA'),
(1585, 38, 'Genova', 'Quindío', 'Municipio', 'QUI_GEN', '63302', '63', '', 'DIVIPOLA'),
(1586, 38, 'La Tebaida', 'Quindío', 'Municipio', 'QUI_LA ', '63401', '63', '', 'DIVIPOLA'),
(1587, 38, 'Montenegro', 'Quindío', 'Municipio', 'QUI_MON', '63470', '63', '', 'DIVIPOLA'),
(1588, 38, 'Pijao', 'Quindío', 'Municipio', 'QUI_PIJ', '63548', '63', '', 'DIVIPOLA'),
(1589, 38, 'Quimbaya', 'Quindío', 'Municipio', 'QUI_QUI', '63594', '63', '', 'DIVIPOLA'),
(1590, 38, 'Salento', 'Quindío', 'Municipio', 'QUI_SAL', '63690', '63', '', 'DIVIPOLA'),
(1591, 39, 'La Celia', 'Risaralda', 'Municipio', 'RIS_CEL', '66383', '66', '', 'DIVIPOLA'),
(1598, 39, 'La Virginia', 'Risaralda', 'Municipio', 'RIS_VIR', '66400', '66', '', 'DIVIPOLA'),
(1605, 39, 'Apia', 'Risaralda', 'Municipio', 'RIS_API', '66045', '66', '', 'DIVIPOLA'),
(1612, 39, 'Balboa', 'Risaralda', 'Municipio', 'RIS_BAL', '66075', '66', '', 'DIVIPOLA'),
(1619, 39, 'Belen De Umbria', 'Risaralda', 'Municipio', 'RIS_BEL', '66088', '66', '', 'DIVIPOLA'),
(1626, 39, 'Dos Quebradas', 'Risaralda', 'Municipio', 'RIS_DOS', '66170', '66', '', 'DIVIPOLA'),
(1633, 39, 'Guatica', 'Risaralda', 'Municipio', 'RIS_GUA', '66318', '66', '', 'DIVIPOLA'),
(1640, 39, 'Marsella', 'Risaralda', 'Municipio', 'RIS_MAR', '66440', '66', '', 'DIVIPOLA'),
(1647, 39, 'Mistrato', 'Risaralda', 'Municipio', 'RIS_MIS', '66456', '66', '', 'DIVIPOLA'),
(1654, 39, 'Pereira', 'Risaralda', 'Municipio', 'RIS_PER', '66001', '66', '', 'DIVIPOLA'),
(1661, 39, 'Pueblo Rico', 'Risaralda', 'Municipio', 'RIS_PUE', '66572', '66', '', 'DIVIPOLA'),
(1668, 39, 'Quinchia', 'Risaralda', 'Municipio', 'RIS_QUI', '66594', '66', '', 'DIVIPOLA'),
(1675, 39, 'Santa Rosa De Cabal', 'Risaralda', 'Municipio', 'RIS_ROS', '66682', '66', '', 'DIVIPOLA'),
(1682, 39, 'Santuario', 'Risaralda', 'Municipio', 'RIS_SAN', '66687', '66', '', 'DIVIPOLA'),
(1689, 40, 'Barbosa', 'Santander', 'Municipio', 'SAN_BAB', '68077', '68', '', 'DIVIPOLA'),
(1690, 40, 'Barrancabermeja', 'Santander', 'Municipio', 'SAN_BAM', '68081', '68', '', 'DIVIPOLA'),
(1691, 40, 'Charala', 'Santander', 'Municipio', 'SAN_CHA', '68167', '68', '', 'DIVIPOLA'),
(1692, 40, 'Charta', 'Santander', 'Municipio', 'SAN_CHT', '68169', '68', '', 'DIVIPOLA'),
(1693, 40, 'Chima', 'Santander', 'Municipio', 'SAN_CHM', '68176', '68', '', 'DIVIPOLA'),
(1694, 40, 'Chipata', 'Santander', 'Municipio', 'SAN_CHI', '68179', '68', '', 'DIVIPOLA'),
(1695, 40, 'Concepcion', 'Santander', 'Municipio', 'SAN_COO', '68207', '68', '', 'DIVIPOLA'),
(1696, 40, 'Confines', 'Santander', 'Municipio', 'SAN_COF', '68209', '68', '', 'DIVIPOLA'),
(1697, 40, 'Contratacion', 'Santander', 'Municipio', 'SAN_CON', '68211', '68', '', 'DIVIPOLA'),
(1698, 40, 'El Carmen De Chucuri', 'Santander', 'Municipio', 'SAN_ELC', '68235', '68', '', 'DIVIPOLA'),
(1699, 40, 'El Guacamayo', 'Santander', 'Municipio', 'SAN_ELG', '68245', '68', '', 'DIVIPOLA'),
(1700, 40, 'El Peñon', 'Santander', 'Municipio', 'SAN_ELP', '68250', '68', '', 'DIVIPOLA'),
(1701, 40, 'El Playon', 'Santander', 'Municipio', 'SAN_PLA', '68255', '68', '', 'DIVIPOLA'),
(1702, 40, 'Encino', 'Santander', 'Municipio', 'SAN_ENC', '68264', '68', '', 'DIVIPOLA'),
(1703, 40, 'Enciso', 'Santander', 'Municipio', 'SAN_ENS', '68266', '68', '', 'DIVIPOLA'),
(1704, 40, 'Florian', 'Santander', 'Municipio', 'SAN_FLO', '68271', '68', '', 'DIVIPOLA'),
(1705, 40, 'Floridablanca', 'Santander', 'Municipio', 'SAN_FLB', '68276', '68', '', 'DIVIPOLA'),
(1706, 40, 'Guaca', 'Santander', 'Municipio', 'SAN_GUA', '68318', '68', '', 'DIVIPOLA'),
(1707, 40, 'Guadalupe', 'Santander', 'Municipio', 'SAN_GUL', '68320', '68', '', 'DIVIPOLA'),
(1708, 40, 'Guapota', 'Santander', 'Municipio', 'SAN_GUP', '68322', '68', '', 'DIVIPOLA'),
(1709, 40, 'Guavata', 'Santander', 'Municipio', 'SAN_GUV', '68324', '68', '', 'DIVIPOLA'),
(1710, 40, 'La Belleza', 'Santander', 'Municipio', 'SAN_BEL', '68377', '68', '', 'DIVIPOLA'),
(1711, 40, 'La Paz', 'Santander', 'Municipio', 'SAN_PAZ', '68397', '68', '', 'DIVIPOLA'),
(1712, 40, 'Palmar', 'Santander', 'Municipio', 'SAN_PAM', '68522', '68', '', 'DIVIPOLA'),
(1713, 40, 'Palmas Del Socorro', 'Santander', 'Municipio', 'SAN_PAL', '68524', '68', '', 'DIVIPOLA'),
(1714, 40, 'Puente Nacional', 'Santander', 'Municipio', 'SAN_PUN', '68572', '68', '', 'DIVIPOLA'),
(1715, 40, 'Puerto Parra', 'Santander', 'Municipio', 'SAN_PRR', '68573', '68', '', 'DIVIPOLA'),
(1716, 40, 'Puerto Wilches', 'Santander', 'Municipio', 'SAN_PUE', '68575', '68', '', 'DIVIPOLA'),
(1717, 40, 'San Andres', 'Santander', 'Municipio', 'SAN_AND', '68669', '68', '', 'DIVIPOLA'),
(1718, 40, 'San Benito', 'Santander', 'Municipio', 'SAN_BEN', '68673', '68', '', 'DIVIPOLA'),
(1719, 40, 'San Gil', 'Santander', 'Municipio', 'SAN_GIL', '68679', '68', '', 'DIVIPOLA'),
(1720, 40, 'San Joaquin', 'Santander', 'Municipio', 'SAN_JOA', '68682', '68', '', 'DIVIPOLA'),
(1721, 40, 'San Jose De Miranda', 'Santander', 'Municipio', 'SAN_JOS', '68684', '68', '', 'DIVIPOLA'),
(1722, 40, 'San Miguel', 'Santander', 'Municipio', 'SAN_MIG', '68686', '68', '', 'DIVIPOLA'),
(1723, 40, 'San Vicente De Chucuri', 'Santander', 'Municipio', 'SAN_VIC', '68689', '68', '', 'DIVIPOLA'),
(1724, 40, 'Santa Helena Del Opon', 'Santander', 'Municipio', 'SAN_SAN', '68720', '68', '', 'DIVIPOLA'),
(1725, 40, 'Aguada', 'Santander', 'Municipio', 'SAN_AGU', '68013', '68', '', 'DIVIPOLA'),
(1726, 40, 'Albania', 'Santander', 'Municipio', 'SAN_ALB', '68020', '68', '', 'DIVIPOLA'),
(1727, 40, 'Aratoca', 'Santander', 'Municipio', 'SAN_ARA', '68051', '68', '', 'DIVIPOLA'),
(1728, 40, 'Betulia', 'Santander', 'Municipio', 'SAN_BET', '68092', '68', '', 'DIVIPOLA'),
(1729, 40, 'Bolivar', 'Santander', 'Municipio', 'SAN_BOL', '68101', '68', '', 'DIVIPOLA'),
(1730, 40, 'Bucaramanga', 'Santander', 'Municipio', 'SAN_BUC', '68001', '68', '', 'DIVIPOLA'),
(1731, 40, 'Cabrera', 'Santander', 'Municipio', 'SAN_CAB', '68121', '68', '', 'DIVIPOLA'),
(1732, 40, 'California', 'Santander', 'Municipio', 'SAN_CAL', '68132', '68', '', 'DIVIPOLA'),
(1733, 40, 'Capitanejo', 'Santander', 'Municipio', 'SAN_CAP', '68147', '68', '', 'DIVIPOLA'),
(1734, 40, 'Carcasi', 'Santander', 'Municipio', 'SAN_CAR', '68152', '68', '', 'DIVIPOLA'),
(1735, 40, 'Cepita', 'Santander', 'Municipio', 'SAN_CEP', '68160', '68', '', 'DIVIPOLA'),
(1736, 40, 'Cerrito', 'Santander', 'Municipio', 'SAN_CER', '68162', '68', '', 'DIVIPOLA'),
(1737, 40, 'Cimitarra', 'Santander', 'Municipio', 'SAN_CIM', '68190', '68', '', 'DIVIPOLA'),
(1738, 40, 'Coromoro', 'Santander', 'Municipio', 'SAN_COR', '68217', '68', '', 'DIVIPOLA'),
(1739, 40, 'Curiti', 'Santander', 'Municipio', 'SAN_CUR', '68229', '68', '', 'DIVIPOLA'),
(1740, 40, 'Galan', 'Santander', 'Municipio', 'SAN_GAL', '68296', '68', '', 'DIVIPOLA'),
(1741, 40, 'Gambita', 'Santander', 'Municipio', 'SAN_GAM', '68298', '68', '', 'DIVIPOLA'),
(1742, 40, 'Giron', 'Santander', 'Municipio', 'SAN_GIR', '68307', '68', '', 'DIVIPOLA'),
(1743, 40, 'Guepsa', 'Santander', 'Municipio', 'SAN_GUE', '68327', '68', '', 'DIVIPOLA'),
(1744, 40, 'Hato', 'Santander', 'Municipio', 'SAN_HAT', '68344', '68', '', 'DIVIPOLA'),
(1745, 40, 'Jesus Maria', 'Santander', 'Municipio', 'SAN_JES', '68368', '68', '', 'DIVIPOLA'),
(1746, 40, 'Jordan', 'Santander', 'Municipio', 'SAN_JOR', '68370', '68', '', 'DIVIPOLA'),
(1747, 40, 'Landazuri', 'Santander', 'Municipio', 'SAN_LAN', '68385', '68', '', 'DIVIPOLA'),
(1748, 40, 'Lebrija', 'Santander', 'Municipio', 'SAN_LEB', '68406', '68', '', 'DIVIPOLA'),
(1749, 40, 'Los Santos', 'Santander', 'Municipio', 'SAN_LOS', '68418', '68', '', 'DIVIPOLA'),
(1750, 40, 'Macaravita', 'Santander', 'Municipio', 'SAN_MAC', '68425', '68', '', 'DIVIPOLA'),
(1751, 40, 'Malaga', 'Santander', 'Municipio', 'SAN_MAL', '68432', '68', '', 'DIVIPOLA'),
(1752, 40, 'Matanza', 'Santander', 'Municipio', 'SAN_MAT', '68444', '68', '', 'DIVIPOLA'),
(1753, 40, 'Mogotes', 'Santander', 'Municipio', 'SAN_MOG', '68464', '68', '', 'DIVIPOLA'),
(1754, 40, 'Molagavita', 'Santander', 'Municipio', 'SAN_MOL', '68468', '68', '', 'DIVIPOLA'),
(1755, 40, 'Ocamonte', 'Santander', 'Municipio', 'SAN_OCA', '68498', '68', '', 'DIVIPOLA'),
(1756, 40, 'Oiba', 'Santander', 'Municipio', 'SAN_OIB', '68500', '68', '', 'DIVIPOLA'),
(1757, 40, 'Onzaga', 'Santander', 'Municipio', 'SAN_ONZ', '68502', '68', '', 'DIVIPOLA'),
(1758, 40, 'Paramo', 'Santander', 'Municipio', 'SAN_PAR', '68533', '68', '', 'DIVIPOLA'),
(1759, 40, 'Piedecuesta', 'Santander', 'Municipio', 'SAN_PIE', '68547', '68', '', 'DIVIPOLA'),
(1760, 40, 'Pinchote', 'Santander', 'Municipio', 'SAN_PIN', '68549', '68', '', 'DIVIPOLA'),
(1761, 40, 'Rionegro', 'Santander', 'Municipio', 'SAN_RIO', '68615', '68', '', 'DIVIPOLA'),
(1762, 40, 'Sabana De Torres', 'Santander', 'Municipio', 'SAN_SAB', '68655', '68', '', 'DIVIPOLA'),
(1763, 40, 'Simacota', 'Santander', 'Municipio', 'SAN_SIM', '68745', '68', '', 'DIVIPOLA'),
(1764, 40, 'Socorro', 'Santander', 'Municipio', 'SAN_SOC', '68755', '68', '', 'DIVIPOLA'),
(1765, 40, 'Suaita', 'Santander', 'Municipio', 'SAN_SUA', '68770', '68', '', 'DIVIPOLA'),
(1766, 40, 'Sucre', 'Santander', 'Municipio', 'SAN_SUC', '68773', '68', '', 'DIVIPOLA'),
(1767, 40, 'Surata', 'Santander', 'Municipio', 'SAN_SUR', '68780', '68', '', 'DIVIPOLA'),
(1768, 40, 'Tona', 'Santander', 'Municipio', 'SAN_TON', '68820', '68', '', 'DIVIPOLA'),
(1769, 40, 'Valle De San Jose', 'Santander', 'Municipio', 'SAN_VAL', '68855', '68', '', 'DIVIPOLA'),
(1770, 40, 'Velez', 'Santander', 'Municipio', 'SAN_VEL', '68861', '68', '', 'DIVIPOLA'),
(1771, 40, 'Vetas', 'Santander', 'Municipio', 'SAN_VET', '68867', '68', '', 'DIVIPOLA'),
(1772, 40, 'Villanueva', 'Santander', 'Municipio', 'SAN_VIL', '68872', '68', '', 'DIVIPOLA'),
(1773, 40, 'Zapatoca', 'Santander', 'Municipio', 'SAN_ZAP', '68895', '68', '', 'DIVIPOLA'),
(1774, 40, 'Barichara', 'Santander', 'Municipio', 'SAN_BAC', '68079', '68', '', 'DIVIPOLA'),
(1775, 40, 'Santa Barbara', 'Santander', 'Municipio', 'SAN_BAR', '68705', '68', '', 'DIVIPOLA'),
(1776, 41, 'San Benito Abad', 'Sucre', 'Municipio', 'SUC_BEN', '70678', '70', '', 'DIVIPOLA'),
(1779, 41, 'San Juan Betulia', 'Sucre', 'Municipio', 'SUC_JUA', '70702', '70', '', 'DIVIPOLA'),
(1782, 41, 'San Marcos', 'Sucre', 'Municipio', 'SUC_MAR', '70708', '70', '', 'DIVIPOLA'),
(1785, 41, 'San Onofre', 'Sucre', 'Municipio', 'SUC_ONO', '70713', '70', '', 'DIVIPOLA'),
(1788, 41, 'San Pedro', 'Sucre', 'Municipio', 'SUC_PED', '70717', '70', '', 'DIVIPOLA'),
(1791, 41, 'Santiago De Tolu', 'Sucre', 'Municipio', 'SUC_SAN', '70820', '70', '', 'DIVIPOLA'),
(1794, 41, 'Buenavista', 'Sucre', 'Municipio', 'SUC_BUE', '70110', '70', '', 'DIVIPOLA'),
(1797, 41, 'Caimito', 'Sucre', 'Municipio', 'SUC_CAI', '70124', '70', '', 'DIVIPOLA'),
(1800, 41, 'Chalan', 'Sucre', 'Municipio', 'SUC_CHA', '70230', '70', '', 'DIVIPOLA'),
(1803, 41, 'Coloso', 'Sucre', 'Municipio', 'SUC_COL', '70204', '70', '', 'DIVIPOLA'),
(1806, 41, 'Corozal', 'Sucre', 'Municipio', 'SUC_COR', '70215', '70', '', 'DIVIPOLA'),
(1809, 41, 'Coveñas', 'Sucre', 'Municipio', 'SUC_COV', '70221', '70', '', 'DIVIPOLA'),
(1812, 41, 'El Roble', 'Sucre', 'Municipio', 'SUC_EL ', '70233', '70', '', 'DIVIPOLA'),
(1815, 41, 'Galeras', 'Sucre', 'Municipio', 'SUC_GAL', '70235', '70', '', 'DIVIPOLA'),
(1818, 41, 'Guaranda', 'Sucre', 'Municipio', 'SUC_GUA', '70265', '70', '', 'DIVIPOLA'),
(1821, 41, 'La Union', 'Sucre', 'Municipio', 'SUC_LA ', '70400', '70', '', 'DIVIPOLA'),
(1824, 41, 'Los Palmitos', 'Sucre', 'Municipio', 'SUC_LOS', '70418', '70', '', 'DIVIPOLA'),
(1827, 41, 'Majagual', 'Sucre', 'Municipio', 'SUC_MAJ', '70429', '70', '', 'DIVIPOLA'),
(1830, 41, 'Morroa', 'Sucre', 'Municipio', 'SUC_MOR', '70473', '70', '', 'DIVIPOLA'),
(1833, 41, 'Ovejas', 'Sucre', 'Municipio', 'SUC_OVE', '70508', '70', '', 'DIVIPOLA'),
(1836, 41, 'Palmito', 'Sucre', 'Municipio', 'SUC_PAL', '70523', '70', '', 'DIVIPOLA'),
(1839, 41, 'Sampues', 'Sucre', 'Municipio', 'SUC_SAM', '70670', '70', '', 'DIVIPOLA'),
(1842, 41, 'Sucre', 'Sucre', 'Municipio', 'SUC_SUC', '70771', '70', '', 'DIVIPOLA'),
(1845, 41, 'Tolu Viejo', 'Sucre', 'Municipio', 'SUC_TOL', '70823', '70', '', 'DIVIPOLA'),
(1852, 41, 'Since', 'Sucre', 'Municipio', 'SUC_SIC', '70742', '70', '', 'DIVIPOLA'),
(1859, 41, 'Sincelejo', 'Sucre', 'Municipio', 'SUC_SIN', '70001', '70', '', 'DIVIPOLA'),
(1866, 42, 'San Antonio', 'Tolima', 'Municipio', 'TOL_ANT', '73675', '73', '', 'DIVIPOLA'),
(1867, 42, 'San Luis', 'Tolima', 'Municipio', 'TOL_LUI', '73678', '73', '', 'DIVIPOLA'),
(1868, 42, 'Santa Isabel', 'Tolima', 'Municipio', 'TOL_SAN', '73686', '73', '', 'DIVIPOLA'),
(1869, 42, 'Alpujarra', 'Tolima', 'Municipio', 'TOL_ALP', '73024', '73', '', 'DIVIPOLA'),
(1870, 42, 'Alvarado', 'Tolima', 'Municipio', 'TOL_ALV', '73026', '73', '', 'DIVIPOLA'),
(1871, 42, 'Ambalema', 'Tolima', 'Municipio', 'TOL_AMB', '73030', '73', '', 'DIVIPOLA'),
(1872, 42, 'Anzoategui', 'Tolima', 'Municipio', 'TOL_ANZ', '73043', '73', '', 'DIVIPOLA'),
(1873, 42, 'Armero Guayabal', 'Tolima', 'Municipio', 'TOL_ARM', '73055', '73', '', 'DIVIPOLA'),
(1874, 42, 'Ataco', 'Tolima', 'Municipio', 'TOL_ATA', '73067', '73', '', 'DIVIPOLA'),
(1875, 42, 'Cajamarca', 'Tolima', 'Municipio', 'TOL_CAJ', '73124', '73', '', 'DIVIPOLA'),
(1876, 42, 'Carmen De Apicala', 'Tolima', 'Municipio', 'TOL_CAR', '73148', '73', '', 'DIVIPOLA'),
(1877, 42, 'Casabianca', 'Tolima', 'Municipio', 'TOL_CAS', '73152', '73', '', 'DIVIPOLA'),
(1878, 42, 'Chaparral', 'Tolima', 'Municipio', 'TOL_CHA', '73168', '73', '', 'DIVIPOLA'),
(1879, 42, 'Coello', 'Tolima', 'Municipio', 'TOL_COE', '73200', '73', '', 'DIVIPOLA'),
(1880, 42, 'Coyaima', 'Tolima', 'Municipio', 'TOL_COY', '73217', '73', '', 'DIVIPOLA'),
(1881, 42, 'Cunday', 'Tolima', 'Municipio', 'TOL_CUN', '73226', '73', '', 'DIVIPOLA'),
(1882, 42, 'Dolores', 'Tolima', 'Municipio', 'TOL_DOL', '73236', '73', '', 'DIVIPOLA'),
(1883, 42, 'Espinal', 'Tolima', 'Municipio', 'TOL_ESP', '73268', '73', '', 'DIVIPOLA'),
(1884, 42, 'Falan', 'Tolima', 'Municipio', 'TOL_FAL', '73270', '73', '', 'DIVIPOLA'),
(1885, 42, 'Flandes', 'Tolima', 'Municipio', 'TOL_FLA', '73275', '73', '', 'DIVIPOLA'),
(1886, 42, 'Fresno', 'Tolima', 'Municipio', 'TOL_FRE', '73283', '73', '', 'DIVIPOLA'),
(1887, 42, 'Guamo', 'Tolima', 'Municipio', 'TOL_GUA', '73319', '73', '', 'DIVIPOLA'),
(1888, 42, 'Herveo', 'Tolima', 'Municipio', 'TOL_HER', '73347', '73', '', 'DIVIPOLA'),
(1889, 42, 'Honda', 'Tolima', 'Municipio', 'TOL_HON', '73349', '73', '', 'DIVIPOLA'),
(1890, 42, 'Ibague', 'Tolima', 'Municipio', 'TOL_IBA', '73001', '73', '', 'DIVIPOLA'),
(1891, 42, 'Icononzo', 'Tolima', 'Municipio', 'TOL_ICO', '73352', '73', '', 'DIVIPOLA'),
(1892, 42, 'Lerida', 'Tolima', 'Municipio', 'TOL_LER', '73408', '73', '', 'DIVIPOLA'),
(1893, 42, 'Libano', 'Tolima', 'Municipio', 'TOL_LIB', '73411', '73', '', 'DIVIPOLA'),
(1894, 42, 'Mariquita', 'Tolima', 'Municipio', 'TOL_MAR', '73443', '73', '', 'DIVIPOLA'),
(1895, 42, 'Melgar', 'Tolima', 'Municipio', 'TOL_MEL', '73449', '73', '', 'DIVIPOLA'),
(1896, 42, 'Murillo', 'Tolima', 'Municipio', 'TOL_MUR', '73461', '73', '', 'DIVIPOLA'),
(1897, 42, 'Natagaima', 'Tolima', 'Municipio', 'TOL_NAT', '73483', '73', '', 'DIVIPOLA'),
(1898, 42, 'Ortega', 'Tolima', 'Municipio', 'TOL_ORT', '73504', '73', '', 'DIVIPOLA'),
(1899, 42, 'Palocabildo', 'Tolima', 'Municipio', 'TOL_PAL', '73520', '73', '', 'DIVIPOLA'),
(1900, 42, 'Piedras', 'Tolima', 'Municipio', 'TOL_PIE', '73547', '73', '', 'DIVIPOLA'),
(1901, 42, 'Planadas', 'Tolima', 'Municipio', 'TOL_PLA', '73555', '73', '', 'DIVIPOLA'),
(1902, 42, 'Prado', 'Tolima', 'Municipio', 'TOL_PRA', '73563', '73', '', 'DIVIPOLA'),
(1903, 42, 'Purificacion', 'Tolima', 'Municipio', 'TOL_PUR', '73585', '73', '', 'DIVIPOLA'),
(1904, 42, 'Rioblanco', 'Tolima', 'Municipio', 'TOL_RIO', '73616', '73', '', 'DIVIPOLA'),
(1905, 42, 'Roncesvalles', 'Tolima', 'Municipio', 'TOL_RON', '73622', '73', '', 'DIVIPOLA'),
(1906, 42, 'Rovira', 'Tolima', 'Municipio', 'TOL_ROV', '73624', '73', '', 'DIVIPOLA'),
(1907, 42, 'Saldaña', 'Tolima', 'Municipio', 'TOL_SAL', '73671', '73', '', 'DIVIPOLA'),
(1908, 42, 'Suarez', 'Tolima', 'Municipio', 'TOL_SUA', '73770', '73', '', 'DIVIPOLA'),
(1909, 42, 'Valle De San Juan', 'Tolima', 'Municipio', 'TOL_VAL', '73854', '73', '', 'DIVIPOLA'),
(1910, 42, 'Venadillo', 'Tolima', 'Municipio', 'TOL_VEN', '73861', '73', '', 'DIVIPOLA'),
(1911, 42, 'Villahermosa', 'Tolima', 'Municipio', 'TOL_VIH', '73870', '73', '', 'DIVIPOLA'),
(1912, 42, 'Villarrica', 'Tolima', 'Municipio', 'TOL_VIL', '73873', '73', '', 'DIVIPOLA'),
(1913, 43, 'Buga', 'Valle Del Cauca', 'Municipio', 'VAL_BUG', '76111', '76', '', 'DIVIPOLA'),
(1914, 43, 'Bugalagrande', 'Valle Del Cauca', 'Municipio', 'VAL_BUD', '76113', '76', '', 'DIVIPOLA'),
(1915, 43, 'Cali', 'Valle Del Cauca', 'Municipio', 'VAL_CAL', '76001', '76', '', 'DIVIPOLA'),
(1916, 43, 'Calima', 'Valle Del Cauca', 'Municipio', 'VAL_CAM', '76126', '76', '', 'DIVIPOLA'),
(1917, 43, 'El Aguila', 'Valle Del Cauca', 'Municipio', 'VAL_AGU', '76243', '76', '', 'DIVIPOLA'),
(1918, 43, 'El Cairo', 'Valle Del Cauca', 'Municipio', 'VAL_ECA', '76246', '76', '', 'DIVIPOLA'),
(1919, 43, 'El Cerrito', 'Valle Del Cauca', 'Municipio', 'VAL_ELC', '76248', '76', '', 'DIVIPOLA'),
(1920, 43, 'El Dovio', 'Valle Del Cauca', 'Municipio', 'VAL_ELD', '76250', '76', '', 'DIVIPOLA'),
(1921, 43, 'La Cumbre', 'Valle Del Cauca', 'Municipio', 'VAL_CUM', '76377', '76', '', 'DIVIPOLA'),
(1922, 43, 'La Union', 'Valle Del Cauca', 'Municipio', 'VAL_UNI', '76400', '76', '', 'DIVIPOLA'),
(1923, 43, 'La Victoria', 'Valle Del Cauca', 'Municipio', 'VAL_VIC', '76403', '76', '', 'DIVIPOLA'),
(1924, 43, 'Alcala', 'Valle Del Cauca', 'Municipio', 'VAL_ALC', '76020', '76', '', 'DIVIPOLA'),
(1925, 43, 'Andalucia', 'Valle Del Cauca', 'Municipio', 'VAL_AND', '76036', '76', '', 'DIVIPOLA');
INSERT INTO `lut_codes` (`LUT_COD_ID`, `LUT_COD_PID`, `LUT_COD_NAME`, `LUT_COD_PNAME`, `LUT_COD_DESCRIPTION`, `LUT_COD_ABBREVIATION`, `LUT_COD_OTHER1`, `LUT_COD_OTHER2`, `LUT_COD_OTHER3`, `LUT_COD_TYPE`) VALUES
(1926, 43, 'Ansermanuevo', 'Valle Del Cauca', 'Municipio', 'VAL_ANS', '76041', '76', '', 'DIVIPOLA'),
(1927, 43, 'Argelia', 'Valle Del Cauca', 'Municipio', 'VAL_ARG', '76054', '76', '', 'DIVIPOLA'),
(1928, 43, 'Bolivar', 'Valle Del Cauca', 'Municipio', 'VAL_BOL', '76100', '76', '', 'DIVIPOLA'),
(1929, 43, 'Buenaventura', 'Valle Del Cauca', 'Municipio', 'VAL_BUE', '76109', '76', '', 'DIVIPOLA'),
(1930, 43, 'Caicedonia', 'Valle Del Cauca', 'Municipio', 'VAL_CAI', '76122', '76', '', 'DIVIPOLA'),
(1931, 43, 'Candelaria', 'Valle Del Cauca', 'Municipio', 'VAL_CAN', '76130', '76', '', 'DIVIPOLA'),
(1932, 43, 'Cartago', 'Valle Del Cauca', 'Municipio', 'VAL_CAR', '76147', '76', '', 'DIVIPOLA'),
(1933, 43, 'Dagua', 'Valle Del Cauca', 'Municipio', 'VAL_DAG', '76233', '76', '', 'DIVIPOLA'),
(1934, 43, 'Florida', 'Valle Del Cauca', 'Municipio', 'VAL_FLO', '76275', '76', '', 'DIVIPOLA'),
(1935, 43, 'Ginebra', 'Valle Del Cauca', 'Municipio', 'VAL_GIN', '76306', '76', '', 'DIVIPOLA'),
(1936, 43, 'Guacari', 'Valle Del Cauca', 'Municipio', 'VAL_GUA', '76318', '76', '', 'DIVIPOLA'),
(1937, 43, 'Jamundi', 'Valle Del Cauca', 'Municipio', 'VAL_JAM', '76364', '76', '', 'DIVIPOLA'),
(1938, 43, 'Obando', 'Valle Del Cauca', 'Municipio', 'VAL_OBA', '76497', '76', '', 'DIVIPOLA'),
(1939, 43, 'Palmira', 'Valle Del Cauca', 'Municipio', 'VAL_PAL', '76520', '76', '', 'DIVIPOLA'),
(1940, 43, 'Pradera', 'Valle Del Cauca', 'Municipio', 'VAL_PRA', '76563', '76', '', 'DIVIPOLA'),
(1941, 43, 'Restrepo', 'Valle Del Cauca', 'Municipio', 'VAL_RES', '76606', '76', '', 'DIVIPOLA'),
(1942, 43, 'Riofrio', 'Valle Del Cauca', 'Municipio', 'VAL_RIO', '76616', '76', '', 'DIVIPOLA'),
(1943, 43, 'Roldanillo', 'Valle Del Cauca', 'Municipio', 'VAL_ROL', '76622', '76', '', 'DIVIPOLA'),
(1944, 43, 'San Pedro', 'Valle Del Cauca', 'Municipio', 'VAL_SAN', '76670', '76', '', 'DIVIPOLA'),
(1945, 43, 'Sevilla', 'Valle Del Cauca', 'Municipio', 'VAL_SEV', '76736', '76', '', 'DIVIPOLA'),
(1946, 43, 'Toro', 'Valle Del Cauca', 'Municipio', 'VAL_TOR', '76823', '76', '', 'DIVIPOLA'),
(1947, 43, 'Trujillo', 'Valle Del Cauca', 'Municipio', 'VAL_TRU', '76828', '76', '', 'DIVIPOLA'),
(1948, 43, 'Tulua', 'Valle Del Cauca', 'Municipio', 'VAL_TUL', '76834', '76', '', 'DIVIPOLA'),
(1949, 43, 'Ulloa', 'Valle Del Cauca', 'Municipio', 'VAL_ULL', '76845', '76', '', 'DIVIPOLA'),
(1950, 43, 'Versalles', 'Valle Del Cauca', 'Municipio', 'VAL_VER', '76863', '76', '', 'DIVIPOLA'),
(1951, 43, 'Vijes', 'Valle Del Cauca', 'Municipio', 'VAL_VIJ', '76869', '76', '', 'DIVIPOLA'),
(1952, 43, 'Yotoco', 'Valle Del Cauca', 'Municipio', 'VAL_YOT', '76890', '76', '', 'DIVIPOLA'),
(1953, 43, 'Yumbo', 'Valle Del Cauca', 'Municipio', 'VAL_YUM', '76892', '76', '', 'DIVIPOLA'),
(1954, 43, 'Zarzal', 'Valle Del Cauca', 'Municipio', 'VAL_ZAR', '76895', '76', '', 'DIVIPOLA'),
(1955, 44, 'Caruru', 'Vaupés', 'Municipio', 'VAU_CAR', '97161', '97', '', 'DIVIPOLA'),
(1956, 44, 'Mitu', 'Vaupés', 'Municipio', 'VAU_MIT', '97001', '97', '', 'DIVIPOLA'),
(1957, 44, 'Taraira', 'Vaupés', 'Municipio', 'VAU_TAR', '97666', '97', '', 'DIVIPOLA'),
(1958, 45, 'Cumaribo', 'Vichada', 'Municipio', 'VIC_CUM', '99773', '99', '', 'DIVIPOLA'),
(1959, 45, 'La Primavera', 'Vichada', 'Municipio', 'VIC_LA ', '99524', '99', '', 'DIVIPOLA'),
(1960, 45, 'Puerto Carreño', 'Vichada', 'Municipio', 'VIC_PUE', '99001', '99', '', 'DIVIPOLA'),
(1961, 45, 'Santa Rosalia', 'Vichada', 'Municipio', 'VIC_SAN', '99624', '99', '', 'DIVIPOLA'),
(1962, 0, 'Oficinas', NULL, 'Oficinas del PMA', 'OFC', NULL, NULL, NULL, 'OFFICES'),
(1963, 1962, 'Colombia Country Office', 'Oficinas', 'Country Office', 'CO_CO', NULL, NULL, NULL, 'OFFICES'),
(1964, 1963, 'SubOficina Neiva', 'Colombia Country Office', 'SubOficina Neiva', 'CO_SO_NEI', NULL, NULL, NULL, 'OFFICES'),
(1965, 1963, 'SubOficina Quibdó', 'Colombia Country Office', 'SubOficina Quibdó', 'CO_SO_QUI', NULL, NULL, NULL, 'OFFICES'),
(1966, 1963, 'SubOficina Pasto', 'Colombia Country Office', 'SubOficina Pasto', 'CO_SO_PAS', NULL, NULL, NULL, 'OFFICES'),
(1967, 1963, 'SubOficina Montería', 'Colombia Country Office', 'SubOficina Montería', 'CO_SO_MON', NULL, NULL, NULL, 'OFFICES'),
(1968, 1964, 'Oficina Satélite Villavicencio', 'SubOficina Neiva', 'Oficina Satélite Villavicencio', 'NEI_OS_VIL', NULL, NULL, NULL, 'OFFICES'),
(1969, 1966, 'Oficina Satélite Buenaventura', 'SubOficina Pasto', 'Oficina Satélite Buenaventura', 'PAS_OS_BUE', NULL, NULL, NULL, 'OFFICES'),
(1970, 1967, 'Oficina Satélite Riohacha', 'SubOficina Montería', 'Oficina Satélite Riohacha', 'MON_OS_RIO', NULL, NULL, NULL, 'OFFICES'),
(1971, 1967, 'Oficina Satélite Arauca', 'SubOficina Montería', 'Oficina Satélite Arauca', 'MON_OS_ARA', NULL, NULL, NULL, 'OFFICES'),
(1972, 7, 'Asistente de Programas', 'Cargo', NULL, 'PROGRAMME_ASIST', NULL, NULL, NULL, 'POSITION'),
(1973, 7, 'Oficial de Emergencias y Asuntos humanitarios', 'Cargo', NULL, 'E&HA_OFFICER', NULL, NULL, NULL, 'POSITION'),
(1974, 7, 'Oficial de Políticas Públicas', 'Cargo', NULL, 'PP_OFFICER', NULL, NULL, NULL, 'POSITION'),
(1975, 7, 'Oficial de Programas', 'Cargo', NULL, 'PROGRAMME_OFC', NULL, NULL, NULL, 'POSITION'),
(1976, 7, 'Auxiliar SIO', 'Cargo', NULL, 'AUX_SIO', NULL, NULL, NULL, 'POSITION'),
(1977, 7, 'ICT', 'Cargo', NULL, 'ICT', NULL, NULL, NULL, 'POSITION'),
(1978, 10, 'Agregar', 'Privilegios', 'Permisos para agregar', 'ADD', '', '', '', 'PRIVILEGES'),
(1979, 10, 'Editar', 'Privilegios', 'Permisos de edición', 'EDIT', '', '', '', 'PRIVILEGES'),
(1980, 10, 'Eliminar', 'Privilegios', 'Permisos de eliminación', 'DELETE', '', '', '', 'PRIVILEGES'),
(1981, 0, 'Unidades de medida de tiempo', '', 'Códigos de las unidades de Medida de tiempo', 'TIMEFRAME_UNIT', NULL, NULL, NULL, 'TIMEFRAME_UNIT'),
(1982, 1981, 'Días', 'Unidades de medida de tiempo', 'Días', 'DAYS', NULL, NULL, NULL, 'TIMEFRAME_UNIT'),
(1983, 1981, 'Meses', 'Unidades de medida de tiempo', 'Meses', 'MONTHS', NULL, NULL, NULL, 'TIMEFRAME_UNIT'),
(1984, 1981, 'Años', 'Unidades de medida de tiempo', 'Años', 'YEARS', NULL, NULL, NULL, 'TIMEFRAME_UNIT'),
(1985, 0, 'Estado de actividad/inactividad', '', 'Estado de actividad/inactividad', 'STATUS', NULL, NULL, NULL, 'STATUS'),
(1986, 1985, 'Activo', 'Estado de actividad/inactividad', 'Activo', 'ACTIVE', NULL, NULL, NULL, 'STATUS'),
(1987, 1985, 'Inactivo', 'Estado de actividad/inactividad', 'Inactivo', 'INACTIVE', NULL, NULL, NULL, 'STATUS'),
(1988, 0, 'Tipo de Modalidad', NULL, 'Tipo de modalidad', 'MOD_TYPE', NULL, NULL, NULL, 'MOD_TYPE'),
(1989, 1988, 'Alimentaria', 'Tipo de Modalidad', 'Modalidad Alimentaria', 'FOOD', NULL, NULL, NULL, 'MOD_TYPE'),
(1990, 1988, 'No Alimentaria', 'Tipo de Modalidad', 'Modalidad no Alimentaria', 'NON_FOOD', NULL, NULL, NULL, 'MOD_TYPE'),
(1991, 0, 'Tipo de elemento', '', 'Tipo de elemento', 'COM_TYPE', '', '', '', 'COM_TYPE'),
(1992, 1991, 'Alimento', 'Tipo de elemento', 'Elemento tipo alimento', 'FOOD', '', '', '', 'COM_TYPE'),
(1993, 1991, 'No Alimento', 'Tipo de elemento', 'Elemento tipo no alimento', 'NON_FOOD', '', '', '', 'COM_TYPE');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `buss_ceilings`
--
ALTER TABLE `buss_ceilings`
  ADD CONSTRAINT `FK_LUD_COD_DIVIPOLA` FOREIGN KEY (`LUD_COD_DIVIPOLA`) REFERENCES `lut_codes` (`LUT_COD_ID`);

--
-- Filtros para la tabla `buss_commodities`
--
ALTER TABLE `buss_commodities`
  ADD CONSTRAINT `FK_LUT_COD_COM_TYPE` FOREIGN KEY (`LUT_COD_COM_TYPE`) REFERENCES `lut_codes` (`LUT_COD_ID`);

--
-- Filtros para la tabla `buss_commodity_attribute`
--
ALTER TABLE `buss_commodity_attribute`
  ADD CONSTRAINT `FK_BUS_COM_ID` FOREIGN KEY (`BUS_COM_ID`) REFERENCES `buss_commodities` (`BUS_COM_ID`);

--
-- Filtros para la tabla `buss_frm_by_mod`
--
ALTER TABLE `buss_frm_by_mod`
  ADD CONSTRAINT `FK_BUS_FRA_ID` FOREIGN KEY (`BUS_FRA_ID`) REFERENCES `buss_framework` (`BUS_FRA_ID`),
  ADD CONSTRAINT `FK_BUS_MOD_ID` FOREIGN KEY (`BUS_MOD_ID`) REFERENCES `buss_modalities` (`BUS_MOD_ID`);

--
-- Filtros para la tabla `buss_kit_by_mod`
--
ALTER TABLE `buss_kit_by_mod`
  ADD CONSTRAINT `FK_BUSS_KIT_ID` FOREIGN KEY (`BUSS_KIT_ID`) REFERENCES `buss_kits` (`BUS_KIT_ID`),
  ADD CONSTRAINT `FK_BUSS_MOD_ID` FOREIGN KEY (`BUSS_MOD_ID`) REFERENCES `buss_modalities` (`BUS_MOD_ID`);

--
-- Filtros para la tabla `core_contract`
--
ALTER TABLE `core_contract`
  ADD CONSTRAINT `FK_CORE_CONTRACT1` FOREIGN KEY (`COR_USR_ID`) REFERENCES `core_users` (`COR_USR_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `core_dpto_by_ofc`
--
ALTER TABLE `core_dpto_by_ofc`
  ADD CONSTRAINT `FK_CORE_DPTO_BY_OFC_01` FOREIGN KEY (`LUT_COD_OFFICES`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_DPTO_BY_OFC_02` FOREIGN KEY (`LUT_COD_DIVIPOLA`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `core_modules`
--
ALTER TABLE `core_modules`
  ADD CONSTRAINT `FK_LUT_COD_STATUS` FOREIGN KEY (`LUT_COD_STATUS`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `SR_CORE_MODULES` FOREIGN KEY (`COR_MOD_PID`) REFERENCES `core_modules` (`COR_MOD_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `core_ofc_by_usr`
--
ALTER TABLE `core_ofc_by_usr`
  ADD CONSTRAINT `FK_CORE_OFC_BY_USR_01` FOREIGN KEY (`COR_USR_ID`) REFERENCES `core_users` (`COR_USR_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_OFC_BY_USR_02` FOREIGN KEY (`LUT_COD_OFFICES`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `core_roles_by_user`
--
ALTER TABLE `core_roles_by_user`
  ADD CONSTRAINT `FK_CORE_ROLES_BY_USER_01` FOREIGN KEY (`COR_ROL_ID`) REFERENCES `core_roles` (`COR_ROL_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_ROLES_BY_USER_02` FOREIGN KEY (`COR_USR_ID`) REFERENCES `core_users` (`COR_USR_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `core_users`
--
ALTER TABLE `core_users`
  ADD CONSTRAINT `FK_CORE_USERS_01` FOREIGN KEY (`LUT_COD_ORGANIZATION`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_USERS_02` FOREIGN KEY (`LUT_COD_POSITION`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CORE_USERS_03` FOREIGN KEY (`LUT_COD_USERSTATUS`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `lut_codes`
--
ALTER TABLE `lut_codes`
  ADD CONSTRAINT `SR_LUT_CODES` FOREIGN KEY (`LUT_COD_PID`) REFERENCES `lut_codes` (`LUT_COD_ID`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

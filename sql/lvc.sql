--
-- Base de datos: `lvc`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin_modulos`
--

CREATE TABLE IF NOT EXISTS `admin_modulos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `nivel_acceso` int(11) NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descripcion` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `nombre` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `orden` int(11) DEFAULT NULL,
  `modulo_padre` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`nivel_acceso`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `admin_modulos`
--

INSERT INTO `admin_modulos` (`id`, `modulo`, `nivel_acceso`, `alta`, `fecha_alta`, `descripcion`, `nombre`, `orden`, `modulo_padre`) VALUES
(1, 'usuario', 1, 'S', '2012-06-17 10:34:52', 'para acceder a la zona de edici�n', 'Usuarios', NULL, 0),
(2, 'pagina', 2, 'S', '2012-06-17 10:34:52', 'para enlazar desde la web', 'P�ginas web', NULL, 0),
(3, 'espacio', 3, 'S', '2012-06-17 10:34:52', 'para saber d�nde se proyecta', 'Espacios', NULL, 6),
(4, 'pelicula', 3, 'S', '2012-06-17 10:34:52', 'pel�culas que se van a proyectar', 'Pel�culas', NULL, 0),
(5, 'convocatoria', 3, 'S', '2012-06-17 10:34:52', 'obras recibidas en la convocatoria abierta', 'Autoproducciones', NULL, 5),
(6, 'proyeccion', 3, 'S', '2012-06-17 10:34:52', 'para definir  lugar y hora de la proyecci�n', 'Proyecciones', NULL, 0),
(7, 'agradecimiento', 3, 'S', '2012-06-17 10:34:52', 'para a�adir nota de agradecimiento a quien a cedido la peli', 'Agradecimientos', NULL, 4),
(8, 'texto', 2, 'S', '2012-06-17 10:34:52', 'textos para enlazar desde la web', 'Textos', NULL, 0),
(9, 'imagen', 2, 'S', '2012-06-17 10:34:52', 'galeria de im�genes y v�deos', 'Multimedia', NULL, 0),
(10, 'edicion', 3, 'S', '2012-06-17 10:34:52', 'informaci�n b�sica de la muestra', 'Muestras', NULL, 0),
(11, 'modulos', 1, 'S', '2012-06-17 10:34:52', 'funcionalidades de la zona de edici�n', 'Modulos', NULL, 0),
(12, 'doc', 2, 'S', '2012-06-17 10:34:52', 'para descargar', 'Documentos', NULL, 0),
(13, 'galeria', 2, 'S', '2012-06-17 10:34:52', 'de fotos y v�deos', 'Galerias', NULL, 9),
(14, 'moduloweb', 1, 'S', '2012-06-17 10:34:52', 'Funcionalidades de la p�gina web', 'Modulos web', NULL, 11),
(15, 'phpinfo', 1, 'S', '2012-06-17 10:34:52', 'Informacion php', 'Info servidor', NULL, 20),
(16, 'perfil', 1, 'S', '2012-06-17 10:34:52', 'Define qu� modulos puede gestionar el usuario', 'Perfil navegaci�n', NULL, 1),
(18, 'convocatorias', 3, 'S', '2012-06-17 10:34:52', 'Convocatorias abiertas', 'Convocatorias', NULL, 10),
(19, 'cache', 1, 'S', '2012-06-17 10:34:52', 'administraci�n de la cach� de memoria', 'Cach�', NULL, 20),
(20, 'skins', 1, 'S', '2012-06-17 10:34:52', 'Dise�o de la zona de administraci�n', 'Admin', NULL, 0),
(21, 'langs', 1, 'S', '2012-06-17 10:34:52', 'Idiomas del site', 'Idiomas', NULL, 0),
(22, 'licencia', 3, 'S', '2012-06-17 10:34:52', 'Licencia para la distribuci�n de una pel�cula', 'Licencia', NULL, 4),
(23, 'convocatoria', 3, 'S', '2012-06-20 19:32:55', 'gesti�n de las obras recibidas en la convocatoria abierta', 'Convocatoria', NULL, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autores`
--

CREATE TABLE IF NOT EXISTS `autores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `autor` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `id_pelicula` int(11) NOT NULL,
  `email` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `telefono` int(11) DEFAULT NULL,
  `tipo` varchar(2) COLLATE latin1_general_ci NOT NULL DEFAULT '01',
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`id_pelicula`),
  KEY `id_pelicula` (`id_pelicula`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `autores`
--

INSERT INTO `autores` (`id`, `autor`, `id_pelicula`, `email`, `telefono`, `tipo`, `alta`, `fecha_alta`) VALUES
(3, 'Muestra de Cine de Lavapi�s', 8, 'muestra@lavapiesdecine.net', 0, '01', 'S', '2012-06-20 22:35:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `convocatoria`
--

CREATE TABLE IF NOT EXISTS `convocatoria` (
  `id` int(11) NOT NULL,
  `id_pelicula` int(11) NOT NULL,
  `autor` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `duracion` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `anyo` year(4) NOT NULL,
  `genero` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `pais` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `web` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `coste` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `recursos` text COLLATE latin1_general_ci,
  `comentarios` text COLLATE latin1_general_ci,
  `fecha_alta` datetime NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  KEY `id_pelicula` (`id_pelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Volcado de datos para la tabla `convocatoria`
--

INSERT INTO `convocatoria` (`id`, `id_pelicula`, `autor`, `duracion`, `anyo`, `genero`, `pais`, `web`, `coste`, `recursos`, `comentarios`, `fecha_alta`, `alta`) VALUES
(8, 8, 'Calipso Films', '1''17''''', 2011, 'Spot', 'Espa�a', 'http://calipso-films.net', '', '', '', '0000-00-00 00:00:00', 'S');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `convocatorias`
--

CREATE TABLE IF NOT EXISTS `convocatorias` (
  `id` varchar(4) COLLATE latin1_general_ci NOT NULL,
  `url` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT 'autoproduccion',
  `cartel` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `id_texto` int(11) NOT NULL DEFAULT '0' COMMENT 'id del texto de presentacion',
  `descripcion` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Volcado de datos para la tabla `convocatorias`
--

INSERT INTO `convocatorias` (`id`, `url`, `cartel`, `id_texto`, `descripcion`, `alta`) VALUES
('2012', 'material-recibido', 'atp_9.jpg', 0, 'Convocatoria de obras audiovisuales con licencia libre', 'S');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docs`
--

CREATE TABLE IF NOT EXISTS `docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `descripcion` varchar(500) COLLATE latin1_general_ci NOT NULL,
  `archivo` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `imagen` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `muestra` varchar(4) COLLATE latin1_general_ci NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `archivo` (`archivo`),
  KEY `muestra` (`muestra`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `donantes`
--

CREATE TABLE IF NOT EXISTS `donantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `donante` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `web` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `logo` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='tabla que almacena las distris, productoras... que ceden las pel�culas' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `donantes`
--

INSERT INTO `donantes` (`id`, `donante`, `web`, `logo`, `alta`, `fecha_alta`) VALUES
(0, '', NULL, NULL, 'N', '0000-00-00 00:00:00'),
(1, 'Fundaci�n quepo', 'http://www.quepo.org', 'fundacin-quepo.jpg', 'S', '2012-06-20 20:05:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ediciones`
--

CREATE TABLE IF NOT EXISTS `ediciones` (
  `id` varchar(4) COLLATE latin1_general_ci NOT NULL,
  `nombre` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `descripcion` text COLLATE latin1_general_ci,
  `cartel` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'N',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Volcado de datos para la tabla `ediciones`
--

INSERT INTO `ediciones` (`id`, `nombre`, `descripcion`, `cartel`, `fecha_inicio`, `fecha_fin`, `alta`, `fecha_alta`) VALUES
('2012', '9� Muestra de Cine de Lavapi�s', 'esto es una descripci�n', '9-muestra-de-cine-de-lavapies.jpg', '2012-06-22', '2012-07-01', 'S', '2012-06-17 10:34:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacios`
--

CREATE TABLE IF NOT EXISTS `espacios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `espacio` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `direccion` varchar(200) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `url` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `descripcion` text CHARACTER SET latin1 COLLATE latin1_bin,
  `latitud` double DEFAULT NULL,
  `longitud` double DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `img` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `alta` varchar(1) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='tabla que almacena los espacios de proyeccion' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `espacios`
--

INSERT INTO `espacios` (`id`, `espacio`, `direccion`, `url`, `descripcion`, `latitud`, `longitud`, `telefono`, `email`, `img`, `alta`, `fecha_alta`) VALUES
(0, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '0000-00-00 00:00:00'),
(1, 'Plaza de Lavapi�s', 'Plaza de Lavapi�s', '', '', 40.4087411, -3.7012135, 0, '', '20120617170617.jpg', 'S', '2012-06-17 15:55:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galerias`
--

CREATE TABLE IF NOT EXISTS `galerias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(500) COLLATE latin1_general_ci NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `galeria` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `galeria` (`galeria`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `galerias`
--

INSERT INTO `galerias` (`id`, `titulo`, `descripcion`, `galeria`, `alta`, `fecha_alta`) VALUES
(1, 'Carteles', NULL, 'carteles', 'S', '2012-06-17 10:34:52'),
(2, 'filmfestCMS', '', 'filmfestcms', 'S', '2012-06-17 10:34:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes`
--

CREATE TABLE IF NOT EXISTS `imagenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `id_galeria` int(11) NOT NULL,
  `url_video` varchar(300) COLLATE latin1_general_ci DEFAULT NULL COMMENT 'enlace al video',
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_galeria` (`id_galeria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=1 ;

INSERT INTO `imagenes` (`imagen`, `descripcion`, `id_galeria`, `url_video`, `alta`) VALUES
('9-muestra-de-cine-de-lavapies.jpg', '8� Muestra de Cine de Lavapi�s', 1, '', 'S'),
('cartel_atp_9.jpg', 'Convocatoria de obras audiovisuales con licencias libres', 1, '', 'S'),
('20120613110648.jpg', 'Panel de administraci�n', 2, '', 'S'),
('20120613110608.jpg', 'Ficha de pel�cula visible en la web', 2, '', 'S'),
('20120613110641.jpg', 'Administraci�n de pel�culas', 2, '', 'S'),
('20120613160625.jpg', 'Programa de proyecciones', 2, '', 'S'),
('20120613160654.jpg', 'Gestor de proyecciones', 2, '', 'S'),
('20120615120651.jpg', 'Gestor de nuevas p�ginas', 2, '', 'S');


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes_pelicula`
--

CREATE TABLE IF NOT EXISTS `imagenes_pelicula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `id_pelicula` int(11) NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_pelicula` (`id_pelicula`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `imagenes_pelicula`
--

INSERT INTO `imagenes_pelicula` (`id`, `imagen`, `descripcion`, `id_pelicula`, `alta`, `fecha_alta`) VALUES
(2, '20120621000636.jpg', NULL, 8, 'S', '2012-06-20 22:37:36'),
(3, 'interferencies-.jpg', NULL, 9, 'S', '2012-06-20 23:18:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `langs`
--

CREATE TABLE IF NOT EXISTS `langs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) COLLATE latin1_general_ci NOT NULL,
  `nombre` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `codigo` varchar(5) COLLATE latin1_general_ci NOT NULL,
  `codificacion` varchar(10) COLLATE latin1_general_ci NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `langs`
--

INSERT INTO `langs` (`id`, `lang`, `nombre`, `codigo`, `codificacion`, `alta`) VALUES
(1, 'es', 'Espa�ol', 'es_ES', 'ISO-8859-1', 'S'),
(2, 'fr', 'Fran�ais', 'fr_FR', 'UTF-8', 'S'),
(3, 'en', 'English', 'en_US', 'UTF-8', 'S'),
(4, 'de', 'Deutsch', 'de_DE', 'UTF-8', 'S'),
(5, 'it', 'Italiano', 'it_IT', 'UTF-8', 'S'),
(6, 'ca', 'Catal�', 'ca_ES', 'UTF-8', 'S'),
(7, 'eu', 'Euskera', 'eu_ES', 'UTF-8', 'S'),
(8, 'gl', 'Galego', 'gl_ES', 'UTF-8', 'S'),
(9, 'pt', 'Portugu�s', 'pt_PT', 'UTF-8', 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lang_edicion`
--

CREATE TABLE IF NOT EXISTS `lang_edicion` (
  `id_edicion` varchar(4) COLLATE latin1_general_ci NOT NULL,
  `lang` varchar(2) COLLATE latin1_general_ci NOT NULL,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `id_edicion` (`id_edicion`,`lang`),
  KEY `lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Volcado de datos para la tabla `lang_edicion`
--

INSERT INTO `lang_edicion` (`id_edicion`, `lang`, `fecha_alta`) VALUES
('2012', 'es', '2012-06-17 10:34:52'),
('2012', 'fr', '2012-06-17 10:34:52'),
('2012', 'ca', '2012-06-17 10:34:52'),
('2012', 'gl', '2012-06-17 10:34:52'),
('2012', 'en', '2012-06-17 10:34:52'),
('2012', 'de', '2012-06-17 10:34:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licencias`
--

CREATE TABLE IF NOT EXISTS `licencias` (
  `id` varchar(2) COLLATE latin1_general_ci NOT NULL,
  `nombre` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `url` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Volcado de datos para la tabla `licencias`
--

INSERT INTO `licencias` (`id`, `nombre`, `url`, `alta`) VALUES
('01', 'Copyright', NULL, 'S'),
('02', 'Creative commons', NULL, 'S'),
('03', 'Public domain', 'http://creativecommons.org/publicdomain/mark/1.0/deed.es', 'S'),
('04', 'cc by-nc-nd 3.0', 'http://creativecommons.org/licenses/by-nc-nd/3.0/deed.es', 'S'),
('05', 'cc by-nc-sa 3.0', 'http://creativecommons.org/licenses/by-nc-sa/3.0/deed.es', 'S'),
('06', 'cc by-nc 3.0', 'http://creativecommons.org/licenses/by-nc/3.0/deed.es', 'S'),
('07', 'cc by-nd 3.0', 'http://creativecommons.org/licenses/by-nd/3.0/deed.es', 'S'),
('08', 'cc by-sa 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/deed.es', 'S'),
('09', 'cc by 3.0', 'http://creativecommons.org/licenses/by/3.0/deed.es', 'S'),
('10', 'ColorIURIS Verde ', NULL, 'S'),
('11', 'ColorIURIS Rojo', NULL, 'S'),
('12', 'ColorIURIS Amarillo', NULL, 'S'),
('13', 'ColorIURIS Azul', NULL, 'S'),
('14', 'ColorIURIS Rojo-amarillo  ', NULL, 'S'),
('15', 'ColorIURIS Rojo-azul', NULL, 'S'),
('16', 'ColorIURIS Rojo-verde', NULL, 'S'),
('17', 'ColorIURIS Verde-amarillo', NULL, 'S'),
('18', 'ColorIURIS Verde-azul', NULL, 'S'),
('19', 'ColorIURIS Verde-rojo', NULL, 'S'),
('20', 'aire incodicional', 'http://artlibre.org/licence/lal/es', 'S'),
('21', 'free art 1.3', 'http://artlibre.org/licence/lal/es', 'S'),
('22', 'against drm 2.0', 'http://www.freecreations.org/Against_DRM2_es1.html', 'S');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `id_pagina` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `nivel` int(11) NOT NULL DEFAULT '0',
  `orden` int(11) NOT NULL,
  `portada` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id_pagina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id_pagina`, `nombre`, `nivel`, `orden`, `portada`) VALUES
(1, 'Espacios', 0, 3, 'N'),
(2, 'Escaparate', 0, 4, 'N'),
(3, 'Muestras', 0, 4, 'N'),
(4, 'Convocatorias', 0, 1, 'N'),
(5, 'Inicio', 0, 1, 'S'),
(6, 'FAQ', 0, 6, 'N'),
(7, 'Licencias libres', 0, 1, 'N'),
(8, 'Bases', 0, 1, 'N'),
(9, 'Convocatoria', 0, 3, 'N'),
(10, 'Incripci�n', 0, 3, 'N'),
(11, 'Obras recibidas', 0, 4, 'N'),
(12, 'Selecci�n', 0, 4, 'N'),
(13, 'Programa', 0, 2, 'N');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagina`
--

CREATE TABLE IF NOT EXISTS `pagina` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) COLLATE latin1_general_ci NOT NULL,
  `id_webmodulo` int(11) NOT NULL DEFAULT '0',
  `layout` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `titulo` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `descripcion` text COLLATE latin1_general_ci,
  `muestra` varchar(4) COLLATE latin1_general_ci NOT NULL,
  `skin` varchar(10) COLLATE latin1_general_ci NOT NULL DEFAULT '2012',
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_paginapadre` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`,`muestra`),
  KEY `muestra` (`muestra`),
  KEY `index5` (`id_webmodulo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=14 ;

--
-- Volcado de datos para la tabla `pagina`
--

INSERT INTO `pagina` (`id`, `url`, `id_webmodulo`, `layout`, `titulo`, `descripcion`, `muestra`, `skin`, `alta`, `fecha_alta`, `id_paginapadre`) VALUES
(1, 'espacios', 4, '1columna.phtml', 'Espacios de proyecci�n', 'Espacios de proyecci�n', '2012', '2012', 'S', '2012-06-17 15:51:04', 0),
(2, 'escaparate', 1, '1columna.phtml', 'As�mate a la muestra', 'Fotos y v�deos ', '2012', '2012', 'S', '2012-06-17 19:49:26', 0),
(3, 'muestras', 3, '2columnas.phtml', 'Muestras anteriores', 'Muestras anteriores', '2012', '2012', 'S', '2012-06-17 19:51:20', 0),
(4, 'convocatorias', 9, '2columnas.phtml', 'Convocatorias', 'Convocatorias de autoproducciones', '2012', '2012', 'S', '2012-06-17 19:52:09', 3),
(5, 'home', 7, '2columnas.phtml', '9� Muestra de Cine de Lavapi�s. 22 de junio - 1 de julio', '9� Muestra de Cine de Lavapi�s. 22 de junio - 1 de julio', '2012', '2012', 'S', '2012-06-17 19:59:59', 0),
(6, 'faq', 7, '2columnas.phtml', 'FAQ', 'faq', '2012', '2012', 'S', '2012-06-20 04:53:41', 0),
(7, 'licencias-libres', 7, '2columnas.phtml', 'licencias-libres', 'licencias-libres', '2012', '2012', 'S', '2012-06-20 05:05:15', 6),
(8, 'bases', 7, '2columnas.phtml', 'bases', 'bases', '2012', 'atp2012', 'S', '2012-06-20 05:07:10', 9),
(9, 'convocatoria-abierta', 7, '2columnas.phtml', 'convocatoria-abierta', 'convocatoria-abierta', '2012', '2012', 'S', '2012-06-20 05:09:14', 0),
(10, 'inscripcion', 5, '1columna.phtml', 'Incripci�n', 'Incripci�n de obras en la convocatoria de licencias libres', '2012', 'atp2012', 'S', '2012-06-20 19:17:12', 9),
(11, 'obras-recibidas', 13, '1columna.phtml', 'Obras recibidas', 'Obras recibidas', '2012', 'atp2012', 'S', '2012-06-20 19:30:24', 9),
(12, 'seleccion', 14, '2columnas.phtml', 'Obras seleccionadas', 'Obras seleccionadas', '2012', '2012', 'S', '2012-06-20 23:08:56', 9),
(13, 'programa', 10, '1columna.phtml', 'Programa de Proyecciones', 'Programa de Proyecciones', '2012', '2012', 'S', '2012-06-20 23:25:03', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagina_texto`
--

CREATE TABLE IF NOT EXISTS `pagina_texto` (
  `id_pagina` int(11) NOT NULL,
  `id_texto` int(11) NOT NULL,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pagina`,`id_texto`),
  KEY `id_texto` (`id_texto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Volcado de datos para la tabla `pagina_texto`
--

INSERT INTO `pagina_texto` (`id_pagina`, `id_texto`, `fecha_alta`) VALUES
(5, 1, '2012-06-17 19:59:59'),
(6, 2, '2012-06-20 05:22:50'),
(6, 3, '2012-06-20 05:22:50'),
(6, 4, '2012-06-20 05:22:50'),
(6, 13, '2012-06-20 05:22:50'),
(7, 15, '2012-06-20 05:05:15'),
(8, 5, '2012-06-20 19:18:59'),
(8, 6, '2012-06-20 19:18:59'),
(8, 7, '2012-06-20 19:18:59'),
(8, 12, '2012-06-20 19:18:59'),
(9, 16, '2012-06-20 05:09:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peliculas`
--

CREATE TABLE IF NOT EXISTS `peliculas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `autor` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `ficha_tecnica` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `sinopsis` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `material_propio` text CHARACTER SET latin1 COLLATE latin1_bin,
  `id_donante` int(11) NOT NULL DEFAULT '1',
  `enlace` varchar(200) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL COMMENT 'enlace al video en streaming',
  `licencia` varchar(2) COLLATE latin1_general_ci NOT NULL DEFAULT '01',
  `muestra` varchar(4) COLLATE latin1_general_ci NOT NULL DEFAULT '2008',
  `alta` char(1) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_proyeccion` int(3) NOT NULL DEFAULT '0',
  `video_descarga` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_proyeccion` (`id_proyeccion`),
  KEY `id_donante` (`id_donante`),
  KEY `muestra` (`muestra`),
  KEY `licencia` (`licencia`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Tabla con las pel�culas y autoproducciones' AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `peliculas`
--

INSERT INTO `peliculas` (`id`, `titulo`, `autor`, `ficha_tecnica`, `sinopsis`, `material_propio`, `id_donante`, `enlace`, `licencia`, `muestra`, `alta`, `fecha_alta`, `id_proyeccion`, `video_descarga`) VALUES
(8, 'Cortinilla de la 8� Muestra de Cine de Lavapi�s', '', 0x3c703e3c7374726f6e673e43616c6970736f2046696c6d733c2f7374726f6e673e3c6272202f3e312731372727202f2032303131202f2053706f74202f2045737061266e74696c64653b613c6272202f3e3c6120687265663d225c27687474703a2f63616c6970736f2d66696c6d732e6e65745c27223e687474703a2f2f63616c6970736f2d66696c6d732e6e65743c2f613e3c2f703e0a3c703e44697265636369266f61637574653b6e3a2043616c6970736f2046696c6d733c6272202f3e20477569266f61637574653b6e3a2043616c6970736f2046696c6d733c6272202f3e2050726f6475636369266f61637574653b6e3a2043616c6970736f2046696c6d733c2f703e, 0x3c703e546f6440732061206c6120616c666f6d62726120726f6a613c2f703e, 0x3c6272202f3e0a3c623e4e6f746963653c2f623e3a2020556e646566696e6564207661726961626c653a2074787450726573656e746163696f6e20696e203c623e433a5c78616d70705c6874646f63735c6c61766170696573646563696e652e6e65745c66696c6d66657374434d535c76697374615c636f6e74726f6c6c6572735c636f6e766f6361746f7269612e7068746d6c3c2f623e206f6e206c696e65203c623e37303c2f623e3c6272202f3e0a, 0, 'http://vimeo.com/25441947', '04', '2012', 'N', '2012-06-20 22:35:16', 1, ''),
(9, 'Interferencies ', '', 0x3c703e3c7374726f6e673e5061626c6f205a6172656365616e736b79266e6273703b3c2f7374726f6e673e3c6272202f3e373427202f2032303131202f204472616d61202f2045737061266e74696c64653b613c6272202f3e3c6120687265663d22687474703a2f2f7777772e696e746572666572656e636965732e6363223e687474703a2f2f7777772e696e746572666572656e636965732e63633c2f613e3c2f703e0a3c703e457374612070656c266961637574653b63756c61207920746f646f20656c2070726f796563746f2065647563617469766f20792064652064656e756e63696120717565206c6520726f64656120657320706f7369626c6520677261636961732061206c6120636f6c61626f72616369266f61637574653b6e207920656c2074726162616a6f20646573696e746572657361646f20646520756e206772616e2065717569706f20646520706572736f6e61732c206f7267616e697a6163696f6e6573206520696e737469747563696f6e65732c2073696e206c6173206375616c657320496e746572666572266567726176653b6e636965732073266f61637574653b6c6f2065786973746972266961637574653b6120656e206e75657374726f7320737565266e74696c64653b6f73206d266161637574653b73207574266f61637574653b7069636f732e20456e206f7264656e2063726f6e6f6c266f61637574653b6769636f20646520737565266e74696c64653b6f732c20617061726563656d6f73204f44472c20517565706f207920746f646173206c617320706572736f6e61732c20717565206361646120756e61206465206e6f736f747261732068656d6f732069646f20696e636f72706f72616e646f206120657374652070726f796563746f2e20556e2065717569706f20666f726d61646f20706f7220756e20746f74616c2064652031353020706572736f6e61732c20656e7469646164657320736f6369616c65732c20656d70726573617320617564696f76697375616c657320792061646d696e697374726163696f6e65732070267561637574653b626c69636173207175652073652068616e20696d706c696361646f206120666f6e646f20636f6e20657374652070726f796563746f2e266e6273703b266e6273703b3c6272202f3e3c6272202f3e416c67756e6173206465206e6f736f74726f7320736f6d6f733a3c6272202f3e3c6272202f3e556e612070726f6475636369266f61637574653b6e2064653c6272202f3e706172613c6272202f3e3c6272202f3e436f6e3c6272202f3e4d617269613a204d61726961205269626572613c6272202f3e416e6e613a20416e6e612043617361733c6272202f3e436563696c69613a20436563696c6961204c69676f72696f3c6272202f3e526f647269676f3a20526f647269676f20476172636961204f6c7a613c6272202f3e50726f6665736f7261206465206c656e6775616a65206465207369676e6f733a20416e612044266961637574653b657a3c6272202f3e3c6272202f3e50726f6475636369266f61637574653b6e20656a656375746976613a204a756c69266161637574653b6e20416c74756e613c6272202f3e52617175656c20426f6e656c6c3c6272202f3e536f6e696120526f733c6272202f3e5061626c6f20412e205a6172656365616e736b793c6272202f3e3c6272202f3e44697265636369266f61637574653b6e3a205061626c6f20412e205a6172656365616e736b793c6272202f3e3c6272202f3e477569266f61637574653b6e3a20416c6265727420546f6c613c6272202f3e5061626c6f20412e205a6172656365616e736b793c6272202f3e3c6272202f3e412070617274697220646520746578746f732070726f70696f732c20616a656e6f732079206465206c617320696d70726f7669736163696f6e65732064656c206163746f722079206c61732061637472696365732e3c6272202f3e3c6272202f3e44697265636369266f61637574653b6e20646520666f746f67726166266961637574653b613a20416c62657274205061736375616c3c6272202f3e3c6272202f3e44697365266e74696c64653b6f20646520736f6e69646f3a2041676f737420416c757374697a613c6272202f3e3c6272202f3e4d267561637574653b736963613a204c7563617320417269656c2056616c6c656a6f733c6272202f3e3c6272202f3e4d6f6e74616a653a20526567696e6f204865726e266161637574653b6e64657a3c6272202f3e4d61797465204865726e266161637574653b6e64657a3c6272202f3e4f63746176696f20526f6472266961637574653b6775657a3c6272202f3e4a6f72646920507569673c6272202f3e3c6272202f3e56657374756172696f3a20416e6120472675756d6c3b656c6c3c6272202f3e537573616e6120426c616e636f3c6272202f3e3c6272202f3e4d617175696c6c616a6520792070656c7571756572266961637574653b613a204b61726f6c20546f726e6172266961637574653b613c6272202f3e3c6272202f3e537570657276697369266f61637574653b6e20646520636f6e74656e69646f733a3c6272202f3e4a6573267561637574653b73204361727269266f61637574653b6e3c6272202f3e496f6c616e646120467265736e696c6c6f3c6272202f3e44616e692047266f61637574653b6d657a2d4f6c6976266561637574653b3c6272202f3e47656d6d61205461726166613c6272202f3e4d266f61637574653b6e696361205661726761733c6272202f3e3c6272202f3e41797564616e74652064652064697265636369266f61637574653b6e3a2044616e69656c6120466f726e3c6272202f3e41797564616e74652064652064697265636369266f61637574653b6e206465207072652070726f6475636369266f61637574653b6e3a2041696e612043617262266f61637574653b3c6272202f3e32612041797564616e74652064652064697265636369266f61637574653b6e3a204e6174616c696120476f6e7a266161637574653b6c657a3c6272202f3e5363726970743a204a6f616e61204d617274266961637574653b3c6272202f3e43617374696e673a204972656e6520526f7175266561637574653b3c6272202f3e41797564616e74657320646520677569266f61637574653b6e3a2052617175656c20426f6e656c6c266e6273703b79266e6273703b536f6e696120526f733c6272202f3e3c6272202f3e4469726563746f722064652070726f6475636369266f61637574653b6e3a204a756c69266161637574653b6e20416c74756e613c6272202f3e4a6566652064652070726f6475636369266f61637574653b6e3a204a6f726765204e616c6c61723c6272202f3e41797564616e7465732064652070726f6475636369266f61637574653b6e3a204d617263204d616c646f6e61646f3c6272202f3e56266961637574653b63746f72204e61636865723c6272202f3e456c6973616265742050756572746173204665726e266161637574653b6e64657a3c6272202f3e4d6172266961637574653b61204a6f73266561637574653b2047617263266961637574653b613c6272202f3e456e6361726e6920457363616c616e74653c6272202f3e3c6272202f3e4f70657261646f7265732064652063266161637574653b6d6172613a204a6f72646920466c6f72656e2663636564696c3b613c6272202f3e4f72696f6c2042757371756574733c6272202f3e3c6272202f3e41797564616e7465732064652063266161637574653b6d6172613a20416c657820476f6e7a266161637574653b6c657a3c6272202f3e446176696420557262696f6c613c6272202f3e3c6272202f3e4173697374656e7465732064652076266961637574653b64656f3a205061626c6f204d6f6e746573696e6f733c6272202f3e546f6d266161637574653b73204162656c6c266161637574653b6e3c6272202f3e3c6272202f3e4d617175696e69737461733a2053657267692043617374656c6c61726e61753c6272202f3e416c657820426f72646567266f61637574653b3c6272202f3e3c6272202f3e4d616b696e67204f66663a20506175204f7274697a3c6272202f3e3c6272202f3e466f746f2066696a613a2053616e64726120476f6e7a266161637574653b6c657a3c6272202f3e506175204f7274697a3c6272202f3e3c6272202f3e4761666665722070726520696c756d696e616369266f61637574653b6e3a2045647520426f6e696c6c613c6272202f3e4a65666520646520656c266561637574653b63747269636f7320726f64616a653a205061626c6f204c266f61637574653b70657a3c6272202f3e326f204a65666520646520656c266561637574653b63747269636f7320726f64616a653a204a6f686e20486172726174743c6272202f3e456c266561637574653b63747269636f732070726520696c756d696e616369266f61637574653b6e3a2058617669204d266561637574653b6e64657a20257532303143576f6f64792575323031443c6272202f3e4465626f2057697474653c6272202f3e456c266561637574653b63747269636f733a204a6f72646920436f7272616c65733c6272202f3e4d617274612056697665733c6272202f3e4d617263204a617264266961637574653b3c6272202f3e416c626572746f20506572616c74613c6272202f3e4573746562616e20486572656469613c6272202f3e41647269266161637574653b6e20436f7265733c6272202f3e506564726f204976266161637574653b6e2047617263266961637574653b613c6272202f3e3c6272202f3e44697265636369266f61637574653b6e20417274266961637574653b73746963613a2044266961637574653b64616320426f6e6f3c6272202f3e526166656c2056697665733c6272202f3e457374656c204665727265723c6272202f3e58617669657220416775696c61723c6272202f3e3c6272202f3e496c75737472616369266f61637574653b6e206465636f7261646f3a20416e61205961656c205a6172656365616e736b793c6272202f3e466f746f67726166266961637574653b6120696c75737472616369266f61637574653b6e3a204f6d617220486176616e613c6272202f3e3c6272202f3e41797564616e74652064652076657374756172696f3a20436f726f204d6174656f3c6272202f3e41797564616e746573206465206d617175696c6c616a6520792070656c7571756572266961637574653b613a2053757369204c65266f61637574653b6e3c6272202f3e456c7920416e6472266561637574653b733c6272202f3e3c6272202f3e536f6e69646f206469726563746f3a20416c62657274204761793c6272202f3e41676f737420416c757374697a613c6272202f3e3c6272202f3e4d6963726f666f6e69737461733a2058617669657220436172726572613c6272202f3e49646f69612049266e74696c64653b266161637574653b72726974753c6272202f3e4a61756d6520566964616465723c6272202f3e4d617274612043756e696c6c3c6272202f3e3c6272202f3e4c6f63616c697a6163696f6e65733a3c6272202f3e4976266161637574653b6e20476f6d657a3c6272202f3e4d616e656c204d616e746563613c6272202f3e4a75616e20526567756572613c6272202f3e3c6272202f3e41797564616e7465206465206d6f6e74616a653a2044617669642053657272616e6f3c6272202f3e3c6272202f3e436f6f7264696e616369266f61637574653b6e20646520706f737470726f6475636369266f61637574653b6e3a2052617175656c20426f6e656c6c3c6272202f3e536f6e696120526f733c6272202f3e53616e647261205069636865723c6272202f3e3c6272202f3e436f6c6f72697374613a204372697374696e612050266561637574653b72657a3c6272202f3e436f6f7264696e616369266f61637574653b6e2074266561637574653b636e696361204d69787469633a2048656e726965747465204d617274266961637574653b6e657a3c6272202f3e54266561637574653b636e69636f204d69787469633a20416e746f6e696f20557272757469613c6272202f3e44697365266e74696c64653b6f206772266161637574653b6669636f3a204368757320506f7274656c613c6272202f3e3c6272202f3e4469676974616c20636f6d706f736974696e673a20456c6f69204761726369613c6272202f3e4d657a636c617320736f6e69646f3a20536973636f2050657265743c6272202f3e3c6272202f3e5472616e736372697063696f6e65733a204f6c67612043656c6164613c6272202f3e457374686572204761726369613c6272202f3e3c6272202f3e54726164756363696f6e65733a204a756c69612043616d65726f6e3c6272202f3e426172626172612042656e6465723c6272202f3e456e6361726e6920457363616c616e74653c6272202f3e3c6272202f3e496d266161637574653b67656e6573206172636869766f206365646964617320706f723a3c6272202f3e436f6d697369266f61637574653b6e20417564696f76697375616c206465206c61204163616d706164612064652042617263656c6f6e613c6272202f3e436f6d697369266f61637574653b6e204175646976697375616c206465206c61204163616d70616461536f6c3c6272202f3e41647269616e61204d6174656f733c6272202f3e416c65782043616d706f7320284e6f6d61642045796573293c6272202f3e416e612044656c6761646f3c6272202f3e416e746f6e696f204772756e66656c643c6272202f3e4a75616e2052616d266f61637574653b6e20526f626c65733c6272202f3e4d6172266961637574653b61204f7465726f3c6272202f3e3c6272202f3e536f6e69646f206172636869766f2063656469646f20706f723a3c6272202f3e456c20737565266e74696c64653b6f206465205465736c613c6272202f3e3c6272202f3e41646d696e69737472616369266f61637574653b6e3a2053696c76696120566172266f61637574653b6e3c6272202f3e3c6272202f3e4361746572696e673a2046756e64616369266f61637574653b2046757475723c6272202f3e3c6272202f3e53656775726f733a2043696e6576656e743c6272202f3e3c6272202f3e53616c617320646520656e7361796f3a2043656e7472652043266961637574653b766963204c61205365646574613c6272202f3e3c6272202f3e43617361206465206c6120536f6c69646172697461743c6272202f3e3c6272202f3e4d6174657269616c65732065647563617469766f733a3c6272202f3e3c6272202f3e48616e20636f6c61626f7261646f20636f6e206e6f736f74726f733a3c2f703e0a3c703e4e6f732068616e2061706f7961646f3a3c6272202f3e3c6272202f3e436f6e206c61207765623a3c2f703e0a3c703e50726f6772616d616369266f61637574653b6e2079206465736172726f6c6c6f3a3c6272202f3e44616e69656c2043616e65743c6272202f3e46616269266161637574653b6e205275697a3c6272202f3e3c6272202f3e44697365266e74696c64653b6f205765623a3c6272202f3e5275746820446f6d266961637574653b6e6775657a3c6272202f3e3c6272202f3e266e6273703b3c6272202f3e4c6f7320746578746f7320696e636c7569646f7320656e20656c20677569266f61637574653b6e20657374266161637574653b6e206578747261266961637574653b646f732064653a3c6272202f3e3c6272202f3e4265726e6172642d4d61726965204b6f6c74266567726176653b732022436f6d62617465206465206e6567726f207920646520706572726f73223c6272202f3e54686f6d61732053616e6b6172612022446973637572736f20656e206c612043756d627265206465206c61204f7267616e697a616369266f61637574653b6e2070617261206c6120556e69266f61637574653b6e204166726963616e61223c6272202f3e506965722050616f6c6f205061736f6c696e692022436172746173204c75746572616e6173207920656e747265766973746120656e206c6120706c617961206465204f73746961223c6272202f3e417263616469204f6c69766572657320224f726967656e206465206c6173206d6967726163696f6e6573223c6272202f3e526f626572746f20426f6c61266e74696c64653b6f202250616c6162726120646520416d266561637574653b72696361223c6272202f3e53657665726e2043756c6c69732d53757a756b692022446973637572736f20656e206c61204f4e55223c6272202f3e4a75616e204d617274266961637574653b6e657a20224d756e646f20532e412e20566f63657320636f6e747261206c6120676c6f62616c697a616369266f61637574653b6e223c6272202f3e3c6272202f3e556e2061677261646563696d69656e746f20657370656369616c20613a3c6272202f3e3c6272202f3e52616d69726f20426c61732c205365726769204f766964652c204d6172696f6c6120436f7274266561637574653b732c20456c20506c6174266f61637574653b2064652043696e656d612c20436c617564696120416c656d616e792c2045766120426965736361732c204361726c6f732043616c766f2c204d617274696e61204675737465722c204576656c696e6120506f646961706f6c736b6169612c204a6f72646920436f7272616c65732c204c6c6f72656e2663636564696c3b204d6173204c6561732c2056266961637574653b63746f72204e61636865722c20476f6e7a616c6f204372757a3c6272202f3e3c6272202f3e41677261646563696d69656e746f733a3c6272202f3e456c205465727261742c204573746865722047617263266961637574653b6120692045737468657220416c6f6e736f3c6272202f3e50697a7a65726961204c612042726963696f6c612c204d6f626c65732052616d2c2054616e69742053696e67756c61723c6272202f3e436f6c6567696f204c657869612c204865726e266161637574653b6e205a696e2c204b696b652050266561637574653b72657a3c6272202f3e4361746f7520566172646965722c20446f632e65733b204a61756d65204d617274266961637574653b2c2044616e656c20416e7365722c20486563746f7220476972266f61637574653b2c204775696c6c65206465206c612043616c2c20536572676920447572616e2c204361726c657320526f796f2c20416e6472656120264161637574653b6c766172657a3c6272202f3e436f6d70616e79696120436572766573736572612064656c204d6f6e7473656e792c2041647269616e6f204d6f72266161637574653b6e2c204b616d656e204e656465763c6272202f3e3c6272202f3e526f6461646f20656e20656c2054656174726f206465206c6f732073656e7469646f732c2042617263656c6f6e612c2064656c20313620616c203237206465206d61796f20646520323031313c6272202f3e3c6272202f3e437265617469766520436f6d6d6f6e7320332e302042792d4e632d5361266e6273703b3c6272202f3e4e266f72646d3b20446570266f61637574653b7369746f204c6567616c3a20422d33333930362d323031313c6272202f3e4e266f72646d3b20657870656469656e746520494349433a2030313134342f31313c6272202f3e41707461207061726120746f646f73206c6f732070267561637574653b626c69636f733c2f703e, 0x3c703e436563696c69612c20416e612c204d6172266961637574653b61207920526f647269676f20666f726d616e20756e61206a6f76656e20636f6d7061266e74696c64653b266961637574653b61207465617472616c2c2064652072656369656e746520266561637574653b7869746f20706f72207375206465736361726164612079207472616e73677265736f72612070756573746120656e20657363656e612c207920706f7220656c20636f6d70726f6d69736f20736f6369616c207920706f6c266961637574653b7469636f206465206c6f7320636f6e74656e69646f7320717565206d7565737472616e2e20507265706172616e207375207072266f61637574653b78696d6f2065737472656e6f2c20756e61206f6272612064652064656e756e63696120736f6272652063266f61637574653b6d6f206c6120736f63696564616420646520636f6e73756d6f20616365707461206c6f20696e616365707461626c652e20556e6120736f63696564616420717565206e6f206375657374696f6e6120756e2073697374656d6120706f6c266961637574653b7469636f20792065636f6e266f61637574653b6d69636f2071756520696d706f6e6520646575646173207920656d706f62726563696d69656e746f20736f627265206c6f73206d266161637574653b732064266561637574653b62696c65732e20456e2065737465207669616a652c20656d7069657a616e20706f7220747261746172206465206d616e6970756c6172206472616d6174267561637574653b72676963616d656e7465206c61206f6272612064656c206175746f72206672616e63266561637574653b73204265726e6172642d4d61726965204b6f6c74266561637574653b732c207065726f20616c2064657363756272697220717565206e6f2066756e63696f6e612c206c6f73206163746f726573207365206162616e646f6e616e206120666f726d6173206d7563686f206d266161637574653b732064697265637461732c2070726f7669737461732064652068756d6f722079207361726361736d6f2e204c6120637265617469766964616420676f6c706561206465206c6c656e6f20636f6e20656c207265737065746f2070726f66756e646f20717565207369656e74656e206861636961206c61732074656d266161637574653b746963617320717565207175696572656e207472617461722e204465206c612064657564612065787465726e6120616c20636f6d657263696f20696e7465726e6163696f6e616c2c2064656c20706170656c206465206c617320696e737469747563696f6e65732066696e616e63696572617320616c20616275736f206465206c6173207472616e736e6163696f6e616c65732c2064656c206d6f64656c6f20646520636f6e73756d6f20616c2063616d62696f20636c696d266161637574653b7469636f2c20756e6120736572696520646520696e6a7573746963696173207175652061677564697a616e206c6120616e677573746961207175652076697669656e646f20647572616e746520656c2070726f6365736f20646520646f63756d656e74616369266f61637574653b6e207920617072656e64697a616a652e2056616e20746f6d616e646f20636f6e6369656e636961206465206c61206469666963756c7461642064652061626172636172206c6120636f6d706c656a6120792073616e677269656e7461207265616c6964616420717565207175696572656e206d6f73747261722c20656e7472616e646f20706f636f206120706f636f20656e20756e6120637269736973206465206964656e7469646164206d6f72616c207920617274266961637574653b737469636120717565206c657320656e6672656e746120656e7472652073266961637574653b2e204c6173206d616e69666573746163696f6e65732064656c2031354d20656e20746f646f20656c207061266961637574653b7320696e7661646972266161637574653b6e20656c2070726f6365736f20637265617469766f206465206c6120636f6d7061266e74696c64653b266961637574653b612c207375706f6e69656e646f20756e2070756e746f20646520696e666c657869266f61637574653b6e2073696e207265746f726e6f2e3c2f703e, '', 1, 'http://vimeo.com/34066375', '01', '2012', 'S', '2012-06-20 23:18:27', 1, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_acceso`
--

CREATE TABLE IF NOT EXISTS `perfil_acceso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `logo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `id_modulodefault` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nivel` (`nivel`),
  KEY `id_modulodefault` (`id_modulodefault`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `perfil_acceso`
--

INSERT INTO `perfil_acceso` (`id`, `nombre`, `descripcion`, `logo`, `id_modulodefault`, `nivel`, `alta`, `fecha_alta`) VALUES
(1, 'Administraci�n', 'Gesti�n de la zona de administraci�n', 'admin.png', 14, 1, 'S', '2012-06-17 10:34:52'),
(2, 'Cine', 'Edici�n de contenidos de las proyecciones', 'cine.png', 5, 3, 'S', '2012-06-17 10:34:52'),
(3, 'Web', 'Gesti�n y edici�n de contenidos del site', 'web.png', 2, 2, 'S', '2012-06-17 10:34:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyecciones`
--

CREATE TABLE IF NOT EXISTS `proyecciones` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `id_espacio` int(3) NOT NULL DEFAULT '0',
  `dia` date NOT NULL DEFAULT '0000-00-00',
  `hora` time NOT NULL DEFAULT '00:00:00',
  `anyo` varchar(4) COLLATE latin1_general_ci NOT NULL DEFAULT '2008' COMMENT 'A�o de la muestra',
  `titulo` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `descripcion` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_espacio` (`id_espacio`),
  KEY `anyo` (`anyo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='tabla de proyecciones. relaciona pelicula con proyeccion' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `proyecciones`
--

INSERT INTO `proyecciones` (`id`, `id_espacio`, `dia`, `hora`, `anyo`, `titulo`, `descripcion`, `alta`, `fecha_alta`) VALUES
(0, 0, '0000-00-00', '00:00:00', '2012', NULL, NULL, 'N', '0000-00-00 00:00:00'),
(1, 1, '2012-06-22', '20:00:00', '2012', '', '', 'S', '2012-06-19 21:50:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `textos`
--

CREATE TABLE IF NOT EXISTS `textos` (
  `titulo` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `texto` text COLLATE latin1_general_ci NOT NULL,
  `autor` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `lang` varchar(2) COLLATE latin1_general_ci NOT NULL DEFAULT 'es',
  `muestra` varchar(4) COLLATE latin1_general_ci NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_galeria` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `muestra` (`muestra`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=17 ;

--
-- Volcado de datos para la tabla `textos`
--

INSERT INTO `textos` (`titulo`, `texto`, `autor`, `lang`, `muestra`, `alta`, `id`, `fecha_alta`, `id_galeria`) VALUES
('9� Muestra de Cine de Lavapi�s. 22 de junio - 1 de julio', '<div id="cartel-home"><img src="../../img/galerias/carteles/9-muestra-de-cine-de-lavapies.jpg" alt="" />Cartel realizado por <a href="http://iagoberro.wordpress.com/" target="_blank">Iago Alvarez</a></div>\n<div id="txt-home">La Muestra de cine de Lavapi&eacute;s entra en su novena edici&oacute;n (si fu&eacute;ramos una sinfon&iacute;a estar&iacute;amos gafados) en un a&ntilde;o en el que hemos visto desaparecer un mont&oacute;n de festivales y chiringuitos por falta de subvenciones p&uacute;blicas. Pero nosotros somos una muestra autogestionada y esta independencia hace que en &eacute;pocas como la que vivimos (&eacute;pocas de estafa, que no de crisis) sigamos hacia adelante con los contratiempos de costumbre, ni m&aacute;s ni menos.<br /><br />Ha sido un a&ntilde;o en el que la actuaci&oacute;n de la policia (en Lavapi&eacute;s, en Madrid y en el estado espa&ntilde;ol) ha incrementado su nivel de violencia como nunca, haciendo redadas constantes e indiscriminadas. Han ladrado mucho, claro, porque hemos cabalgado mucho... Theo Angelopoulos, un cineasta al que admiramos y que muri&oacute; este a&ntilde;o atropellado por un policia en el Pireo a los 76 a&ntilde;os, dec&iacute;a en su pel&iacute;cula El paso suspendido de la cig&uuml;e&ntilde;a : &ldquo;Si doy un paso estoy en otra parte... o muero&rdquo;. Terrible met&aacute;fora de su destino y del de todxs los griegxs. &Eacute;ste ha sido el a&ntilde;o de dar pasos adelante, zancadas a topetazos en el barrio de Lavapi&eacute;s, producto de la incre&iacute;ble bocanada de aire fresco que ha supuesto el 15m, que ha recogido y amplificado v&iacute;as y sue&ntilde;os que buscaban trenzar nuestras redes de apoyo: paralizaciones de desahucios, movimientos contra las redadas,<br />ocupaciones, grupos y coordinadoras de consumo responsable, mercados de trueque, bancos de tiempo, espacios de pedagog&iacute;a libre, plataformas de activismo cibern&eacute;tico o proyectos solidarios y de emprendimiento como el Mercado de San Fernando que est&aacute; reconfigur&aacute;ndose y viviendo un proceso de restructuraci&oacute;n muy interesante. Pasos hacia adelante en las ant&iacute;podas de la gentrificaci&oacute;n, del stress de lo cotidiano y del desencuentro entre el vecindario.<br /><br />En lo que a nosotrxs nos compete ( desarrollar una Muestra de cine ) la repercusi&oacute;n que ha tenido estas nuevas maneras de estar en la vida y en la calle se ha traducido en un gran salto cuantitativo pero sobretodo cualitativo en produciones liberadas al que hemos respondido dando el salto adelante y abriendo la convocatoria de autoproducciones exclusivamente a obras con licencias libres. Ha aumentado el nivel en las autoproducciones y sobre todo la calidad argumentativa. Estas obras liberadas nos cuentan lo que est&aacute; pasando y c&oacute;mo est&aacute; pasando. Y nos han hecho reflexionar, entre otras cosas, sobre la presencia generalizada de la acampada como forma de lucha contempor&aacute;nea (Sol, Plaza Catalunya y el resto de ciudades de nuestro estado, pero tambi&eacute;n Nueva York, Londres, Tahrir, S&aacute;hara Occidental, T&uacute;nez...), sobre el valor de los campamentos como lugares in extremis donde florecen los acontecimientos.<br /><br />Frente a los grandes proyectos urban&iacute;sticos vac&iacute;os y los grandes terremotos de una tierra que aulla, hemos decidido plantar nuestras jaimas en la ciudad como ese espacio absolutamente privilegiado de la lucha, del perderse, del encuentro. En esa topograf&iacute;a, en ese callejero es donde hemos trazado los caminos que van forjando alianzas inesperadas, que se van configurando como el recept&aacute;culo de las huellas de la<br />cultura, comport&aacute;ndonos como si acabasemos de despertar de un violento terremoto, reactivando los procesos como si de un plan de emergencia se tratase. Decia Walter Benjamin en 1926: &ldquo;Los pueblos de Europa Central viven como los habitantes de una ciudad sitiada que est&aacute; agotando ya la p&oacute;lvora y los v&iacute;veres y que es muy dif&iacute;cil que se salve. Un caso en el que habr&iacute;a que pensar seriamente en rendirse. Pero la fuerza muda e invisible frente a la que se encuentra hoy Europa Central no negocia. De manera que el &uacute;nico remedio, en espera de que llegue el asalto final es volver la mirada a lo extraordinario, lo &uacute;nico que todav&iacute;a nos puede salvar&rdquo;.<br /><br />En nuestras estructuras precarias tratamos de saber quienes somos, cu&aacute;ntos estamos, vincularnos a la necesidad de estar con los nuestros, de reconocernos bajo esas jaimas, a tientas, de trabajar silenciosamente en&nbsp; nuestro mundo paralelo de redes y mercados sociales, asomando la cabeza escandalosamente cuando hace falta parar un desahucio o simplemente para aullar de rabia en un cotidiano en el que desayunamos con suicidios,<br />primas de riesgo y algo llamado rescate, que en realidad es una piedra al cuello. Las pel&iacute;culas que nos gusta mostrar no son necesariamente sociales o pol&iacute;ticas, pero s&iacute; lo es nuestra actitud de c&oacute;mo entendemos la cultura, como eje transformador de la sociedad. Es por ello que queremos mostrar nuestro apoyo, solidaridad y cari&ntilde;o a Willy Toledo, Javier Krahe, La Casika y su festival de cortos, a las personas represaliadas y detenidas en la Huelga del 29m, las multadas, detenidas, apaleadas y acogotadas en las movilizaciones del 15m, las luchas estudiantiles y a toda la ciudadan&iacute;a que lucha por mejorar este mundo que otros tratan de destruir y de dividir en aras de la cantidad de ceros que tengan las cuentas corrientes.<br /><br />&iexcl;Nos vemos en las jaimas, bajo la luz del proyector!</div>', NULL, 'es', '2012', 'S', 1, '2012-06-17 19:59:17', 0),
('FAQ - Questions Fr�quentes', '<div id="calling" class="inicio-columnaizquierda">\n<p><a href="../../img/galerias/carteles/9-muestra-de-cine-de-lavapies.jpg"> <img src="../../img/galerias/carteles/9-muestra-de-cine-de-lavapies.jpg" alt="9-muestra-de-cine-de-lavapies" width="180" height="254" /> </a></p>\n</div>\n<div class="inicio-columnaderecha">\n<p><strong>1.- Qu&rsquo;est-ce que <em>La Muestra de cine de Lavapi&eacute;s</em>?</strong><br /> La<em> Muestra de cine de Lavapi&eacute;s</em> est une manifestation culturelle qui se d&eacute;roule depuis 9 ans dans le quartier de Lavapi&eacute;s, &agrave; Madrid, qui a pour but d&rsquo;offrir aux voisins un point de rencontre qui leur permette d&rsquo;acc&eacute;der &agrave; des films, documentaires et courts m&eacute;trages que nous s&eacute;lectionnons pendant l&rsquo;ann&eacute;e.<br /> <br /> <strong>2.- Quelles sont les dates de <em>La Muestra de cine de Lavapi&eacute;s</em>?</strong><br /> D&rsquo;habitude, elle se d&eacute;roule fin juin, d&eacute;but juillet.<br /> <strong><br /> 3.- O&ugrave; a lieu <em>La Muestra de cine de Lavapi&eacute;s</em>?</strong><br /> La Muestra de cine de Lavapi&eacute;s se d&eacute;roule dans des locaux, associations, bars et d&rsquo;autres lieux o&ugrave; ont lieu des activit&eacute;s culturelles et qui collaborent avec la Muestra, ainsi que dans la rue.<br /> <strong><br /> </strong><span style="font-weight: bold;">4</span><strong>.- Comment peut-on collaborer avec la <em>Muestra</em>?</strong><br /> <a href="contactez-nous">Contactez-nous</a>, et, si vous le d&eacute;sirez, vous pouvez assister &agrave; une des r&eacute;unions de la Muestra et voir vous voulez faire partie de l&rsquo;organisation.<br /> <strong><br /> 5.- Combien &ccedil;a coute ?</strong><br /> Toutes les projections sont gratuites.<br /> <strong><br /> </strong></p>\n<p><strong> 6.- Quel est le moyen de financement de la <em>Muestra </em>?</strong><br /> Nous ne recevons ni aides publiques ni parrainages priv&eacute;s. Nous n&rsquo;avons pas vraiment beaucoup de frais. On organise une f&ecirc;te chaque ann&eacute;e avec laquelle on paye les programmes, l&rsquo;affiche, le maintien du mat&eacute;riel et les frais des invit&eacute;s qui habitent en dehors de Madrid.<br /> <strong><br /> 7.- Comment vous procurez-vous les films qui passent &agrave; la <em>Muestra </em>?</strong><br /> De deux fa&ccedil;ons : d&rsquo;une part on contacte les distributeurs, les producteurs et les r&eacute;alisateurs pour qu&rsquo;ils nous c&egrave;dent gratuitement les droits pour la semaine pendant laquelle se d&eacute;roule la <em>Muestra</em>. D&rsquo;autre part, on lance un avis de convocation pour que tous ceux qui sont int&eacute;ress&eacute;s nous envoient leurs travaux.</p>\n<p>&nbsp;</p>\n</div>\n<div class="inicio-columnaizquierda"><a title="Convocatoria de obras audiovisuales con licencia libre" href="../../vista/2012/img/cartel_atp_9.jpg" rel="lightbox"> <img style="width: 180px;" src="../../img/galerias/carteles/cartel_atp_9.jpg" alt="Convocatoria de obras audiovisuales con licencia libre" /> </a> <a href="http://www.lacuadrillaestudio.com" target="_blank">La Cuadrilla</a> (cc by-nc-nd)</div>\n<div class="inicio-columnaderecha">\n<p><strong>Appel &agrave; productions audiovisuelles sous licence libre</strong></p>\n<p><strong>1.- Quel est le d&eacute;lai pour s&rsquo;inscrire dans la cat&eacute;gorie autoproduction ?</strong><br /> L&rsquo;inscription commence le 15 d&eacute;cembre 2011 et termine le 15 mars 2012.</p>\n<p><strong>2.- Est-ce qu&rsquo;il y a des prix en esp&egrave;ces &agrave; la Muestra ?</strong><br /> Non, il s&rsquo;agit d&rsquo;une muestra, et pas d&rsquo;un festival. Les &oelig;uvres s&eacute;lectionn&eacute;es passent &agrave; la <em>Muestra</em>.<br /> <br /> <strong>3.- Pourquoi cette ann&eacute;e vous n&rsquo;avez pas accept&eacute; de DVD ?</strong><br /> De nos jours il est moins cher, plus commode et plus rapide de se servir d&rsquo;Internet et de nous envoyer un lien.</p>\n<p><strong>4.- Est-ce que vous nous conseillez un site web pour envoyer les vid&eacute;os qu&rsquo;on veut pr&eacute;senter ?</strong><br /> Vous pouvez envoyer vos vid&eacute;os via une plate-forme de streaming telle que vimeo.com ou archive.org. Vous pouvez &eacute;galement nous envoyer un lien pour t&eacute;l&eacute;charger la vid&eacute;o.</p>\n<p><strong>5.- Allez-vous vraiment mettre tous les films sur Internet ?</strong><br /> <em>La Muestra de cine de Lavapi&eacute;s</em> est tr&egrave;s fi&egrave;re de tous les films qu&rsquo;on re&ccedil;oit, et &ccedil;a nous fait mal au c&oelig;ur de ne pas pouvoir tous les projeter. C&rsquo;est pour &ccedil;a que nous voulons qu&rsquo;ils soient tous disponibles sur Internet pour permettre &agrave; un maximum de gens de les regarder. Mais on comprend qu&rsquo;il y existe des raisons pour ne pas le faire (crit&egrave;res d&rsquo;exclusivit&eacute; avec d&rsquo;autres festivals, possibilit&eacute;s de distribution commerciale, etc.). Si c&rsquo;est le cas, nous pouvons retarder la date de publication jusqu&rsquo;au jour de l&rsquo;inauguration de la Muestra.</p>\n<p><strong>6.- Pourquoi vous n&rsquo;acceptiez que de licences libres ?</strong><br /> Parce que la <em>Muestra</em> a pour objectif de rendre la culture libre. Il nous semble logique que l&rsquo;appel ouvert serve &agrave; rendre visible et &agrave; diffuser au maximum les &oelig;uvres de tous ceux qui font de la culture libre.</p>\n<p><strong>7.- Comment et quand peut-on savoir si on a &eacute;t&eacute; s&eacute;lectionn&eacute; ?</strong><br /> Une fois la s&eacute;lection finie, nous vous contacterons par mail. Nous envisageons comme date limite le 15 mai 2012.</p>\n<p><strong>8.- Le mat&eacute;riel qu&rsquo;on vous envoie va &ecirc;tre utilis&eacute; dans l&rsquo;avenir ?</strong><br /> Tout le mat&eacute;riel qu&rsquo;on re&ccedil;oit passe &agrave; nos archives et il n&rsquo;est jamais utilis&eacute; sans l&rsquo;autorisation de l&rsquo;auteur.</p>\n<p><strong>9.- Pourquoi tant de FAQ?</strong><br /> Il vaut mieux en avoir trop que pas assez.</p>\n</div>', NULL, 'fr', '2012', 'S', 2, '2012-06-20 04:47:03', 0),
('FAQs', '<div class="inicio-columnaizquierda"><a title="Convocatoria de obras audiovisuales con licencia libre" href="../../img/galerias/carteles/cartel_atp_9.jpg" rel="lightbox"> <img style="width: 180px;" src="../../img/galerias/carteles/cartel_atp_9.jpg" alt="Convocatoria de obras audiovisuales con licencia libre" /> </a> <a href="http://www.lacuadrillaestudio.com">La Cuadrilla</a> (cc by-nc-nd)</div>\n<div class="inicio-columnaderecha">\n<p><strong>1.- Was ist die<em> Muestra de cine de Lavapi&eacute;s</em>?</strong><br /> Die <em>Muestra de cine de Lavapi&eacute;s</em> ist eine Filmschau, die seit neun Jahren in Lavapi&eacute;s, einem Stadtviertel von Madrid, stattfindet und deren Ziel es ist, durch den gemeinsamen Genuss einer Auswahl von Kurz-, Spiel- und Dokumentarfilmen (die wir das Jahr &uuml;ber ausw&auml;hlen und zu erhalten versuchen) Orte der nachbarschaftlichen Begegnung zu schaffen und zu f&ouml;rdern.<br /> <br /> <strong>2.- Wann findet die <em>Muestra</em> statt? </strong><br /> F&uuml;r gew&ouml;hnlich findet die Muestra Ende Juni und Anfang Juli statt.<br /> <br /> <strong>3.- Wo findet die <em>Muestra</em> statt?</strong><br /> Die <em>Muestra de Cine de Lavapi&eacute;s</em> wird in Lokalen, Vereinigungen, Kneipen und anderen Orten im Viertel durchgef&uuml;hrt, in denen kulturelle Veranstaltungen stattfinden und die mit der Muestra zusammenarbeiten. Au&szlig;erdem auf Stra&szlig;en und Pl&auml;tzen.</p>\n<p><strong>4.- Wie kann ich bei der <em>Muestra</em> mitmachen?</strong><br /> Bitte nimm <a href="kontakt">Kontakt</a> mit uns auf, beteilige dich an unseren Treffen, dann kannst du dir &uuml;berlegen, ob du bei der Organisation dabeisein willst.&nbsp;</p>\n</div>\n<p><strong>5.- Wieviel kostet der Eintritt?</strong><br /> Nichts, alle unsere Vorf&uuml;hrungen sind gratis.</p>\n<p><strong>6.- Wie finanziert ihr euch?</strong><br /> Wir erhalten keinerlei &ouml;ffentliche F&ouml;rderung und haben auch keine privaten Sponsoren. Wir haben allerdings auch keine allzu hohen Kosten und machen einmal im Jahr ein Fest, mit dem wir Programmhefte, Plakate, die technischen Ausstattung und die Spesen der von uns eingeladenen G&auml;ste finanzieren.</p>\n<p><strong>7.- Wie kommt ihr zu den Filmen, die ihr zeigt?</strong><br /> Auf zwei Wegen: Einerseits verfolgen wir Verleihe, Produzenten und Filmemacher, damit sie uns kostenlos die Auff&uuml;hrungsrechte f&uuml;r die Filmschauwoche &uuml;berlassen. Andererseits f&uuml;hren wir eine offene Ausschreibung durch, bei der uns wer will seine Werke schicken kann. <br /> <br /> <strong>Ausschreibung f&uuml;r Audiovisuelle Werke mit freier Lizenz</strong><br /> <br /> <strong>1.- Wann ist Einsendeschlu&szlig;?</strong><br /> Die Anmeldefrist beginnt am 15. Dezember 2011 und endet am 15. M&auml;rz 2012.<br /> <br /> <strong>2.- Werden Preise verliehen?</strong><br /> Nein, es handelt sich um eine Filmschau, nicht um ein Festival. Die ausgew&auml;hlten Werke werden im Verlauf der <em>Muestra</em> vorgef&uuml;hrt.<br /> <br /> <!--[if gte mso 9]><xml> <o:OfficeDocumentSettings> <o:RelyOnVML /> <o:AllowPNG /> </o:OfficeDocumentSettings> </xml><![endif]--><!--[if gte mso 9]><xml> <w:WordDocument> <w:View>Normal</w:View> <w:Zoom>0</w:Zoom> <w:TrackMoves /> <w:TrackFormatting /> <w:HyphenationZone>21</w:HyphenationZone> <w:PunctuationKerning /> <w:ValidateAgainstSchemas /> <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid> <w:IgnoreMixedContent>false</w:IgnoreMixedContent> <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText> <w:DoNotPromoteQF /> <w:LidThemeOther>ES</w:LidThemeOther> <w:LidThemeAsian>X-NONE</w:LidThemeAsian> <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript> <w:Compatibility> <w:BreakWrappedTables /> <w:SnapToGridInCell /> <w:WrapTextWithPunct /> <w:UseAsianBreakRules /> <w:DontGrowAutofit /> <w:SplitPgBreakAndParaMark /> <w:EnableOpenTypeKerning /> <w:DontFlipMirrorIndents /> <w:OverrideTableStyleHps /> </w:Compatibility> <m:mathPr> <m:mathFont m:val="Cambria Math" /> <m:brkBin m:val="before" /> <m:brkBinSub m:val=" " /> <m:smallFrac m:val="off" /> <m:dispDef /> <m:lMargin m:val="0" /> <m:rMargin m:val="0" /> <m:defJc m:val="centerGroup" /> <m:wrapIndent m:val="1440" /> <m:intLim m:val="subSup" /> <m:naryLim m:val="undOvr" /> </m:mathPr></w:WordDocument> </xml><![endif]--><!--[if gte mso 9]><xml> <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true" DefSemiHidden="true" DefQFormat="false" DefPriority="99" LatentStyleCount="267"> <w:LsdException Locked="false" Priority="0" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Normal" /> <w:LsdException Locked="false" Priority="9" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="heading 1" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8" /> <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9" /> <w:LsdException Locked="false" Priority="39" Name="toc 1" /> <w:LsdException Locked="false" Priority="39" Name="toc 2" /> <w:LsdException Locked="false" Priority="39" Name="toc 3" /> <w:LsdException Locked="false" Priority="39" Name="toc 4" /> <w:LsdException Locked="false" Priority="39" Name="toc 5" /> <w:LsdException Locked="false" Priority="39" Name="toc 6" /> <w:LsdException Locked="false" Priority="39" Name="toc 7" /> <w:LsdException Locked="false" Priority="39" Name="toc 8" /> <w:LsdException Locked="false" Priority="39" Name="toc 9" /> <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption" /> <w:LsdException Locked="false" Priority="10" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Title" /> <w:LsdException Locked="false" Priority="1" Name="Default Paragraph Font" /> <w:LsdException Locked="false" Priority="11" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Subtitle" /> <w:LsdException Locked="false" Priority="22" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Strong" /> <w:LsdException Locked="false" Priority="20" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Emphasis" /> <w:LsdException Locked="false" Priority="59" SemiHidden="false" UnhideWhenUsed="false" Name="Table Grid" /> <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text" /> <w:LsdException Locked="false" Priority="1" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="No Spacing" /> <w:LsdException Locked="false" Priority="60" SemiHidden="false" UnhideWhenUsed="false" Name="Light Shading" /> <w:LsdException Locked="false" Priority="61" SemiHidden="false" UnhideWhenUsed="false" Name="Light List" /> <w:LsdException Locked="false" Priority="62" SemiHidden="false" UnhideWhenUsed="false" Name="Light Grid" /> <w:LsdException Locked="false" Priority="63" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 1" /> <w:LsdException Locked="false" Priority="64" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 2" /> <w:LsdException Locked="false" Priority="65" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 1" /> <w:LsdException Locked="false" Priority="66" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 2" /> <w:LsdException Locked="false" Priority="67" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 1" /> <w:LsdException Locked="false" Priority="68" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 2" /> <w:LsdException Locked="false" Priority="69" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 3" /> <w:LsdException Locked="false" Priority="70" SemiHidden="false" UnhideWhenUsed="false" Name="Dark List" /> <w:LsdException Locked="false" Priority="71" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Shading" /> <w:LsdException Locked="false" Priority="72" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful List" /> <w:LsdException Locked="false" Priority="73" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Grid" /> <w:LsdException Locked="false" Priority="60" SemiHidden="false" UnhideWhenUsed="false" Name="Light Shading Accent 1" /> <w:LsdException Locked="false" Priority="61" SemiHidden="false" UnhideWhenUsed="false" Name="Light List Accent 1" /> <w:LsdException Locked="false" Priority="62" SemiHidden="false" UnhideWhenUsed="false" Name="Light Grid Accent 1" /> <w:LsdException Locked="false" Priority="63" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1" /> <w:LsdException Locked="false" Priority="64" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1" /> <w:LsdException Locked="false" Priority="65" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 1 Accent 1" /> <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision" /> <w:LsdException Locked="false" Priority="34" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="List Paragraph" /> <w:LsdException Locked="false" Priority="29" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Quote" /> <w:LsdException Locked="false" Priority="30" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Intense Quote" /> <w:LsdException Locked="false" Priority="66" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 2 Accent 1" /> <w:LsdException Locked="false" Priority="67" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1" /> <w:LsdException Locked="false" Priority="68" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1" /> <w:LsdException Locked="false" Priority="69" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1" /> <w:LsdException Locked="false" Priority="70" SemiHidden="false" UnhideWhenUsed="false" Name="Dark List Accent 1" /> <w:LsdException Locked="false" Priority="71" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Shading Accent 1" /> <w:LsdException Locked="false" Priority="72" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful List Accent 1" /> <w:LsdException Locked="false" Priority="73" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Grid Accent 1" /> <w:LsdException Locked="false" Priority="60" SemiHidden="false" UnhideWhenUsed="false" Name="Light Shading Accent 2" /> <w:LsdException Locked="false" Priority="61" SemiHidden="false" UnhideWhenUsed="false" Name="Light List Accent 2" /> <w:LsdException Locked="false" Priority="62" SemiHidden="false" UnhideWhenUsed="false" Name="Light Grid Accent 2" /> <w:LsdException Locked="false" Priority="63" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2" /> <w:LsdException Locked="false" Priority="64" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2" /> <w:LsdException Locked="false" Priority="65" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 1 Accent 2" /> <w:LsdException Locked="false" Priority="66" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 2 Accent 2" /> <w:LsdException Locked="false" Priority="67" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2" /> <w:LsdException Locked="false" Priority="68" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2" /> <w:LsdException Locked="false" Priority="69" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2" /> <w:LsdException Locked="false" Priority="70" SemiHidden="false" UnhideWhenUsed="false" Name="Dark List Accent 2" /> <w:LsdException Locked="false" Priority="71" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Shading Accent 2" /> <w:LsdException Locked="false" Priority="72" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful List Accent 2" /> <w:LsdException Locked="false" Priority="73" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Grid Accent 2" /> <w:LsdException Locked="false" Priority="60" SemiHidden="false" UnhideWhenUsed="false" Name="Light Shading Accent 3" /> <w:LsdException Locked="false" Priority="61" SemiHidden="false" UnhideWhenUsed="false" Name="Light List Accent 3" /> <w:LsdException Locked="false" Priority="62" SemiHidden="false" UnhideWhenUsed="false" Name="Light Grid Accent 3" /> <w:LsdException Locked="false" Priority="63" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3" /> <w:LsdException Locked="false" Priority="64" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3" /> <w:LsdException Locked="false" Priority="65" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 1 Accent 3" /> <w:LsdException Locked="false" Priority="66" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 2 Accent 3" /> <w:LsdException Locked="false" Priority="67" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3" /> <w:LsdException Locked="false" Priority="68" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3" /> <w:LsdException Locked="false" Priority="69" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3" /> <w:LsdException Locked="false" Priority="70" SemiHidden="false" UnhideWhenUsed="false" Name="Dark List Accent 3" /> <w:LsdException Locked="false" Priority="71" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Shading Accent 3" /> <w:LsdException Locked="false" Priority="72" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful List Accent 3" /> <w:LsdException Locked="false" Priority="73" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Grid Accent 3" /> <w:LsdException Locked="false" Priority="60" SemiHidden="false" UnhideWhenUsed="false" Name="Light Shading Accent 4" /> <w:LsdException Locked="false" Priority="61" SemiHidden="false" UnhideWhenUsed="false" Name="Light List Accent 4" /> <w:LsdException Locked="false" Priority="62" SemiHidden="false" UnhideWhenUsed="false" Name="Light Grid Accent 4" /> <w:LsdException Locked="false" Priority="63" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4" /> <w:LsdException Locked="false" Priority="64" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4" /> <w:LsdException Locked="false" Priority="65" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 1 Accent 4" /> <w:LsdException Locked="false" Priority="66" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 2 Accent 4" /> <w:LsdException Locked="false" Priority="67" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4" /> <w:LsdException Locked="false" Priority="68" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4" /> <w:LsdException Locked="false" Priority="69" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4" /> <w:LsdException Locked="false" Priority="70" SemiHidden="false" UnhideWhenUsed="false" Name="Dark List Accent 4" /> <w:LsdException Locked="false" Priority="71" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Shading Accent 4" /> <w:LsdException Locked="false" Priority="72" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful List Accent 4" /> <w:LsdException Locked="false" Priority="73" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Grid Accent 4" /> <w:LsdException Locked="false" Priority="60" SemiHidden="false" UnhideWhenUsed="false" Name="Light Shading Accent 5" /> <w:LsdException Locked="false" Priority="61" SemiHidden="false" UnhideWhenUsed="false" Name="Light List Accent 5" /> <w:LsdException Locked="false" Priority="62" SemiHidden="false" UnhideWhenUsed="false" Name="Light Grid Accent 5" /> <w:LsdException Locked="false" Priority="63" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5" /> <w:LsdException Locked="false" Priority="64" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5" /> <w:LsdException Locked="false" Priority="65" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 1 Accent 5" /> <w:LsdException Locked="false" Priority="66" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 2 Accent 5" /> <w:LsdException Locked="false" Priority="67" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5" /> <w:LsdException Locked="false" Priority="68" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5" /> <w:LsdException Locked="false" Priority="69" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5" /> <w:LsdException Locked="false" Priority="70" SemiHidden="false" UnhideWhenUsed="false" Name="Dark List Accent 5" /> <w:LsdException Locked="false" Priority="71" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Shading Accent 5" /> <w:LsdException Locked="false" Priority="72" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful List Accent 5" /> <w:LsdException Locked="false" Priority="73" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Grid Accent 5" /> <w:LsdException Locked="false" Priority="60" SemiHidden="false" UnhideWhenUsed="false" Name="Light Shading Accent 6" /> <w:LsdException Locked="false" Priority="61" SemiHidden="false" UnhideWhenUsed="false" Name="Light List Accent 6" /> <w:LsdException Locked="false" Priority="62" SemiHidden="false" UnhideWhenUsed="false" Name="Light Grid Accent 6" /> <w:LsdException Locked="false" Priority="63" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6" /> <w:LsdException Locked="false" Priority="64" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6" /> <w:LsdException Locked="false" Priority="65" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 1 Accent 6" /> <w:LsdException Locked="false" Priority="66" SemiHidden="false" UnhideWhenUsed="false" Name="Medium List 2 Accent 6" /> <w:LsdException Locked="false" Priority="67" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6" /> <w:LsdException Locked="false" Priority="68" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6" /> <w:LsdException Locked="false" Priority="69" SemiHidden="false" UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6" /> <w:LsdException Locked="false" Priority="70" SemiHidden="false" UnhideWhenUsed="false" Name="Dark List Accent 6" /> <w:LsdException Locked="false" Priority="71" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Shading Accent 6" /> <w:LsdException Locked="false" Priority="72" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful List Accent 6" /> <w:LsdException Locked="false" Priority="73" SemiHidden="false" UnhideWhenUsed="false" Name="Colorful Grid Accent 6" /> <w:LsdException Locked="false" Priority="19" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis" /> <w:LsdException Locked="false" Priority="21" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis" /> <w:LsdException Locked="false" Priority="31" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference" /> <w:LsdException Locked="false" Priority="32" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Intense Reference" /> <w:LsdException Locked="false" Priority="33" SemiHidden="false" UnhideWhenUsed="false" QFormat="true" Name="Book Title" /> <w:LsdException Locked="false" Priority="37" Name="Bibliography" /> <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading" /> </w:LatentStyles> </xml><![endif]--><!--[if gte mso 10]> <mce:style><!  /* Style Definitions */ table.MsoNormalTable {mso-style-name:"Tabla normal"; mso-tstyle-rowband-size:0; mso-tstyle-colband-size:0; mso-style-noshow:yes; mso-style-priority:99; mso-style-parent:""; mso-padding-alt:0cm 5.4pt 0cm 5.4pt; mso-para-margin-top:0cm; mso-para-margin-right:0cm; mso-para-margin-bottom:10.0pt; mso-para-margin-left:0cm; line-height:115%; mso-pagination:widow-orphan; font-size:11.0pt; font-family:"Calibri","sans-serif"; mso-ascii-font-family:Calibri; mso-ascii-theme-font:minor-latin; mso-hansi-font-family:Calibri; mso-hansi-theme-font:minor-latin; mso-bidi-font-family:"Times New Roman"; mso-bidi-theme-font:minor-bidi; mso-fareast-language:EN-US;} --> <!--[endif] --><strong><span style="font-size: 10pt; line-height: 115%;" lang="EN-US">4.- Gibt es was Neues dieses Jahr?</span></strong><span style="font-size: 10pt; line-height: 115%;" lang="EN-US"><br /> </span><span style="font-size: 10pt; line-height: 115%;">Ja, dieses Jahr gibt es zwei grundlegende Ver&auml;nderungen. </span><span style="font-size: 10pt; line-height: 115%;" lang="EN-US">Erstens werden Eigenproduktionen f&uuml;r die Auswahl nur angenommen, wenn sie mit einer freien Lizenzen angemeldet werden. Zweitens ist es dieses Jahr nicht mehr notwendig, einen Datentr&auml;ger zu schicken. Es reicht, wenn ihr das Video auf eine der zahlreichen Videoportale hochladet und uns den Link dazu schickt. Falls die Arbeit ausgew&auml;hlt wird, werdet ihr benachrichtigt, um uns eine Kopie in Vorf&uuml;hrqualit&auml;t zukommen zu lassen.</span><br /> <br /> <strong>5.- Warum akzeptiert ihr dieses Jahr keine DVDs?</strong><br /> Weil es heutzutage billiger, praktischer und schneller ist, die Arbeit ins Internet hochzuladen und uns den Link zu schicken.<br /> <br /> <strong>4.- Auf welcher Plattform empfehlt ihr uns die Videos hochzuladen?</strong><br /> Ihr k&ouml;nnt sie auf eine Streaming-Plattform wie z.B. vimeo.com oder archive.org hochladen oder auch einen Link zum direkten Download angeben.<br /> <br /> <strong>5.- Werdet ihr wirklich alle Filme auf eurer Webseite zeigen?</strong><br /> Wir von der Muestra sind sehr solz auf alle Filme, die uns erreichen und wir bedauern sehr, da&szlig; wir nur einige von ihnen zeigen k&ouml;nnen. Deshalb wollen wir alle Videos, sobald sie uns erreichen, auf unserer Seite verlinken, um m&ouml;glichst vielen Leuten die M&ouml;glichkeit zu geben, sie zu sehen. Wir verstehen allerdings, da&szlig; ihr Gr&uuml;nde haben k&ouml;nntet, die dem widersprechen (Exklusivit&auml;t anderer Festivals, M&ouml;glichkeiten zum kommerziellen Vertrieb usw.). Wenn ihr uns darauf hinweist, verschieben wir die Ver&ouml;ffentlichung auf den Tag der Er&ouml;ffnung der <em>Muestra</em>.<br /> <br /> <!--[if gte mso 9]><xml> <o:OfficeDocumentSettings> <o:RelyOnVML /> <o:AllowPNG /> </o:OfficeDocumentSettings> </xml><![endif]--><strong><span style="font-size: 10pt;" lang="EN-US">6.- Und wenn alle auf der Webseite zu sehen sind, warum dann noch auf der <em>Muestra</em>?<br /> </span></strong><span style="font-size: 10pt;" lang="EN-US">Weil obwohl die Digitalisierung den Austausch von Kopien im Netz erlaubt und erleichtert, schl&auml;gt sich das &ndash; anders als man uns glauben machen will &ndash; nicht nieder in &ouml;ffentlichen Vorf&uuml;hrungen, die f&uuml;r alle zug&auml;nglich sind. Die Vorf&uuml;hrs&auml;le sind mit teuersten Technik ausgestattet und die Kosten daf&uuml;r tr&auml;gt der Kinobesucher. Die Filme werden daher nicht oder erst nach Jahren verliehen. Die <em>Muestra</em> besteht auf dem Aspekt der Technikbefreiung: Wir machen Vorf&uuml;hrungen mit der h&ouml;chsten Qualit&auml;t (und die ist hoch), die uns die g&uuml;nstigen Ger&auml;te heutzutage erlauben. Auf diese Weise sozialisieren wir die technischen Hilfsmittel, sozialisieren die Filme, sozialisieren und Punkt.</span></p>\n<p><span style="font-weight: bold;">7</span><strong>.- Warum akzeptiert ihr diese Jahr nur freie Lizenzen?</strong><br /> Weil die Muestra de cine sich zum Ziel gesetzt hat, freie Kultur zu machen, und daher ist es logisch, da&szlig; die Teilnahmeaufforderung (Ausschreibung) dazu dient, die Werke freier Kultur zu zeigen und zu verbreiten.<br /> <br /> <strong>8.- Was bedeutet &ldquo;ordnungsgem&auml;ss lizenziert&rdquo;?</strong><br /> Im Verlauf von neun Jahren Auswahl der Eigenproduktionen haben wir festgestellt, da&szlig; viele Bewerber beim Ausf&uuml;llen des Anmeldeformulars sich entscheiden f&uuml;r &ldquo;Raubkopie&rdquo; oder &ldquo;das ist f&uuml;r alle&rdquo; oder irgendeine andere Art von Absichtserkl&auml;rung, die lediglich das ist: eine Absichtserkl&auml;rung. Wenn du nicht genau angibst, welche Lizenz die Arbeit aufweist, wird ihr automatisch das copyright &uuml;bertragen, und du wirst trotz allerbester Absichten nicht die Rechte an deinem Werk haben, die du haben willst.<br /> <br /> <strong>9.- Wie bzw. wann werde ich verst&auml;ndigt ob ich ausgew&auml;hlt wurde?</strong><br /> Sobald wir die Auswahl getroffen haben, werden wir uns mit dir per e-mail in Verbindung setzen. Als sp&auml;tm&ouml;glichsten Termin haben wir uns auf den 15. Mai 2012 festgelegt.<br /> <br /> <strong>10.- Wird das von mir geschickte Material irgendwie verwendet?</strong><br /> Das uns von euch &uuml;berlassene Material wird in unser Archiv &uuml;bernommen, das in keinem Fall ohne Einwilligung der Autoren verwendet wird.<br /> <br /> <strong>11.-Warum gibt es so viele FAQ?</strong><br /> Weil zu viel besser ist als zu wenig.</p>', NULL, 'de', '2012', 'S', 3, '2012-06-20 04:48:20', 0),
('Preguntas e respostas', '<div class="inicio-columnaizquierda"><a title="Convocatoria de obras audiovisuales con licencia libre" href="../../vista/2012/img/cartel_atp_9.jpg" rel="lightbox"> <img style="width: 180px;" src="../../img/galerias/carteles/cartel_atp_9.jpg" alt="Convocatoria de obras audiovisuales con licencia libre" /> </a> <a href="http://www.lacuadrillaestudio.com">La Cuadrilla</a> (cc by-nc-nd)</div>\n<div class="inicio-columnaderecha">\n<p><strong><span>1.- Qu&eacute; &eacute; a Muestra de cine de Lavapi&eacute;s?</span></strong><span><br /> A Muestra de cine de Lavapi&eacute;s </span><span>&eacute; un evento que leva nove anos desenvolv&eacute;ndose no barrio de Lavapi&eacute;s (Madrid) cuxo obxectivo &eacute; fomentar lugares de encontro entre veci&ntilde;@s co obxectivo de gozar dunha grella de pel&iacute;culas, documentais e curtas que durante o ano dedic&aacute;monos a seleccionar e conseguir.</span></p>\n<p><strong><span>2.- En qu&eacute; datas se realiza a Muestra? </span></strong><span><br /> </span><span>Como v&eacute;n sendo habitual real&iacute;zase a finais de xu&ntilde;o e principios de xullo</span></p>\n<p><strong><span>3.- Onde se realiza a Muestra?</span></strong><span><br /> A Muestra de Cine de Lavapi&eacute;s r</span>eal&iacute;zase naqueles locais ou asociaci&oacute;ns, bares e distintos lugares do barrio onde se realiza unha actividade cultural e colaboran coa mostra, ademais da r&uacute;a.</p>\n<p><strong><span>4.- C&oacute;mo podo colaborar na Muestra?</span></strong><span><br /> </span>O mesmo, ponte en contacto con nos, v&eacute;s a unha das nosas reuni&oacute;ns e ves se che apetece formar parte da organizaci&oacute;n.</p>\n<p><strong><span>5.- Canto custa a entrada?</span></strong><span><br /> Nada, todalas proxecciones que facemos son gratuitas, </span></p>\n</div>\n<p><strong><span>6.- C&oacute;mo vos financiades? </span></strong><span><br /> </span>Non temos ning&uacute;n tipo de subvenci&oacute;n p&uacute;blica nin patrocinadores privados. Tampouco temos demasiados gastos, facemos unha festa ao ano coa que sufragamos os programas de man, o cartel, o mantemento dos equipos que temos ou os gastos de invitados que traemos que viven f&oacute;ra de Madrid.</p>\n<p><strong><span>7.- C&oacute;mo conseguide-las pel&iacute;culas que proxectades?</span></strong><span><br /> </span>Por d&uacute;as v&iacute;as, por unha banda perseguimos a distribuidoras, produtoras, realizadorxs... para que nos cedan gratu&iacute;tamente os dereitos para unha proxecci&oacute;n durante a semana da Muestra. Por outra banda facemos unha convocatoria aberta para que quen queira nos env&iacute;e os seus traballos.</p>\n<p><span>&nbsp;</span></p>\n<p><strong><span>Convocatoria de obras audiovisuais con licencia libre</span></strong></p>\n<p><strong><span><br /> 1.- Cando finaliza o prazo de inscripci&oacute;n de autoproducci&oacute;ns?</span></strong><span><br /> O prazo para a inscripci&oacute;n vai do 15 de decembro ao 15 de marzo de 2012.</span></p>\n<p><strong><span>2.- Hai premios en met&aacute;lico?</span></strong><span><br /> Non, esto &eacute; unha Muestra de Cine, non un Festival. As obras seleccionadas proxectaranse nos d&iacute;as da Muestra.</span></p>\n<p><strong><span>3.- Por qu&eacute; este ano non aceptades DVD&acute;s? </span></strong><span><br /> Porque cos tempos que corren &eacute; m&aacute;is barato, c&oacute;modo e r&aacute;pido subi-lo a Internet e enviarnolo enlace.</span></p>\n<p><strong><span>4.- En qu&eacute; plataforma nos recomendades subir os videos que enviemos?</span></strong><span><br /> Podedes subi-lo a unha plataforma de streaming como </span><a href="http://vimeo.com/" target="_blank"><span>vimeo.com</span></a><span> ou </span><a href="http://archive.org/" target="_blank"><span>archive.org</span></a><span>, ainda que tam&eacute;n podedes por un enlace de descarga directa.</span></p>\n<p><strong><span>5.- De verdade vades a colgar t&oacute;dalas pel&iacute;culas?</span></strong><span><br /> </span><span>Na <span style="mso-spacerun: yes;">&nbsp;</span>Muestra estamos moi orgullosxs de todalas pel&iacute;culas que recibimos, e </span>d&oacute;enos poder proxectar s&oacute; unha parte delas. Por iso queremos enlazar todolos v&iacute;deos na nosa p&aacute;xina en canto nos cheguen, para posibilitar que os vexa a maior cantidade de xente posible. Pero entendemos que podades ter raz&oacute;ns para non querer que isto se faga (criterios de exclusividade doutros festivais, posibilidades de distribuci&oacute;n comercial) e, se nolo indicades, atrasaremos a s&uacute;a publicaci&oacute;n ata o d&iacute;a de inauguraci&oacute;n da Muestra.</p>\n<p><strong><span>6.- </span>E se est&aacute;n al&iacute; colgadas, por qu&eacute; velas na Muestra?</strong><span><br /> </span>Porque a&iacute;nda que a dixitalizaci&oacute;n permite e facilita o tr&aacute;nsito de copias pola rede para o seu visionado "individual" non se traduciu, como quixeron facernos pensar, en proxecci&oacute;ns p&uacute;blicas m&aacute;is accesibles. As salas adoptan unha tecnolox&iacute;a car&iacute;sima e o gasto repercute nos espectadores, as pel&iacute;culas non se distrib&uacute;en ou chegan con atraso de lustros... A Muestra se obstina no aspecto liberador da tecnolox&iacute;a: facemos proxecci&oacute;ns con toda a calidade (que &eacute; moita) que permiten os equipos baratos de hoxe, socializando eses recursos, socializando esas pelis, socializando e punto.</p>\n<p><strong><span>7.- Por qu&eacute; s&oacute; aceptades as licencias libres?<br /> </span></strong>Porque a Muestra de cine exponse como obxectivo facer libre a cultura, e o l&oacute;xico &eacute; que a convocatoria aberta sirva para visibilizar e propagar a obra de quen fan cultura libre. Temos preparamos un pequeno manual:</p>\n<p><strong><span>8.- C&oacute;mo e cu&aacute;ndo me entero si fun seleccionado?<br /> </span></strong>Unha vez fagamos a selecci&oacute;n por&eacute;monos en contacto contigo v&iacute;a mail, fix&aacute;monos como data tope o 15 de maio de 2012.</p>\n<p><strong><span>9.- El material que env&iacute;o logo &eacute; empregado? </span></strong><span><br /> </span>O material que se nos env&iacute;a pasa a formar parte do noso arquivo que nunca &eacute; usado sen o permiso dos autores.</p>\n<p><strong><span>10.- Por qu&eacute; hay tantas FAQ?</span></strong><span>&nbsp;<br /> </span><span>Porque mellor que sobre que non que falte</span></p>', NULL, 'gl', '2012', 'S', 4, '2012-06-20 04:52:14', 0),
('Bases da convocatoria', '<p><strong>Participaci&oacute;n</strong><br />1_Poden concorrer calquera persoa ou colectivo f&iacute;sico ou xur&iacute;tico, productorxs ou realizadorxs con calquera tipo de traballo audiovisual (curtametraxe, largometraje, videoarte, etc&hellip;) de calquer tipo de tem&aacute;tico que cumpra os requisitos estipulados nestas bases.</p>\n<p><strong>Selecci&oacute;n</strong><br />2_As obras presentadas deber&aacute;n levar calquera tipo de licencia libre ou dominio p&uacute;blico, sempre que est&eacute;n debidamente licenciadas.</p>\n<p>O comit&eacute; de selecci&oacute;n estar&aacute; composto por membros do colectivo que organiza a 9&ordf; Muestra de Cine de Lavapi&eacute;s, e valorar&aacute; especialmente as obras producidas e realizadas segundo os seguintes criterios:</p>\n<ul>\n<li>Gui&oacute;n e realizaci&oacute;n:&nbsp;valorarase principalmente a orixinalidade do punto de vista, a capacidade para suxerir unha mirada propia da realidade que se aborda.</li>\n<li>Producci&oacute;n:&nbsp;valoraranse especialmente as produci&oacute;ns independentes ou autoproducci&oacute;ns nas que o risco econ&oacute;mico sexa asumido polxs autorxs sen a axuda de produtoras externas. Tam&eacute;n se valorar&aacute; o enxe&ntilde;o e a valent&iacute;a na captaci&oacute;n de recursos econ&oacute;micos, humanos e t&eacute;cnicos para producir a obra.</li>\n<li>Distribuci&oacute;n: valoraranse especialmente as obras publicadas con licencia copyleft (BY-SA) e dominio p&uacute;blico.</li>\n</ul>\n<p>&nbsp;</p>\n<p><strong>A decisi&oacute;n do Comit&eacute; de preselecci&oacute;n ser&aacute; inapelable.</strong><br /><br />3_O prazo de inscrici&oacute;n &aacute;brese o 15 de decembro de 2011 e finaliza o 15 de marzo de 2012.<br /><br />4_&nbsp;A obra deber&aacute; subirse a calquera plataforma de visionado ou ben estar dispo&ntilde;ible para a s&uacute;a descarga. Os enlaces publicaranse na nosa p&aacute;xina web, accesibles para o seu visionado en xeral, desde o momento da s&uacute;a recepci&oacute;n. Se nalg&uacute;n caso, por raz&oacute;ns de forza maior, de continxencias persoais ou necesidades ineludibles, ata por capricho ou promesa no leito de morte dun ser querido, en suma, por decisi&oacute;n dxs autorxs, isto fose imposible, publicar&iacute;anse o d&iacute;a de inauguraci&oacute;n da 9&ordf; Muestra de cine de Lavapi&eacute;s.</p>\n<p>&nbsp;</p>\n<p>5_&nbsp;Non se establecen l&iacute;mites de duraci&oacute;n da obra. Non se aceptar&aacute;n as obras que foran presentadas en anteriores edici&oacute;ns da Muestra.</p>\n<p>6_Os traballos que non estean realizados en lingua castel&aacute; deber&aacute;n inclu&iacute;r subt&iacute;tulos en castel&aacute;n.</p>\n<p>7_Para inscribir a obra os aspirantes deber&aacute;n encher o&nbsp;<a href="inscricion">formulario de inscripci&oacute;n</a>&nbsp;con&nbsp;</p>\n<ul>\n<li>Datos de contacto do realizador/responsable.</li>\n<li>Enlace &aacute; obra presentada.</li>\n<li>Os datos habituais sobre a obra (ficha t&eacute;cnica e art&iacute;stica, duraci&oacute;n, datos de rodaxe).</li>\n<li>Breve sinopsis da obra.</li>\n</ul>\n<p><br />Para valorar as autoproducci&oacute;ns v&eacute;nnos especialmente ben:</p>\n<ul>\n<li>Que se informe do custo de producci&oacute;n</li>\n<li>Que se incl&uacute;a un breve relato de como e con que recursos t&eacute;cnicos e humanos realizouse.</li>\n</ul>\n<p><br /><strong>No caso de que a obra fose seleccionada</strong><br />A selecci&oacute;n comunicarase a xs autorxs o 15 de maio de 2012. Antes do 1 de xu&ntilde;o estes far&aacute;n chegar unha copia en calidade dvd para a s&uacute;a proxecci&oacute;n mediante un enlace de descarga ou por correo ordinario &aacute; direcci&oacute;n seguinte:</p>\n<p>Lavapi&eacute;s de Cine<br />C/ Fe 10<br />28012 Madrid<br /><br /><strong>Aceptaci&oacute;n das bases</strong><br />A participaci&oacute;n na Muestra de cine implica a aceptaci&oacute;n de t&oacute;dolos apartados das presentes bases.</p>', NULL, 'gl', '2012', 'S', 5, '2012-06-20 04:54:47', 0);
INSERT INTO `textos` (`titulo`, `texto`, `autor`, `lang`, `muestra`, `alta`, `id`, `fecha_alta`, `id_galeria`) VALUES
('Bases de la convocatoria', '<p><strong>Participaci&oacute;n</strong><br />1_Puede concurrir cualquier persona o colectivo f&iacute;sico o jur&iacute;dico, productorxs o realizadorxs con cualquier tipo de trabajo audiovisual (cortometraje, largometraje, v&iacute;deoarte, etc ...) de cualquier tipo de tem&aacute;tica que cumpla los requisitos estipulados en estas bases.<br /><br /><strong>Selecci&oacute;n</strong><br />2_Las obras presentadas deber&aacute;n llevar cualquier tipo de&nbsp;<a href="licencias-libres">licencia libre</a>&nbsp;o dominio p&uacute;blico, siempre que est&eacute;n debidamente licenciadas.<br /><br />El comit&eacute; de selecci&oacute;n estar&aacute; compuesto por miembros del colectivo que organiza la 9&ordf; Muestra de Cine de Lavapi&eacute;s, y valorar&aacute; especialmente las obras producidas y realizadas seg&uacute;n los siguientes criterios:</p>\n<ul>\n<li>Gui&oacute;n y realizaci&oacute;n: se valorar&aacute; principalmente la originalidad del punto de vista, la capacidad para sugerir una mirada propia de la realidad que se aborda.</li>\n<li>Producci&oacute;n: se valorar&aacute;n especialmente las producciones independientes o autoproducciones en las que el riesgo econ&oacute;mico sea asumido por lxs autorxs sin la ayuda de productoras externas. Tambi&eacute;n se valorar&aacute; el ingenio y la valent&iacute;a en la captaci&oacute;n de recursos econ&oacute;micos, humanos y t&eacute;cnicos para producir la obra.</li>\n<li>Distribuci&oacute;n: se valorar&aacute;n especialmente las obras publicadas con licencia copyleft (BY-SA) y dominio p&uacute;blico.</li>\n</ul>\n<p>&nbsp;</p>\n<p><strong>La decisi&oacute;n del Comit&eacute; de preselecci&oacute;n ser&aacute; inapelable.</strong><br /><br />3_El plazo de inscripci&oacute;n se abre el 15 de diciembre de 2011 y finaliza el 15 de marzo de 2012.<br /><br />4_La obra deber&aacute; subirse a cualquier plataforma de visionado o bien estar disponible para su descarga. Los enlaces se publicar&aacute;n en nuestra p&aacute;gina web, accesibles para su visionado en general, desde el momento de su recepci&oacute;n. Si en alg&uacute;n caso, por razones de fuerza mayor, de contingencias personales o necesidades ineludibles, incluso por capricho o promesa en el lecho de muerte de un ser querido, en suma, por decisi&oacute;n de lxs autorxs, esto fuera imposible, se publicar&iacute;an el d&iacute;a de inauguraci&oacute;n de la 9&ordf; Muestra de cine de Lavapi&eacute;s.<br /><br />5_No se establecen l&iacute;mites de duraci&oacute;n de la obra. No se aceptar&aacute;n las obras que hayan sido presentadas en anteriores ediciones de la Muestra.<br /><br />6_Los trabajos que no est&eacute;n realizados en lengua castellana deber&aacute;n incluir subt&iacute;tulos en castellano.<br /><br />7_Para inscribir la obra los aspirantes deber&aacute;n rellenar el&nbsp;<a href="inscripcion">formulario de inscripci&oacute;n</a>&nbsp;con</p>\n<ul>\n<li>Datos de contacto del realizador/responsable.</li>\n<li>Enlace a la obra presentada.</li>\n<li>Los datos habituales sobre la obra (ficha t&eacute;cnica y art&iacute;stica, duraci&oacute;n, datos de rodaje).</li>\n<li>Breve sinopsis de la obra.</li>\n</ul>\n<p><br />Para valorar las autoproducciones nos viene especialmente bien:</p>\n<ul>\n<li>Que se informe del coste de producci&oacute;n</li>\n<li>Que se incluya un breve relato de c&oacute;mo y con qu&eacute; recursos t&eacute;cnicos y humanos se realiz&oacute;.</li>\n</ul>\n<p><br /><strong>En caso de que la obra fuese seleccionada</strong><br />La selecci&oacute;n se comunicar&aacute; a lxs autorxs el 15 de mayo de 2012. Antes del 1 de junio estos har&aacute;n llegar una copia en calidad dvd para su proyecci&oacute;n mediante un enlace de descarga o por correo ordinario a la direcci&oacute;n siguiente:<br />Lavapi&eacute;s de Cine<br />C/ Fe 10<br />28012 Madrid<br /><br /><strong>Aceptaci&oacute;n de las bases</strong><br />La participaci&oacute;n en la muestra de cine implica la aceptaci&oacute;n de todos los apartados de las presentes bases.</p>', NULL, 'es', '2012', 'S', 6, '2012-06-20 04:55:09', 0),
('Bases de la convocat�ria', '<p><strong>Participaci&oacute;</strong><br />1. Hi pot participar qualsevol persona o col.lectiu f&iacute;sic o jur&iacute;dic, productors o realitzadors en qualsevol tipus de treball audiovisual ( curt, llarg, videoart, etc..) de qualsevol tem&agrave;tica que compleixi els requisits estipulats per aquestes bases.<br /><br /><strong>Selecci&oacute;</strong><br />2. Les obres presentades hauran de tenir qualsevol tipus de&nbsp;<a href="licencias-libres">llicencia lliure</a>&nbsp;o domini p&uacute;blic, sempre que estiguin llicenciades degudament.<br /><br />El comit&egrave; de selecci&oacute; estar&agrave; format per membres del dol.lectiu que organitza la 9&ordf; Mostra de Cine de Lavapi&eacute;s i valorar&agrave; especialment les obres produ&iuml;des i realitzades segons el criteris seg&uuml;ents:</p>\n<ul>\n<li>Gui&oacute; i realitzaci&oacute; : es valorar&agrave; principalment L''originalitat del punt de vista, la capacitat per a suggerir una mirada pr&ograve;pia enfront de la realitat abordada.</li>\n<li>Producci&oacute;: es valorar&agrave; especialment les produccions independents o auto-produccions, el risc econ&ograve;mic de les quals hagi sigut assumit per els autors sense ajuda de productores alienes. Tamb&eacute; es valorar&agrave; L''enginy i la valentia en la captaci&oacute; de recursos econ&ograve;mics, humans i t&egrave;cnics per a produir l''obra.</li>\n<li>Distribuci&oacute;: es valoraran especialment les obres publicades amb llic&egrave;ncia copyleft (BY-SA) i de domini public.</li>\n</ul>\n<p><strong>La decisi&oacute; del Comit&egrave; de preselecci&oacute; no admet apel.laci&oacute;.</strong></p>\n<p><br />3- El pla&ccedil; d''inscripci&oacute; s''obre el 15 de desembre de 2011 i finalitza el 15 de mar&ccedil; de 2012.<br /><br />4- L''obra s''haur&agrave; de pujar a qualsevol plataforma de visionat o be estar disponible per a &eacute;sser descarregada. Els enlla&ccedil;os es publicaran a la nostra p&agrave;gina web, i seran accessibles per el visionat general d''en&ccedil;&agrave; del moment de la seva recepci&oacute;. Si en algun cas, per raons de for&ccedil;a major, per conting&egrave;ncies personals o per necessitats ineludibles, o incl&uacute;s degut a un caprici o promesa en el llit de mort d''un &eacute;sser estimat, en fi, per decisi&oacute; dels autors/es, aixo fos impossible, es publicarien el dia d''inauguraci&oacute; de la 9&ordf; Mostra de cine de Lavapi&eacute;s.<br /><br />5- No s''estableixen l&iacute;mits de durada de l''obra. No s&acute;acceptaran obres que ja s''hagin presentat a anteriors edicions de la Mostra.<br /><br />6- Els treballs que no siguin en llengua castellana hauran d''incloure subt&iacute;tols en castell&agrave;.<br /><br />7- Per a inscriure l''obra, els aspirants hauran d''emplenar el&nbsp;<a href="&lt;a href=">"formulari d''inscripci&oacute;</a>&nbsp;fent-hi constar:</p>\n<p>&nbsp;</p>\n<ul>\n<li>dades de contacte del realitzador/responsable.</li>\n<li>enlla&ccedil; a l''obra presentada.</li>\n<li>Les dades habituals sobre l''obra (fitxa t&egrave;cnica i art&iacute;stica, durada, dades de rodatge)</li>\n<li>Curta sinopsis</li>\n</ul>\n<p>A fi de valorar les auto-produccions ens es de gran utilitat</p>\n<ul>\n<li>informaci&oacute; sobre el cost de producci&oacute;.</li>\n<li>un breu relat de c&oacute;m i amb quins recursos t&egrave;cnics i humans s''ha realitzat l''obra.</li>\n</ul>\n<p><br /><strong>En cas de que l''obra fos seleccionada</strong><br />La selecci&oacute; es comunicar&agrave; als autors el 15 de maig de 2012. Abans del 1 de juny aquests hauran de fer arribar una c&ograve;pia en calitat dvd a fi de que es pugui projectar mitjan&ccedil;ant un enlla&ccedil; de desc&agrave;rrega o per correu ordinari a la seg&uuml;ent adre&ccedil;a:<br /><br />Lavapi&eacute;s de Cine<br />C/ Fe 10<br />28012 Madrid<br /><br /><strong>Acceptaci&oacute; de les bases</strong><br />La participaci&oacute; a la mostra de cine implica l''acceptaci&oacute; de tots els apartats de les presents bases.</p>', NULL, 'ca', '2012', 'S', 7, '2012-06-20 04:55:36', 0),
('Call for audiovisual free works', '<p>Winter comes<span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;and,&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">as</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">has been happening for</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">nine years</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">,</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;so does&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">the call for</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">audiovisual</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">works</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;from&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>La Muestra de Cine de Lavapi&eacute;s</strong></span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>.</strong></span></span></p>\n<div style="margin-bottom: 0cm;"><span style="font-family: Arial,sans-serif;"><span lang="en">Since many issues</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">ago</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">we have been triying to</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">break the</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">usual</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">dynamics</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">of leisure consumption</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">, bringing the&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">films</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">to the streets and to</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">the spaces where</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">culture</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">develops</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;during&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">the rest</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">of the year.</span></span></div>\n<div style="margin-bottom: 0cm;"><span style="font-family: Arial,sans-serif;"><span lang="en">Many times the neighbors have</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">supported and</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">enjoyed</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;this&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">horizontal way</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;of understanding</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;culture, where</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">nobody pays</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">and nobody</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">is paid</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">, where&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">debate take place and</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">where you</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;may have to</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;carry</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">chairs</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">because there are not</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">enough hands</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">.</span></span></div>\n<div style="margin-bottom: 0cm;"><span style="font-family: Arial,sans-serif;"><strong><br /></strong></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>Call for audiovisual free works</strong></span></span></div>\n<div style="margin-bottom: 0cm;"><span style="font-family: Arial,sans-serif;"><span lang="en">As in previous editions</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">, we send&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">a</span></span><strong><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;call</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">for all types</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">of audiovisual works</span></span></strong><span style="font-family: Arial,sans-serif;"><span lang="en">.&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">But this</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">year we have taken</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">one more step</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">and have changed the</span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><a href="../../call-guidelines">bases</a>,</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">with an idea in</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">mind,</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">the best way&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">to publicize your</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">work,</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">make it accessible to</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;everyone.</span></span></div>\n<div style="margin-bottom: 0cm;"><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>&nbsp;</strong></span></span></div>\n<div style="margin-bottom: 0cm;"><span style="font-family: Arial,sans-serif;"><span lang="en">So this year</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">we will not ask</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">you</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;to&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">send us a</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">DVD,</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">we</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">just&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>need</strong></span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>to see</strong></span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>(or</strong></span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>download)</strong></span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>online</strong></span></span><span style="font-family: Arial,sans-serif;"><span lang="en">.</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">This</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">brings us to the</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">following requirement;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">the work must</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">have some sort of</span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><strong>free license</strong></span></span><span style="font-family: Arial,sans-serif;"><span lang="en">.</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">What,</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">in short,</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">means allowing</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">(at least</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">) to copy,&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">distribute and transmit</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">your work</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">and its</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">telematic</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">dissemination long as</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">...</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">anyway it''s</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">a</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">long story</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">,&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">so please read&nbsp;<a href="http://freedomdefined.org/Definition" target="_blank">this</a></span></span><span style="font-family: Arial,sans-serif;"><span lang="en">.</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">We have also</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">prepared a list</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">of&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en"><a href="../../faqs">frequent asked</a></span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;questions</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;whith&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">which</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">&nbsp;we will&nbsp;</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">solve any of</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">these</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">questions, and any</span></span><span style="font-family: Arial,sans-serif;"><span lang="en">more yuo bring up.</span></span></div>', NULL, 'en', '2012', 'S', 8, '2012-06-20 04:56:00', 0),
('Appel � productions audiovisuelles sous licence libre', '<p>Depuis neuf ans, d&egrave;s que l''hiver arrive, on lance l''appel aux travaux audiovisuels de la&nbsp;<strong>Muestra de Cine de Lavapi&eacute;</strong>s.<br />Beaucoup d''&eacute;ditions o&ugrave; l''on essaie de rompre avec les dynamiques habituelles de consommation de loisirs, en sortant le cin&eacute;ma dans la rue et dans les espaces o&ugrave; l''on d&eacute;veloppe de la culture pendant le reste de l''ann&eacute;e.<br /><br />Tous les ans, les voisin(e)s soutiennent et jouissent de cette fa&ccedil;on horizontale de comprendre la culture, o&ugrave; personne ne paie, o&ugrave; l''on ne paie personne, o&ugrave; l''on discute et o&ugrave; vous pouvez m&ecirc;me vous porter volontaires pour aider &agrave; placer des chaises.<br />Comme dans les &eacute;ditions pr&eacute;c&eacute;dentes, on lance un&nbsp;<strong>appel &agrave; tout type de travail audiovisuel</strong>. Mais, cette ann&eacute;e, on a avanc&eacute; d''un pas et on a chang&eacute; les bases, avec une arri&egrave;re-pens&eacute;e: la meilleure fa&ccedil;on de faire conna&icirc;tre ton travail, c''est de le rendre accessible &agrave; tout le monde.<br /><br />C''est pourquoi cette ann&eacute;e nous n''allons pas vous demander d''envoyer un DVD, mais de&nbsp;<strong>nous permettre de le visionner (ou le t&eacute;l&eacute;charger) par l''internet</strong>. Cela nous m&egrave;ne &agrave; une autre exigence: la pi&egrave;ce doit avoir n''importe quel type de&nbsp;<strong>licence libre</strong>. Bref, cela implique la permission (au moins) de copier, distribuer et communiquer publiquement votre &oelig;uvre et sa diffusion t&eacute;l&eacute;matique si et seulement si... enfin, c''est peut-&ecirc;tre un peu trop long &agrave; raconter... il vaut mieux lire&nbsp;<a title="freedomdefined" href="http://freedomdefined.org/Definition/Fr" target="_blank"><span>cliquez i&ccedil;i, svp</span></a>. Par ailleurs, nous avons pr&eacute;par&eacute; une liste de&nbsp;<a href="../../faq">questions fr&eacute;quentes</a>&nbsp;o&ugrave; nous r&eacute;pondons &agrave; tous les doutes qui puissent vous survenir et &agrave; quelques autres.</p>', NULL, 'fr', '2012', 'S', 9, '2012-06-20 04:56:46', 0),
('Ausschreibung f�r Audiovisuelle Werke mit freier Lizenz', '<p>Es gab jetzt schon viele Auflagen, bei denen wir versucht haben, die gew&ouml;hnliche Dynamik des Freizeitkonsums zu brechen, indem wir das Kino auf die Strasse holen und es dahin bringen, wo sonst kulturelle Veranstaltungen stattfinden.<br /><br />Es gab jetzt schon viele Momente, in denen die Bewohner des Viertels diese horizontale Form des Kulturverst&auml;ndnisses unterst&uuml;tzt und bei der sie sich vergn&uuml;gt haben; bei der niemand bezahlt und niemand verdient; bei der debattiert wird und bei der es passieren kann, da&szlig; du mit St&uuml;hlen beladen wirst, weil gerade nicht gen&uuml;gend H&auml;nde frei sind.<br /><br />Wie in den vorigen Jahren auch, f&uuml;hren wir auch dieses Mal eine Ausschreibung f&uuml;r alle Arten von audiovisuellen Werken durch. Allerdings machen wir dieses Jahr einen weiteren kleinen Schritt und &auml;ndern die&nbsp;<a href="../../teilnahmebedingungen">Teilnahmebedingungen</a>&nbsp;mit folgender Absicht: Die beste Art und Weise, deine Arbeit bekanntzumachen, ist sie f&uuml;r alle zug&auml;nglich zu machen.<br /><br />Deshalb bitten wir euch dieses Jahr nicht uns eine DVD zu schicken, sondern darum, da&szlig; wir die Arbeit im Internet ansehen (bzw. downloaden) k&ouml;nnen. Daraus folgt eine weitere Bedingung: Das Werk muss &uuml;ber irgendeine Art freie Lizenz verf&uuml;gen. Das bedeutet, kurz gesagt, da&szlig; (zumindest) die Erlaubnis zum Vervielf&auml;ltigen, zum Verteilen und zur &ouml;ffentlichen Bekanntmachung der Arbeit erteilt wird, sofern...na ja, das ist jetzt vielleicht ein bischen viel, mehr zur Erkl&auml;rung findet ihr&nbsp;<a href="http://freedomdefined.org/Definition/De" target="_blank">hier</a>. Au&szlig;erdem haben wir einige Antworten vorbereitet, mit denen wir hoffentlich alle m&ouml;glichen&nbsp;<a href="../../fragen">Fragen</a>&nbsp;(und noch einige mehr) beantworten k&ouml;nnen</p>', NULL, 'de', '2012', 'S', 10, '2012-06-20 04:57:04', 0),
('Agradecimientos', '<p>La Muestra quiere agradecer especialmente a todas las personas que, de una u otra manera, han colaborado para que esto pueda realizarse: a Eva, Alfonso y M&oacute;nica que vieron con nosotras autoproducciones a saco; a&nbsp;<a href="http://iagoberro.wordpress.com/" target="_blank">Iago &Aacute;lvarez</a>&nbsp;por su cartel, a&nbsp;<a href="http://www.lacuadrillaestudio.com/">La Cuadrilla</a>&nbsp;por el cartel de la convocatoria de autoproducciones; a Calipso Films por la cortinilla y por regalarnos con ella un rodaje memorable; a sindominio.net por el blog; a&nbsp;<a href="http://xsto.info" target="_blank">xsto.info</a>&nbsp;por alojar nuestra web; a Diagonal, al AMPA del CEIP Emilia Pardo Baz&aacute;n; a Ram&oacute;n, de IEPE, por proveer de lonas a medio barrio y al taller Puntera, por prestarnos herramientas y oficio para hacerle los remaches y convertirlas en pantallas.</p>\n<p><br />A las empresas e instituciones que gratuitamente nos han cedido sus pel&iacute;culas para que podamos exhibirlas: Alta Films, Golem, Institut Fran&ccedil;ais de Espa&ntilde;a en Madrid, Esc&aacute;ndalo Films, Paramount Pictures, Research Entertainment, Frida Films, Goethe Institut; a quienes nos han cedido sus pel&iacute;culas y/o vendr&aacute;n a presentarlas: Javier Serrano Fayos, Jan Codina, colectivo Thawra, Mar&iacute;a Ruido, Sylvain George, Izaskun S. Aroca, Jos&eacute; Luis &Aacute;lvarez, David &Aacute;lvarez e Ivar Mu&ntilde;oz-Rojas, Ad&aacute;n Aliaga, Luisa Romeo y Sergio Frade; a quienes siempre est&aacute;n dispuestos a dejarnos cosas, aunque este a&ntilde;o no haya podido ser: Instituto Italiano de Cultura, Instituto Polaco de Cultura, Embajada de Portugal, Eddie Saeta, Pir&aacute;mide Films, Wanda Films, Zapata Films... A Eva y Fernando (<a href="http://guardarcomo.films" target="_blank">guardarcomo.films</a>) por venir a compartir su saber sobre herramientas libres, y a Fernando Arrocha y Agatha Maciaszek por contarnos c&oacute;mo van a lograr financiar sus pel&iacute;culas. A Susana, Andrea, Anouk, Almudena y quienes se presenten en el &uacute;ltimo momento por animarse a charlar con nosotras sobre licencias y libertades, a Stephane M Grueso por aceptar nuestra invitaci&oacute;n para la mesa redonda del 28 de junio; a Fuera de Lugar por venir a actuar en la fiesta de clausura; a Mayka Guerao, de Fisahara, por ayudarnos en las gestiones de programaci&oacute;n; a quienes han registrado sus pel&iacute;culas con licencias libres y a quienes nos las han enviado a nuestra convocatoria (elegidas o no); a la Filmoteca por volver a dejarnos inaugurar la Muestra en su bella sala de cine y a Marina por recibirnos all&iacute; con humor y paciencia; a todas las personas que durante la semana de la Muestra arriman con entusiasmo hombros y sillas, echan cables, sirven cervezas y arrastran carros y carretas junto a los muestrenses para que lo que decimos en este programa se haga realidad; a todas las asambleas, colectivos e individuos que acogen las proyecciones en sus locales y a todos los que con vuestra presencia nos anim&aacute;is a seguir creyendo que esta locura merece la pena.</p>\n<p><br />A las asambleas, plataformas, colectivos, grupos, centros sociales, personas y proyectos que sostienen y expanden desde cada barrio las realidades nuevas, que no novedosas, y los sue&ntilde;os de siempre, que no viejos, del 15m.</p>', NULL, 'es', '2012', 'S', 11, '2012-06-20 05:01:06', 0),
('Call guidelines', '<p><strong>Participation</strong><br />1_ Any person, group or entity, producers or directors, may participate with any audiovisual work (short film, feature film, video art, etc ...) on any subject that meets the requirements of these rules.<br /><br /><strong>Selection</strong><br />2_ The works submitted must use any type of free or public domain license, provided they are properly licensed.<br /><br />The selection committee shall be composed by members of the group that organized the<strong>&nbsp;9 th&nbsp;</strong><em><strong>Muestra de Cine de Lavapies</strong></em>, and will particularly appreciate the works produced and performed on the following criteria:<br />&nbsp;</p>\n<ul>\n<li>Script and realization: It will be valued mainly the originality of point of view, the capacity to suggest a personal view of the reality being described.</li>\n<li>Production: they will be specially appreciated independent productions or self-productions in which the financial risk is assumed by the authors without the help of outsiders. The wit and courage in raising financial resources, human and technical resources to produce the work will be also valued.</li>\n<li>Distribution: The works published under copyleft license (BY-SA) and public domain will be specially appreciate</li>\n</ul>\n<p><br /><strong>The screening committee''s decision is final.</strong><br /><br />3_ The registration period opens on December 15, 2011 and ends on March 15, 2012.<br />4_ The work must get on any viewing platform or be available for download. The links will be posted on our website, available for general viewing, since the time of receiption. If in some cases, as decided by the authors, this would not be possible, they would be published on the opening day of the 9 th&nbsp;<em>Muestra de Cine de Lavapi&eacute;s</em>.<br />5_ Limitations on how large the work will be are not established. Works that have been presented in previous editions of the Festival will not be accepted.<br /><br />6_ The work not performed in Spanish language must include captions in Castilian.<br /><br />7_ To enter the work applicants must fill out the registration form established:</p>\n<ul>\n<li>Contact information of the director / manager.</li>\n<li>Links to the work presented.</li>\n<li>The usual data about the work (technical and artistic life, shooting data).</li>\n<li>Brief synopsis of the work.</li>\n</ul>\n<p>To evaluate the autoproduction will be useful:</p>\n<ul>\n<li>That the cost of production will be reported.</li>\n<li>A brief account of what and which technical and human resources were used should be presented</li>\n</ul>\n<p><br /><strong>In case the work will be selected</strong><br />The selection will be communicated to the authors on fifteenth May 2011. A copy with DVD quality should be sent by link or by ordinary mail to the following address:<br />Lavapi&eacute;s de Cine<br />C/ Fe 10<br />28012 Madrid<br /><br /><strong>Acceptance of bases</strong><br />The participation in the festival involves the acceptance of all the present bases.</p>', NULL, 'en', '2012', 'S', 12, '2012-06-20 05:01:38', 0),
('Frequently asked question', '<div class="inicio-columnaizquierda"><a title="Convocatoria de obras audiovisuales con licencia libre" href="../../vista/2012/img/cartel_atp_9.jpg" rel="lightbox"> <img style="width: 180px;" src="../../img/galerias/carteles/cartel_atp_9.jpg" alt="Convocatoria de obras audiovisuales con licencia libre" /></a>by&nbsp; <a href="http://www.lacuadrillaestudio.com">La Cuadrilla</a> cc by-nc-nd</div>\n<div class="inicio-columnaderecha">\n<p><strong><span>1.- What is &ldquo;La Muestra de Cine de Lavapi&eacute;s&rdquo;?</span></strong><br /> <span>La Muestra de Cine de Lavapi&eacute;s</span><span> is an event that''s been taking place for nine years in the Lavapi&eacute;s quarter (Madrid) which aims to promote encounters between neigh''s in order to enjoy a great list of films, documentaries and shorts, which we are dedicated to select and get months before the Muestra occurs.</span><br /> <br /> <strong><span>2 .- When La Muestra takes place?</span></strong><br /> <span>As usual, in late June and early July.</span><br /> <br /> <strong><span>3 .- Where is the Show?</span></strong><br /> <span>La Muestra de Lavapi&eacute;s is done on those local associations, bars and other places in the neighborhood where cultural activity is carried out and that they want collaborate with La Muestra. There are projections in some squares, too.</span><br /> <br /> <strong><span>4 .- How I can help in La Muestra?</span></strong><br /> <span>Again, please </span><a href="contacta" target="_blank"><span>contact us</span></a><span>. You can come to one of our meetings and see if you feel like being part of the organization.</span><br /> <br /> <strong><span>5 .- How much is the ticket?</span></strong><br /> <span>Nothing, all the projections that we make are free.</span></p>\n</div>\n<p><strong><span>6 .- How do you get funding?</span></strong><br /> <span>We have neither public subsidy nor private sponsors. Nor do we have too many expenses. We make a party every year which helps to defray the handout, the poster, maintenance of equipment or the costs we have for bringing guests who live outside of Madrid.</span><br /> <br /> <strong><span>8 .- How do you get the films?</span></strong><br /> <span>In two ways: first we seek to distributors, producers, directors ... hoping they cede us the rights to do a free projection during the week of La Muestra. On the other hand, we make an open call for anyone who wants to send us their work.</span></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p><strong>Call for audiovisual free works</strong><br /> <br /> <strong><span>1 .- When is the deadline for registration?</span></strong><br /> <span>The deadline for registration is December 15 to March 15, 2012.</span><br /> <br /> <strong><span>2 .- Is there cash prizes?</span></strong><br /> <span>No, this is not a festival. Selected works will be screened in the days of the Exhibition.</span><br /> <br /> <strong><span>3 .- Why this year will not accept DVD''s?</span></strong><br /> <span>For in these days is more convenient, cheaper and faster that they are upload on the internet and you send the link.</span><br /> <span><br /> </span><strong><span>4 .- What platform do you recomend we upload the videos we want to send?</span></strong><br /> <span>You can upload them to a streaming platform as </span><a href="http://www.google.es/url?sa=t&amp;rct=j&amp;q=vimeo&amp;source=web&amp;cd=1&amp;ved=0CCgQFjAA&amp;url=http%3A%2F%2Fvimeo.com%2F&amp;ei=L3fmTp-PFYWh-QaGn-3WBQ&amp;usg=AFQjCNGtqpYt-X_l4gw28wKRCyZd6WUKqw&amp;cad=rja" target="_blank"><span>vimeo.com</span></a><span> or </span><a href="http://www.google.es/url?sa=t&amp;rct=j&amp;q=archive%20org&amp;source=web&amp;cd=1&amp;ved=0CCsQFjAA&amp;url=http%3A%2F%2Fwww.archive.org%2F&amp;ei=NHfmTpTLEIXt-gbEy8iYAg&amp;usg=AFQjCNHW_CXGAZjSayb-8euU-Bex03HGsw&amp;cad=rja" target="_blank"><span>archive.org</span></a><span>. You can also put a direct download link.</span><br /> <br /> <strong><span>5 .- Are you really going to put all the movies up in your web?</span></strong><br /> <span>In la Muestra we are proud of all the films we received, and it hurts us to project only a part of them. So we want to link all the videos on our website as soon as we get them, to be seen for as many people as possible. But we understand that you may have reasons for not wanting this to be done (exclusive criteria in some festivals, opportunities for commercial distribution) and, if you make clear to us, we delayed the release until the day of inauguration.</span><br /> <br /> <strong><span>6 .- Why only accept free licenses?</span></strong><br /> <span>Because La Muestra seeks a free access to culture, and it is logical that the open call serve to make visible the work of those who pursue the same goal.</span><br /> <br /> <strong><span>7 .- How and when will I know if I am selected?</span></strong><br /> <span>Once we have made our selection we will contact you via e-mail. We have set the deadline of May 15, 2012.</span><br /> <strong><br /> <span>8 .- The material I send is used after La Muestra ends?</span></strong><br /> <span>The material submitted to us becomes part of our files is never used without the permission of the authors.</span><br /> <strong><br /> <span>9 .- Why are there so many FAQ''s?</span></strong><br /> <span>"It''s better to have too much than not enough"</span></p>\n<p>&nbsp;</p>', NULL, 'en', '2012', 'S', 13, '2012-06-20 05:02:38', 0),
('Teilnahmebedingungen', '<p><strong>Teilnahme</strong><br />1_Teilnehmen kann jede nat&uuml;rliche oder juristische Person, jede/r Filmemacher/in und jeder Produzent mit jeglicher audiovisuellen Arbeit (Kurzfilm, Langfilm, Videokunst usw.) ohne Einschr&auml;nkung des Themas bei Erf&uuml;llung der folgenden Bedingungen:</p>\n<p><strong>Auswahl</strong><br />2_Die eingereichten Werke m&uuml;ssen Arbeiten m&uuml;ssen&nbsp;<a href="http://freedomdefined.org/Definition/De" target="_blank">frei lizenziert</a>&nbsp;oder&nbsp;<a href="http://creativecommons.org/publicdomain/zero/1.0/deed.de" target="_blank">gemeinfrei</a>&nbsp;(engl. public domain) sein, d.h. eine ordnungsgem&auml;sse Lizenzierung wird vorausgesetzt.<br /><br />Die Auswahljury setzt sich aus Mitglieder des Teams zusammen, die die 9. Muestra de Cine Lavapi&eacute;s organisiert. Sie bewertet die Werke vor allem nach den folgenden Kriterien:</p>\n<ul>\n<li>Drehbuch und Ausf&uuml;hrung: Originalit&auml;t des Standpunkts und Potential zur Entwicklung eines eigenen Blickpunkts auf die zur Sprache gebrachten Wirklichkeit</li>\n<li>Produktion: Es werden besonders unabh&auml;ngige Produktionen oder Eigenproduktionen honoriert, in denen die Autoren das wirtschaftliche Risiko ohne Hilfe durch externe Produzenten tragen. Au&szlig;erdem wird der Einfallsreichtum und der Mut zur Beschaffung von Geldmitteln, des Personals und der technischen Hilfsmittel bei der Produktion der Arbeit bewertet.</li>\n<li>Vertrieb: Es werden besonders Werke mit einer copyleft-Lizenz (BY-SA) oder gemeinfreie Arbeiten gew&uuml;rdigt.</li>\n</ul>\n<p><br /><strong>Die Entscheidung der Jury ist unanfechtbar.</strong></p>\n<p>3_Die Anmeldefrist beginnt am 15. Dezember 2011 und endet am 15. M&auml;rz 2012<br />&nbsp;</p>\n<p>4_Die Arbeit sollte auf ein beliebiges Videoportal hochgeladen sein bzw. zum Download zur Verf&uuml;gung stehen. Der Link zum Video wird nach dem Eintreffen bei uns auf unsere Webseite &uuml;bernommen und f&uuml;r alle zug&auml;nglich bzw. ansehbar gemacht. Falls das aus irgendeinem Grund, z.B. durch h&ouml;here Gewalt, menschliche Schw&auml;che oder unvermeidliche Bed&uuml;rfnisse(dazu geh&ouml;ren auch Marotten und der letzte Wille eines uns nahestehenden Menschen), also durch den Willen der Autoren, nicht m&ouml;glich w&auml;re, w&uuml;rde die Ver&ouml;ffentlichung im Web auf den Tag der Er&ouml;ffnung der 9. Muestra de cine de Lavapi&eacute;s verschoben werden.<br />&nbsp;</p>\n<p>5_Es gibt keine Einschr&auml;nkungen bei der Laufzeit. Es werden jedoch keine Arbeiten angenommen, die bereits bei fr&uuml;heren Ausgaben der Muestra gezeigt wurden.<br />&nbsp;</p>\n<p>6_Arbeiten mit f&uuml;r das Verst&auml;ndnis relevanten Dialogen und die nicht in spanischer Sprache vorgelegt werden, m&uuml;ssen mit spanischen Untertiteln versehen sein.<br />&nbsp;</p>\n<p>7_Zur Anmeldung der Arbeit bitte das&nbsp;<a href="anmeldeformular">Anmeldeformular</a>&nbsp;ausf&uuml;llen mit</p>\n<ul>\n<li>den Kontaktdaten des/r Filmemachers/in bzw. des/r Verantwortlichen</li>\n<li>dem Link zur vorgestellten Arbeit</li>\n<li>den g&auml;ngigen Filmdaten (Credits, Laufzeit, Angaben zu den Dreharbeiten)</li>\n<li>einer kurzen Zusammenfassung</li>\n</ul>\n<p>Um die Eigenproduktionen bewerten zu k&ouml;nnen w&auml;re f&uuml;r uns sehr hilfreich:</p>\n<ul>\n<li>Informationen &uuml;ber die Produktionskosten</li>\n<li>Kurze Beschreibung wie und mit welchen Mitteln (Personal und Technik) produziert wurde</li>\n</ul>\n<p><strong>Bei Auswahl der Arbeit</strong></p>\n<p>Die Auswahl wird den Kontaktpersonen am 15. Mai 2012 mitgeteilt. Zur Vorf&uuml;hrung brauchen wir dann vor dem 1. Juni eine Kopie in DVD-Qualit&auml;t, die uns entweder per Link zum Download oder per Post an die folgende Anschrift &uuml;bermittelt werden sollte:<br />Lavapi&eacute;s de Cine<br />C/ Fe 10<br />28012 Madrid<br /><br /><strong>Akzeptierung der Teilnahmebedingungen</strong><br />Die Einreichung eines Wekes zur Muestra bedeutet die Anerkennung dieser Teilnahmebedingungen.</p>', NULL, 'de', '2012', 'S', 14, '2012-06-20 05:03:13', 0),
('Licencias libres para obras audiovisuales', '<p>La propiedad intelectual de una obra, corresponde al autor/a por el solo hecho de su creaci&oacute;n. El registro de la obra sirve como prueba ante posibles plagios o usos indebidos de nuestra obra, y no es obligatoria para el autor. Para registrar se puede acudir al <a href="http://www.mcu.es/propiedadInt/CE/RegistroPropiedad/RegistroPropiedad.html" target="_blank">Registro de la Propiedad Intelectual</a> o bien hacer un registro on-line basados en la figura de los terceros de confianza, para ello existen plataformas en internet como <a href="http://colorIURIS.net">ColorIURIS</a> o <a href="http://www.safecreative.org/" target="_blank">Safe Creative</a>.<br /> <br /> En materia de derechos de autor se suele distinguir los</p>\n<ul type="disc">\n<li><strong>Derechos morales</strong>: son aquellos ligados al autor de manera permanente y son irrenunciables e imprescriptibles.</li>\n<li><strong>Derechos patrimoniales</strong>: son aquellos que permiten de manera exclusiva la explotaci&oacute;n de la obra hasta un plazo contado a partir de la muerte del &uacute;ltimo de los autores, posteriormente pasan a formar parte del dominio p&uacute;blico pudiendo cualquier persona explotar la obra.</li>\n</ul>\n<p>Una licencia es una declaraci&oacute;n contractual por la cual otorgamos a terceros el derecho a usar nuestra obra bajo las condiciones que libremente decidimos y los usos que pueden hacer de esta.</p>\n<p>Existen diferentes tipos de licencias en funci&oacute;n de las condiciones que impone el autor. Por un lado,&nbsp;est&aacute; el <strong>copyright</strong> en el que los derechos de explotaci&oacute;n est&aacute;n reservados para el poseedor de los derechos patrimoniales y, por tanto, impide que las obras sean reproducidas, transformadas o publicadas por terceros sin obtener previamente permiso expreso y por escrito de los titulares.</p>\n<p>Por otro lado, existen diferentes licencias, con algunos derechos reservados, podemos diferenciar:</p>\n<ul type="disc">\n<li><strong>Semilibres</strong>: Algunos derechos reservados. No permitimos ciertos usos: Obras derivadas, comerciales, o los que decidamos.</li>\n<li><strong>Libres o copyleft</strong>. permite uso, copia, modificaci&oacute;n y redistribuci&oacute;n pero exigiendo los mismos derechos en las obras derivadas. La definici&oacute;n m&aacute;s exacta la puedes leer en <a href="http://freedomdefined.org/Definition/Es" target="_blank">freedomdefined.org</a></li>\n</ul>\n<p>Por &uacute;ltimo cuando un autor decide revertir al <strong>Dominio P&uacute;blico</strong> todos los derechos patrimoniales,permitecopiar, modificar, distribuir y usar como los dem&aacute;s quieran.</p>\n<p>Los derechos que el autor se puede reservar son:</p>\n<div id="listado-licencias">\n<ul>\n<li>\n<div id="doc-by"><strong>Reconocimiento (BY): </strong>En cualquier explotaci&oacute;n de la obra autorizada por la licencia har&aacute; falta reconocer la autor&iacute;a.</div>\n</li>\n<li>\n<div id="doc-nc"><strong>No Comercial (NC):</strong> La explotaci&oacute;n de la obra queda limitada a usos no comerciales.</div>\n</li>\n<li>\n<div id="doc-nd"><strong>Sin obras derivadas (ND)</strong>: La autorizaci&oacute;n para explotar la obra no incluye la transformaci&oacute;n para crear una obra derivada.</div>\n</li>\n<li>\n<div id="doc-sa"><strong>Compartir Igual (SA) o Coypyleft:</strong> La explotaci&oacute;n autorizada incluye la creaci&oacute;n de obras derivadas siempre que mantengan la misma licencia al ser divulgadas.</div>\n</li>\n</ul>\n</div>\n<p>En este gr&aacute;fico (de <a href="http://commons.wikimedia.org">commons.wikimedia.org</a>), se puede ver el espectro de licencias, desde la m&aacute;s restrictiva en rojo a la m&aacute;s permisiva en verde</p>\n<p><img src="../../img/licencias/CreativeCommonsSpectrum.png" alt="" /></p>\n<p>&nbsp;</p>\n<p>&nbsp;Las licencias libres o semilibres existentes para obras audiovisuales son:</p>\n<div id="listado-licencias">\n<ul type="disc">\n<li>\n<div id="doc-02"><strong>Licencias Creative commons</strong>&nbsp; originalmente fueron redactadas en ingl&eacute;s, pero han sido adaptadas a varias legislaciones en otros pa&iacute;ses. Permite a los autores poder decidir ciertas restricciones en la difusi&oacute;n de su obra, <a href="http://es.creativecommons.org/licencia/" target="_blank">ver licencias.<br /> </a></div>\n</li>\n<li>\n<div id="doc-colorIURIS"><strong>ColorIURIS</strong>&nbsp; sistema internacional de gesti&oacute;n y cesi&oacute;n de derechos de autor creado a partir del <a href="http://es.wikipedia.org/wiki/Derecho_continental">modelo jur&iacute;dico continental</a>, cuya principal caracter&iacute;stica es la puesta a disposici&oacute;n de contenidos a trav&eacute;s de contratos de cesi&oacute;n de derechos, o acuerdos de licencia, que se distinguen por un sistema de <a href="http://www.coloriuris.net/es:codigo_colores">colores</a> seg&uacute;n qu&eacute; restricciones quiera el autor.</div>\n</li>\n<li>\n<div id="doc-20"><strong>Licencia Aire Incondicional </strong>(BY-NC-SA)&nbsp; fue redactada desde el principio en espa&ntilde;ol y desde el marco legal de Espa&ntilde;a - <a href="http://www.platoniq.net/aireincodicional_licencia.html" target="_blank">ver licencia<br /> </a></div>\n</li>\n<li>\n<div id="doc-21"><strong>Licencia Arte Libre</strong> (BY-SA) una licencia que surge del encuentro de <em>Copyleft Attitude</em> en Par&iacute;s, con el fin de dar acceso abierto a una obra para autorizar su uso sin ignorar los derechos morales de autor <a href="http://artlibre.org/licence/lal/es" target="_blank">ver licencia</a></div>\n</li>\n<li>\n<div id="doc-22"><span style="font-weight: bold;">Licencia Against DRM 2.0</span> (BY-SA) - <span id="result_box" lang="es"><span class="hps">es una licencia</span> <span class="hps">copyleft</span> <span class="hps">gratis para</span> <span class="hps">obras de arte</span><span>.</span> <span class="hps">Se trata de</span> <span class="hps">la primera licencia</span> <span class="hps">de contenido libre</span> <span class="hps">que contiene una cl&aacute;usula</span> <span class="hps">sobre</span> <span class="hps">los derechos conexos</span> <span class="hps">y una cl&aacute;usula</span> <span class="hps">en contra del DRM</span></span>. <a href="http://freecreations.org/Against_DRM2_es1.html" target="_blank">ver licencia</a></div>\n</li>\n</ul>\n</div>\n<p>&nbsp;</p>\n<p>La manera m&aacute;s f&aacute;cil de asegurarte que todo el mundo sepa de la licencia que has elegido, es ponerla en los t&iacute;tulos de cr&eacute;dito. Por ejemplo:</p>\n<p><img title="Pudor - CC BY-NC-SA" src="../../img/licencias/pantallazo.png" alt="" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img title="Big buck bunny - CC BY" src="../../img/licencias/pantallazo2.png" alt="" /><br /> <a href="http://vimeo.com/4154241">Pudor - Felipe Vara de Rey</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://vimeo.com/1084537">Big Buck Bunny -&nbsp; Blender Institute</a></p>\n<p>&nbsp;</p>\n<p>Tambi&eacute;n las plataformas de streaming suelen incorporar una opci&oacute;n para definir cu&aacute;l es la licencia creative commons del v&iacute;deo</p>\n<ul>\n<li><a href="http://www.youtube.com/t/creative_commons" target="_blank">youtube.com/t/creative_commons</a></li>\n<li><a href="http://vimeo.com/creativecommons">vimeo.com/creativecommons</a></li>\n</ul>\n<p>&nbsp;</p>\n<p>Si quer&eacute;is saber m&aacute;s sobre el tema os recomendamos:</p>\n<ul type="disc">\n<li><a href="http://blogs.latabacalera.net/dgac/manual-de-registro-y-licencias-libres" target="_blank">Manual de registro y licencias libres</a>(presentaci&oacute;n)</li>\n<li><a href="http://www.rtve.es/television/documentales/copiad-malditos/" target="_blank">Copiad Malditos</a> (v&iacute;deo)</li>\n<li><a href="http://en.wikipedia.org/wiki/List_of_open_content_films" target="_blank">Ejemplos de pel&iacute;culas con licencias libres</a>(en)</li>\n<li><a href="http://fundacioncopyleft.org/" target="_blank">Fundacion Copyleft</a></li>\n<li><a href="http://rtve.es/alacarta/audios/hoy-empieza-todo/hoy-empieza-todo-festival-cine-creative-commons-16-05-11/1102294/" target="_blank">Luis Rom&aacute;n de bccn.cc lo cuenta en Hoy empieza todo</a> (audio)</li>\n</ul>\n<p>&nbsp;</p>', NULL, 'es', '2012', 'S', 15, '2012-06-20 05:03:51', 0);
INSERT INTO `textos` (`titulo`, `texto`, `autor`, `lang`, `muestra`, `alta`, `id`, `fecha_alta`, `id_galeria`) VALUES
('Convocatoria de obras audiovisuales con licencia libre', '<div id="cartel-home"><img src="../../img/galerias/carteles/cartel_atp_9.jpg" alt="" /> Cartel realizado por <a href="http://www.lacuadrillaestudio.com" target="_blank">La Cuadrilla</a>\n<ul>\n<li><a title="Convocatoria de obras audiovisuales con licencia libre" href="../../convocatoria">Presentaci&oacute;n</a></li>\n<li><a title="Bases de la convocatoria" href="../../bases-convocatoria">Bases</a></li>\n<li><a title="Convocatoria abierta" href="../../seleccion">Selecci&oacute;n</a></li>\n<li><a title="Obras inscritas en la convocatoria de obras audiovisuales con licencia libre" href="../../material-recibido">Obras inscritas</a></li>\n</ul>\n</div>\n<div id="txt-home">\n<p>Desde la segunda edici&oacute;n de la Muestra de cine de Lavapi&eacute;s hemos hecho una convocatoria anual de autoproducciones y trabajos audiovisuales. Lo que en las primeras ediciones fue una llamada a los amigos para que proyectaran sus obras en la Muestra se convirti&oacute; con el paso del tiempo en una macroconvocatoria, en la que llegamos a recibir m&aacute;s de 400 producciones de todo tipo. De manera paralela hemos programado talleres, mesas redondas y charlas de sensibilizaci&oacute;n sobre derechos de autor, licencias libres, herramientas de producci&oacute;n basadas en software libre, colaborando y difundiendo el trabajo que han desarrollado los hacktivistas en contra de toda legislaci&oacute;n que buscara cercenar la libertad de expresi&oacute;n (ley Sinde, Hadopi, canon digital, ley SOPA...). Igualmente, en las bases de nuestras sucesivas convocatorias hemos dado prioridad a aqu&eacute;llas obras licenciadas bajo cualquier variante no restrictiva.<br /><br />En esta edici&oacute;n nos hemos decidido a dar el gran salto adelante y dejar la convocatoria de autoproducciones abierta exclusivamente para obras audiovisuales con licencias&nbsp; libres y que puedan ser visualizadas desde nuestra web, actuando como un canal de distribuci&oacute;n y como plataforma de visionado gratuita y libre.<br /><br />Este paso es la consecuencia l&oacute;gica de un proceso paralelo de maduraci&oacute;n de la Muestra, pero tambi&eacute;n de la sociedad, que asume ya como normal la existencia y el uso cotidiano de este tipo de licencias. La nuestra ya no es una postura rebelde que abandera un futuro incierto, sino una respuesta a la generalizaci&oacute;n del conocimiento, la aceptaci&oacute;n y la defensa de una forma de compartir saberes, experiencias y sensibilidades. Ahora se trata simplemente de dejarnos llevar.<br /><br />No se entienda esto como un brindis al sol, un optimismo ciego. Somos conscientes de que el dinosaurio anda a&uacute;n por ah&iacute;, arrastr&aacute;ndose. La mayor&iacute;a del sector audiovisual sigue anclada en un modelo de producciones cada vez m&aacute;s caras, pensando (&iquest;lo llamamos pensar?) que el 3D es el futuro de la industria, confiando su salvaci&oacute;n a los superh&eacute;roes. Ya lo dec&iacute;a Machado: &ldquo;Castilla agonizante, ayer dominadora, envuelta en sus harapos, desprecia cuanto ignora&rdquo;. A nosotras estas producciones nos recuerdan a esas inmensas promociones inmobiliarias que invaden nuestros paisajes, mastod&oacute;nticas, vac&iacute;as, inhabitables. Colosos con pies en el fango inaccesibles para nuestra econom&iacute;a diminuta y que se convierten en vengadores t&oacute;xicos y que, rescates mediante, acabamos pagando entre todas. La industria del cine, super subvencionada, genera incesantemente pel&iacute;culas que no encuentran d&oacute;nde proyectarse, con entradas que cuestan un mont&oacute;n y que, para qu&eacute; negarlo, no nos interesan demasiado.<br /><br />Las productoras se empecinan en proyectos cada vez m&aacute;s caros, el desembolso publicitario cada vez es mayor, las distribuidoras independientes no pueden afrontar esos gastos y fastos, los exhibidores cierran las salas comerciales cada vez m&aacute;s desiertas ante el elevado coste de la entrada. Es el colapso de la burbuja, del modelo hipotecario cinematogr&aacute;fico.<br /><br />Ante esta situaci&oacute;n la industria descubre (a buenas horas) otros canales de distribuci&oacute;n: los festivales, muestras, redes de cineclubes... e internet. Proliferan las plataformas de visionado en streaming... pero siempre bajo el signo de la exclusividad, del corporativismo y de la competencia. Siguen obcecados con el concepto de &ldquo;estreno&rdquo;, lo que siempre y en todo lugar conduce a la obsolescencia programada.<br /><br />Siendo conscientes de este panorama, nuestra apuesta no es s&oacute;lo proyectar las autoproducciones en la semana de la Muestra sino convertir nuestra p&aacute;gina web en canal de distribuci&oacute;n y plataforma de distribuci&oacute;n de todas las obras recibidas.<br /><br />Aunque algo sab&iacute;amos del tema, el proceso de transformar nuestra vieja convocatoria en una convocatoria realmente abierta ha sido enrevesado y un poco farragoso. Pero hemos aprendido mucho. Por ejemplo que, gracias al car&aacute;cter libre de las pel&iacute;culas convocadas, pod&iacute;amos ampliar el concepto de gratuidad de la Muestra. Para la selecci&oacute;n y el visionado en web ped&iacute;amos un enlace a una plataforma de visualizaci&oacute;n. De esta manera pudimos despu&eacute;s permitirnos el pagar los portes de aquellas obras seleccionadas que necesitaran enviarse en un soporte f&iacute;sico. Puede parecer una tonter&iacute;a pero, para una Muestra que presume de eliminar costes en todas sus facetas, el ahorrar los gastos de env&iacute;o es un gran paso. Adem&aacute;s, nos ha permido hacer internacional la convocatoria.<br /><br />Y hemos recibido 73 obras. 73 pel&iacute;culas, largometrajes y cortometrajes, ficciones y documentales, la mayor&iacute;a comprometidas con la tarea de contarnos, desde la historia o desde el presente, fabulando o registrando la realidad, con la vista puesta en compartir.<br /><br />Por estas razones (y alguna m&aacute;s) esta edici&oacute;n est&aacute; protagonizada por las autoproducciones. Inauguramos con ellas y clausuramos con ellas.<br /><br />Aquellos que nos sois mas fieles os habr&eacute;is percatado de que este a&ntilde;o no inauguramos con la pel&iacute;cula ganadora del Fisahara como viene siendo habitual desde hace ocho a&ntilde;os y que es producto del hermanamiento que tenemos con este Festival como muestra de solidaridad hacia el pueblo saharaui. Los motivos de no hacerlo se deben exclusivamente a lo que hemos expuesto anteriormente. La pel&iacute;cula ganadora de este a&ntilde;o ha sido estrenada en estos d&iacute;as y precisamente por la l&oacute;gica del sistema no nos ha podido ser cedida al estar en cartelera. Por esta raz&oacute;n inauguramos con una autoproducci&oacute;n sobre la causa saharaui que tambi&eacute;n particip&oacute; en el Fisahara.<br /><br />La clausura tambi&eacute;n es una autoproducci&oacute;n. Hab&iacute;amos decidido clausurar la Muestra con una pel&iacute;cula que hablase sobre el proceso del 15M, que nos han enviado con una licencia libre. No pod&iacute;a ser de otra manera.<br /><br />Sigue diciendo Machado: &ldquo;Todo se mueve, fluye, discurre, corre o gira; cambian la mar y el monte y el ojo que los mira.&rdquo;</p>\n</div>', NULL, 'es', '2012', 'S', 16, '2012-06-20 05:08:29', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `pass` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `nivel_acceso` int(11) NOT NULL DEFAULT '0',
  `email` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_nivel_acceso` (`nivel_acceso`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci PACK_KEYS=1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `pass`, `nivel_acceso`, `email`, `alta`, `fecha_alta`) VALUES
(2, 'admin', '827ccb0eea8a706c4c34a16891f84e7b', 1, 'admin@admin.com', 'S', '2012-06-17 10:38:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web_modulos`
--

CREATE TABLE IF NOT EXISTS `web_modulos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `nombre` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `alta` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'S',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `web_modulos`
--

INSERT INTO `web_modulos` (`id`, `modulo`, `descripcion`, `nombre`, `alta`, `fecha_alta`) VALUES
(1, 'escaparate', 'Fotos y v�deos', '', 'S', '2012-06-17 10:34:52'),
(2, 'contacta', 'Formulario de contacto', '', 'S', '2012-06-17 10:34:52'),
(3, 'ediciones', 'lista todas las ediciones de la muestra', '', 'S', '2012-06-17 10:34:52'),
(4, 'espacios', 'mapa con los espacios de proyecci�n', '', 'S', '2012-06-17 10:34:52'),
(5, 'inscripcion', 'Formulario de inscripci�n de la convocatoria', '', 'S', '2012-06-17 10:34:52'),
(6, 'pelicula', 'Ficha de la pel�cula', '', 'N', '2012-06-17 10:34:52'),
(7, 'texto', 'Texto o contenido estatico', '', 'S', '2012-06-17 10:34:52'),
(8, 'proyecciones', 'listado de pel�culas de una proyecci�n/es ', '', 'N', '2012-06-17 10:34:52'),
(9, 'convocatorias', 'Listado de convocatorias', '', 'S', '2012-06-17 10:34:52'),
(10, 'programacion', 'programa de proyecciones', '', 'S', '2012-06-17 10:34:52'),
(11, 'error', 'pagina de error', '', 'S', '2012-06-17 10:34:52'),
(12, 'doc', 'P�gina de descargas de documentos', '', 'S', '2012-06-17 10:34:52'),
(13, 'recepcion', 'Listado de las obras inscritas en la convocatoria', '', 'S', '2012-06-17 10:34:52'),
(14, 'seleccion', 'Listado de obras inscritas en la convocatoria', '', 'S', '2012-06-17 10:34:52');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `admin_modulos`
--
ALTER TABLE `admin_modulos`
  ADD CONSTRAINT `admin_modulos_ibfk_1` FOREIGN KEY (`nivel_acceso`) REFERENCES `perfil_acceso` (`nivel`) ON DELETE NO ACTION;

--
-- Filtros para la tabla `autores`
--
ALTER TABLE `autores`
  ADD CONSTRAINT `autores_ibfk_1` FOREIGN KEY (`id_pelicula`) REFERENCES `convocatoria` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `convocatoria`
--
ALTER TABLE `convocatoria`
  ADD CONSTRAINT `convocatoria_ibfk_1` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `convocatorias`
--
ALTER TABLE `convocatorias`
  ADD CONSTRAINT `convocatorias_ibfk_1` FOREIGN KEY (`id`) REFERENCES `ediciones` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `docs`
--
ALTER TABLE `docs`
  ADD CONSTRAINT `docs_ibfk_1` FOREIGN KEY (`muestra`) REFERENCES `ediciones` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `imagenes_ibfk_1` FOREIGN KEY (`id_galeria`) REFERENCES `galerias` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `imagenes_pelicula`
--
ALTER TABLE `imagenes_pelicula`
  ADD CONSTRAINT `imagenes_pelicula_ibfk_1` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `lang_edicion`
--
ALTER TABLE `lang_edicion`
  ADD CONSTRAINT `lang_edicion_ibfk_1` FOREIGN KEY (`id_edicion`) REFERENCES `ediciones` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lang_edicion_ibfk_2` FOREIGN KEY (`lang`) REFERENCES `langs` (`lang`) ON DELETE CASCADE;

--
-- Filtros para la tabla `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`id_pagina`) REFERENCES `pagina` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pagina`
--
ALTER TABLE `pagina`
  ADD CONSTRAINT `pagina_ibfk_7` FOREIGN KEY (`id_webmodulo`) REFERENCES `web_modulos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pagina_ibfk_8` FOREIGN KEY (`muestra`) REFERENCES `ediciones` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pagina_texto`
--
ALTER TABLE `pagina_texto`
  ADD CONSTRAINT `pagina_texto_ibfk_1` FOREIGN KEY (`id_pagina`) REFERENCES `pagina` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pagina_texto_ibfk_2` FOREIGN KEY (`id_texto`) REFERENCES `textos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD CONSTRAINT `peliculas_ibfk_3` FOREIGN KEY (`muestra`) REFERENCES `ediciones` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `peliculas_ibfk_7` FOREIGN KEY (`id_donante`) REFERENCES `donantes` (`id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `peliculas_ibfk_8` FOREIGN KEY (`licencia`) REFERENCES `licencias` (`id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `peliculas_ibfk_9` FOREIGN KEY (`id_proyeccion`) REFERENCES `proyecciones` (`id`) ON DELETE NO ACTION;

--
-- Filtros para la tabla `proyecciones`
--
ALTER TABLE `proyecciones`
  ADD CONSTRAINT `proyecciones_ibfk_3` FOREIGN KEY (`id_espacio`) REFERENCES `espacios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `proyecciones_ibfk_4` FOREIGN KEY (`anyo`) REFERENCES `ediciones` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `textos`
--
ALTER TABLE `textos`
  ADD CONSTRAINT `textos_ibfk_1` FOREIGN KEY (`muestra`) REFERENCES `ediciones` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`nivel_acceso`) REFERENCES `perfil_acceso` (`nivel`);


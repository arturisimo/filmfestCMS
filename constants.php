<?php
	
	//rutas
	define('APP', 'filmfestCMS');
	define('APP_VERSION', '1.0 beta');
	define('ADMIN', 'admin');
	define('WEB', 'www');
	define('IMG', 'img');
	define('GALERIAS', 'galerias');
	define('LOGO', 'logo');
	define('DOC', 'doc');
	define('THUMBNAIL', 'tn');
	define('MEDIUM', 'md');
	
	//path
	define('DS', DIRECTORY_SEPARATOR);
	define('ROOT', realpath(dirname(__FILE__)) . DS);
	define('ADMIN_PATH', ROOT . APP . DS);
	define('DOC_PATH', ROOT . DOC . DS);
	define('IMG_PATH', ROOT . IMG . DS);
	define('GALERIAS_PATH', IMG_PATH . GALERIAS . DS);
	define('LOGO_PATH', IMG_PATH . LOGO . DS);
	
	//url
	define('URL_ADMIN', BASE_URL . '/' . ADMIN);
	define('BASE_URL_ADMIN', BASE_URL . '/' . APP);
	define('BASE_URL_WEB', BASE_URL . '/' . WEB);
	define('URL_IMG', BASE_URL . '/' . IMG . '/');
	define('URL_LOGO', URL_IMG . LOGO . '/');
	define('URL_IMG_ADMIN', BASE_URL_ADMIN . '/vista/skins/'.ADMIN_SKIN.'/img/');
	define('URL_GALERIAS', URL_IMG . GALERIAS . '/');
	define('URL_DOC', BASE_URL . '/'.DOC.'/');
	define('URL_LIBJS', BASE_URL . '/libjs/');
	
	//valores por defecto
	define('DEFAULT_ANYO', date('Y'));
	define('DEFAULT_LAYOUT', '1columna.phtml');	
	define('DEFAULT_METODO', 'index');
	define('DEFAULT_LANG', 'es');
<?php
	
	date_default_timezone_set("Europe/Paris");
	
	session_start();
	
	include_once("conf.php");
	include_once("constants.php");
	include_once("funciones.php");
	
	set_error_handler('error_handler',E_STRICT);
	set_exception_handler('exception_handler');
	
	Bootstrap::run();
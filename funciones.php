<?php 

	function __autoload($class) {
		//controladores admin
		if(file_exists(ADMIN_PATH . "controllers" . DS . "$class.php")) {
			require(ADMIN_PATH . "controllers" . DS . "$class.php");
		} 
		//controladores web
		else if(file_exists(ROOT . WEB . DS ."controllers" . DS . "$class.php")) {
			require(ROOT . WEB . DS . "controllers" . DS . "$class.php");
		} 
		//libs
		else if(file_exists(ADMIN_PATH . "lib" . DS . "$class.php")) {
			require(ADMIN_PATH . "lib" . DS . "$class.php");
		} 
		//clases
		else if(file_exists(ADMIN_PATH . "classes" . DS . "$class.php")) {
			require(ADMIN_PATH . "classes" . DS . "$class.php");
		} 
		//aplicacion
		else{
			require(ADMIN_PATH . "$class.php");
		}
	}
	
	function error_handler($errno, $errmsg, $file, $line, $ctxt){ 
	   if ( error_reporting() == 0 ){ 
	   		return;
	   } 	  
	   $msg = sprintf('Error %d: %s (%s:%d)', $errno, $errmsg, $file, $line );
	   
	   if ($errno == 8) {
	   		Error::add("error: $msg");
	   }
	}
	
	function exception_handler(Exception $e) {
		Error::add("excepcion no controlada: ".$e->getMessage());
	}
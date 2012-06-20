<?php 

class Log {

	static function add($msg, $mostrar=true){
		if ($mostrar){
			echo "<pre>";
			print_r($msg);
	 		echo "</pre>";
	 	}
	}
}
?>
<?php 

class Error {

	static function add($error){
	 	$error = date("Y-m-d H:i:s (T)"). " | $error <br>";
	 	if(MAIL_ERROR){
	 		mail(ADMIN_EMAIL, "error ", $error);
	 	} else{
	 		Log::add($error);
	 	}
	
	}
}
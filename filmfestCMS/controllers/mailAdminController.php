<?php

class mailAdminController extends AdminController{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$mensaje = "";$asunto= "";
    	if(!empty($this->_id)){
	   		$mail = $this->_dao->mailEnviadoDAO($this->_id);
	   		$mensaje = $mail->mensaje;
			$asunto = $mail->asunto;
	    }
    	$this->addData(array("listado" => $this->_dao->mailsEnviadosDAO(), "tipos" => $this->_dao->tiposMailsDAO(true),
    						 "mensaje" =>  $mensaje, "asunto" =>  $asunto));
    	
    	$this->loadView();
    }
    
}
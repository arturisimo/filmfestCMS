<?php

class destinatariosAdminController extends AdminController{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$mail = "";
	    if(!empty($id)){
	   		$mail = $this->_dao->emailDAO($this->_id);
	    }
    	$this->addData(array("listado" => $this->_dao->emailsDAO(),
    							"tipos" => $this->_dao->tiposMailsDAO(true),
    							"mail" =>  $mail));
    	
    	$this->loadView();
    }
    
}
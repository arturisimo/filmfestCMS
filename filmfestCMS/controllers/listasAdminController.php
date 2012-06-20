<?php

class mailAdminController extends AdminController{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$mail = "";
	    if(!empty($this->_id)){
	   		$tipo = $this->_dao->tipoMailsDAO($this->_id);
	    }
    	$this->addData(array("listado" => $this->_dao->tiposMailsDAO(false), "tipo" => $tipo));
    	
    	$this->loadView();
    }
    
}
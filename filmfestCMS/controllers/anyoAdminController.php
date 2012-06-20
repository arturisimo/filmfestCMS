<?php

class anyoAdminController extends AdminController{
	
    public function __construct(Data $data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$this->addData(array("ediciones" => $this->_dao->edicionesDAO()));
		$this->loadView();
    }   
}
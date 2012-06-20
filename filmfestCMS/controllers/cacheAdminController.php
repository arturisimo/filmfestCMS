<?php

class cacheAdminController extends AdminController{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$this->addData(array("clear" => false));
    	$this->loadView();
    }
    
    
    public function clear(){
    	$this->addData(array("clear" => true));
    	$this->loadView();
    }
    
}
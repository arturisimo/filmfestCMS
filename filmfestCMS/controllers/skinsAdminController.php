<?php

class skinsAdminController extends AdminController{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    
    	$this->addData(array("skinAdmin" => ADMIN_SKIN, "skins" => Util::getFolder(ROOT . APP . DS . "vista" . DS . "skins", array(".", "..","commons"))));
    
		$this->loadView();
    }
    
}
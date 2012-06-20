<?php

class phpinfoAdminController extends AdminController{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
		$this->loadView();
    }
    
}
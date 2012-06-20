<?php

class loginAdminController extends AdminController{
	
     public function __construct(Data $data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$this->loadView();
    }   
    
}
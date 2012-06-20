<?php 

	class espaciosWebController extends Controller{
		
	    public function __construct($data) {
	    	parent::__construct($data);
	    }
	    
	    public function index(){
	    	$this->tagBody = "onload='load()' onunload='GUnload()'";
	    	$this->addData(array("espacios" => $this->_dao->espaciosDAO($this->_anyo)));
			$this->loadView();  
	    }
	}
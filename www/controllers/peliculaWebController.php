<?php 

class peliculaWebController extends Controller{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$this->addData(array("pelicula" => $this->_dao->fichaPeliculaDAO($this->_id)));
		$this->loadView();       
    }
}
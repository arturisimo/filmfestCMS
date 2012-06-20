<?php

class modulowebAdminController extends AdminController{
	
     public function __construct(Data $data) {
     	$this->_tabla = "web_modulos";
    	parent::__construct($data);
    }
    
    public function index(){
		
      	$webModulo = "";
	   	$descripcion = "";
	   
    	if(!empty($this->_id)){
	   		$webModuloDAO = $this->_dao->select($this->_id, $this->_tabla);
			$descripcion = $webModuloDAO->descripcion;
			$webModulo = $webModuloDAO->modulo;
	 	 }
	 	
    	$this->addData(array("listado" => $this->_dao->webModulosDAO(false),
    						 "webModulo" => $webModulo,
							 "descripcion" => $descripcion));

		$this->loadView();

    }   
    
    
 	public function alta(){
 		
 		$campos = array("modulo" => $_POST['modulo'],
						"descripcion" => $_POST['id_descripcion']);

		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
 		
    }
    
}
<?php

class langsAdminController extends AdminController{
	
	public function __construct($data) {
		$this->_tabla = "langs";
		parent::__construct($data);
    }
    
    public function index(){

    	$nombre = "";
	    $codigo = "";
	    $codificacion = "";
	    
	    if(!empty($this->_id)){
		    $language = $this->_dao->select($this->_id, $this->_tabla);
		    $nombre = $language->nombre;
			$codigo = $language->codigo;
			$codificacion = $language->codificacion;
	    }
	 	
    	$this->addData(array("listado" => $this->_dao->langsDAO(),
    						 "nombre" => $nombre, "codigo" => $codigo,
							 "codificacion" => $codificacion));
		$this->loadView();
    }
    
	public function alta(){
 		
 		$campos = array("nombre" => $_POST['id_nombre'],
						"codigo" => $_POST['id_codigo'],
						"lang" => substr($_POST['id_codigo'],0,2),
 						"codificacion" => $_POST['id_codificacion']);
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);

    }
    
    
}
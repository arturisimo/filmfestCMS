<?php

class textoAdminController extends AdminController{
	
    public function __construct($data) {
    	$this->cambioEdicion = true;
    	$this->_tabla = "textos";
        parent::__construct($data);
    }
    
    public function index(){
		$texto = "";
		$titulo = "";
		$lang = 0;
		$idGaleria = 0;
		
		if(!empty($this->_id)){
	   		$textoDAO = $this->_dao->select($this->_id, $this->_tabla);
	   		$texto = $textoDAO->texto;
	   		$titulo = $textoDAO->titulo;
	   		$lang = $textoDAO->lang;
	   		$idGaleria = $textoDAO->id_galeria;
	   	}	
	 	
    	$this->addData(array("listado" => $this->_dao->textosDAO($this->_anyo, false),
    						 "texto" => $texto, "titulo" => $titulo, "lang"=> $lang, 
    						 "langs" => $this->_dao->langsEdicionDAO($this->_anyo),
    						 "idGaleria" => $idGaleria,
    						 "galerias" => $this->_dao->galeriasDAO()));
    	$this->loadView();
    }
    
    
	public function alta(){
 		
		$campos = array("titulo" => $_POST['id_titulo'], "texto" => $_POST['texto'],
						"muestra" => $_POST['id_muestra'], "lang" => $_POST['lang'],
						"id_galeria" => $_POST['id_galeria']);
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
	}
    

}
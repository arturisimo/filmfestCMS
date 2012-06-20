<?php 

class seleccionWebController extends Controller{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	
    	$textoSeleccion = $this->_dao->textoSeleccionDAO($this->_anyo);
    	$txt = $this->_dao->textoDAO($textoSeleccion->id_texto);
    	
	    $this->addData(array("txt" => $txt->texto, "peliculas" => $this->_dao->seleccionDAO($this->_anyo)));		
		$this->loadView();
    }
}
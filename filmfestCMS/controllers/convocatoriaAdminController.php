<?php

class convocatoriaAdminController extends peliculaAdminController{
   
   public function index(){
    	
		$this->addData(array("listado" => $this->_dao->peliculasConvocatoriaDAO($this->_anyo)));
		
		if(!empty($this->_id)){
			$this->addData(array("pelicula" => $this->_dao->fichaPeliculaConvocatoriaDAO($this->_id),
								 "licencias" => $this->_dao->licenciasDAO(),
			 					 "proyecciones" => $this->_dao->proyeccionesPeliculaDAO($this->_anyo)));
		}
		
		$this->loadView();
		 
    }   

    
    public function view(){
 		
    	$id = $_POST["id"];
		$accion = $_POST["accion"];
		
 		if(!empty($id)){
			$ok = $this->_dao->view($id, "convocatoria", $accion);
		}
		echo $ok;
    }
    
}
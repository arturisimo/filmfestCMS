<?php

class modulosAdminController extends AdminController{
	
    public function __construct($data) {
    	$this->_tabla = "admin_modulos";
    	parent::__construct($data);
    }
    
    
    public function index(){
     
      	$nombre = "";
	   	$descripcion = "";
	   	$nivelAcceso = 0;
	   	$moduloAdmin = "";
	   	$idModuloPadre = 0;
	   	
	   	$modulosPadre = $this->_dao->modulosPadreDAO(null, 0);
	 
	   if(!empty($this->_id)){
	   		$adminModuloDAO = $this->_dao->select($this->_id, $this->_tabla);
			$nivelAcceso = $adminModuloDAO->nivel_acceso;
			$moduloAdmin = $adminModuloDAO->modulo;
			$nombre = $adminModuloDAO->nombre;
			$descripcion = $adminModuloDAO->descripcion;
			$idModuloPadre = $adminModuloDAO->modulo_padre;
			$modulosPadre = $this->_dao->modulosPadreDAO($adminModuloDAO->id, $adminModuloDAO->nivel_acceso);
		}
	 	
    	$this->addData(array("listado" => $this->_dao->adminModulosDAO(),
    							"perfiles" => $this->_dao->nivelesNavegacionDAO(), 
    							"modulosPadre" => $modulosPadre,
    							"nivelAcceso" => $nivelAcceso,
    							"idModuloPadre" => $idModuloPadre,
    							"moduloAdmin" => $moduloAdmin,
    							"nombre" => $nombre,
								"descripcion" => $descripcion,
    							"nombre" => $nombre));
		
		$this->loadView();

    }   
    
    
 	public function alta(){
  		$campos = array("nombre" => $_POST['nombre'],
		"modulo" => $_POST['modulo'],
		"nivel_acceso" => $_POST['id_nivel_acceso'],
  		"descripcion" => $_POST['descripcion'],
		"modulo_padre" => $_POST['id_modulopadre']);

		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
 		
    }
   	
    public function load(){
    	
    	if(isset($_POST['id_nivelacceso'])){
			$modulosPadre = $this->_dao->modulosPadreDAO(null, $_POST['id_nivelacceso']);
			$options_str = "[";
			$tmp_array = array();
			array_push($tmp_array,"['0','selecciona..']");
			foreach ($modulosPadre as $moduloPadre) {
				array_push($tmp_array,"['".$moduloPadre->id."','".$moduloPadre->titulo."']");
			}
			$options_str .= join(',',$tmp_array);
			$options_str .= "]";
			print $options_str;
    	}
    }
    
}
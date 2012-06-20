<?php

class galeriaAdminController extends AdminController{
	
    public function __construct($data) {
    	$this->_tabla = "galerias";	
    	$this->cambioEdicion = true;
        parent::__construct($data);
    }
    
    public function index(){
		$nombre = "";
		$descripcion = "";
		
		if(!empty($this->_id)){
	   		$galeriaDAO = $this->_dao->select($this->_id, $this->_tabla);
			$nombre = $galeriaDAO->titulo;
			$descripcion = $galeriaDAO->descripcion;
	    }	
	 	
    	$this->addData(array("listado" => $this->_dao->galeriasDAO(false),
    							"nombre" => $nombre, 
    							"descripcion" => $descripcion));
    	$this->loadView();
    }
    
	public function alta(){
    	
    	$id = $_POST['id'];
		if(empty($id)){
			$folder = Util::stripAccents($_POST['id_nombre']);
			$ok = $this->_dao->insert(array("titulo"=>$_POST['id_nombre'], "descripcion"=>$_POST['id_descripcion'], "galeria"=>$folder), $this->_tabla);
			if($ok=="ok"){
				if(!mkdir(GALERIAS_PATH . $folder . DS . THUMBNAIL, 0777, true)){
					$ok = "ko";
					Error::add(" error en ".__FUNCTION__. " generando ".GALERIAS_PATH . $folder . DS . THUMBNAIL);
				}
			}
		}
		else{
			$ok = $this->_dao->update($id, array("titulo"=>$_POST['id_nombre'], "descripcion"=>$_POST['id_descripcion']), $this->_tabla);
		}
	    echo $ok;
    }
    
	public function delete(){
 		
    	$id = $_POST['id'];
    	
		$galeriaDAO = $this->_dao->select($id, $this->_tabla);
		if(isset($galeriaDAO->galeria)){
			Util::recursirveRmdir(GALERIAS_PATH.$galeriaDAO->galeria);
			$ok = $this->_dao->delete($id, $this->_tabla);
		}
		
	    echo $ok;
    }

}
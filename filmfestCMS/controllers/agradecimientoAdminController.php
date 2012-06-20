<?php

class agradecimientoAdminController extends AdminController{
	
	public function __construct($data) {
		$this->_tabla = "donantes";
		$this->_carpetaImg = "donantes";
		$this->cambioEdicion = true;
		parent::__construct($data);
    }
    
    public function index(){

    	$nombre = "";
	    $classUpload = "upload-img";
	    $url = "http://";
	    $img = null;
	    $fileImg = "";
	   
	    if(!empty($this->_id)){
		    $agradecimientoDAO = $this->_dao->select($this->_id, $this->_tabla);
		    $nombre = $agradecimientoDAO->donante;
			if(!empty($agradecimientoDAO->logo)){
				$classUpload = "";
				$fileImg = $agradecimientoDAO->logo;
				$img = URL_LOGO . $this->_carpetaImg . "/". $fileImg;
			}
			$url = $agradecimientoDAO->web;
	    }
	 	
    	$this->addData(array("listado" => $this->_dao->agradecimientosDAO(),
    						 "nombre" => $nombre, "classUpload" => $classUpload,
							 "img" => $img, "fileImg" => $fileImg, 
							 "url" => $url, "mostrarEdicion" => true));
		$this->loadView();
    }
   
 	public function alta(){
 		
 		$campos = array("donante" => $_POST['nombre'],
						"web" => $_POST['web'],
						"logo" => $_POST['id_logo']);
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);

    }
     
	public function delete(){
 		
    	$id = $_POST['id'];
    	
 		if(!empty($id)){
			$agradecimientoDAO = $this->_dao->select($id, $this->_tabla);
			if(!empty($agradecimientoDAO->logo)){
				unlink(LOGO_PATH . $this->_carpetaImg . DS .$agradecimientoDAO->logo);
			}	
			$ok = $this->_dao->delete($id, $this->_tabla);  
		}
		echo $ok;
    }
	
	public function upload(){ 
     	if(isset($_FILES['imagen'])){
	    	try{
	    		$this->_pathImg = LOGO_PATH . $this->_carpetaImg . DS;
	    		$nombreImg = $this->uploadImagen("", "", 80);
	    		$urlImagen = URL_LOGO . $this->_carpetaImg . "/" . $nombreImg;
	    		
	    		if(!empty($_POST['id_donante'])){
	    			$ok = $this->_dao->update($_POST['id_donante'], array("logo" => $nombreImg), $this->_tabla);
				}
				echo "<input type='hidden' id='nombre_imagen' value='$nombreImg' />";
				echo "<img src='$urlImagen' height='100px' width='100px'/>";
	    	} catch (Exception $e) {
	    		echo("<p>problemas al subir la imagen</p>");
	    		Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage());
	    	}
	    }
     }
    
    
	public function deleteImagen(){
 		$id = $_POST['id'];
		if(!empty($id)){
			$agradecimientoDAO = $this->_dao->select($id, $this->_tabla);
			if(!empty($agradecimientoDAO->logo)){
				$ok = $this->_dao->update($id, array("logo" => ""), $this->_tabla);
				if($ok!="ok"){
					unlink(LOGO_PATH . $this->_carpetaImg . DS .$agradecimientoDAO->logo);
				}
			}
		}
	}
    
}
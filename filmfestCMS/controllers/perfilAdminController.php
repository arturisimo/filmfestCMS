<?php

class perfilAdminController extends AdminController{
	
     public function __construct(Data $data) {
     	$this->_tabla = "perfil_acceso";
        parent::__construct($data);
    }
    
    public function index(){
		$idModuloDefault=0;
		$nombre = "";
	   	$descripcion = "";
	   	$classUpload = "upload-img";
	    $img = null;
	    $fileImg = "";
	   	
	   	if(!empty($this->_id)){
	   		$perfilDAO = $this->_dao->select($this->_id, $this->_tabla);
	   		$nombre = $perfilDAO->nombre;
	   		$descripcion = $perfilDAO->descripcion;
	   		$idModuloDefault = $perfilDAO->id_modulodefault;
	   		$modulos = $this->_dao->modulosNivelAccesoDAO($perfilDAO->nivel);
	   		if(!empty($perfilDAO->logo)){
				$classUpload = "";
				$fileImg = $perfilDAO->logo;
				$img = URL_IMG_ADMIN.$fileImg;
			}
	    } else {
	   		$modulos = $this->_dao->modulosNivelAccesoDAO(0);
	    }	
	 	
    	$this->addData(array("listado" => $this->_dao->nivelesAccesoDAO(),
    						 "idModuloDefault" => $idModuloDefault, 
    						 "nombre" => $nombre,"classUpload" => $classUpload,
							 "img" => $img, "fileImg" => $fileImg,
							 "descripcion" => $descripcion, 
							 "modulos" => $modulos));
		
		$this->loadView();

    }   
    
    
 	public function alta(){
 		$campos = array("nombre" => $_POST['nombre'],
				"descripcion" => $_POST['descripcion'],
				"id_modulodefault" => $_POST['id_modulodefault'],
 				"logo" => $_POST['file_imagen']);
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
		
    }
    
    
	public function delete(){
 		$id = $_POST['id'];
    	$perfilDAO = $this->_dao->select($id, $this->_tabla);
		if(isset($perfilDAO->logo)){
			$ok = $this->_dao->delete($id, $this->_tabla);
			if($ok=="ok"){
				unlink(LOGO_PATH . 'admin' . DS . $perfilDAO->logo);
			}
		}
		echo $ok;
	}
	
	public function deleteImagen(){
 		$id = $_POST['id'];
    	if(!empty($id)){
			$perfilDAO = $this->_dao->select($id, $this->_tabla);
			if(!empty($perfilDAO->logo)){
				$ok = $this->_dao->update($id, array("logo" => ""), $this->_tabla);
				if($ok=="ok"){
					unlink(LOGO_PATH . 'admin' . DS . $perfilDAO->logo);
					header("Location: ".URL_ADMIN."/perfil/$id");
					exit;
				}	
			}
		}
	}
    
	public function upload(){ 
		$thumbnail = "50x50"; //cuadrado
		if(isset($_FILES['imagen'])){
	    	try{
	    		$this->_pathImg = LOGO_PATH . 'admin' . DS;
	    		$nombreImagen = $this->uploadImagen($thumbnail, "", "");
	    		$urlImagen = URL_IMG_ADMIN . $nombreImagen;
	    		echo "<input type='hidden' id='nombre_imagen' value='$nombreImagen' />";
				echo "<img src='$urlImagen' height='100px' width='100px'/>";
	    	} catch (Exception $e) {
	    		echo("<p>problemas al subir la imagen</p>");
	    		Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage());
	    	}
	    }
     }
    
}
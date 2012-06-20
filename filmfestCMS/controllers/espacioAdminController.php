<?php

class espacioAdminController extends AdminController{
	
     public function __construct(Data $data) {
    	$this->cambioEdicion = true;
    	$this->_tabla = "espacios";
    	$this->_carpetaImg = "espacios";
    	parent::__construct($data);
    }
    
    public function index(){
		
		$direccion = "";
		$url = "http://";
		$nombre = "";
		$descripcion="";
		$email = "";
		$telefono = "";
  		$img = null;
   		$classUpload = "upload-img";
   		$fileImg = "";
   		$longitud = LONGITUD;
   		$latitud = LATITUD;
   		
	    if(!empty($this->_id)){
	   		$espacioDAO = $this->_dao->select($this->_id, $this->_tabla);
		    $fileImg = $espacioDAO->espacio;
		    if(!empty($espacioDAO->img)){
				$classUpload = "";
				$img = URL_LOGO . $this->_carpetaImg . "/" . $espacioDAO->img;
			}
		    $direccion = $espacioDAO->direccion;
		    $url = $espacioDAO->url;
		    $nombre = $espacioDAO->espacio;
		    $descripcion = $espacioDAO->descripcion;
		    $email = $espacioDAO->email;
		    $telefono = $espacioDAO->telefono;
		    $longitud = $espacioDAO->longitud;
		    $latitud = $espacioDAO->latitud;
		    $fileImg = $espacioDAO->img; 
	    }
	 	
    	$this->addData(array("listado" => $this->_dao->espaciosDAO(),
    							"direccion" => $direccion,
								"url" => $url,
								"nombre" => $nombre,
								"descripcion"=>$descripcion,
								"email" => $email,
								"telefono"=>$telefono,
						  		"img" => $img,
    							"fileImg" => $fileImg, 
						   		"classUpload" => $classUpload,
								"longitud" => $longitud,
    							"latitud" => $latitud));
		
		$this->loadView();
    }   
    
    public function alta(){
  		$campos = array("espacio" => $_POST['espacio'],
		"direccion" => $_POST['direccion'],
		"latitud" => $_POST['latitud'],
  		"longitud" => $_POST['longitud'],
		"img" => $_POST['id_logo'],
  		"descripcion" => $_POST['descripcion'],
  		"url" => $_POST['web'],
		"telefono" => $_POST['telefono'],
  		"email" => $_POST['email']);
  		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
    	
    }
    
	public function delete(){
 		
    	$id = $_POST['id'];
    	
 		if(!empty($id)){
			$espacioDAO = $this->_dao->select($this->_id, $this->_tabla);
			if(isset($espacioDAO->img)){
				unlink(LOGO_PATH . $this->_carpetaImg . DS . $espacioDAO->img);
			}	
			$ok = $this->_dao->delete($id, $this->_tabla);	
		}
		
	    echo $ok;
    }
    
	public function deleteImagen(){
 		$id = $_POST['id'];
    	if(!empty($id)){
			$espacioDAO = $this->_dao->select($id, $this->_tabla);
			if(!empty($espacioDAO->img)){
				$ok = $this->_dao->update($id, array("img" => ""), $this->_tabla);
				if($ok=="ok"){
					unlink(LOGO_PATH . $this->_carpetaImg . DS .$espacioDAO->img);
					header("Location: ".URL_ADMIN."/espacio/$id");
					exit;
				}	
			}
		}
	}
	
	public function upload(){ 
     	if(isset($_FILES['imagen'])){
	    	try{
	    		$this->_pathImg = LOGO_PATH . $this->_carpetaImg . DS;
	    		$nombreImagen = $this->uploadImagen("", "", 80);
	    		$urlImagen = URL_LOGO . $this->_carpetaImg . "/" . $nombreImagen;
	    		if(!empty($_POST['id_espacio'])){
					$ok = $this->_dao->update($_POST['id_espacio'], array("img" => $nombreImagen), $this->_tabla);
				} 
				echo "<input type='hidden' id='nombre_imagen' value='$nombreImagen' />";
				echo "<img src='$urlImagen' height='100px' width='100px'/>";
	    	} catch (Exception $e) {
	    		echo("<p>problemas al subir la imagen</p>");
	    		Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage());
	    	}
	    }
     }
	
	
}
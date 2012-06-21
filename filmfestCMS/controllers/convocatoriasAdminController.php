<?php

class convocatoriasAdminController extends AdminController{
	
     public function __construct(Data $data) {
        $this->_tabla = "convocatorias";
     	$this->_carpetaImg = "carteles";
     	$this->cambioEdicion = true;
     	parent::__construct($data);
    }
    
    public function index(){
    	
	   	if(empty($this->_id)){
	   		$this->_id = DEFAULT_ANYO;
	   	}	
   		$edit = true;
	    $edicionDAO = $this->_dao->convocatoriaDAO($this->_id);
	    $nombre	= $edicionDAO->nombre;
	    $url = $edicionDAO->url;
		$descripcion = $edicionDAO->descripcion;
		$fileImg = $edicionDAO->cartel;
		$idTexto = $edicionDAO->id_texto;
		$textos = $this->_dao->textosDAO($this->_id, true);
		$img = null;
   		$classUpload = "upload-img";
		
		if(!empty($fileImg)){
			$classUpload = "";
			$img = URL_GALERIAS.$this->_carpetaImg."/".THUMBNAIL."/$fileImg";
		}
	    
    	$this->addData(array("listado" => $this->_dao->convocatoriasDAO(),
    						 "textos" => $textos, "nombre" => $nombre,
    						 "paginas" => $this->_dao->urlPaginasDAO($this->_id),
    						 "url" => $url, "descripcion" => $descripcion, "nombre" => $nombre,
							 "descripcion" => $descripcion, "fileImg" => $fileImg,
    						 "img" => $img, "idTexto" => $idTexto,
							 "classUpload" => $classUpload));
		
		$this->loadView();

    }   
    
	public function alta(){
 		$campos = array("url" => $_POST['id_url'],
				"cartel" => $_POST['file_imagen'],
				"descripcion" => $_POST['descripcion']);
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
		
    }
    
	public function upload(){ 
     	if(isset($_FILES['imagen'])){
	     	$thumbnail = "100x100";
	     	$medium = "200x150";
	     	try{
	    		$this->_pathImg = GALERIAS_PATH . $this->_carpetaImg . DS;
	    		$nombreImagen = $this->uploadImagen($thumbnail, $medium, "");
	    		$urlImagen = URL_GALERIAS . $this->_carpetaImg . "/" . $nombreImagen;
	    		
	    		if(!empty($_POST['id_edicion'])){
					$ok = $this->_dao->update($_POST['id_edicion'], array("cartel" => $nombreImagen), $this->_tabla);
				} 
				echo "<input type='hidden' id='nombre_imagen' value='$nombreImagen' />";
				echo "<img src='$urlImagen' height='100px' width='100px'/>";
				
	    	} catch (Exception $e) {
	    		echo("<p>problemas al subir la imagen</p>");
	    		Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage());
	    	}
	    }
    }
    
	public function deleteImagen(){
 		$id = $_POST['id'];
 		echo $id;
    	if(!empty($id)){
    		$edicionDAO = $this->_dao->select($id, $this->_tabla);
			$ok = $this->_dao->update($id, array("cartel" => ""), $this->_tabla);
			if($ok=="ok" && !empty($edicionDAO->cartel)){
				unlink(GALERIAS_PATH . $this->_carpetaImg . DS . $edicionDAO->cartel);
				unlink(GALERIAS_PATH . $this->_carpetaImg . DS . THUMBNAIL . DS . $edicionDAO->cartel);
				unlink(GALERIAS_PATH . $this->_carpetaImg . DS . MEDIUM . DS . $edicionDAO->cartel);
			}	
		}
	}
    
 	
}
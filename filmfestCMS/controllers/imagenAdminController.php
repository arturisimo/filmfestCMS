<?php 

class imagenAdminController extends AdminController{
	
    public function __construct($data) {
    	$this->_tabla = "imagenes";
    	$this->cambioEdicion = true;
    	parent::__construct($data);
    }
    
    public function index(){
		$idImg = 0;
		$galeria = "";
		$idGaleria = 0;
		$url = "http://";
		$descripcion = "";
		$fileImg = "";
		$classUpload = "upload-img";
		$img = null;
		$sizeFile = "";
		$dimensiones = "";
		 
		if(!empty($this->_id)){
			$imagenDAO = $this->_dao->imagenDAO($this->_id);
			$idImg = $imagenDAO->id;
			$galeria = $imagenDAO->galeria;
			$idGaleria = $imagenDAO->id_galeria;
			$url = $imagenDAO->url_video;
			$descripcion = $imagenDAO->descripcion;
			$fileImg = $imagenDAO->imagen;
			if(!empty($imagenDAO->imagen)){
				$classUpload = "";
				$img = URL_GALERIAS.$galeria."/".THUMBNAIL."/".$fileImg;
			}
			$image = new Image(GALERIAS_PATH.$galeria.DS.$fileImg);
			$sizeFile = $image->getSize();
			$dimensiones = $image->getDimension();
		}		
	 	
    	$this->addData(array("listado" => $this->_dao->imagenesDAO(),
    							"galerias" => $this->_dao->galeriasDAO(),
    							"idImg" => $idImg,
								"galeria" => $galeria,
								"idGaleria" => $idGaleria,
								"url" => $url,
								"descripcion" => $descripcion,
								"fileImg" => $fileImg,
								"classUpload" => $classUpload,
								"img" => $img,
								"sizeFile" => $sizeFile, 
								"dimensiones" => $dimensiones));
    	
		$this->loadView();
    }
    
    public function alta(){
    	
    	$campos = array("imagen" => $_POST['file_imagen'],
						"descripcion" => $_POST['descripcion'],
						"id_galeria" => $_POST['id_galeria'],
    					"url_video" => Util::getUrlVideo($_POST['video']));
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
    	
    }
    
	public function delete(){
 		
    	$id = $_POST['id'];
    	
 		if(!empty($id)){
 			$imagenDAO = $this->_dao->imagenDAO($id);
			if(isset($imagenDAO->imagen)){
				$ok = $this->_dao->delete($id, $this->_tabla);
				if($ok=="ok"){
					unlink(GALERIAS_PATH.$imagenDAO->galeria.DS.$imagenDAO->imagen);
					unlink(GALERIAS_PATH.$imagenDAO->galeria.DS.THUMBNAIL.DS.$imagenDAO->imagen);
				}
			}
		}
		echo $ok;
    }

    public function load(){
    	if(isset($_POST['id_galeria'])){
			$galeria = $this->_dao->select($_POST['id_galeria'], "galerias");
			echo $galeria->galeria;
		}
    }
    
	public function upload(){ 
		$thumbnail = "100x100"; //cuadrado
		if(isset($_FILES['imagen'])){
	    	try{
	    		$this->_pathImg = GALERIAS_PATH . $_POST['galeria'] . DS;
	    		$nombreImagen = $this->uploadImagen($thumbnail, "", "");
	    		$urlImagen = URL_GALERIAS . $_POST['galeria'] . "/" . $nombreImagen;
	    		$id = $this->_dao->insertId(array("imagen" => $nombreImagen, "id_galeria" => $_POST['id_galeria_img']), $this->_tabla);
	    		echo "<input type='hidden' id='id' value='$id' />";
	    		echo "<input type='hidden' id='nombre_imagen' value='$nombreImagen' />";
				echo "<img src='$urlImagen' height='100px' width='100px'/>";
	    	} catch (Exception $e) {
	    		echo("<p>problemas al subir la imagen</p>");
	    		Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage());
	    	}
	    }
     }

}	  
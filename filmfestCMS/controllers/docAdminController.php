<?php

class docAdminController extends AdminController{
	
    public function __construct($data) {
    	$this->cambioEdicion = true;
    	$this->_tabla = "docs";
    	parent::__construct($data);
    }
    
    public function index(){
		$nombre = "";
		$nombreImg = "";
		$descripcion = "";
		$classUpload = "upload-img";
		$classUploadImg = "upload-img";
		$fileName = "";
		$fileNameImg = "";
		$urlFile = "";
		$file ="";
		$infoFile = null; 
    	$sizeFile = 0;
		
	    if(!empty($this->_id)){
	    	
	   		$documentoDAO = $this->_dao->select($this->_id, $this->_tabla);
	        if(!empty($documentoDAO)){
				$classUpload = "";
				$file = DOC_PATH.$documentoDAO->archivo;
				$infoFile = pathinfo($file);
				$sizeFile = Util::formatBytes(filesize($file));
				$nombre = $documentoDAO->nombre;
				$nombreImg = $documentoDAO->imagen;
				if(!empty($nombreImg)){
					$fileNameImg = URL_LOGO . 'docs/' . $documentoDAO->imagen;
					$classUploadImg = "";
				}
				$descripcion = $documentoDAO->descripcion;
				$fileName = $documentoDAO->archivo;
				$urlFile = URL_DOC.$documentoDAO->archivo;
			}
	    }	
	 	
    	$this->addData(array("listado" => $this->_dao->documentosDAO($this->_anyo),
    							"nombre" => $nombre, "nombreImg" => $nombreImg, "urlFile" =>  $urlFile,
    							"descripcion" => $descripcion,"classUpload" => $classUpload, "classUploadImg" => $classUploadImg,
    							"fileName" => $fileName,"fileNameImg" => $fileNameImg, "infoFile" => $infoFile, 
    							"sizeFile" => $sizeFile,"file"=>$file));
    	
		$this->loadView();
    }
    
	public function alta(){
 		
		$campos = array("nombre" => $_POST['nombre'], 
						"imagen" => $_POST['file_imagen'],
						"descripcion" =>  $_POST['descripcion'],
						"archivo" => $_POST['file_doc'],
						"muestra" => $_POST['id_edicion']);
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
		
    }
    
	public function delete(){
 		
    	$id = $_POST['id'];
    	
		$documentoDAO = $this->_dao->select($id, $this->_tabla);
		if(isset($documentoDAO->archivo)){
			$ok = $this->_dao->delete($id, $this->_tabla);
			if($ok=="ok"){
				unlink(LOGO_PATH . 'docs' . DS . $documentoDAO->imagen);
				unlink(DOC_PATH.$documentoDAO->archivo);
			}
		}
		
	   echo $ok;
	
    }
	
	public function upload(){ 		
		
		if(isset($_FILES['doc'])){	
			echo "<head><style type='text/css'> body{margin: 0;}</style></head>";
			$size = $_FILES['doc']['size'];
			
			if(isset($_POST['id_nombreDoc'])){
				$nombreDoc = Util::stripAccents($_POST['id_nombreDoc']);
			}
			
			if ($_FILES['doc']['error'] > 0){
				echo 'Problem: ';
				switch ($_FILES['doc']['error']){
					case 1: echo 'File exceeded upload_max_filesize'; break;
					case 2: echo 'File exceeded max_file_size'; break;
					case 3: echo 'File only partially uploaded'; break;
					case 4: echo 'No file uploaded'; break;
				}
				exit;
			}
			
			switch ($_FILES['doc']['type']){
				case 'application/pdf': 
					$extension = 'pdf'; 
					break;
				case 'application/x-pdf': 
					$extension = 'pdf'; 
					break;
				case 'application/rtf':
					$extension = 'rtf'; 
					break;
				case 'application/msword':
					$extension = 'doc'; 
					break;
				default:
					$extension = 'pdf';		
			}

			if (copy ($_FILES['doc']['tmp_name'], DOC_PATH.$nombreDoc.".".$extension )) {
				$id = $this->_dao->insertId(array("muestra" => $this->_anyo, "nombre" => $_POST['id_nombre'], "archivo" => $nombreDoc.".".$extension), $this->_tabla);
				echo "<input type='hidden' id='id' value='$id' />";
				echo "<input type='hidden' id='nombre_imagen' value='".$nombreDoc.".".$extension."' />";
				echo "<a href='".URL_DOC.$nombreDoc.".".$extension."'><img src='".URL_IMG_ADMIN.$extension.".png' />"._("descargar")."</a></strong> ($size".Util::formatBytes($size).")";
			}
			else{
				Error::add(" error en ".__FUNCTION__. " : problemas al subir el documento: ". DOC_PATH.$nombreDoc.".".$extension );
				echo ("<p>problemas al subir la imagen</p>");
			}
	    }
	}
	
	public function uploadImg(){ 
		$thumbnail = "200x100"; //cuadrado
		if(isset($_FILES['imagen'])){
	    	try{
	    		$pathImagen = LOGO_PATH . 'docs' . DS;
	    		if (!empty($_POST['id_nombre'])){
					$nombreImg = Util::stripAccents($_POST['id_nombre']).$this->_anyo.".jpg";
				} else {
					$nombreImg = date('YmdHms').".jpg";
				}
				$pathImagen .= $nombreImg;
			
				if (copy ($_FILES['imagen']['tmp_name'], $pathImagen)) {
					echo "<head><style type='text/css'> body{margin: 0;font-size: 10px;}</style></head>";
					$img = new Image($pathImagen);
					$thumbnail = explode("x", $thumbnail);
					$img->crop("", $thumbnail[0], $thumbnail[1]);
					$urlImagen = URL_LOGO . 'docs/'.$nombreImg;
	    			echo "<input type='hidden' id='nombre_imagen' value='$nombreImg' />";
					echo "<img src='$urlImagen' height='100px' width='100px'/>";
				}
	    	} catch (Exception $e) {
    			echo("<p>problemas al subir la imagen</p>".$urlImagen);
    			Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage());
	    	}
	    }
     }
	
}
<?php

class edicionAdminController extends AdminController{
	
    public function __construct(Data $data) {
     	$this->_tabla = "ediciones";
     	$this->_carpetaImg = "carteles";
     	$this->cambioEdicion = true;
    	parent::__construct($data);
    }
    
    public function index(){
		$nombre = "";
	   	$descripcion = "";
	   	$fechaInicio= "";
	   	$fechaFin= "";
	    $fileImg= "";
	    $classUpload = "upload-img";
	    $img = null;
	   	$anyo = $this->_anyo;
	    
	    if(!empty($this->_id)){
	   		$edit = true;
		    $edicionDAO = $this->_dao->select($this->_id, $this->_tabla);
			$nombre	= $edicionDAO->nombre;
			$descripcion = $edicionDAO->descripcion;
			$ini = explode("-", $edicionDAO->fecha_inicio);
			$fechaInicio = $ini[2]."/".$ini[1]."/".$ini[0];
			$fin = explode("-", $edicionDAO->fecha_fin);
			$fechaFin = $fin[2]."/".$fin[1]."/".$fin[0];
			$fileImg = $edicionDAO->cartel;
			$anyo = $this->_id;
			
			if(!empty($fileImg)){
				$classUpload = "";
				$img = URL_GALERIAS.$this->_carpetaImg."/".THUMBNAIL."/".$fileImg;
			}
	    }
	 	
    	$dataController = array("listado" => $this->_dao->edicionesDAO(),
    							"langs" => $this->_dao->langsEdicionDAO($anyo),
    							"langsDisponibles" => $this->_dao->langsDisponiblesEdicionDAO($anyo),
    							"nombre" => $nombre,
								"descripcion" => $descripcion,
    							"nombre" => $nombre,
								"descripcion" => $descripcion,
    							"fechaInicio" => $fechaInicio,
								"fechaFin" => $fechaFin,
								"fileImg" => $fileImg,
    							"galeria" => $this->_carpetaImg,
    							"img" => $img,
								"classUpload" => $classUpload);
		
		$this->_data->setData(array_merge((array)$this->_data->getData(), $dataController));
		$this->loadView();

    }   
    
    public function alta(){
 		
    	$id = $_POST['id'];
    	$this->_dao->startTransaction();
    	$ini = explode("/", $_POST['id_dia_inicio']);
		$fecInicio = $ini[2]."-".$ini[1]."-".$ini[0];
		$fin = explode("/", $_POST['id_dia_fin']);
		$fecFin = $fin[2]."-".$fin[1]."-".$fin[0];
    	
    	$campos = array("nombre"=>$_POST['nombre'],"descripcion"=>$_POST['descripcion'],"cartel"=>$_POST['file_imagen'],"fecha_inicio"=>$fecInicio,"fecha_fin"=>$fecFin);
    	
		if(!empty($id)){
			$ok = $this->_dao->update($id, $campos, $this->_tabla);
		} else{
			$ok ="ok";
			$id = $fin[2];
			
			//genera carpetas de imagenes 
			$paths = array (IMG_PATH . "peliculas" . DS . $id,
							IMG_PATH . "peliculas" . DS . $id . DS . THUMBNAIL, 
							IMG_PATH . "peliculas" . DS . $id . DS . MEDIUM);
							
			foreach ($paths as $path){
				if(!is_dir($path) && !mkdir($path)){
					$ok = "ko";
			    	echo 'Fallo al crear carpetas...';
			    	break;
				}
			}
			
			if($ok=="ok"){
				$campos = array_merge($campos, array("id" => $id));
				$ok = $this->_dao->insert($campos, $this->_tabla);
				//insercion imagen del cartel en la galeria de carteles
				$ok = $this->_dao->insert(array("id" => $id, "url"=>"", "cartel"=>$_POST['file_imagen'], "alta"=>"N"), "convocatorias");
				//TODO hacer una funcion que copie
				Util::recursiveCopy(ROOT. WEB . DS . "vista" . DS . "skins" . DS . "2012", ROOT . WEB . DS . "vista"  .DS . "skins" .DS . $id);
			}
			
			//langs
			$langs = explode(",", $_POST['langs']);
			if($ok=="ok"){
				$ok = $this->_dao->deleteLangEdicion($id);
				foreach ($langs as $lang) {
					$ok = $this->_dao->insert(array("id_edicion" => $id, "lang" => $lang), "lang_edicion");
				}
			}
		} 
		
		if($ok=="ok"){
			$this->_dao->commit();
		} else {
			$this->_dao->rollback();
		}
		echo $ok;
    }
    
	public function delete(){
 		
    	$id = $_POST['id'];
    	
 		if(!empty($id)){
			$ok = $this->_dao->delete($id, $this->_tabla);
			$edicionDAO = $this->_dao->select($id, $this->_tabla);	
			if($ok=="ok"){
				if(!empty($edicionDAO->cartel)){
					unlink(GALERIAS_PATH . $this->_carpetaImg . DS . $edicionDAO->cartel);
					unlink(GALERIAS_PATH . $this->_carpetaImg . DS . THUMBNAIL . DS . $edicionDAO->cartel);
					unlink(GALERIAS_PATH . $this->_carpetaImg . DS . MEDIUM . DS . $edicionDAO->cartel);
				}
				Util::recursirveRmdir(IMG_PATH . "peliculas". DS . $id);
				Util::recursirveRmdir(ROOT. WEB . DS  . "vista". DS . "skins" . DS . $id);
			}  
		}
		echo $ok;
    }
	
	public function deleteImagen(){
 		$id = $_POST['id'];
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
	
	public function upload(){ 
     	if(isset($_FILES['imagen'])){
	     	$thumbnail = "100x100";
	     	$medium = "250x100";
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
       
}
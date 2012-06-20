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
 	
}
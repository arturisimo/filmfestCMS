<?php

abstract class Controller{
	
    protected $_dao;
    protected $_data;
    protected $_anyo;
    protected $_id;
    protected $_controller;
    protected $_baseUrl;
    protected $_base;
    protected $_pathImg;
    protected $tagBody;
    
    public function __construct(Data $data=null) {
    	$this->_data = $data;
    	$this->_dao = $data->getDao();
    	$this->_id = $data->getRequest()->getId();
    	$this->_anyo = $data->getRequest()->getAnyo();
    	$this->_controller = $this->_data->getModulo();    	
    	$this->_skin = $this->_anyo;
    	$this->tagBody = "";
    	$this->_baseUrl = BASE_URL . '/' . ( $this->_anyo == DEFAULT_ANYO ? '' : $this->_anyo . '/');
    	$this->_base = BASE_URL_WEB;
    }
    
    protected function loadView(){
		
    	$title = $this->_data->getTitle();
    	$description = $this->_data->getDescription();
    	$urlPagina = $this->_data->getRequest()->getControlador();
    	$usuario = $this->_data->getUsuario();
    	
    	$lang = $this->_data->getLang();
    	$langs = $this->_data->getLangs();
    	
    	$edicion = $this->_data->getEdicion();
    	if (!empty($edicion)){
	    	$fechaInicio = strtotime($edicion->fecha_inicio);
	    	$fechaFin = strtotime($edicion->fecha_fin);
    	}
    	
    	$pathVista =  ROOT . $this->_data->getRequest()->getApplication(). DS .'vista' . DS;
		$pathSkin =  ROOT . $this->_data->getRequest()->getApplication(). DS .'vista' . DS . 'skins' . DS . $this->_data->getSkin() . DS;
		$pathCommons = ROOT . $this->_data->getRequest()->getApplication(). DS .'vista' . DS . 'skins' . DS . 'commons' . DS;
		
		$urlSkin =  $this->_base . "/vista/skins/".$this->_data->getSkin()."/";
		$urlCommons =  $this->_base . "/vista/skins/commons/";
		
    	Log::add($pathSkin . 'layouts' . DS . $this->_data->getLayout(), false);
    	
    	extract($this->_data->getData());
    	
        include_once $pathSkin . 'layouts' . DS . $this->_data->getLayout();
           
    }
    
    protected function addData($dataController){
    	$this->_data->setData(array_merge((array)$this->_data->getData(), (array)$dataController));
    }
    
    public function uploadImagen($thumbnail, $medium, $resize){ 
   		echo "<head><style type='text/css'> body{margin: 0;font-size: 10px;}</style></head>";
			
	 	$pathImagen =  $this->_pathImg;
	 	if(is_dir($pathImagen)) {
			if (!empty($_POST['id_nombre'])){
				$nombreImg = Util::stripAccents($_POST['id_nombre']).".jpg";
			} else {
				$nombreImg = date('YmdHms').".jpg";
			}
			
			$pathImagen .= $nombreImg;
			
			if (copy ($_FILES['imagen']['tmp_name'], $pathImagen)) {

				$img = new Image($pathImagen);
				
				if (!empty($thumbnail)){
					$thumbnail = explode("x", $thumbnail);
					$img->crop(DS . THUMBNAIL . DS, $thumbnail[0], $thumbnail[1]);
				}
				if (!empty($medium)){
					$medium = explode("x", $medium);
					$img->crop(DS . MEDIUM . DS, $medium[0], $medium[1]);
				}
				if (!empty($resize)){
					$img->resize($resize);
				}
				
				return $nombreImg;
			}
			else{
				throw new Exception("error al subir imagen $pathImagen");
			}
		}
		else{		
			throw new Exception("error al subir imagen $pathImagen");
		}
		
    }
}
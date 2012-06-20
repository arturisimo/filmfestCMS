<?php 

	class Data {
		
		//datos url
	    private $_lang;
	    private $_langs;
		
		private $_dao;
		
		private $_request;
		
		//datos bbdd
		private $_modulo;
		private $_layout;
		private $_skin;
		private $_title;
		private $_description;
		private $_data;
		private $_edicion;
		private $_idTexto;
		private $_perfiles;
		private $_usuario;
		
		
		public function getDao(){
	        return $this->_dao;
	    }
		public function setDao($dao){
	        $this->_dao = $dao;
	    }
		public function getRequest(){
	        return $this->_request;
	    }
		public function setRequest($request){
	        $this->_request = $request;
	    }
		
		public function getModulo(){
	        return $this->_modulo;
	    }
		public function setModulo($modulo){
	        $this->_modulo = $modulo;
	    }

		public function getLang(){
		        return $this->_lang;
		}
		public function setLang($lang){
		       $this->_lang = $lang;
		}
		public function getLangs(){
		        return $this->_langs;
		}
		public function setLangs($langs){
		       $this->_langs = $langs;
		}
	    
		public function getTitle(){
	        return $this->_title;
	    }
		public function setTitle($title){
	        $this->_title = $title;
	    }
	    
	    public function getDescription(){
	        return $this->_description;
	    }
		public function setDescription($description){
	        $this->_description = $description;
	    }
	    
	    public function getLayout(){
	        return $this->_layout;
	    }
		public function setLayout($layout){
	        $this->_layout = $layout;
	    }
	    
		public function getSkin(){
	        return $this->_skin;
	    }
		public function setSkin($skin){
	        $this->_skin = $skin;
	    }
	    
		public function getData(){
	        return $this->_data;
	    }
		public function setData($data){
	        $this->_data = $data;
	    }
		public function getEdicion(){
	        return $this->_edicion;
	    }
		public function setEdicion($edicion){
	        $this->_edicion = $edicion;
	    }

		public function getIdTexto(){
	        return $this->_idTexto;
	    }
		public function setIdTexto($idTexto){
	        $this->_idTexto = $idTexto;
	    }
	    
		public function getPerfiles(){
	        return $this->_perfiles;
	    }
		public function setPerfiles($perfiles){
	        $this->_perfiles = $perfiles;
	    }
		public function getUsuario(){
	        return $this->_usuario;
	    }
		public function setUsuario($usuario){
	        $this->_usuario = $usuario;
	    }
	    
		public function __toString(){
	        return "Data:  request ".$this->getRequest(). " | modulo ".$this->getModulo(). " | lang ".$this->getLang(). "  | data ".$this->getData().
	        	   "| titulo ".$this->getTitle(). " | descripcion ".$this->getDescription(). " | layout ".$this->getLayout();
	    }
	}
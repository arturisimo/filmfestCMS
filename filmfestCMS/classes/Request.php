<?php 

	class Request{
		
		private $_controlador;
	    private $_metodo;
	    private $_id;
	    private $_anyo;
	    private $_application;
		
	    
		public function getControlador(){
        	return $this->_controlador;
	    }
		public function setControlador($controlador){
	        $this->_controlador = $controlador;
	    }
	    
	    public function getMetodo(){
	        return $this->_metodo;
	    }
		public function setMetodo($metodo){
	        $this->_metodo = $metodo;
	    }
	    
	    public function getApplication(){
	        return $this->_application;
	    }
		public function setApplication($application){
	        $this->_application = $application;
	    }
	    
	    public function getId(){
	        return $this->_id;
	    }
		public function setId($id){
	        $this->_id = $id;
	    }
	    
	    public function getAnyo(){
	        return $this->_anyo;
	    }
		public function setAnyo($anyo){
	        $this->_anyo = $anyo;
	    }
		
		public function __toString(){
	        return "Data:  aplicacion ".$this->getApplication(). " | controller ".$this->getControlador(). " | metodo ".$this->getMetodo(). " | id ".$this->getId(). " | anyo ".$this->getAnyo();
	    }
	
	}
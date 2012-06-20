<?php 

	class Usuario {
		
		private $_nombre;
		private $_perfiles;
		private $_perfil;
		private $_email;
		private $_descripcion;
		private $_modulo;
		
		
		public function getNombre(){
	        return $this->_nombre;
	    }
		public function setNombre($nombre){
	        $this->_nombre = $nombre;
	    }
		public function getDescripcion(){
	        return $this->_descripcion;
	    }
		public function setDescripcion($descripcion){
	        $this->_descripcion = $descripcion;
	    }
		public function getEmail(){
	        return $this->_email;
	    }
		public function setEmail($email){
	        $this->_email = $email;
	    }
		public function getPerfil(){
	        return $this->_perfil;
	    }
		public function setPerfil($perfil){
	        $this->_perfil = $perfil;
	    }
		
	    public function getPerfiles(){
	        return $this->_perfiles;
	    }
		public function setPerfiles($perfiles){
	        $this->_perfiles = $perfiles;
	    }
	 	public function getModulo(){
	        return $this->_modulo;
	    }
		public function setModulo($modulo){
	        $this->_modulo = $modulo;
	    }
	    
		public function __toString(){
	        return "Usuario: ".$this->_nombre. " - ".$this->_descripcion;
	    }
	}
<?php

class usuarioAdminController extends AdminController{
	
     public function __construct(Data $data) {
     	$this->_tabla = "usuarios";
    	parent::__construct($data);
    }
    
    public function index(){
    	
		$nivelAcceso = 0;
		$classPassword = "";
		$usuario = "";
		$email = "";
		$nombre ="";
		
		if(!empty($this->_id)){
	   		$classPassword = "oculto";
	   		$usuarioDAO = $this->_dao->select($this->_id, $this->_tabla);
	   		$nombre = $usuarioDAO->usuario;
	   		$email = $usuarioDAO->email;
	   		$nivelAcceso = $usuarioDAO->nivel_acceso;
	 	}		
	 	
	 	$this->addData(array("listado" => $this->_dao->usuariosDAO(),
    						 "perfiles" => $this->_data->getUsuario()->getPerfiles(),
    						 "nivelAcceso" => $nivelAcceso, "classPassword" => $classPassword,
							 "nombre" => $nombre, "email" => $email));
		
		$this->loadView();

    }   
    
    public function alta(){
    	$id = $_POST['id'];
    	
    	$campos = array("usuario" => $_POST['usuario'],
						"email" => $_POST['id_email'],
						"nivel_acceso" => $_POST['id_nivel_acceso']);
		
 		if(!empty($id)){
			$ok = $this->_dao->update($id, $campos, $this->_tabla);			
		}
		else{
			$campos = array_merge($campos, array("pass" => md5($_POST['id_password'])));
			$ok = $this->_dao->insert($campos, $this->_tabla);
		}
		echo $ok;
		
    }

 
}
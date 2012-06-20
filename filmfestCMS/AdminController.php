<?php 

abstract class AdminController extends Controller{
	
	protected $urlWebModulo;
	protected $imprimir;
	protected $cambioEdicion;
	protected $_tabla;
	protected $_carpetaImg;
	
    public function __construct($data) {
    	parent::__construct($data);
    	$this->_baseUrl = URL_ADMIN;
    	$this->_base = BASE_URL_ADMIN;
    }
    
	public function view(){
 		$id = $_POST["id"];
		$accion = $_POST["accion"];
		$ok = "ko";
 		if(!empty($id)){
			$ok = $this->_dao->view($id, $this->_tabla, $accion);
		}
		echo $ok;
    }
    
	public function delete(){
 		$id = $_POST['id'];
    	$ok = "ko";
 		if(!empty($id)){
			$ok = $this->_dao->delete($id, $this->_tabla);	
		}
		echo $ok;
    }
    
}
<?php 

class recepcionWebController extends Controller{
	
    public function __construct($data) {
        parent::__construct($data);
    }
    
    public function index(){
    	$TOTAL_LISTADO = 20;
    	$numeroTotal = $this->_dao->numeroAutoproduccionesDAO($this->_anyo);
		$totalPaginas = ceil($numeroTotal/$TOTAL_LISTADO); 
	    $pag = !empty($this->_id) ? $this->_id : 1;	
	    $inicio = !empty($this->_id) ? ($pag-1) * $TOTAL_LISTADO : 0;
   		
	    
	    $this->addData(array("total" => $numeroTotal, "peliculas" => $this->_dao->listadoAutoproduccionesDAO($this->_anyo, $inicio, $TOTAL_LISTADO),
   	    					 "pag" => $pag, "totalPaginas" => $totalPaginas ));										 		
		$this->loadView();
        
    }
}
<? 
	class textoWebController extends Controller{
		
	    public function __construct($data) {
	    	parent::__construct($data);
	    }
	    
	    public function index(){
	    	$txtDAO = $this->_dao->textoDAO($this->_data->getIdTexto());
	    	$galeriaDAO = array();
	    	if(!empty($txtDAO->id_galeria)){
	    		$galeriaDAO = $this->_dao->imagenesDAO($txtDAO->id_galeria);
	    	}
	    	$this->addData(array("txt" => $txtDAO, "galeria" => $galeriaDAO));
			$this->loadView();
	    }
	}
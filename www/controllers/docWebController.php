<? 
class docWebController extends Controller{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$this->addData(array("documentos" => $this->_dao->documentosDAO($this->_anyo)));
		$this->loadView();
	}
}


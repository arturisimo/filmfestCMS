<? 
class convocatoriasWebController extends Controller{
	
    public function __construct($data) {
       parent::__construct($data);
    }
    
    public function index(){
    	$this->addData(array("convocatorias" => $this->_dao->convocatoriasDAO()));
		$this->loadView();
    }
}
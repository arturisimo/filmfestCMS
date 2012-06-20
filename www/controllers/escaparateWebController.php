<? 
class escaparateWebController extends Controller{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$this->addData(array("imagenes" => $this->_dao->escaparateDAO()));
		$this->loadView();
	}
}
<? 
	class edicionesWebController extends Controller{
		
	    public function __construct($data) {
	    	parent::__construct($data);
	    }
	    
	    public function index(){
			$this->addData(array("ediciones" => $this->_dao->edicionesDAO()));
			$this->loadView();
	        
	    }
	}
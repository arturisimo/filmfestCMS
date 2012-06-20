<? 
	class errorAdminController extends AdminController{
		
	    public function __construct(Data $data) {
	    	parent::__construct($data);
	    }
	    
	    public function index(){
	    	//Error::add(" error : ".implode(", ", $_SERVER));
			$this->loadView();
	        
	    }
	}

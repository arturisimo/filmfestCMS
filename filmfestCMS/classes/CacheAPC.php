<?
 class CacheAPC {
 
    //private $_ttl = 600; // Time To Live
    private $_enabled = false;
 
   
    public function __construct() {
        $this->_enabled = extension_loaded('apc');
    }
  
    public function getData($key) {
        $data = null;
    	if($this->_enabled && !empty($key)){
	    	$data = apc_fetch($key, $ok);
	    	if(!$ok){
	    		$data = null;
	    	}
    	}
        return $data;
    }
 
    public function setData($key, $data) {
    	$stored = false;
    	if($this->_enabled && !empty($key)){
    		$stored = apc_store($key, $data);
    	}
    	return $stored;	
    }
    
    public function isEnabled(){
    	return  $this->_enabled;
    }
    
}
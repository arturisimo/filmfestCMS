<?php

	class DataBase {
		private $_mySQLi;
		private $_resource;
		private $_sql;
		private $_cache;
		
		public function __construct(){
	        $this->_mySQLi = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
	        if (mysqli_connect_errno()){
	            throw new Exception("Connection failed : \n" . mysqli_connect_error());
	        }
	        $this->_cache = new CacheAPC();
        }
		        
		public function execute(){
			if(!($this->_resource =  $this->_mySQLi->query($this->_sql))){
				throw new Exception($this->_mySQLi->error);
				return null;
			}
			return $this->_resource;
		}
		
		public function setQuery($sql){
			if(empty($sql)){
				return false;
			}
			$this->_sql = $sql;
			return true;
		}
			
		public function loadObject($key=null){
			$object = $this->_cache->getData($key);
			if(empty($object)){
				if ($query = $this->execute()){
					if ($object = mysqli_fetch_object($query)){
						if(!($this->_cache->setData($key, $object))){
							if (!empty($key)){
								//Error::add("cache - $key not stored");
							}
						}
						mysqli_free_result($query);
					}
				}
			}
			return $object;
		}	
		
		public function loadObjectList($key=null){
			$array = $this->_cache->getData($key);
			if(empty($array)){
				if ($query = $this->execute()){
					$array = array();
					while ($row = mysqli_fetch_object($query)){
						$array[] = $row;
					}
					if(!($this->_cache->setData($key, new ArrayObject($array)))){
						if(!empty($key)){
							//Error::add("cache - $key not stored");
						}
					}
				}
			}
			return $array;
		}
		
		public function count($key=null){
			$total = $this->_cache->getData($key);
			if(empty($total)){
				if(!$this->_resource =  $this->_mySQLi->query($this->_sql)){
					throw new Exception(mysqli_error());
				}
				$total = mysqli_num_rows($this->_resource);
			}
			return $total;
		}
		
		public function __destruct(){
			$this->_mySQLi->close();
		}
		
	    public function startTransaction(){
	    	self::setQuery("START TRANSACTION");
		    return self::execute();
	    }
		public function rollback(){
			self::setQuery("ROLLBACK");
			return self::execute();
		}
		public function commit(){
			self::setQuery("COMMIT");
			return self::execute();
		}
		
		/* select */
		public function select($id, $tabla){
			try{
				$sql= "select * from $tabla where id=$id";
				self::setQuery($sql);
			    return self::loadObject();
			} catch (Exception $e) {
				Error::add("<strong>error en ".__FUNCTION__. "</strong><br>". $e->getMessage(). "<br> query: $sql");
			}
		}
		public function selectQuery($query, $list=false, $key=null){
			try{
				self::setQuery($query);
				return $list ? self::loadObjectList($key) : self::loadObject($key);
			} catch (Exception $e) {
				Error::add("<strong>error en ".__FUNCTION__. "</strong><br>". $e->getMessage(). "<br> query: $query");
			}
		}
		public function selectCount($query, $key=null){
			try{
				self::setQuery($query);
			    return self::count($key);
			} catch (Exception $e) {
				Error::add("<strong>error en ".__FUNCTION__. "</strong><br>". $e->getMessage(). "<br> query: $query");
			}
		}
		
		/* delete */
		public function delete($id, $tabla){
			$ok = "ko";
			try{
				$sql= "delete from $tabla where id=$id";
				self::setQuery($sql);
				$result = self::execute();
			    if(!empty($result)){
			    	$ok = "ok";
			    }
			} catch (Exception $e) {
				Error::add("<strong>error en ".__FUNCTION__. "</strong><br>". $e->getMessage(). "<br> query: $sql");
			}
			return $ok;
		}
		public function deleteQuery($query){
			$ok = "ko";
			try{
				self::setQuery($query);
				$result = self::execute();
			    if(!empty($result)){
			    	$ok = "ok";
			    }
			} catch (Exception $e) {
				Error::add("<strong>error en ".__FUNCTION__. "</strong><br>". $e->getMessage(). "<br> query: $query");
			}
			return $ok;
		}
	
		/* alta baja */
		public function view($id, $tabla, $accion){
			$ok = "ko";	
			try{
				$sql = "update $tabla set alta='$accion' where id=$id";
				self::setQuery($sql);
				$result = self::execute();
				if(!empty($result)){
			    	$ok = "ok";
			    }
			} catch (Exception $e) {
				Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage(). ". query: $sql");
			}
			return $ok;
		}
	    
	    public function insertUpdate($id, $campos, $tabla){
	    	$ok = "ko";
	    	if(empty($id)){
	    		$ok = $this->insert($campos, $tabla);
			}
			else{
				$ok = $this->update($id, $campos, $tabla); 
			}	
		    return $ok;
	    }
		
	    public function insert($campos, $tabla){
	    	$ok = "ko";
	    	try{
	    		foreach ($campos as $campo => $valor){
		            $keys[] = $campo;
		            $valores[]='\'' . $this->sanitize($valor) . '\'';
		        }
				$keys = implode(',', $keys);
		        $valores=(implode(',', $valores)); 
		    	$sql = "insert into $tabla ($keys) values ($valores)";
		    	Log::add($sql, false);
		    	self::setQuery($sql);
		    	$result = self::execute();
				if(!empty($result)){
					$ok = "ok";
				}
	    	} catch(Exception $e){
				Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage(). ". query: $sql");
			}
			return $ok;
	    }
	    
		public function insertId($campos, $tabla){
	    	$id = 0;
	    	foreach ($campos as $campo => $valor){
	            $keys[] = $campo;
	            $valores[]='\'' . self::sanitize($valor) . '\'';
	        }
			$keys = implode(',', $keys);
	        $valores=(implode(',', $valores)); 
	    	$sql = "insert into $tabla ($keys) values ($valores)";
	    	$ok = $this->_mySQLi->query($sql);
	    	Log::add($sql, false);
	    	if($ok){
				$id = $this->_mySQLi->insert_id;
			} else {
				Error::add(" error en ".__FUNCTION__. " : ". $this->_mySQLi->error . ". query: $sql");
			}
			return $id;
	    }
	    
	 	public function update($id, $campos, $tabla){
	 		$ok = "ko";	
	    	try{
		    	foreach ($campos as $campo => $valor){
	           		 $sets[]= $campo . '=\'' . $this->sanitize($valor) . '\'';
	            }
				$sets = implode(',', $sets);
				$sql = "UPDATE $tabla SET $sets WHERE id = $id";
				Log::add($sql, false);
				self::setQuery($sql);
		    	$result = self::execute();
				if(!empty($result)){
					$ok = "ok";
				}
	    	} catch(Exception $e){
				Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage(). ". query: $sql");
			}
			return $ok;
	    }
	    
	    public function sanitize($string){
	      //$string = htmlspecialchars($string);
	      return $this->_mySQLi->real_escape_string($string);
	      return $string;
	    }
}
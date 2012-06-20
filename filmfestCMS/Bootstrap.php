<?php

class Bootstrap{
	
	private static $_dao;
	
	public static function run(){
		$data = new Data();
    	
		$data->setRequest(self::loadRequest());
		
		$isAdmin = $data->getRequest()->getApplication() == APP;
    	
        $data = $isAdmin ? self::loadDataAdmin($data) : self::loadDataWeb($data);

		$controller = $data->getModulo().($isAdmin ? 'AdminController' : 'WebController');
		$controller = new $controller($data);
      	  
		$metodo = is_callable(array($controller, $data->getRequest()->getMetodo())) ? $data->getRequest()->getMetodo() : DEFAULT_METODO;
		
		call_user_func(array($controller, $metodo));
	}
    
	/**
	 * carga el objeto Request con la peticion del usuario.
	 * admin - posibles url
	 *  > admin: http://site.com/admin/controlador
	 *	> admin: http://site.com/admin/controlador/id
	 *  > admin: http://site.com/admin/controlador/accion ajax
	 *  
	 * www - posibles url
	 *  > muestra actual: http://site.com/controlador/id
	 *	> muestra pasada: http://site.com/anyo/controlador/id
	 *	> pelicula: http://site.com/pelicula/id/nombre-de-pelicula
	 *	> recepcion con paginacion:  http://site.com/anyo/recepcion/pag
	 *	  
	 * @return Request
	 */
	private static function loadRequest(){
    	//valores por defecto
    	$controller = "";
    	$metodo = DEFAULT_METODO;
    	$anyo = DEFAULT_ANYO;
        $id = 0;
    	
    	$url = explode("/", $_SERVER['REQUEST_URI']);
		$numURL = count(explode("/",str_replace('http://', '', BASE_URL)));
    	
    	if (isset($url[$numURL]) && $url[$numURL] == ADMIN){
        	//navegacion admin    
			$application = APP;
			
			//tratamiento anyo
			if (isset($_POST["edicion"]) && !empty($_POST["edicion"])){
				$anyo = $_POST["edicion"];
			} elseif(isset($_SESSION['anyo'])){
				$anyo = $_SESSION['anyo'];
			} 
			$_SESSION['anyo']= $anyo;
    		
			//tratamiento perfil
			if (isset($_POST["perfil"]) && !empty($_POST["perfil"])){
				$_SESSION['nivel_navegacion'] = $_POST["perfil"];
				header("Location: ".URL_ADMIN."/".$_POST["controller"]);
				exit;
			} 
			
			if(isset($_POST["accion"]) && $_POST["accion"]=='exit'){
				$_SESSION = array();
				session_destroy();
				header("Location: ".URL_ADMIN);
				exit;
			} else if (isset($_POST["accion"]) && $_POST["accion"] == 'reset_edicion'){
				unset($_SESSION['anyo']);
				$anyo = "";
			} else if (isset($_POST["accion"]) && $_POST["accion"] == 'inicio'){
				unset($_SESSION['nivel_navegacion']);
			} else {
				if (isset($url[$numURL+1])){ 
					$controller = $url[$numURL+1];				
		   		}	
		   		if (isset($url[$numURL+2])){
					if (is_numeric($url[$numURL+2])){
						$id = $url[$numURL+2];
					}
					else{
						$metodo = $url[$numURL+2];
					}
		   		}
				if (isset($url[$numURL+3])){
					if (is_numeric($url[$numURL+3])){
						$id = $url[$numURL+3];
					}
					else{
						$metodo = $url[$numURL+3];
					}
		   		}
		   	}
        } else {
        	//navegacion www
        	$application = WEB;
        
			if (isset($url[$numURL]) && !empty($url[$numURL])){
				if (is_numeric($url[$numURL])){
					$anyo = $url[$numURL];
					if (isset($url[$numURL+1])){
						$controller = $url[$numURL+1];
					}
				} else{
					$controller = $url[$numURL];
					if (isset($url[$numURL+1])){
						if (is_numeric($url[$numURL+1])){
							$id = $url[$numURL+1];
						} else{
							$metodo = $url[$numURL+1];
						}
			   		}
				}
				if (isset($url[$numURL+2])){ 
					if(is_numeric($url[$numURL+2])){
						$id = $url[$numURL+2];
					} else {
						$metodo = $url[$numURL+2];
					}		
				}	
			}
        }	
		$request = new Request();
		$request->setApplication($application);
        $request->setControlador($controller);
        $request->setMetodo($metodo);
        $request->setId($id);
        $request->setAnyo($anyo);
        Log::add($request, false);
        return $request;
    }
   
    /**
     * carga de datos para la aplicacion web. 
     * 
     * @param $data
     * @return Data
     */
    private static function loadDataWeb(Data $data){
    	$values = array();
    	$idControllerMenu = 0;
	    $idPagina = 0;
		$layout = DEFAULT_LAYOUT;
		$request = $data->getRequest();
		$skin = $request->getAnyo();
		$modulo = $request->getControlador();
    	
		$dao = DAO::getInstance();

		//obtener idiomas de la muestra $langs
    	$langs = $dao->langsEdicionDAO($request->getAnyo());
    	$lang = self::loadLanguage($langs);
    	$data->setLang($lang);
    	$data->setLangs($langs);
    	
    	//paginas atemporales solo dependen del id: peliculas y proyecciones
		$paginaUnica = $dao->paginaUnicaDAO($request->getControlador(), $request->getId(), $request->getAnyo());
   		if (!empty($paginaUnica)){
   			$titulo = $paginaUnica->titulo;
	   		$descripcion = Util::substring($paginaUnica->descripcion, 200);
	   		$anyo = $paginaUnica->anyo;
	   		if($paginaUnica->id_proyeccion>0){
	   			$skin = $paginaUnica->anyo;
	   			//$values = array_merge($values, array("edicionConvocatoria" => $dao->convocatoriaDAO($request->getAnyo())));
	   		} else {
	   			$skin = "atp".$paginaUnica->anyo;
	   		}
	   		$request->setAnyo($paginaUnica->anyo);
	 		$layout = $paginaUnica->layout;
	 	}
	 	//datos de la edicion
    	$edicion = $dao->edicionDAO($request->getAnyo());
    	$data->setEdicion($edicion); 
		$subMenu = array();
		if (empty($paginaUnica)){
		   	//paginas gestionadas por bbdd
		   	$pagina = $dao->paginaDAO($request->getControlador(), $request->getAnyo(), $lang);
		   	Log::add($pagina, false);
		   
		   	if (!empty($pagina)){
		   		$titulo = $pagina->titulo;
		   		$descripcion = Util::substring($pagina->descripcion, 200);
		   		$layout = $pagina->layout;
		   		$skin = $pagina->skin;
		 		$modulo = $pagina->modulo;
		 		$data->setIdTexto($pagina->id_texto);
		 		$idControllerMenu = $pagina->id_paginapadre;
		 		$idPagina = $pagina->id;
		 		//carga submenu
				if ($idPagina>0){
					$idControllerMenu = ($idControllerMenu==0) ? $idPagina : $idControllerMenu;
					$subMenu = $dao->submenuDAO($idControllerMenu);
				}	 		
		 	} else {
				$modulo = "error";
				$values = array_merge($values, array("error" => "404"));
				$titulo = _("Error 404. P&aacute;gina no encontrada");
		   		$descripcion = _("Error 404. P&aacute;gina no encontrada");
			}
    	}
		//carga menu
		$values = array_merge($values, array("menu" => $dao->menuDAO($request->getAnyo())));
		$values = array_merge($values, array("subMenu" => $subMenu));
		$values = array_merge($values, array("idControllerMenu" => $idControllerMenu));
		$data->setData($values);
		$data->setDao($dao);
		$data->setTitle($titulo);
		$data->setDescription($descripcion);
		$data->setLayout($layout);
		$data->setSkin($skin);
		$data->setModulo($modulo);
		return $data;
    }
	

    /**
     * valida si esta logado el usuario y carga los datos
     *   
	 * @return Data
     */
    private static function loadDataAdmin(Data $data){
    	$values = array();
		$layout = "2columnas.phtml";
		$skin = ADMIN_SKIN;
		
		$dao = AdminDAO::getInstance();
    	$data->setDao($dao);
    	
    	$langs = $dao->langDAO(ADMIN_LANG);
    	$data->setLang(self::loadLanguage($langs));
    	$data->setLangs($langs);
    	
    	$modulo = $data->getRequest()->getControlador();
    	$anyo = $data->getRequest()->getAnyo();
  		
    	$usuario = self::validaUsuario($dao);
    	$nivel = isset($_SESSION['nivel_navegacion']) ? $_SESSION['nivel_navegacion'] : "";
    	
    	if (!empty($usuario)){
    		$data->setUsuario($usuario);
			if(empty($modulo)){
				$layout = DEFAULT_LAYOUT;
    			if(empty($anyo)){
    				$modulo = "anyo";
    			} else {
    				if(count($usuario->getPerfiles())>1){
    					$modulo = "inicio";
    				} else {
    					header("Location: ".URL_ADMIN."/".$usuario->getModulo());
						exit;
    				}
    			}
    		} else {
    			if(empty($nivel)){
    				$nivel = $_SESSION['nivel_acceso'];
    			}
    			$adminModulo = $dao->adminModuloNombreDAO($modulo, $nivel);
		    	if (!empty($adminModulo)){
		    		$data->setTitle($adminModulo->nombre);
			 		$data->setDescription($adminModulo->descripcion);
			 		$_SESSION['nivel_navegacion'] = $adminModulo->nivel_acceso;
			 		$nivel = $adminModulo->nivel_acceso;
				} else {
					Error::add("no encuentra modulo: " . $modulo ." - " .$_SESSION['nombreusuario']);
					$modulo = "error";
					$data->setTitle("Oooops no existe esta funcionalidad");
			 		$data->setDescription("o no tienes permiso");
				}
				$values = array_merge($values, array("idControllerMenu" => $adminModulo->modulo_padre));
	 			$data->setEdicion($dao->select($anyo, "ediciones"));
	 			$data->setPerfiles($dao->perfilesAccesoDAO($_SESSION['nivel_acceso']));
	 			
	 			$menu = array();
	 			foreach ($dao->menuDAO($nivel) as $controller) {
	 				$subMenu = $dao->subMenuDAO($controller->id);	
	 				$controller = array_merge((array)$controller, array("submenu" =>$subMenu));
	 				array_push($menu, (array)$controller);
	 			}
	 			$values = array_merge($values, array("menu" => $menu));
    		}
	 		
    	} else {
    		$modulo = "login";
    		$layout = DEFAULT_LAYOUT;
    		if (isset($_POST['nombreusuario'])){
				$values = array_merge($values, array("error" => "Usuario/Contrase&ntilde;a incorrecta!"));
				Error::add(" Usuario/Contrase&ntilde;a incorrecta! ".$_POST['nombreusuario']);
			}
    	}
    	$data->setModulo($modulo);
    	$data->setData($values);
    	$data->setLayout($layout);
    	$data->setSkin($skin);
    	return $data;
    }
    
    /**
     * validacion usuario
     * @return boolean
     */
    private static function validaUsuario(AdminDAO $dao){
    	$usuario = null;
    	//validado previamente
    	if (isset($_SESSION['id_usuario']) && isset($_SESSION['nombreusuario'])){
			//$logado = true;
			$usuarioDAO = $dao->validaDAO($_SESSION['nombreusuario']);
			$usuario = new Usuario();
			$usuario->setNombre($usuarioDAO->usuario);
			$usuario->setPerfil($usuarioDAO->nivel);
			$usuario->setPerfiles($dao->perfilesAccesoDAO($usuarioDAO->nivel));
			$usuario->setEmail($usuarioDAO->email);
			$usuario->setDescripcion($usuarioDAO->descripcion);
			$usuario->setModulo($usuarioDAO->modulo);
		} else {
			//se va a validar
			if (isset($_POST['nombreusuario'])){
				$login = $dao->validaDAO(strip_tags($_POST['nombreusuario']));
		    	$password = md5($_POST['psw']);   
		    	
		    	if(isset($login) && $login->usuario == $_POST['nombreusuario'] && $login->pass == $password){
					$_SESSION['nombreusuario'] = $login->usuario;
					$_SESSION['id_usuario'] = $login->id;
					$_SESSION['nivel_acceso'] = $login->nivel;
					$usuario = new Usuario();
					$usuario->setNombre($login->usuario);
					$usuario->setPerfil($login->nivel);
					$usuario->setPerfiles($dao->perfilesAccesoDAO($login->nivel));
					$usuario->setEmail($login->email);
					$usuario->setDescripcion($login->descripcion);
					$usuario->setModulo($login->modulo);
				}
			}
		}
		Log::add($usuario, false);
		return $usuario;
    }
    
    /**
     * carga de idiomas para los properties
     * 
     * @param $languages
     * @return lang
    */
 	private static function loadLanguage($languages){
        if(count($languages)>1){
	    	if(isset($_POST["lang"])){
	    	  $lang = $_POST["lang"];
			} else if(isset($_SESSION["lang"])) {
			  $lang = $_SESSION["lang"];
			} else { 
				$clientLanguages = explode(",", getenv("HTTP_ACCEPT_LANGUAGE"));
				for($i=0; $i<count($clientLanguages); $i++){
					foreach ($languages as $language) {
						if($language->lang==substr($clientLanguages[$i], 0, 2)){
							$lang = $language->lang;
							break 2;
						}
					}
				}
			}
			$_SESSION["lang"] = $lang;
		} else {
			$lang = $languages[0]->lang;
		}
 		foreach ($languages as $language) {
			if($language->lang==$lang){
				putenv("LC_ALL=".$language->codigo.".".$language->codificacion);
				setlocale(LC_ALL, $language->codigo.".".$language->codificacion);
				bindtextdomain("messages", ROOT."locale");
				textdomain("messages");
				break;
			}
		}
		return $lang;
    }
}
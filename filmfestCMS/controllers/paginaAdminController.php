<?php

class paginaAdminController extends AdminController{
	
     public function __construct(Data $data) {
    	$this->cambioEdicion = true;
    	$this->_tabla = "pagina";
    	parent::__construct($data);
    }
    
    public function index(){
		$titulo = "";
		$descripcion = "";
		$urlPagina = "";
		$langPagina = "";
		$layoutPagina  = "";
		$idPaginaPadre  = 0;
		$idWebModulo  = 0;
		$nombre = "";
		$orden = 0;
		$portada = false;
		$textos = "";
		$skinPagina = $this->_anyo;
		
		 if(!empty($this->_id)){
	   		$paginaDAO = $this->_dao->select($this->_id, $this->_tabla);
	  		$idPaginaPadre = $paginaDAO->id_paginapadre;
	  		$idWebModulo = $paginaDAO->id_webmodulo;
	  		$urlPagina = $paginaDAO->url;
	  		$titulo = $paginaDAO->titulo;
	  		$descripcion = $paginaDAO->descripcion;
	  		$layoutPagina = $paginaDAO->layout;
	  		$skinPagina = $paginaDAO->skin;
	  		$textos =  $this->_dao->textosPaginaDAO($this->_id);
	  		$menuDAO = $this->_dao->webMenuDAO($this->_id);

	  		if(!empty($menuDAO)){
	  			$nombre = $menuDAO->nombre;
	  			$orden = $menuDAO->orden;
	  			$portada = $menuDAO->portada=='S';
	  		}
		}
	 	
    	$this->addData(array("listado" => $this->_dao->paginasDAO($this->_anyo),
    							"textosPosibles" => $this->_dao->textosPosiblesPaginaDAO($this->_anyo),
    							"textos" => $textos,
    							"titulo" => $titulo,
								"descripcion" => $descripcion,
    							"nombre" => $nombre,
								"orden" => $orden,
								"urlPagina" => $urlPagina,
								"layoutPagina"=>$layoutPagina,
    							"idPaginaPadre" => $idPaginaPadre,
		  						"idWebModulo" => $idWebModulo,
    							"portada" => $portada, 
    							"paginasPadre" => $this->_dao->paginasPadreDAO($this->_id, $this->_anyo, $langPagina), 
    							"layouts" => Util::getFiles(ROOT . WEB . DS . "vista" . DS . "skins" . DS . $skinPagina . DS . "layouts", "phtml"),
    							"skins" => Util::getFolder(ROOT . WEB . DS . "vista" . DS . "skins", array(".", "..","commons")),
    							"skinPagina" => $skinPagina,
    							"webmodulos" => $this->_dao->webModulosDAO(true)));
		
		$this->loadView();

    }   
   	
    public function alta(){
 		
    	$idMenu = $_POST['id'];
 		$this->_dao->startTransaction();
 		
		$campos = array("titulo"=>$_POST['id_titulo'],"url"=>$_POST['id_url'],"descripcion"=>$_POST['id_descripcion'],"id_webmodulo"=>$_POST['id_modulo'],"skin"=>$_POST['id_skin'], "layout"=>$_POST['id_layout'],"id_paginapadre"=>$_POST['id_paginapadre']);
 		if(!empty($idMenu)){
			$ok = $this->_dao->update($idMenu, $campos, $this->_tabla);
		}
		else{
			$campos = array_merge($campos, array("muestra"=>$_POST['id_edicion']));
			$idMenu = $this->_dao->insertId($campos, $this->_tabla);
			$ok = $idMenu > 0 ? "ok" : "ko";
		}
		
		//textos
		if (!empty($_POST['textos'])){
			$textos = explode(",", $_POST['textos']);
			if($ok=="ok"){
				$ok = $this->_dao->deleteTextoPagina($idMenu);
				foreach ($textos as $id_texto) {
					$ok = $this->_dao->insert(array("id_pagina" => $idMenu, "id_texto" => $id_texto), "pagina_texto");
				}
			}
		}
		//menu
		if($ok=="ok"){
			if (!empty($_POST['id_orden']) && !empty($_POST['id_nombremenu'])){
				$ok = $this->_dao->deleteMenu($idMenu);
				if($ok=="ok"){
					 $ok = $this->_dao->insert(array("id_pagina" => $idMenu, "nombre" => $_POST['id_nombremenu'], "orden"=>$_POST['id_orden'], "portada"=>$_POST['portada']), "menu");
				} 
			} else {
				$ok = $this->_dao->deleteMenu($idMenu);
			}
		}	
		
		if($ok=="ok"){
			$this->_dao->commit();
		} else {
			$this->_dao->rollback();
		}
		echo $ok;
    }
    
    public function load(){
    	
		if(isset($_POST['id_edicion'])){
			$paginasPadreDAO = $this->_dao->paginasPadreDAO(null, $_POST['id_edicion'], $_POST['id_idioma']);
			$options_str = "[";
			$tmp_array = array();
			array_push($tmp_array,"['0','selecciona..']");
			foreach ($paginasPadreDAO as $paginaPadre) {
				array_push($tmp_array,"['".$paginaPadre->id."','".$paginaPadre->titulo."']");
			}
			$options_str .= join(',',$tmp_array);
			$options_str .= "]";
			print $options_str;
		}
    }
    /*
    public function loadTextos(){
    	
		if(isset($_POST['anyo'])){
			$textos = $this->_dao->textosDAO($_POST['anyo'], false);
			$options_str = "[";
			$tmp_array = array();
			array_push($tmp_array,"['0','selecciona..']");
			foreach ($textos as $texto) {
				array_push($tmp_array,"['".$texto->id."','".$texto->titulo."']");
			}
			$options_str .= join(',',$tmp_array);
			$options_str .= "]";
			print $options_str;
		}
    }
    */
    public function loadLayouts(){
    	if(isset($_POST['id_skin'])){
    		$layouts = Util::getFiles(ROOT . WEB . DS . "vista" . DS . "skins" . DS . $_POST['id_skin'] . DS . "layouts", "phtml");
			$options_str = "[";
			$tmp_array = array();
			foreach ($layouts as $layout) {
				array_push($tmp_array,"['".$layout."','".$layout."']");
			}
			$options_str .= join(',',$tmp_array);
			$options_str .= "]";
			print $options_str;
		}
    }
    
}
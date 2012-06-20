<?php

class inicioAdminController extends AdminController{
	
    public function __construct(Data $data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	$perfiles=$this->_data->getUsuario()->getPerfiles();
    	$html = "";
    	$html .= "<div id='inicio'>";
    	foreach($perfiles as $perfil){	
			$html .= "<div class='img_perfil'>";
			$menu = $this->_dao->menuDAO($perfil->nivel);
			$html .="<h3 class='logo-$perfil->nivel'>$perfil->nombre<span class='small'>$perfil->descripcion</span></h3>";
			$html .="<ul class='menu'>";
			foreach ($menu as $controller) {
				$html .="<li><a href='".URL_ADMIN."/$controller->modulo' title='$controller->descripcion'><strong>$controller->nombre</strong></a>";
				$subMenu = $this->_dao->subMenuDAO($controller->id);
				$html .="<ul class='submenu'>";
				foreach ($subMenu as $subController) {
					$html .="<li><a href='".URL_ADMIN."/$subController->modulo' title='$subController->descripcion'>$subController->nombre</a></li>";
				}
				$html .="</ul>";
				$html .="</li>";
			}
			$html .="</ul>";
			$html .="</div>";
    	}
    	$html .= "</div>";
    	$this->addData(array("html" =>$html));
		$this->loadView();
    }   
}
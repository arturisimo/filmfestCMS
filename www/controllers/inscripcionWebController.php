<? 
	class inscripcionWebController extends Controller{
		
		private $_carpetaImg = "peliculas";
		
	    public function __construct($data) {
	    	parent::__construct($data);
	    }
	    
	    public function index(){
	    	$this->loadView();
	    }
		   
	    public function contacto(){
	    	
	    	$idPelicula = isset($_SESSION["id_pelicula"]) ? $_SESSION["id_pelicula"] : null;
	    	
			$this->_dao->startTransaction();
			if(empty($idPelicula)){
				if (isset($_POST['id_nombre'])){
					$idPelicula = $this->_dao->insertId(array("titulo"=>"","ficha_tecnica"=>"","sinopsis"=>"", "muestra" => DEFAULT_ANYO, "alta"=>"N"), "peliculas");
					$_SESSION["id_pelicula"] = $idPelicula;
					$ok = $this->_dao->insert(array("id"=>$idPelicula,"id_pelicula"=>$idPelicula,"autor"=>"", "duracion"=>"", "alta"=>"N"), "convocatoria");
					if($ok=="ok"){
						$ok = $this->_dao->insert(array("id_pelicula"=>$idPelicula,"autor"=>$_POST['id_nombre'], "email" => $_POST['id_email'], "telefono"=>$_POST['id_telefono'], "tipo"=>$_POST['id_tipocontacto']), "autores");
					}	
				}
			} else {
				if (isset($_POST['id_nombre'])){
					$ok = $this->_dao->update($idPelicula, array("autor"=>$_POST['id_nombre'],"email"=>$_POST['id_email'],"telefono"=>$_POST['id_telefono'], "tipo"=>$_POST['id_tipocontacto']), "autores");		
				}
				else{
					unset($_SESSION["id_pelicula"]);
				}
			}	
			
			if($ok=="ok"){
				$this->_dao->commit();
				echo utf8_encode("<strong>"._("Datos de contacto")."</strong><br>"._("Nombre")." ".$_POST['id_nombre']."<br>"._("Email").": ".$_POST['id_email']."<br>"._("Tel&eacute;fono").": ".$_POST['id_telefono']."<br>");
				echo "<a href='#' id='edit-contacto'>"._("Modificar datos")."</a>";
			} else {
				$this->_dao->rollback();
				echo "<div class='msg'><strong>"._("Ha habido un error en la inserci&oacute;n en la base de datos")."</strong></div>";
				Error::add(_("error en el formulario de inscripcion")." ".mysql_error()." $idPelicula");
			}
	    	
	    }
	    

	    public function pelicula(){

	    	$idPelicula = $_SESSION["id_pelicula"];
	    	
	    	$this->_dao->startTransaction();
			
			if(!empty($idPelicula)){
				$web = $_POST["id_web"];
				$ficha = "<p><strong>".$_POST['id_autor']."</strong><br>"
				.$_POST["id_duracion"]." / ".$_POST["id_anyo"]
				.($_POST["id_genero"]!="" ? " / ".$_POST["id_genero"]:"")
				.($_POST["id_pais"]!="" ? " / ".$_POST["id_pais"]:"")
				.($web!='' ? "<br><a href=\'$web\'>$web</a></p>" : "");
				$tecnica ="<p>".nl2br($_POST['id_tecnica'])."</p>";
				
				$ok = $this->_dao->update($idPelicula, array("titulo"=>$_POST['id_titulo'],"ficha_tecnica"=>$ficha.$tecnica,"sinopsis"=>$_POST['id_sinopsis']), "peliculas");		
				
				if($ok=="ok"){
					$ok = $this->_dao->update($idPelicula, array("autor"=>$_POST['id_autor'],"duracion"=>$_POST['id_duracion'],"anyo"=>$_POST['id_anyo'], "genero"=>$_POST['id_genero'],"pais"=>$_POST['id_pais'],"web"=>$_POST['id_web']), "convocatoria");					
				}
			}
			
			if($ok=="ok"){
				$this->_dao->commit();
				echo utf8_encode($ficha."<br><a href='#' id='edit-pelicula'>"._("Modificar datos")."</a>");
			} else {
				$this->_dao->rollback();
				echo utf8_encode("<div class='msg'><strong>"._("Ha habido un error en la inserci&oacute;n en la base de datos")."</strong></div>");
				Error::add(_("error en el formulario de inscripcion"));
			}
	    }
	    
	    public function adicional(){
			
	    	$idPelicula = $_SESSION["id_pelicula"];
	    	$ok = $this->_dao->update($idPelicula, array("coste"=>$_POST['id_coste'],"recursos"=>$_POST['id_recursos'],"comentarios"=>$_POST['id_comentarios']), "convocatoria");
	    	
	    	if($ok=="ko"){
				echo utf8_encode("<div class='msg'><strong>"._("Ha habido un error en la inserci&oacute;n en la base de datos")."</strong></div>");
				Error::add(_("error en el formulario de inscripcion"));
			}
	    }
	    
	    public function licencia(){
		    
			$idPelicula = $_SESSION["id_pelicula"];
			$ok = $this->_dao->update($idPelicula, array("licencia"=>$_POST['id_licencia']), "peliculas");
			
			if($ok=="ko"){
				$this->_dao->rollback();
				echo utf8_encode("<div class='msg'><strong>"._("Ha habido un error en la inserci&oacute;n en la base de datos")."</strong></div>");
				Error::add(_("error en el formulario de inscripcion"));
			}
	    }
	   
	    public function upload(){ 
	     	if(isset($_FILES['imagen'])){
		     	$thumbnail = "50x50";
		    	$medium = "150x100";
		    	$idPelicula = $_SESSION["id_pelicula"];
		    	$anyo = DEFAULT_ANYO;
		    	try{
		    		$this->_pathImg = IMG_PATH . $this->_carpetaImg . DS . $anyo . DS;
		    		$nombreImagen = $this->uploadImagen($thumbnail, $medium, "");
		    		$urlImagen = URL_IMG . $this->_carpetaImg . "/" . $anyo . "/" . $nombreImagen;
		    		
		    		if(!empty($idPelicula)){
		    			$ok = $this->_dao->insert(array("id_pelicula" => $idPelicula, "imagen" => $nombreImagen), "imagenes_pelicula");
					} 
					echo "<img src='$urlImagen' height='100px' width='100px'/>";
					
		    	} catch (Exception $e) {
		    		echo("<p>problemas al subir la imagen</p>");
		    		Error::add(" error en ".__FUNCTION__. " : ". $e->getMessage());
		    	}
		    }
	    }

	     
	    public function multimedia(){
	    	
	    	$idPelicula = $_SESSION["id_pelicula"];
	    	$video = Util::getUrlVideo($_POST["id_video"]);
	    	$ok = $this->_dao->update($idPelicula, array("enlace"=>$video,"video_descarga"=>$_POST["id_videodescarga"]), "peliculas");
				
	    	if($ok=="ok"){
				$msgFeedback = "<h3>"._("&iexcl;&iexcl;&iexcl;Muchas gracias!!!")."</h3><p>"._("Nos pondremos en contacto contigo tanto si has sido seleccionado, como si no.")."</p>";
				$datos = $this->_dao->datosContactoDAO($idPelicula);
				self::sendEMailOK($datos, $this->_data->getEdicion()->nombre);
			}
			else{
				$msgFeedback = utf8_encode("<div class='msg'><strong>"._("Ha habido un error en la inserci&oacute;n en la base de datos")."</strong></div>");
				Error::add("error en el formulario de inscripcion");
			}
			
			echo $msgFeedback;
			unset($_SESSION['id_pelicula']);
	    	
	    }
	    
		private function sendEmailOK($datos, $edicion){	
			$autor = $datos->autor;
			$titulo = $datos->titulo;
			$idPelicula = $datos->id_pelicula;
			$asunto = utf8_encode("Inscripcion en la $edicion");
			$cuerpo = "<html><body><p>Hola $autor,</p>";
			$cuerpo .= "<p><strong>$titulo</strong> se ha inscrito correctamente para la <strong>$edicion</strong>. </p>";
			$cuerpo .= "<p>Puedes ver la ficha en este link <strong>".BASE_URL."pelicula/$idPelicula</strong></p>";
			$cuerpo .= "<p>Gracias por participar!!</p></body></html>";
			
			$firma = "<div style='font: small Arial, Helvetica, sans-serif;margin-top:30px;'><table>";
			$firma .= "<tr><td><img src='".URL_IMG."logo_lavapies_firma.JPG'></td>";
			$firma .= "<td>Lavapi&eacute;s de Cine. $edicion<br>";
			$firma .= EMAIL_WEB. "<br>";
			$firma .= $_SERVER['SERVER_NAME']."<br>";
			$firma .= "</td></tr></table></div>";
			
			$headers  = "MIME-Version: 1.0\r\n";
			$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
			$headers .= "From: ".$_SERVER['SERVER_NAME']." <".EMAIL_WEB.">\r\n";
			$headers .= "Bcc: ".EMAIL_WEB."\r\n"; 
			mail($datos->email, $asunto, $cuerpo.$firma, $headers);
		}
	    
	 	 
	}
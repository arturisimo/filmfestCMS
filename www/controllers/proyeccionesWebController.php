<? 
	class proyeccionesWebController extends Controller{
		
	    public function __construct($data) {
	    	parent::__construct($data);
	    }
	    
	    public function index(){
	    	
			$html = "";
	    	
			$proyecciones = $this->_dao->proyeccionesDAO($this->_id, $this->_anyo);
			foreach ($proyecciones as $proyeccion) {
				$dia = $proyeccion->dia;
				$hora = $proyeccion->hora;
				$espacio =  $proyeccion->espacio;		
				$direccion =  $proyeccion->direccion;				
				$titulo = $proyeccion->titulo;
				$html .= "<div class='proyeccion'><h3>";
				
				if(empty($this->_id)){
					$html .= strftime("%A %e %B", strtotime(substr($dia,8,2)."-".substr($dia,5,2)."-".substr($dia,0,4)));
				}
				$html .= " $hora $titulo $espacio <span style='font-weight: normal; font-size: 12px;'>c/".$direccion."</span></h3>";
				
				$peliculas = $this->_dao->peliculasProyeccionesDAO($proyeccion->id_proyeccion);
				
				foreach ($peliculas as $pelicula) {
					$titulo = $pelicula->titulo;
					$idPelicula = $pelicula->id;
					$tituloURL = Util::stripAccents($titulo);
				 	$ficha = $pelicula->ficha_tecnica;
				
					if (!empty($pelicula->cartel)){
						$thumbnail = URL_IMG."peliculas/$this->_anyo/md/".$pelicula->cartel;
						$cartel = "<img src='$thumbnail' title='$titulo' alt='$titulo'>"; 
						$html .= "<div class='img-proyeccion'><a href='".BASE_URL."/pelicula/$idPelicula/$tituloURL' >$cartel</a><br><strong>$titulo</strong><br><span class='ficha'>".Util::recortaFicha($ficha)."</span></div>";
					}	
				}
				
				$html .= "</div>";
			}
	    	
			$this->addData(array("html" => $html));
			$this->loadView();  
	    }
	}
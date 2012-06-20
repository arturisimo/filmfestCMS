<? 
class programacionWebController extends Controller{
	
    public function __construct($data) {
    	parent::__construct($data);
    }
    
    public function index(){
    	
    	$fechaInicio = strtotime($this->_data->getEdicion()->fecha_inicio);
    	$fechaFin = strtotime($this->_data->getEdicion()->fecha_fin);
    	$html="<div id='programa'>";
		for ($i = $fechaInicio; $i <= $fechaFin; $i+=86400) {
	 			$html .= "<div id='proyeccion-programa'>";
				$html .= "<h2>".strftime("%A %e %B", $i)."</h2>";
				$html .= "<ul>";
				
				$proyecciones = $this->_dao->proyeccionesPorDiaDAO(date('Y-m-d', $i));
				
				foreach ($proyecciones as $proyeccion) {
						$espacio = $proyeccion->espacio;
						$hora = $proyeccion->hora;
					 	$html .= "<li>$hora ";
						if(!empty($proyeccion->titulo)){
					 		$html .= "$proyeccion->titulo<br><span style='margin-left:35px;'>$espacio</span>";
						} else {
					 		$html .= "$espacio";
						}
						$html .= "<ul>";
						$peliculas = $this->_dao->peliculasProyeccionesDAO($proyeccion->id_proyeccion);
						foreach ($peliculas as $pelicula){
							$titulo = $pelicula->titulo;
							$idPelicula = $pelicula->id;
							$tituloURL = Util::stripAccents($titulo);
							
							if (!empty($pelicula->sinopsis)){
								$enlace = BASE_URL."/pelicula/$idPelicula/$tituloURL";
								$html .= "<li><a href='$enlace' > $titulo </a></li>";
							} else{
								$html .= "<li> $titulo </li>";
							}
						}
						$html .= "</ul>";
						$html .= "</li>";
				}
				
				$html .= "</ul>";
				$html .= "</div>";
		}
 		$html.="</div>";
    	$this->addData(array("html" => $html));
		$this->loadView();  
        
    }
}
<?php

class proyeccionAdminController extends AdminController{
	
     public function __construct(Data $data) {
    	$this->_data = $data;
    	$this->cambioEdicion = true;
    	$this->imprimir = true;
    	$this->_tabla = "proyecciones";
        parent::__construct($data);
    }
    
    public function index(){
		
		$titulo = "";
	   	$descripcion = "";
	   	$hora = "00:00";
	   	$idEspacio = 0;
	   	$diaProyeccion = 0;
    	
	   if(!empty($this->_id)){
	   		$proyeccionDAO = $this->_dao->select($this->_id, $this->_tabla);
	   		$titulo = $proyeccionDAO->titulo;
	   		$descripcion = $proyeccionDAO->descripcion;
	   		$hora = $proyeccionDAO->hora;
	   		$idEspacio = $proyeccionDAO->id_espacio;
	   		$diaProyeccion = $proyeccionDAO->dia;
	   }	
	 	
    	$this->addData(array("listado" => $this->_dao->proyeccionesDAO($this->_anyo),
    						 "espacios" => $this->_dao->espaciosProyeccionDAO(),
    						 "titulo" => $titulo,
							 "descripcion" => $descripcion,
							 "hora" => $hora,
							 "idEspacio" => $idEspacio,
							 "diaProyeccion" => $diaProyeccion));
		
		$this->loadView();
    }   
    
 	public function alta(){
 		
		$campos = array("id_espacio" => $_POST['id_espacio'],
						"dia" => date('Y-m-d', $_POST['id_dia']),
						"hora" => $_POST['id_hora'].':00',
						"titulo" => $_POST['titulo'],
						"descripcion" => $_POST['descripcion'],
						"anyo" => $_POST['id_edicion']);
		
		echo $this->_dao->insertUpdate($_POST['id'], $campos, $this->_tabla);
		
    }
    

    public function imprimir(){
    	$id = $this->_id;
   		if (!empty($id)){
   			$pdf = new PDF();
   			$pdf->setEdicion($this->_data->getEdicion());
   			$pdf->AddPage();
			$pdf->SetAutoPageBreak(on, 30);
			$pdf->SetFont('Arial','B',16);
			$proyeccion = $this->_dao->proyeccionPDFDAO($id);
			$peliculas = $this->_dao->fichasPeliculaProyeccionDAO($id);
			$titulo = strftime("%A %e", strtotime($proyeccion->dia)). " ".$proyeccion->hora." ".$proyeccion->espacio;
			$pdf->proyeccion($titulo, $peliculas);
			$pdf->Output(Util::stripAccents($titulo).'.pdf', 'D');
   		}
	}
 	
    
    
}
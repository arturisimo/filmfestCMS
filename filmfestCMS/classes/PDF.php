<?php

class PDF extends PDF_HTML{
	
	private $_anchuraImagen = 50;
	private $_margin = 10;
	private $_alturaInicial = 50; 
	private $_edicion;
	
	public function Header(){
		$this->Image(BASE_URL_WEB.'/vista/skins/'.$this->_edicion->id.'/img/cabecera.jpg', 0, 0, 210, 30);
		$this->Ln(20);
	}

	public function Footer(){
	 	$this->SetFont('Arial','',23);
	 	$this->SetY(-10);
	 	$this->Cell(90,10,"un mundo muchos barrios un barrio muchos mundos",0,0,'C');
	}
	
	
	
	public function fichaPelicula($pelicula){

		if(!empty($pelicula->cartel)){
			$this->SetCol(0);
			$urlImagen = URL_IMG."peliculas/".$pelicula->muestra."/".$pelicula->cartel;
			$img = new Image($urlImagen);
			$w = $img->getWidth();
			$h = $img->getHeight();
			$ratio = $w / $this->_anchuraImagen;
			$this->Image($urlImagen, $this->_margin, $this->_alturaInicial, $this->_anchuraImagen, round($h/$ratio));
			$this->SetCol(1);
		}
		$this->SetFont('Arial','',25);
		$this->Cell(0,20,$pelicula->titulo,0,2,'L');
		$this->SetFont('Arial','',12);
		$this->Cell(0,0,$this->WriteHTML($pelicula->ficha_tecnica),0,2,'L');
		$this->Ln(10);
		$this->SetFont('Arial','',10);
		$this->Cell(0,0,$this->WriteHTML($pelicula->sinopsis),0,2,'L');
	}
	
	public function proyeccion($proyeccion, $peliculas){
		$this->SetFont('Arial','',25);
		$this->Cell(0,20,$proyeccion,0,0,'C',0,0);
		$this->Ln(20);
		
		for ($i = 0; $i < count($peliculas); $i++) {
			if(count($peliculas)==1){
				$this->fichaPelicula($peliculas[0]);
			} else {
				if ($i==0){ 
					$posicion = $this->_alturaInicial;
				}	
				$posicion = $this->fichaProyeccion($peliculas[$i], $posicion);
			}
		}
	}
	
	
	public function fichaProyeccion($pelicula, $posicion){
		$alturaImagen = 0;
		if(!empty($pelicula->cartel)){
			$this->SetCol(0);
			$urlImagen = URL_IMG."peliculas/".$pelicula->muestra."/".$pelicula->cartel;
			$img = new Image($urlImagen);
			$w = $img->getWidth();
			$h = $img->getHeight();
			$ratio = $w / $this->_anchuraImagen;
			$alturaImagen = round($h/$ratio); 
			$this->Image($urlImagen, $this->_margin, $posicion, $this->_anchuraImagen, $alturaImagen);
			$this->SetCol(1);
		}
		$this->SetFont('Arial','B',15);
		$this->Cell(0,10,$pelicula->titulo,0,2,'L');
		$this->SetFont('Arial','',12);
		$this->Cell(0,0,$this->WriteHTML(Util::recortaFicha($pelicula->ficha_tecnica)),0,2,'L');
		$this->Ln(10);
		$this->SetFont('Arial','',10);
		$this->Cell(0,0,$this->WriteHTML(Util::substring($pelicula->sinopsis,1000)),0,2,'L');
		$posicion = (($posicion + $alturaImagen) > $this->GetY() ? $posicion + $alturaImagen : $this->GetY())+10;
		$this->Ln($posicion-$this->GetY());
		return $posicion;
	}
	
	private function SetCol($col){
		$this->col=$col;
		$x = $this->_margin + $col * $this->_anchuraImagen;
		$this->SetLeftMargin($x);
		$this->SetX($x);
	}
	
	public function setEdicion($edicion){
		$this->_edicion = $edicion;
	}
}
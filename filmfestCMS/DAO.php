<?php 

class DAO extends Database{
	
	private static $_singleton;
	
	public static function getInstance(){
		if (is_null(self::$_singleton)) {
			self::$_singleton = new DAO();
		}
		return self::$_singleton;
	}
	
	public function __construct() {
	   parent::__construct();
    }
	
    /* carga pagina menu */
	public function paginaDAO($pagina, $anyo, $lang){
		
			if (empty($pagina)){ //portada
				$sql = "SELECT q. *
						FROM (
							select p.id, p.muestra, m.modulo, p.layout, p.skin, p.url, IFNULL( t.titulo, p.titulo ) titulo, IFNULL( t.texto, p.descripcion ) descripcion, t.id as id_texto, p.id_paginapadre, IFNULL( t.lang, '".DEFAULT_LANG."' ) lang, IF( t.lang = '".DEFAULT_LANG."', 2, 1 ) orden
							from pagina p
							LEFT JOIN pagina_texto pt ON p.id = pt.id_pagina, textos t,
							web_modulos m, menu mn
							where m.id=p.id_webmodulo and p.id = mn.id_pagina and pt.id_texto=t.id and mn.portada='S' and p.muestra = '$anyo' and p.alta='S' AND t.lang IN ('".DEFAULT_LANG."', '$lang')) q
							ORDER BY orden
							LIMIT 0 , 1";
			} else {
				$sql = "SELECT q. *
						FROM (
							SELECT p.id, p.muestra, 'texto' modulo, p.layout, p.skin, p.url, IFNULL( t.titulo, p.titulo ) titulo, IFNULL( t.texto, p.descripcion ) descripcion, t.id as id_texto, p.id_paginapadre, IFNULL( t.lang, '".DEFAULT_LANG."' ) lang, IF( t.lang = '".DEFAULT_LANG."', 2, 1 ) orden, p.alta
							FROM pagina p
							LEFT JOIN pagina_texto pt ON p.id = pt.id_pagina, textos t
							LEFT JOIN pagina_texto pt2 ON t.id = pt2.id_texto
							WHERE pt.id_pagina = pt2.id_pagina
							AND pt.id_texto = pt2.id_texto
							AND t.lang IN ('".DEFAULT_LANG."', '$lang')
							UNION
							SELECT p.id, p.muestra, m.modulo, p.layout, p.skin, p.url, p.titulo, p.descripcion, 0, p.id_paginapadre, '".DEFAULT_LANG."' lang, 3 orden, p.alta
							FROM pagina p, web_modulos m
						WHERE m.id = p.id_webmodulo	) q
						WHERE url = '$pagina' and muestra = '$anyo' and alta = 'S'
						ORDER BY orden
						LIMIT 0 , 1";
			}
			
			return parent::selectQuery($sql, false, __FUNCTION__.$pagina.$anyo.$lang);
	}
	public function paginaUnicaDAO($controller, $id, $anyo){
		$sql = "";	
		if ($controller=='pelicula'){
			$sql = "select titulo, sinopsis as descripcion, muestra as anyo, 'pelicula.phtml' as layout, id_proyeccion from peliculas where id='$id'";
		} else if($controller=='proyecciones'){
			$msg = _('Proyecciones ');
			$where = ''; 
			if($id>0){
				$msg .= strftime("%A %e %B", strtotime(substr($id,0,2)."-".substr ($id,2,2)."-".substr ($id,4,4)));
				$where = "where DATE_FORMAT(dia, '%d%m%Y') ='$id'";
			}else{
				$msg .= $anyo;
				$where = "where anyo ='$anyo'";
			}
			$sql = "select '$msg' as titulo , '$msg' as descripcion, anyo, '2columnas.phtml' as layout, 1 id_proyeccion from proyecciones $where";
		}
		if(!empty($sql)){
			return parent::selectQuery($sql, false, __FUNCTION__.$controller.$id.$anyo);
		} else {
			return null;
		}
	}
	
	/* ediciones */ 
	public function edicionDAO($id){
		return parent::selectQuery("select id, nombre, descripcion, cartel, fecha_inicio, fecha_fin from ediciones where id='$id'", false, __FUNCTION__.$id);
	}
	public function edicionesDAO(){
		return parent::selectQuery("select id, nombre, descripcion, cartel, DATE_FORMAT(fecha_inicio, '%d/%c') as inicio, DATE_FORMAT(fecha_fin, '%d/%c') as fin from ediciones where alta='S' order by fecha_inicio asc", true, __FUNCTION__);
	}
	
	/* autoproducciones */
	public function convocatoriaDAO($anyo){
		return parent::selectQuery("select e.id, e.nombre, DATE_FORMAT(e.fecha_inicio, '%d/%c') as inicio, DATE_FORMAT(e.fecha_fin, '%d/%c') as fin, c.url, c.cartel, c.descripcion from convocatorias c, ediciones e where e.id=c.id and c.alta='S' and c.id='$anyo' order by e.id desc", true, __FUNCTION__.$anyo);
	}
	public function convocatoriasDAO(){
		return parent::selectQuery("select e.id, e.nombre, DATE_FORMAT(e.fecha_inicio, '%d/%c') as inicio, DATE_FORMAT(e.fecha_fin, '%d/%c') as fin, c.url, c.cartel, c.descripcion from convocatorias c, ediciones e where e.id=c.id and c.alta='S' order by e.id desc", true, __FUNCTION__); 
	}
	
	/* menu */
	public function menuDAO($anyo){
		return parent::selectQuery("select p.id, p.url, m.nombre, p.id_paginapadre as modulo_padre, m.portada, p.descripcion from pagina p, menu m where p.id=m.id_pagina and p.alta='S' and p.muestra='$anyo' and id_paginapadre=0 order by m.orden", true, __FUNCTION__.$anyo);
	}
	public function submenuDAO($idPaginaPadre){
		return parent::selectQuery("select p.id, p.url, m.nombre, m.orden as orden, p.id_paginapadre as modulo_padre, m.portada, p.descripcion from pagina p, menu m where p.id=m.id_pagina and p.alta='S' and p.id_paginapadre=$idPaginaPadre order by m.orden", true, __FUNCTION__.$idPaginaPadre);
	}
	
	/*mail confirmacion */
	public function datosContactoDAO($idPelicula){
		return parent::selectQuery("select * from autores where id_pelicula=$idPelicula", false, __FUNCTION__.$idPelicula); 	   		
	}
    
	/* material inscrito */
	public function numeroAutoproduccionesDAO($anyo){
		return parent::selectCount("select p.id from peliculas p, convocatoria c where p.id=c.id_pelicula and p.muestra='$anyo' and c.alta='S'", __FUNCTION__.$anyo);
	}
    	public function listadoAutoproduccionesDAO($anyo, $inicio, $total){
			$sql = "select p.titulo, c.id, c.duracion, c.anyo, c.genero, c.pais, l.id as id_licencia, l.nombre as nombre_licencia, c.autor, p.sinopsis, c.fecha_alta, p.enlace as video,
						    IF(i.imagen is null, '".URL_IMG."gris.jpg', concat('".URL_IMG."peliculas/$anyo/tn/', i.imagen)) as cartel
							from peliculas p LEFT JOIN imagenes_pelicula i ON p.id = i.id_pelicula, convocatoria c, licencias l 
						    where p.id=c.id_pelicula and p.licencia = l.id and p.muestra='$anyo' and c.alta='S' order by p.id desc LIMIT $inicio, $total";
			return parent::selectQuery($sql, true, __FUNCTION__.$anyo.$inicio.$total);
	}
	
	/* material seleccionado */
	public function seleccionDAO($anyo){
			$sql = "select p.id, p.titulo, c.autor, p.muestra, 
							IF(i.imagen is null, '".URL_IMG."gris.jpg', concat('".URL_IMG."peliculas/$anyo/md/', i.imagen)) as cartel 
							from peliculas p LEFT JOIN imagenes_pelicula i ON p.id = i.id_pelicula, convocatoria c 
							where p.id=c.id_pelicula and p.muestra='$anyo' and p.id_proyeccion > 0";
			return parent::selectQuery($sql, true, __FUNCTION__.$anyo);
	}
	public function textoSeleccionDAO($id){ 
		return parent::selectQuery("select id_texto from convocatorias where id='$id'", false,__FUNCTION__.$id); 
	}

	/* texto */
	public function textoDAO($id){
		return parent::selectQuery("select * from textos where id=$id", false, __FUNCTION__.$id);
	}
	
	/* espacios */
	public function espaciosDAO($anyo){
		return parent::selectQuery("select * from espacios where id in (select id_espacio from proyecciones where anyo='$anyo')", true, __FUNCTION__.$anyo);
	}
	
	/* img y video */
	public function escaparateDAO(){
		return parent::selectQuery("select * from galerias g, imagenes i where g.id = i.id_galeria and g.alta='S' and i.alta='S' order by g.id", true, __FUNCTION__); 
	}
	
	/* img para textos */
	public function imagenesDAO($idGaleria){ 
		return parent::selectQuery("select i.*, g.galeria from imagenes i, galerias g where i.id_galeria=g.id and i.id_galeria=$idGaleria order by i.id", true, __FUNCTION__.$idGaleria);
	}
	
	/* proyecciones */
	public function proyeccionesDAO($diaProyeccion, $anyo){
		$sql = "select pr.titulo, pr.dia, TIME_FORMAT(pr.hora,'%H:%i') as hora, e.espacio, e.direccion, e.id as id_espacio, pr.id as id_proyeccion from espacios e, proyecciones pr where e.id=pr.id_espacio";
		if(empty($diaProyeccion)){
			$sql .= " and pr.anyo = '$anyo' order by pr.dia, pr.hora";
		} else {
			$sql .= " and DATE_FORMAT(pr.dia, '%d%m%Y') = '$diaProyeccion' order by pr.hora";
		}
		
	    return parent::selectQuery($sql, true, __FUNCTION__.$diaProyeccion.$anyo);
	}
	public function proyeccionesPorDiaDAO($id){
		return parent::selectQuery("select pr.id as id_proyeccion, pr.titulo, TIME_FORMAT(pr.hora,'%H:%i') as hora, e.espacio from espacios e, proyecciones pr where e.id=pr.id_espacio and pr.dia = '$id' and pr.alta='S' order by pr.hora", true, __FUNCTION__.$id); 
	}
	public function peliculasProyeccionesDAO($id){
		return parent::selectQuery("select p.id, p.titulo, p.ficha_tecnica, p.sinopsis, i.imagen as cartel 
						    from peliculas p LEFT JOIN imagenes_pelicula i
							ON p.id = i.id_pelicula 
						    where p.id_proyeccion=$id order by p.id asc", true,__FUNCTION__.$id); 	
	}
	
	/* pelicula */
	public function peliculaDAO($id){
		return parent::selectQuery("select * from peliculas where id=$id", false, __FUNCTION__.$id);   
	}
	
	public function fichaPeliculaDAO($id){
		return parent::selectQuery("SELECT p.* , i.imagen AS cartel, d.web AS web_donante, d.donante, d.logo AS logo_donante, l.nombre AS nombre_licencia, l.url AS url_licencia
							FROM peliculas p LEFT JOIN imagenes_pelicula i ON p.id = i.id_pelicula, 
							peliculas pe LEFT JOIN donantes d ON pe.id_donante = d.id, licencias l
							WHERE p.id = pe.id
							AND p.licencia = l.id and p.id=$id", false, __FUNCTION__.$id);
	}
	
	
	/* descargas */
	public function documentosDAO($anyo){
		return parent::selectQuery("select * from docs where id>0 and muestra='$anyo' and alta='S'", true, __FUNCTION__.$anyo); 
	}
	
	//langs
	public function langsEdicionDAO($anyo){
		return parent::selectQuery("select l.* from langs l, lang_edicion e where l.lang=e.lang and id_edicion='$anyo'", true, __FUNCTION__.$anyo); 
	}
	

}
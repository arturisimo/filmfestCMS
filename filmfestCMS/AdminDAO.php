<?php 

class AdminDAO extends Database{
	
	private static $_singleton;
	
	public static function getInstance(){
		if (is_null(self::$_singleton)) {
			self::$_singleton = new AdminDAO();
		}
		return self::$_singleton;
	}
	
	public function __construct() {
	   parent::__construct();
    }
	
    /* validacion */
	public function validaDAO($nombre){
		$sql = sprintf("SELECT u.id, pass, u.usuario, u.nivel_acceso, pa.nivel, pa.descripcion, u.email, am.modulo FROM usuarios u, perfil_acceso pa, admin_modulos am WHERE u.usuario='%s' and u.nivel_acceso=pa.nivel and pa.id_modulodefault=am.id", parent::sanitize($nombre));
		return parent::selectQuery($sql);
	}
	  
    /* menu */
    public function menuDAO($nivelAcceso){
    	return parent::selectQuery("SELECT id, modulo, nombre, nivel_acceso, descripcion, modulo_padre, modulo as url, 'N' as portada FROM admin_modulos WHERE nivel_acceso=$nivelAcceso and modulo_padre=0 and alta='S'", true);
	}
	
    public function submenuDAO($moduloMenu){
    	return parent::selectQuery("SELECT id, modulo, nombre, nivel_acceso, descripcion, modulo_padre, modulo as url, 'N' as portada FROM admin_modulos WHERE modulo_padre=$moduloMenu and alta='S'", true);
	}
     
    /*usuario*/
	public function usuariosDAO(){
		return parent::selectQuery("select u.id, concat(u.usuario, ' - ' , pa.descripcion) as titulo, u.alta from usuarios u, perfil_acceso pa where u.nivel_acceso=pa.nivel order by pa.nivel", true);
	}
	public function nivelesAccesoDAO(){
		return parent::selectQuery("select id, concat(nombre, ' - ',descripcion) as titulo, alta from perfil_acceso order by nivel", true);
	}
	public function nivelesNavegacionDAO(){
		return parent::selectQuery("select nivel id, nombre as titulo from perfil_acceso where alta='S' order by nivel", true);
	}
	public function perfilesAccesoDAO($nivel){
		return parent::selectQuery("select pa.*, am.modulo, pa.logo from admin_modulos am, perfil_acceso pa where am.id=pa.id_modulodefault and pa.alta='S' and pa.nivel >= $nivel order by nivel", true);
	}
	
	/* modulos */
	public function adminModulosDAO(){ 
		return parent::selectQuery("select am.id, concat(am.nombre, ' - ', am.descripcion, ' - ', pa.nombre) as titulo, am.alta from admin_modulos am, perfil_acceso pa where am.nivel_acceso=pa.id order by pa.nivel", true);
	}
	public function adminModuloNombreDAO($modulo, $id_nivelacceso){
		return parent::selectQuery("select * from admin_modulos where modulo='$modulo' and nivel_acceso>=$id_nivelacceso");
	}
  	public function adminModuloDefaultDAO($id_nivelacceso){
		return parent::selectQuery("SELECT am.* FROM admin_modulos am, perfil_acceso pa WHERE am.id = pa.id_modulodefault and pa.nivel=$id_nivelacceso");
    }
	public function modulosNivelAccesoDAO($nivelAcceso){ 
		$sql = "select id, nombre as titulo from admin_modulos where alta='S'";
		if ($nivelAcceso>0){
			$sql .= " and nivel_acceso=$nivelAcceso";
		}
		return parent::selectQuery($sql, true);
	}
	/*
	public function numAdminModulo($modulo){ 
		return parent::selectCount("select * from admin_modulos where modulo='$modulo'");
	}
	*/
	public function modulosPadreDAO($id, $nivelAcceso){ 
		$sql = "select id, nombre as titulo from admin_modulos where alta='S'";
		if(!empty($id)){
			$sql .= " and id<>$id";
		}
		$sql .= " and nivel_acceso=$nivelAcceso";
		return parent::selectQuery($sql, true);
	}
	
	public function webModulosDAO($alta){
		$sql = "select id, concat(modulo, ' - ', descripcion)titulo, alta from web_modulos";
		if($alta){
			$sql = "select id, modulo as titulo, alta from web_modulos where alta='S'";
		}
		$sql .= " order by id";
		return parent::selectQuery($sql, true);
	}
	
	/* edicion muestras */
	public function edicionesDAO(){ 
		return parent::selectQuery("select id, nombre as titulo, alta, cartel from ediciones order by id", true);
	}
	
	/* convocatorias */
	public function convocatoriaDAO($anyo){
		return parent::selectQuery("select e.id, e.nombre, DATE_FORMAT(e.fecha_inicio, '%d/%c') as inicio, DATE_FORMAT(e.fecha_fin, '%d/%c') as fin, c.url, c.cartel, c.descripcion, c.id_texto from convocatorias c, ediciones e where e.id=c.id and c.id='$anyo' order by e.id desc");
	}
	public function convocatoriasDAO(){
		return parent::selectQuery("select e.id, e.nombre as titulo, c.alta from convocatorias c, ediciones e where e.id=c.id", true);
	}
	
	/* paginas web */
	public function paginasDAO($anyo){ 
		return parent::selectQuery("select p.id, p.url as titulo, p.alta from pagina p where p.muestra='$anyo' order by p.alta desc, p.url", true);
	}
	public function urlPaginasDAO($anyo){ 
		return parent::selectQuery("select url as id, url as titulo from pagina where muestra='$anyo' order by url", true);
	}
	public function webMenuDAO($id){ 
		return parent::selectQuery("select * from menu where id_pagina=$id");
	}
	public function paginasPadreDAO($id, $anyo){
		$sql = "select id, url as titulo from pagina where muestra='$anyo' and alta='S'";
	  	if(!empty($id)){
			$sql .= " and id<>$id";
		}
		return parent::selectQuery($sql, true);
	}
	
	/* textos */ 
	public function textosDAO($anyo, $alta){
		$sql = "select * from textos where muestra='$anyo'";
		if($alta){
			$sql .= " and alta='S'";
		}
		$sql .= " order by titulo";
		return parent::selectQuery($sql, true);
	}

	public function textosPosiblesPaginaDAO($anyo){ 
		return parent::selectQuery("select * from textos where alta='S' and muestra='$anyo' and id not in (select id_texto from pagina_texto) order by titulo", true);
	}
	public function textosPaginaDAO($idPagina){ 
		return parent::selectQuery("select * from textos t, pagina_texto pt where t.id=pt.id_texto and pt.id_pagina=$idPagina and t.alta='S' order by titulo", true);
	}
	
	
    /* agradecimientos */
	public function agradecimientosDAO(){ 
		return parent::selectQuery("select id, donante as titulo, alta from donantes where id>0 order by donante", true); 
	}
	
	/* espacios de proyeccion */
	public function espaciosDAO(){ 
		return parent::selectQuery("select id, espacio as titulo, alta from espacios where id>0 order by lower(espacio)", true);
	}

	/* documentos descarga */
	public function documentosDAO($anyo){ 
		return parent::selectQuery("select id, archivo as titulo, alta from docs where id>0 and muestra='$anyo'", true);
	}

	/* imagen y galerias */
	public function imagenesDAO(){ 
		return parent::selectQuery("select i.id as id, concat(i.descripcion, ' / ', g.galeria) as titulo, i.alta as alta from imagenes i, galerias g where i.id_galeria=g.id order by g.id", true);
	}
	public function galeriasDAO($alta=null){ 
		$sql = "select * from galerias";
		if ($alta){
			$sql .= " where alta='S'";
		}
		return parent::selectQuery($sql, true);
	}
	public function imagenDAO($id){ 
		return parent::selectQuery("select i.*, g.galeria from imagenes i, galerias g where i.id_galeria=g.id and i.id=$id");
	}
	
	/* pelicula */
	public function peliculasDAO($anyo){ 
		return parent::selectQuery("select id, titulo, alta from peliculas where muestra ='$anyo' and id not in (select id from convocatoria) order by titulo", true);
	}
	public function proyeccionesPeliculaDAO($anyo){
		return parent::selectQuery("select pr.id, concat(DATE_FORMAT(pr.dia, '%d/%c/%Y'),' ',TIME_FORMAT(pr.hora,'%H:%i'),' ', e.espacio) as titulo from espacios e, proyecciones pr where e.id=pr.id_espacio and pr.anyo='$anyo' and pr.alta='S' order by pr.dia, pr.hora", true);
	}
	public function proyeccionPDFDAO($id){
		return parent::selectQuery("select DATE_FORMAT(pr.dia, '%d-%c-%Y') as dia, TIME_FORMAT(pr.hora,'%H:%i') as hora, e.espacio from espacios e, proyecciones pr where e.id=pr.id_espacio and pr.id=$id");
	}
	public function agradecimientosPeliculaDAO(){ 
		return parent::selectQuery("select id, donante as titulo from donantes where alta='S' and id>0 order by donante", true);
	}
	public function fichaPeliculaDAO($id){
		return parent::selectQuery("SELECT p.*, l.id as id_licencia, l.nombre AS nombre_licencia, a.autor as nombre_contacto, a.email, a.telefono,
							i.id as id_imagen, i.imagen AS cartel, IF(i.imagen is null, 'upload-img', '') as class_upload, p.muestra
							FROM peliculas p LEFT JOIN imagenes_pelicula i ON p.id = i.id_pelicula,
							peliculas pe LEFT JOIN autores a ON pe.id = a.id_pelicula, licencias l
							WHERE p.id = pe.id 
							AND p.licencia = l.id 
							AND p.id=$id");
	}
	public function fichaPeliculaConvocatoriaDAO($id){
		return parent::selectQuery("SELECT p.*, l.nombre AS nombre_licencia, a.autor as nombre_contacto, a.email, a.telefono,
							i.id as id_imagen, i.imagen AS cartel, IF(i.imagen is null, 'upload-img', '') as class_upload,
							c.recursos, c.comentarios, c.coste, p.material_propio
							FROM peliculas p LEFT JOIN imagenes_pelicula i ON p.id = i.id_pelicula,
							peliculas pe LEFT JOIN autores a ON pe.id = a.id_pelicula, convocatoria c, licencias l
							WHERE p.id = pe.id 
							AND p.id= c.id
							AND p.licencia = l.id 
							AND p.id=$id");
	}
	
	public function fichasPeliculaProyeccionDAO($idProyeccion){
		return parent::selectQuery("SELECT p.*, l.nombre AS nombre_licencia, a.autor as nombre_contacto, a.email, a.telefono,
							i.id as id_imagen, i.imagen AS cartel, IF(i.imagen is null, 'upload-img', '') as class_upload, p.muestra
							FROM peliculas p LEFT JOIN imagenes_pelicula i ON p.id = i.id_pelicula,
							peliculas pe LEFT JOIN autores a ON pe.id = a.id_pelicula, licencias l
							WHERE p.id = pe.id 
							AND p.licencia = l.id 
							AND p.id_proyeccion=$idProyeccion", true);
	}
	public function licenciasDAO(){
		return parent::selectQuery("select id, nombre as titulo, alta from licencias where alta='S'", true);
	}
	public function peliculasConvocatoriaDAO($anyo){ 
		return parent::selectQuery("select c.id, p.titulo, c.alta from peliculas p, convocatoria c where p.id=c.id_pelicula and p.muestra ='$anyo' order by id", true); 
	}	
	public function imgPeliculaDAO($idPelicula){ 
		return parent::selectQuery("select * from imagenes_pelicula where id_pelicula=$idPelicula");
	}
	
	/* proyecciones */
	public function proyeccionesDAO($anyo){
		return parent::selectQuery("select pr.id as id, CONCAT(DATE_FORMAT(pr.dia, '%d/%c'),' ',TIME_FORMAT(pr.hora,'%H:%i'),' ',e.espacio) as titulo, pr.alta from espacios e, proyecciones pr where e.id=pr.id_espacio and pr.anyo='$anyo' and pr.id > 0 order by pr.dia, pr.hora", true);
	}
	public function espaciosProyeccionDAO(){ 
		return parent::selectQuery("select id, espacio as titulo from espacios where id > 0 and alta='S' order by espacio", true);
	}	
	public function proyeccionDAO($id){	
		return parent::selectQuery("select pr.id, pr.id_espacio, e.espacio, pr.dia, TIME_FORMAT(pr.hora,'%H:%i') as hora, pr.titulo, pr.descripcion from espacios e, proyecciones pr where e.id=pr.id_espacio and pr.id=$id");
	}
	
	/* idiomas */
	public function langsDAO(){
		return parent::selectQuery("select id, nombre as titulo, alta from langs", true);
	}
	public function langDAO($lang){
		return parent::selectQuery("select * from langs where lang='$lang'", true);
	}
	public function langsEdicionDAO($anyo){
		return parent::selectQuery("select l.lang id, l.nombre titulo from langs l, lang_edicion e where l.lang=e.lang and id_edicion='$anyo'", true);
	}
	public function langsDisponiblesEdicionDAO($anyo){
		return parent::selectQuery("select l.lang id, l.nombre titulo from langs l where l.lang not in (select lang from lang_edicion where id_edicion='$anyo')", true);
	}
    
    public function deleteTextoPagina($idPagina){
    	return parent::deleteQuery("delete from pagina_texto where id_pagina=$idPagina");
	}
    public function deleteMenu($idPagina){
    	return parent::deleteQuery("delete from menu where id_pagina=$idPagina");
    }
    public function deleteLangEdicion($edicion){
    	return parent::deleteQuery("delete from lang_edicion where id_edicion='$edicion'");
	}
    public function deleteImagenPelicula($id){
    	return parent::deleteQuery("delete from imagenes_pelicula where id_pelicula=$id");
	}
	
}
/*	variables globales	*/
var goMsg = {};

/*	funciones globales	*/
function ocultar(poElemento){Element.addClassName(poElemento, 'oculto');}
function mostrar(poElemento){Element.removeClassName(poElemento, 'oculto');}
function activar(poElemento){Element.addClassName(poElemento, 'activo');}
function desactivar(poElemento){Element.removeClassName(poElemento, 'activo');}
function mouseover(poElemento){Element.addClassName(poElemento, 'hover');}
function mouseout(poElemento){Element.removeClassName(poElemento, 'hover');}

//objeto ajax
function nuevoAjax(){
	var xmlhttp=false;
 	try {
 		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
 	} catch (e) {
 		try {
 			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
 		} catch (E) {
 			xmlhttp = false;
 		}
  	}

	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
 		xmlhttp = new XMLHttpRequest();
	}
	return xmlhttp;
}

function cargarContacto(){
	ajax=nuevoAjax(); 
	ajax.open("POST", "/inscripcion/contacto",true);
	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			$('resumen-contacto').innerHTML = ajax.responseText;
			goMsgConfirmacion.mostrar();
			if (ajax.status === 200){ 
				ocultar($('div-contacto'));
				mostrar($('div-pelicula'));
			}
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_nombre=" + escape($F('id_nombre')) + "&id_email=" + $F('id_email') +"&id_telefono=" + $F('id_telefono') + "&id_tipocontacto=" + $F('id_tipocontacto'));
}

function cargarPelicula(){
	ajax=nuevoAjax();

	ajax.open("POST", "/inscripcion/pelicula",true);
	
	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
				$('resumen-pelicula').innerHTML = ajax.responseText;
				goMsgConfirmacion.mostrar();
				if (ajax.status === 200){ 
					ocultar($('div-pelicula'));
					mostrar($('div-adicional'));
				}
		}
	}
	
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	//se eliminan valores por defecto
	if ($('id_web').value=='http://') $('id_web').value=''; 
	if ($('id_minutos').value!='') $('id_minutos').value=$('id_minutos').value+"'";
	if ($('id_segundos').value!='') $('id_segundos').value=$('id_segundos').value+"''";
			
	ajax.send("id_titulo="+escape($F('id_titulo')) + "&id_autor=" + escape($F('id_autor')) + 
			  "&id_duracion=" + $('id_minutos').value + $('id_segundos').value +"&id_anyo=" + $F('id_anyo') + "&id_genero=" + escape($F('id_genero')) + "&id_pais=" + escape($F('id_pais')) + "&id_web=" + $F('id_web') + "&id_sinopsis=" + escape($F('id_sinopsis')) +  "&id_tecnica=" + escape($F('id_tecnica')));

}

function cargarAdicional(){
	ajax=nuevoAjax();

	ajax.open("POST",  "/inscripcion/adicional",true);

	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			$('resumen-adicional').innerHTML = ajax.responseText;
			goMsgConfirmacion.mostrar();
			if (ajax.status === 200){
				ocultar($('div-adicional'));
				mostrar($('div-licencia'));
			}
		}
	}
	
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_coste=" + $F('id_coste') +  "&id_recursos=" + escape($F('id_recursos')) + "&id_comentarios=" + escape($F('id_comentarios')));
}

function cargarLicencia(licencia){
	ajax=nuevoAjax();

	ajax.open("POST",  "/inscripcion/licencia",true);

	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			$('resumen-licencia').innerHTML = ajax.responseText;
			goMsgConfirmacion.mostrar();
			if (ajax.status === 200){
				ocultar($('div-licencia'));
				mostrar($('div-multimedia'));
			}
		}
	}
	
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_licencia=" + licencia);
}

function multimedia(){
	ajax=nuevoAjax();
	ajax.open("POST",  "/inscripcion/multimedia",true);
	if ($('id_video').value=='http://') $('id_video').value='';
	if ($('id_videodescarga').value=='http://') $('id_videodescarga').value=''; 
	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			$('div-confirmacion').innerHTML = ajax.responseText;
			goMsgConfirmacion.mostrar();
			ocultar($('div-multimedia'));
			ocultar($('resumen'));
			mostrar($('div-confirmacion'));
			//setTimeout("window.location='inscripcion'", 3000); 
		}
	}	
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_video="+$F('id_video')+ "&id_videodescarga=" + $F('id_videodescarga'));
}

/*	funcion de inicio	*/	
/*	-	_onLoad()
		siempre se carga en el evento onload	*/
Event.observe(window, 'load', _onLoad, false);

function _onLoad(){
	
	$$('div#div-licencia img').each(function(element) {
		Event.observe(element, 'click', function(e){
			var licencia = element.id.split('_');
			$('lic_'+licencia[1]).checked = true;
		});
	});	
	
	//	objeto Msg
	goMsg = new Msg($('msg'));
	goMsgConfirmacion = new Msg($('msg-confirmacion'));
	
	//alta de la pelicula
	Event.observe('b-contacto', 'click', function(e){
		
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if ($('id_nombre').value == '') {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nombre);
			}
			else {
				Element.removeClassName($('id_nombre'), 'errorLabel');
			}
			if (!esNumero($('id_telefono').value)) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_telefono'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_telefono);
			}
			else {
				Element.removeClassName($('id_telefono'), 'errorLabel');
			}
			if ($('id_email').value == '' || !validarEmail($('id_email').value)) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_email'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_email);
			}
			else {
				Element.removeClassName($('id_email'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', gcMsg_revisa);
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				cargarContacto();
				window.scrollTo(0,0);
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);	
	
	//alta de la pelicula
	Event.observe('b-pelicula', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if ($('id_titulo').value == '') {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_titulo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_titulo);				
			}
			else {
				Element.removeClassName($('id_titulo'), 'errorLabel');
			}
			
			if ($('id_autor').value == '') {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_autor'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_director);
			}
			else {
				Element.removeClassName($('id_autor'), 'errorLabel');
			}
			if ($('id_anyo').value == '' || !esNumero($('id_anyo').value)) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_anyo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_ano);
			}
			else {
				Element.removeClassName($('id_anyo'), 'errorLabel');
			}			
			if (($('id_minutos').value == ''||!esNumero($('id_minutos').value)) && ($('id_segundos').value == ''||!esNumero($('id_segundos').value))){
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_minutos'), 'errorLabel');
				Element.addClassName($('id_segundos'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_duracion);
			}
			else {
				Element.removeClassName($('id_minutos'), 'errorLabel');
				Element.removeClassName($('id_segundos'), 'errorLabel');
			}
			if ($('id_sinopsis').value == '') {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_sinopsis'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_sinopsis);
			}
			else {
				Element.removeClassName($('id_sinopsis'), 'errorLabel');
			}
			if ($('id_tecnica').value == '') {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_tecnica'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_tecnica);
			}
			else {
				Element.removeClassName($('id_tecnica'), 'errorLabel');
			}
			if ($('id_web').value!= 'http://' && !esUrl($('id_web').value)) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_web'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_web);
			}
			else {
				Element.removeClassName($('id_web'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', gcMsg_revisa);
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				cargarPelicula();
				window.scrollTo(0,0);
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);
	
	//alta de la pelicula
	Event.observe('b-adicional', 'click', function(e){
			goMsg.ocultar();
			cargarAdicional();
			window.scrollTo(0,0);
			Event.stop(e);
		}, false);
	
	
		//alta de la pelicula
	Event.observe('b-licencia', 'click', function(e){
			
			var bCorrecto = true;
			
			goMsg.limpiar();
			goMsg.ocultar();

		
			var licenciachecked = Form.getInputs('form-pelicula','radio', 'licencias').find(function(radio){ return radio.checked; });
			
			if (licenciachecked==undefined) {
				bCorrecto = false;
				goMsg.nuevo('em', 'msg-info', gcMsg_licencia);
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				cargarLicencia(licenciachecked.value);
				window.scrollTo(0,0);
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);
	
	
	//boton de imprimir	
	Event.observe('b-multimedia', 'click', function(e){
			goMsgConfirmacion.ocultar();
			
			var bCorrecto = true;
			goMsg.limpiar();
			goMsg.ocultar();
			
			if ($('id_video').value == 'http://' || $('id_video').value == '') {
				bCorrecto = false;
				Element.addClassName($('id_video'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_videovacio);
			}
			else if (!esUrl($('id_video').value)) {
				bCorrecto = false;
				Element.addClassName($('id_video'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_video);
			}
			else {
				Element.removeClassName($('id_video'), 'errorLabel');
			}
			if (bCorrecto) {
				goMsg.ocultar();
				multimedia();
			}
			else {
				goMsg.mostrar();
			}
			
			Event.stop(e);
	});
	
	//boton de imagen
	Event.observe('imagen', 'change', function(e){
			$('b-multimedia').disabled = true;
			$('form_imagen').submit();
			goMsgConfirmacion.ocultar();
			mostrar($('div-cargando'));
			ocultar($('form_imagen'));
			mostrar($('frame_imagen'));
			$('b-multimedia').disabled = false;
			return false;
	}, false);
	

	Event.observe('resumen-pelicula', 'click', function(e){
		mostrar($('div-pelicula'));
		ocultar($('div-contacto'));
		ocultar($('div-adicional'));
		ocultar($('div-licencia'));
		ocultar($('div-multimedia'));
	}, false);
	
	Event.observe('resumen-contacto', 'click', function(e){
		mostrar($('div-contacto'));
		ocultar($('div-pelicula'));
		ocultar($('div-adicional'));
		ocultar($('div-licencia'));
		ocultar($('div-multimedia'));
	}, false);
	
	
	//se elimina clase de error de los campos 
	Event.observe('id_titulo', 'click', function(e){
			Element.removeClassName($('id_titulo'), 'errorLabel');
			return false;
	}, false);		
	Event.observe('id_nombre', 'click', function(e){
		Element.removeClassName($('id_nombre'), 'errorLabel');
		return false;
	}, false);
	Event.observe('id_email', 'click', function(e){
		Element.removeClassName($('id_email'), 'errorLabel');
		return false;
	}, false);
	Event.observe('id_telefono', 'click', function(e){
		Element.removeClassName($('id_telefono'), 'errorLabel');
		return false;
	}, false);		
	Event.observe('id_autor', 'click', function(e){
		Element.removeClassName($('id_autor'), 'errorLabel');
		return false;
	}, false);		
	Event.observe('id_anyo', 'click', function(e){
		Element.removeClassName($('id_anyo'), 'errorLabel');
		return false;
	}, false);		
	Event.observe('id_minutos', 'click', function(e){
		Element.removeClassName($('id_minutos'), 'errorLabel');
		Element.removeClassName($('id_segundos'), 'errorLabel');
		return false;
	}, false);
	Event.observe('id_segundos', 'click', function(e){
		Element.removeClassName($('id_minutos'), 'errorLabel');
		Element.removeClassName($('id_segundos'), 'errorLabel');
		return false;
	}, false);		
	Event.observe('id_web', 'click', function(e){
		Element.removeClassName($('id_web'), 'errorLabel');
		return false;
	}, false);
	Event.observe('id_video', 'click', function(e){
		Element.removeClassName($('id_video'), 'errorLabel');
		return false;
	}, false);		
	Event.observe('id_sinopsis', 'click', function(e){
		Element.removeClassName($('id_sinopsis'), 'errorLabel');
		return false;
	}, false);		
	Event.observe('id_tecnica', 'click', function(e){
		Element.removeClassName($('id_tecnica'), 'errorLabel');
		return false;
	}, false);
}

//-------------------------INICIO OBJETO Msg------------------------//
var Msg = Class.create();

Msg.prototype = {
	initialize: function(poElemento){
		//	funcion de inicio, se ejecuta al crear la instancia de la clase
		this.id = poElemento.id;
	},
	limpiar: function(){
		var aoMsg = $(this.id).childNodes;
		var iMax = aoMsg.length;
		
		for (var i = 0; i < iMax; i++){
			Element.remove(aoMsg[0]);
		}	
	},
	nuevo: function(pcTagName, pcClassName, pcInnerHTML, pcPosition){
		var cHTML = '<' + pcTagName + ' class="' + pcClassName + '">' + pcInnerHTML + '</' + pcTagName + '>';
		
		switch(pcPosition){
			case 'After':new Insertion.After($(this.id), cHTML);break;
			case 'Before':new Insertion.Before($(this.id), cHTML);break;
			case 'Bottom':new Insertion.Bottom($(this.id), cHTML);break;
			case 'Top':new Insertion.Top($(this.id), cHTML);break;
			default:new Insertion.Top($(this.id), cHTML);
		}
	},
	mover: function(poElemento, pcPosition){
		var oMsg = $(this.id).cloneNode(true);
		var cHTML = '';
		
		oMsg.id = this.id + '-proxy';
		cHTML = '<div id="' + this.id + '" class="' + oMsg.className + '">' + oMsg.innerHTML + '</div>';
		Element.remove(this.id);
		oMsg.id = this.id;
		
		switch(pcPosition){
			case 'After':new Insertion.After(poElemento, cHTML);break;
			case 'Before':new Insertion.Before(poElemento, cHTML);break;
			case 'Bottom':new Insertion.Bottom(poElemento, cHTML);break;
			case 'Top':new Insertion.Top(poElemento, cHTML);break;
			default:new Insertion.Top(poElemento, cHTML);
		}	
	},
	
	ocultar: function(){Element.addClassName($(this.id), 'oculto');},
	mostrar: function(){Element.removeClassName($(this.id), 'oculto');}
}
//-------------------------FIN OBJETO Msg------------------------//
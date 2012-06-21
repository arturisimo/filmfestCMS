/**
 *  funciones globales
 */
function validarEmail(pcTexto){
	return (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(pcTexto));
}
function esNumero(numero){
	if (!numero) return true;
	urlRegExp = /^[0-9]+$/;
	return urlRegExp.test(numero);
}
function esUrl(texto){
	if (!texto) return true;
	urlRegExp = /^(((ht|f)tp(s?))\:\/\/)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?$/;
	return urlRegExp.test(texto);
}
function isVacio(texto){
	return !/\S/.test(texto);
}

function ocultar(poElemento){
	Element.addClassName(poElemento, 'oculto');
}
function mostrar(poElemento){
	Element.removeClassName(poElemento, 'oculto');
}

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

function feedback(respuesta){
	var feedback = "<p class='ko'>" + gcMsg_ko + "</p>";
	if (respuesta=='ok'){
		feedback = "<p class='ok'>" + gcMsg_ok + "</p>";
	}
	return feedback; 
}

function controlHttp($url){
	if ($url=='http://'){
		$url='';
	}
	return $url;
}

function alta(controller, datos){
	ajax=nuevoAjax();
	ajax.open("POST", urlAdmin + controller + '/alta', true);
	
	ajax.onreadystatechange=function() {
		if (ajax.readyState == 4) {
			$('msg').innerHTML = feedback(ajax.responseText);
			setTimeout("window.location='" + urlAdmin + controller + "'", 2000);
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send(datos);
}

function eliminar(controller, id){
	ajax=nuevoAjax();
	ajax.open("POST", urlAdmin + controller + "/delete",true);
	ajax.onreadystatechange=function() {
		if (ajax.readyState == 4) {
			$('msg').innerHTML = feedback(ajax.responseText);
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id="+ id);
	setTimeout("window.location='" + urlAdmin + controller +"'", 2000);
}

/**
 * funciones para carga de valores por ajax
 */
//carga de galerias 
function loadGaleria(id){
	ajax=nuevoAjax();
	ajax.open("POST", urlAdmin + "imagen/load",true);

	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			$('galeria').value = ajax.responseText; 
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_galeria=" + id);
}
//carga de paginas para el menu
function loadPadre(lang, anyo){
	ajax=nuevoAjax();
	ajax.open("POST", urlAdmin + "pagina/load",true);

	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			if(eval(ajax.responseText)) {
	            var options = $A(eval(ajax.responseText));
	            $A(options).each(function(s, index) {
	              var tmp = $A(s);
	              var opt = document.createElement('option');
	               opt.text = tmp[1];
	               opt.value = tmp[0];
	               $('id_paginapadre').options.add(opt);
	            });
		    }
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_idioma=" + lang + "&id_edicion=" + anyo);
}
//carga de posibles layous
function loadLayout(skin){
	ajax=nuevoAjax();
	ajax.open("POST", urlAdmin + "pagina/loadLayouts",true);

	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			if(eval(ajax.responseText)) {
	            var options = $A(eval(ajax.responseText));
	            $A(options).each(function(s, index) {
	              var tmp = $A(s);
	              var opt = document.createElement('option');
	               opt.text = tmp[1];
	               opt.value = tmp[0];
	               $('id_layout').options.add(opt);
	            });
		    }
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_skin=" + skin);
}

//carga de modulos para el menu de administracion
function loadModuloPadre(nivelAcceso){
	ajax=nuevoAjax();
	ajax.open("POST", urlAdmin + "modulos/load",true);
	
	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			if(eval(ajax.responseText)) {
	            var options = $A(eval(ajax.responseText));
	            $A(options).each(function(s, index) {
	            	
	              var tmp = $A(s);
	              var opt = document.createElement('option');
	               opt.text = tmp[1];
	               opt.value = tmp[0];
	               $('id_modulopadre').options.add(opt);
	            });
		    }
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("id_nivelacceso=" + nivelAcceso);
}



/**
 * Tratamiento de Formulario: validaciones y llamadas ajax
 * 
 **/
Event.observe(window, 'load', _onLoad, false);

function _onLoad(){

	//	objeto Msg
	goMsg = new Msg($('msg'));
	goMsg.ocultar();
	
	//login zona admin
	if ($('form_login')) {
		Event.observe('b_login', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('nombreusuario'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('nombreusuario'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_usuario);
			}
			else {
				Element.removeClassName($('nombreusuario'), 'errorLabel');
			}

			if (isVacio($F('psw'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('psw'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_password);
			}
			else {
				Element.removeClassName($('psw'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				$('form_login').submit();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);
	}
	
	
	/* modulo - usuario */
	if ($('form_usuario')) {
		Event.observe('b_usuario', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('usuario'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('usuario'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_usuario);
			}
			else {
				Element.removeClassName($('usuario'), 'errorLabel');
			}
			if (isVacio($F('id')) && isVacio($F('id_password'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_password'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_password);
			}
			else {
				Element.removeClassName($('id_password'), 'errorLabel');
			}
			if (isVacio($F('id_email')) || !validarEmail($('id_email').value)) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_email'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_email);
			}
			else {
				Element.removeClassName($('id_email'), 'errorLabel');
			}
			
			if ($F('id_nivel_acceso')==0) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_nivel_acceso'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nivel);
			}
			else {
				Element.removeClassName($('id_nivel_acceso'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("usuario", "id="+$F('id') +"&usuario="+$F('usuario') + "&id_password="+$F('id_password') + "&id_email="+$F('id_email') + "&id_nivel_acceso="+escape($F('id_nivel_acceso')));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);
		
		Event.observe('usuario', 'click', function(e){
			Element.removeClassName($('usuario'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_password', 'click', function(e){
			Element.removeClassName($('id_password'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_nivel_acceso', 'click', function(e){
			Element.removeClassName($('id_nivel_acceso'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_email', 'click', function(e){
			Element.removeClassName($('id_email'), 'errorLabel');
			return false;
		}, false);
	}
	
	
	/* modulo - perfil navegacion */
	if ($('form_perfil')) {
		Event.observe('b_perfil', 'click', function(e){
			
			if($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
				$('file_imagen').value=$('frame_imagen').contentWindow.document.body.firstElementChild.value;
			}
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('nombre'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nombre);
			}
			else {
				Element.removeClassName($('nombre'), 'errorLabel');
			}
			if ($F('id_modulodefault')==0) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_modulodefault'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('id_modulodefault'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("perfil", "id=" + $F('id') + "&id_modulodefault=" + $F('id_modulodefault')  + "&file_imagen=" + $F('file_imagen') + "&nombre=" +  escape($F('nombre')) + "&descripcion=" +  escape($F('descripcion')));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);
		
		Event.observe('nombre', 'click', function(e){
			Element.removeClassName($('nombre'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_modulodefault', 'click', function(e){
			Element.removeClassName($('id_modulodefault'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* modulo - idiomas */
	if ($('form_lang')) {
		Event.observe('b_lang', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('id_nombre'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nombre);
			}
			else {
				Element.removeClassName($('id_nombre'), 'errorLabel');
			}
			if (isVacio($F('id_codigo'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_codigo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('id_codigo'), 'errorLabel');
			}
			if (isVacio($F('id_codificacion'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_codificacion'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('id_codificacion'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("langs", "id=" + $F('id') + "&id_codigo=" + $F('id_codigo')  + "&id_nombre=" +  escape($F('id_nombre')) + "&id_codificacion=" +  escape($F('id_codificacion')));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);
		
		Event.observe('nombre', 'click', function(e){
			Element.removeClassName($('nombre'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_codigo', 'click', function(e){
			Element.removeClassName($('id_codigo'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_codificacion', 'click', function(e){
			Element.removeClassName($('id_codificacion'), 'errorLabel');
			return false;
		}, false);
	}
	
	
	/* controllers  */
	if ($('form_modulo')) {
		Event.observe('b_modulo', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('modulo'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('modulo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('modulo'), 'errorLabel');
			}
			
			
			if (isVacio($F('nombre'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nombre);
			}
			else {
				Element.removeClassName($('nombre'), 'errorLabel');
			}
			
			if ($F('id_nivel_acceso')==0) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_nivel_acceso'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nivel);
			}
			else {
				Element.removeClassName($('id_nivel_acceso'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("modulos", "id=" + $F('id') +"&nombre=" + escape($F('nombre')) + "&modulo=" + $F('modulo') + "&id_modulopadre=" + $F('id_modulopadre') + "&descripcion=" +  escape($F('descripcion')) + "&id_nivel_acceso=" + $F('id_nivel_acceso'))
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
		}, false);
		
		Event.observe('id_nivel_acceso', 'change', function(e){
			if($('id').value==''){
				$('id_modulopadre').descendants().each(Element.remove); //vaciar select
				loadModuloPadre($('id_nivel_acceso').value);
				return false;
			}
		}, false);
		
		Event.observe('modulo', 'click', function(e){
			Element.removeClassName($('modulo'), 'errorLabel');
			return false;
		}, false);
		Event.observe('nombre', 'click', function(e){
			Element.removeClassName($('nombre'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_nivel_acceso', 'click', function(e){
			Element.removeClassName($('id_nivel_acceso'), 'errorLabel');
			return false;
		}, false);
		
	}
	
	/* modulo web */
	if ($('form_moduloweb')) {
		Event.observe('b_moduloweb', 'click', function(e){
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('modulo'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('modulo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('modulo'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("moduloweb", "id=" + $F('id') +"&modulo=" + $F('modulo') + "&id_descripcion=" +  escape($F('id_descripcion')));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			
		}, false);
		Event.observe('modulo', 'click', function(e){
			Element.removeClassName($('modulo'), 'errorLabel');
			return false;
		}, false);
	}
	
	
	/* ediciones */
	if ($('form_edicion')) {
		Event.observe('b_edicion', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if ($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
				$('file_imagen').value=$('frame_imagen').contentWindow.document.body.children[0].value;
			}
			
			if (isVacio($F('nombre'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nombre);
			}
			else {
				Element.removeClassName($('nombre'), 'errorLabel');
			}
			if (isVacio($F('id_dia_inicio'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_dia_inicio'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_fechainicio);
			}
			else {
				Element.removeClassName($('id_dia_inicio'), 'errorLabel');
			}
			if (isVacio($F('id_dia_fin'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_dia_fin'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_fechafin);
			}
			else {
				Element.removeClassName($('id_dia_fin'), 'errorLabel');
			}
			
			var langs = "";
			for (var int = 0; int < $('langs').options.length; int++) {
				langs = langs + $('langs').options[int].value;
				if($('langs').options.length-1>int){
					langs = langs + ",";
				}
			}
			
			$('langsSelected').value = langs;
			
			if(isVacio($F('langsSelected')) ){
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('langs'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_texto);
			}
			else{
				Element.removeClassName($('langs'), 'errorLabel');
			}
			
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("edicion", "id=" + $F('id') + "&file_imagen=" + $F('file_imagen') + "&id_dia_inicio=" + $F('id_dia_inicio') + "&id_dia_fin=" + $F('id_dia_fin') + "&nombre=" + escape($F('nombre')) + "&descripcion=" + escape($F('descripcion')) + "&langs=" + $F('langsSelected'));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
		}, false);
		
		if ($('right')){
			Event.observe('right', 'click', function(e){
				if($('langsPosibles').selectedIndex!=-1){
					var option = document.createElement('option');
					option.text = $('langsPosibles').options[$('langsPosibles').selectedIndex].innerHTML;
					option.value = $('langsPosibles').options[$('langsPosibles').selectedIndex].value;
					$('langsPosibles').options[$('langsPosibles').selectedIndex].remove();
					$('langs').options.add(option);
				}
			});	
		}
		if ($('left')){
			Event.observe('left', 'click', function(e){
				if($('langs').selectedIndex!=-1){
					var option = document.createElement('option');
					option.text = $('langs').options[$('langs').selectedIndex].innerHTML;
					option.value = $('langs').options[$('langs').selectedIndex].value;
					$('langs').options[$('langs').selectedIndex].remove();
					$('langsPosibles').options.add(option);
				} 
				
			});	
		}
		
		Event.observe('nombre', 'click', function(e){
			Element.removeClassName($('nombre'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_dia_inicio', 'click', function(e){
			Element.removeClassName($('id_dia_inicio'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_dia_fin', 'click', function(e){
			Element.removeClassName($('id_dia_fin'), 'errorLabel');
			return false;
		}, false);
		
		
		/*calendario */
		Event.observe('id_dia_inicio', 'focus', function(e){
			$('id_dia_inicio').value='';
			displayCalendar($('id_dia_inicio'),'dd/mm/yyyy',this,false);
		});
	
		Event.observe('id_dia_fin', 'focus', function(e){
			$('id_dia_fin').value='';
			displayCalendar($('id_dia_fin'),'dd/mm/yyyy',this,false);
		});
		
	}
	
	/* convocatorias*/
	if ($('form_convocatorias')) {
		Event.observe('b_convocatorias', 'click', function(e){
			goMsg.ocultar();
			if ($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
				$('file_imagen').value=$('frame_imagen').contentWindow.document.body.children[0].value;
			}
			alta("convocatorias", "id=" + $F('id') + "&id_url=" + $F('id_url') +"&file_imagen=" + $F('file_imagen') + "&descripcion=" + escape($F('descripcion')));
			goMsg.mostrar();
			Event.stop(e);
		}, false);
	}
	
	/* modulo - pagina */
	if ($('form_pagina')) {
		
		Event.observe('b_pagina', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('id_titulo'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_titulo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_titulo);
			}
			else {
				Element.removeClassName($('id_titulo'), 'errorLabel');
			}
			if (isVacio($F('id_url'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_url'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_url);
			}
			else {
				Element.removeClassName($('id_url'), 'errorLabel');
			}
			if (isVacio($F('id_descripcion'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_descripcion'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_descripcion);
			}
			else {
				Element.removeClassName($('id_descripcion'), 'errorLabel');
			}
			
			if ($F('id_modulo')==0) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_modulo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('id_modulo'), 'errorLabel');
			}
			
			var textos = "";
			for ( var int = 0; int < $('textos').options.length; int++) {
				textos = textos + $('textos').options[int].value;
				if($('textos').options.length-1>int){
					textos = textos + ",";
				}
			}
			$('textosSelected').value = textos; 
			if($('id_modulo').options[$('id_modulo').selectedIndex].text=='texto' && isVacio($F('textosSelected')) ){
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('textos'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_texto);
			}
			else{
				Element.removeClassName($('textos'), 'errorLabel');
			}
			
			if ($F('id_layout')==0) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_layout'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_layout);
			}
			else {
				Element.removeClassName($('id_layout'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("pagina", "id=" + $F('id') +"&id_url="+$F('id_url') + "&id_titulo="+escape($F('id_titulo')) + "&id_descripcion=" + escape($F('id_descripcion'))+ "&id_modulo="+$F('id_modulo') + "&id_layout="+$F('id_layout') + "&id_skin="+$F('id_skin') + "&id_nombremenu="+ escape($F('id_nombremenu')) + "&id_orden="+$F('id_orden') + "&id_edicion="+$F('id_edicion') + "&id_paginapadre="+$F('id_paginapadre') + "&portada=" + ($('id_portada').checked ? 'S':'N') + "&textos=" + $F('textosSelected'));
				goMsg.mostrar();
				window.scrollTo(0,0);
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
		}, false);
		
		Event.observe('id_skin', 'change', function(e){
				$('id_layout').descendants().each(Element.remove); //vaciar select
				loadLayout($('id_skin').value);
				return false;
		}, false);
		
		if($('id_modulo').options[$('id_modulo').selectedIndex].text=='texto'){
			mostrar($('div_texto'));
		}
		
		Event.observe('id_modulo', 'change', function(e){
			if($('id_modulo').options[$('id_modulo').selectedIndex].text=='texto'){
				mostrar($('div_texto'));
			}
			else{
				ocultar($('div_texto'));
			}
			return false;
		}, false);
		
		if ($('right')){
			Event.observe('right', 'click', function(e){
				if($('textosDisponibles').selectedIndex!=-1){
					var option = document.createElement('option');
					option.text = $('textosDisponibles').options[$('textosDisponibles').selectedIndex].innerHTML;
					option.value = $('textosDisponibles').options[$('textosDisponibles').selectedIndex].value;
					$('textosDisponibles').options[$('textosDisponibles').selectedIndex].remove();
					$('textos').options.add(option);
					$('textos').lastElementChild.focus();
				}
			});	
		}
		if ($('left')){
			Event.observe('left', 'click', function(e){
				if($('textos').selectedIndex!=-1){
					var option = document.createElement('option');
					option.text = $('textos').options[$('textos').selectedIndex].innerHTML;
					option.value = $('textos').options[$('textos').selectedIndex].value;
					$('textos').options[$('textos').selectedIndex].remove();
					$('textosDisponibles').options.add(option);
					$('textosDisponibles').lastElementChild.focus();
				}
			});	
		}
		
		
		Event.observe('id_url', 'click', function(e){
			Element.removeClassName($('id_url'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_titulo', 'click', function(e){
			Element.removeClassName($('id_titulo'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_descripcion', 'click', function(e){
			Element.removeClassName($('id_descripcion'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_modulo', 'click', function(e){
			Element.removeClassName($('id_modulo'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_layout', 'click', function(e){
			Element.removeClassName($('id_layout'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* modulo - pelicula */
	if ($('formPelicula')) {
		Event.observe('b_pelicula', 'click', function(e){
			if ($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
					$('file_imagen').value=$('frame_imagen').contentWindow.document.body.children[1].value;
					$('id').value=$('frame_imagen').contentWindow.document.body.children[0].value;
			}
			
			var bCorrecto = true;
			var iNCampos = 0;
			goMsg.limpiar();
			tinyMCE.triggerSave();
			
			if (isVacio($F('titulo'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('titulo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_titulo);
			}
			else {
				Element.removeClassName($('titulo'), 'errorLabel');
			}
			/*
			if (isVacio($F('id_sinopsis'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_sinopsis'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_sinopsis);
			}
			else {
				Element.removeClassName($('id_sinopsis'), 'errorLabel');
			}
			if (isVacio($F('id_ficha'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_ficha'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_fichatecnica);
			}
			else {
				Element.removeClassName($('id_ficha'), 'errorLabel');
			}*/
			if ((!isVacio($F('id_enlace'))&&!$F('id_enlace')=='http://') && !esUrl($F('id_enlace'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_enlace'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_url);
			}
			else {
				Element.removeClassName($('id_enlace'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			if (bCorrecto) {
				alta("pelicula", "id=" + $F('id') + "&id_muestra="+$F('id_muestra') + "&titulo="+escape($F('titulo')) + "&id_ficha=" + escape($F('id_ficha')) + "&id_sinopsis=" + escape($F('id_sinopsis'))+ "&id_enlace=" + controlHttp($F('id_enlace')) + "&id_descarga=" + controlHttp($F('id_descarga')) + "&id_proyeccion=" + $F('id_proyeccion') + "&id_donante=" + $F('id_donante') + "&id_propio=" +  escape($F('id_propio')) + "&id_licencia="+$F('id_licencia'));
				goMsg.mostrar();
				//mostrar($('formPelicula'));
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		Event.observe('titulo', 'click', function(e){
			Element.removeClassName($('titulo'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_sinopsis', 'click', function(e){
			Element.removeClassName($('id_sinopsis'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* upload imagenes */
	if ($('form_imagen')) {

		Event.observe('imagen', 'change', function(e){
			var bCorrecto = true;
			var iNCampos = 0;
			goMsg.limpiar();
			goMsg.ocultar();
			if($('id_galeria')){
				if ($('id_galeria').value == 0){
					bCorrecto = false;
					goMsg.nuevo('em', 'msg-alerta', gcMsg_galeriaupload);
				}
			}
			if($('nombre')){
				if ($('nombre').value == ''){
					bCorrecto = false;
					iNCampos++;
					goMsg.nuevo('em', 'msg-alerta', gcMsg_mensaje);
				} else {
					$('id_nombre').value = $('nombre').value;
				}
			}
			if($('titulo')){
				if ($('titulo').value == ''){
					bCorrecto = false;
					iNCampos++;
					goMsg.nuevo('em', 'msg-alerta', gcMsg_mensaje);
				} else {
					$('id_nombre').value = $('titulo').value;
				}
			}
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+ gcMsg_revisa + ":</strong> <br>");
			}
			if (bCorrecto) {
				$('form_imagen').submit();
				ocultar($('div-img'));
				mostrar($('frame_imagen'));
				$('frame_imagen').contentWindow.document.body.innerHTML="<img height='90px' src='" + urlImgAdmin + "loading.gif' />";
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		
		if($('id_galeria')){
			Event.observe('id_galeria', 'change', function(e){
				$('id_galeria_img').value = $('id_galeria').value;
				loadGaleria($('id_galeria').value);
				return false;
			}, false);
		}
	}
	
	/* upload doc */
	if ($('form_uploaddoc')) {
		Event.observe('doc', 'change', function(e){
			var bCorrecto = true;
			var iNCampos = 0;
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('nombre'))){
				bCorrecto = false;
				iNCampos++;
				goMsg.nuevo('em', 'msg-alerta', gcMsg_mensaje);
			} else {
				$('id_nombreDoc').value = $('nombre').value + $('id_edicion').value;
			}
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			if (bCorrecto) {
				$('form_uploaddoc').submit();
				ocultar($('div-doc'));
				mostrar($('frame_doc'));
				$('frame_doc').contentWindow.document.body.innerHTML="<img src='" + urlImgAdmin + "loading.gif' />";
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		Event.observe('nombre', 'click', function(e){
			Element.removeClassName($('nombre'), 'errorLabel');
			return false;
		}, false);
	}
	
	
	/* modulo - texto */
	if ($('form_texto')) {
		Event.observe('b_texto', 'click', function(e){
			var bCorrecto = true;
			var iNCampos = 0;
			goMsg.limpiar();
			tinyMCE.triggerSave();
			
			if (isVacio($F('id_titulo'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_titulo'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_titulo);
			}
			else {
				Element.removeClassName($('id_titulo'), 'errorLabel');
			}
			if (isVacio($F('texto'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('texto'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_texto);
			}
			else {
				Element.removeClassName($('texto'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("texto", "id=" + $F('id') + "&id_titulo=" + escape($F('id_titulo')) +  "&texto=" + escape($F('texto')) + "&id_muestra=" +  $F('id_muestra') + "&lang=" +  $F('lang') + "&id_galeria=" +  $F('id_galeria'));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		
		Event.observe('id_titulo', 'click', function(e){
			Element.removeClassName($('id_titulo'), 'errorLabel');
			return false;
		}, false);
		Event.observe('texto', 'click', function(e){
			Element.removeClassName($('texto'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* modulo - proyeccion */
	if ($('formProyeccion')) {
		Event.observe('b_proyeccion', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('id_espacio')) ) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_espacio'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_espacio);
			}
			else {
				Element.removeClassName($('id_espacio'), 'errorLabel');
			}
			if (isVacio($F('id_dia'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_dia'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_dia);
			}
			else {
				Element.removeClassName($('id_dia'), 'errorLabel');
			}
			if (isVacio($F('id_hora'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_hora'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_hora);
			}
			else {
				Element.removeClassName($('id_hora'), 'errorLabel');
			}
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("proyeccion", "id=" + $F('id') +"&id_edicion="+$F('id_edicion') + "&id_espacio="+$F('id_espacio') + "&id_dia="+ $F('id_dia') + "&id_hora=" + $F('id_hora') + "&titulo="+escape($F('id_titulo')) + "&descripcion="+escape($F('id_descripcion')));
				goMsg.mostrar();
				window.scrollTo(0,0);
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;

		}, false);
		
		Event.observe('id_espacio', 'click', function(e){
			Element.removeClassName($('id_espacio'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_dia', 'click', function(e){
			Element.removeClassName($('id_dia'), 'errorLabel');
			return false;
		}, false);
		Event.observe('id_hora', 'click', function(e){
			Element.removeClassName($('id_hora'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* modulo - agradecimiento */
	if ($('form_donante_alta')) {
		Event.observe('b_donante', 'click', function(e){
			if($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
				$('file_imagen').value=$('frame_imagen').contentWindow.document.body.firstElementChild.value;
			}
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('nombre'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_usuario);
			}
			else {
				Element.removeClassName($('nombre'), 'errorLabel');
			}
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			if (bCorrecto) {
				goMsg.ocultar();
				alta("agradecimiento", "id=" + $F('id') +"&nombre=" + escape($F('nombre')) + "&web=" + controlHttp($F('web')) + "&id_logo=" + $F('file_imagen'));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		
		Event.observe('nombre', 'click', function(e){
			Element.removeClassName($('nombre'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* galerias de imagenes */
	if ($('form_galeria')) {
		Event.observe('b_galeria', 'click', function(e){
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('id_nombre'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('id_nombre'), 'errorLabel');
			}
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			if (bCorrecto) {
				goMsg.ocultar();
				alta("galeria", "id=" + $F('id') +"&id_nombre=" + escape($F('id_nombre')) + "&id_descripcion=" + escape($F('id_descripcion')))
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		
		Event.observe('id_nombre', 'click', function(e){
			Element.removeClassName($('id_nombre'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* imagenes */
	if ($('form_img')) {
		Event.observe('b_imagen', 'click', function(e){
			
			if ($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
				$('file_imagen').value=$('frame_imagen').contentWindow.document.body.children[1].value;
				$('id').value=$('frame_imagen').contentWindow.document.body.children[0].value;
			}
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('file_imagen'))) {
				bCorrecto = false;
				iNCampos++;
				goMsg.nuevo('em', 'msg-alerta', gcMsg_img);
			}
			
			if ($F('id_galeria')==0) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('id_galeria'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_modulo);
			}
			else {
				Element.removeClassName($('id_galeria'), 'errorLabel');
			}
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			if (bCorrecto) {
				goMsg.ocultar();
				alta("imagen", "id=" + $F('id') + "&file_imagen=" + $F('file_imagen') + "&video=" + controlHttp($F('id_video')) + "&id_galeria=" + $F('id_galeria') + "&descripcion=" + escape($F('descripcion')));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		
		Event.observe('id_galeria', 'click', function(e){
			Element.removeClassName($('id_galeria'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* modulo - espacio */
	if ($('form_espacio')) {
		Event.observe('b_espacio', 'click', function(e){
			if($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
				$('file_imagen').value=$('frame_imagen').contentWindow.document.body.firstElementChild.value;
			}
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('espacio'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('espacio'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nombre);
			}
			else {
				Element.removeClassName($('espacio'), 'errorLabel');
			}
			
			if (isVacio($F('direccion')) || $F('direccion') == 'c/' ) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('direccion'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_direccion);
			}
			else {
				Element.removeClassName($('direccion'), 'errorLabel');
			}
			
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			
			if (bCorrecto) {
				goMsg.ocultar();
				alta("espacio", "id=" + $F('id') + "&espacio=" + escape($F('espacio')) + "&direccion=" + escape($F('direccion')) + "&descripcion=" + escape($F('descripcion')) + "&web=" + controlHttp($F('web')) + "&telefono=" + $F('telefono') + "&email=" + $F('email') + "&latitud=" + $F('id_latitud') + "&longitud=" + $F('id_longitud') + "&id_logo=" + $F('file_imagen'));
				goMsg.mostrar();
				window.scrollTo(0,0);
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		
		Event.observe('espacio', 'click', function(e){
			Element.removeClassName($('espacio'), 'errorLabel');
			return false;
		}, false);
		
		Event.observe('direccion', 'click', function(e){
			Element.removeClassName($('direccion'), 'errorLabel');
			return false;
		}, false);
	}
	
	/* modulo - descarga docs */
	if ($('form_doc')) {
		Event.observe('b_doc', 'click', function(e){

			if ($('frame_doc') && $('frame_doc').contentWindow.document.body.firstElementChild!=null){
				$('file_doc').value=$('frame_doc').contentWindow.document.body.children[1].value;
				$('id').value=$('frame_doc').contentWindow.document.body.children[0].value;
			}
			
			if($('frame_imagen') && $('frame_imagen').contentWindow.document.body.firstElementChild!=null){
				$('file_imagen').value=$('frame_imagen').contentWindow.document.body.firstElementChild.value;
			}
			
			var bCorrecto = true;
			var iNCampos = 0;
			
			goMsg.limpiar();
			goMsg.ocultar();
			
			if (isVacio($F('file_doc'))) {
				bCorrecto = false;
				goMsg.nuevo('em', 'msg-alerta', gcMsg_doc);
			}
			
			if (isVacio($F('nombre'))) {
				bCorrecto = false;
				iNCampos++;
				Element.addClassName($('nombre'), 'errorLabel');
				goMsg.nuevo('em', 'msg-alerta', gcMsg_nombre);
			}
			else {
				Element.removeClassName($('nombre'), 'errorLabel');
			}
			if (iNCampos > 0) {
				goMsg.nuevo('em', 'msg-info', "<strong>"+gcMsg_revisa+":</strong> <br>");
			}
			if (bCorrecto) {
				goMsg.ocultar();
				alta("doc", "id=" + $F('id') +"&id_edicion="+$F('id_edicion') + "&nombre=" + escape($F('nombre')) + "&descripcion=" + escape($F('descripcion')) + "&file_doc=" + $F('file_doc') + "&file_imagen=" + $F('file_imagen'));
				goMsg.mostrar();
			}
			else {
				goMsg.mostrar();
			}
			Event.stop(e);
			return false;
		}, false);
		
		Event.observe('nombre', 'click', function(e){
			Element.removeClassName($('nombre'), 'errorLabel');
			return false;
		}, false);
		
	}
	
}

/**
 * Objeto Msg para notificaciones feedback + validaciones
 */
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
	
	ocultar: function(){Element.addClassName($(this.id), 'oculto');},
	mostrar: function(){Element.removeClassName($(this.id), 'oculto');}
}
Event.observe(window, 'load', _onLoad, false);

var goMsg = {};

function validarEmail(pcTexto){
	return (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(pcTexto));
}
function enviaMail(){
	ajax=nuevoAjax(); 
	ajax.open("POST", "/contacta/send",true);
	ajax.onreadystatechange=function() {
		if (ajax.readyState==4) {
			$('msg').innerHTML = ajax.responseText;
			goMsg.mostrar();
			$('form-contacta').addClassName('oculto');
			setTimeout("window.location='contacta'", 3000);
		}
	}
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send("email=" + escape($F('email')) + "&asunto=" + escape($F('asunto')) +"&comentario=" + escape($F('comentario')));
}

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

function _onLoad(){
	goMsg = new Msg($('msg'));
	Event.observe('b-mail', 'click', function(e){
		
		var bCorrecto = true;
		var iNCampos = 0;
		
		goMsg.limpiar();
		goMsg.ocultar();
		
		if ($('asunto').value == '') {
			bCorrecto = false;
			iNCampos++;
			Element.addClassName($('asunto'), 'errorLabel');
			goMsg.nuevo('em', 'msg-alerta', gcMsg_asunto);
		}
		else {
			Element.removeClassName($('asunto'), 'errorLabel');
		}
		if ($('comentario').value == '') {
			bCorrecto = false;
			iNCampos++;
			Element.addClassName($('comentario'), 'errorLabel');
			goMsg.nuevo('em', 'msg-alerta', gcMsg_comentario);
		}
		else {
			Element.removeClassName($('comentario'), 'errorLabel');
		}
		if ($('email').value == '' || !validarEmail($('email').value)) {
			bCorrecto = false;
			iNCampos++;
			Element.addClassName($('email'), 'errorLabel');
			goMsg.nuevo('em', 'msg-alerta', gcMsg_email);
		}
		else {
			Element.removeClassName($('email'), 'errorLabel');
		}
		
		if (iNCampos > 0) {
			goMsg.nuevo('em', 'msg-info', gcMsg_revisa);
		}
		
		if (bCorrecto) {
			goMsg.ocultar();
			enviaMail();
			window.scrollTo(0,0);
		}
		else {
			goMsg.mostrar();
		}
		Event.stop(e);
		
	}, false);
	
	Event.observe('asunto', 'click', function(e){
		Element.removeClassName($('asunto'), 'errorLabel');
		return false;
	}, false);		
	Event.observe('comentario', 'click', function(e){
		Element.removeClassName($('comentario'), 'errorLabel');
		return false;
	}, false);
	Event.observe('email', 'click', function(e){
		Element.removeClassName($('email'), 'errorLabel');
		return false;
	}, false);	
}

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
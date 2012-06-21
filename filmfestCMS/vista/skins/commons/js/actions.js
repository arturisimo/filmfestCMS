Event.observe(window, 'load', _onLoad, false);

function _onLoad(){
	  
	/**
	 * acciones en el menu superior
	 **/
	//salir zona de administracion
	if ($('id_exit')){
		Event.observe('id_exit', 'click', function(e){
			$('accion').value = 'exit';
			$('formAccion').submit();
		});
	}
	//seleccionar perfil de navegacion
	if ($('id_inicio')){
		Event.observe('id_inicio', 'click', function(e){
			$('accion').value = 'inicio';
			$('formAccion').submit();
		});
	}
	//cambiar edicion
	if ($('id_cambio_edicion')){
		Event.observe('id_cambio_edicion', 'click', function(e){
			$('accion').value = 'reset_edicion';
			$('formAccion').submit();
		});	
	}
	
	//cambiar imagenes
	if ($('change-img')){
		Event.observe('change-img', 'click', function(e){
			var item = $('change-img').className.split('-');
			if (confirm(gcMsg_confirmdeleteimg + " " + item[0] + " " + item[1])){
				ajax=nuevoAjax();
				ajax.open("POST", urlAdmin + item[0]+'/deleteImagen', true);
				ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				ajax.send("id="+ item[1]);
				$('imagen_uploaded').src= urlImgAdmin + "loading.gif";
				ajax.onreadystatechange=function() {
					if (ajax.readyState == 4) {
						setTimeout("location.reload(true)", 5000);
					}
				}
			}
		});	
	}
	
	//seleccionar edicion
	$$('div.img_muestra a').each(function(element) {
		Event.observe(element, 'click', function(e){
			$('edicion').value = element.id;
			$('formAccion').submit();
		});
	});
	
	//seleccionar perfil de navegacion
	$$('div.botonera a.perfil').each(function(element) {
		Event.observe(element, 'click', function(e){
			var item = element.id.split('-');
			$('perfil').value = item[0];
			$('controller').value = item[1];
			$('formAccion').submit();
		});
	});
	
	
	/**
	 * acciones columna derecha
	 */
	var modulo ='';
	$$('div.rightmenu ul').each(function(element) {
		modulo = element.className;
	});
	
	//carga para edicion
	$$('div.rightmenu span.titulo').each(function(element) {
		Event.observe(element, 'click', function(e){
			var item = element.id.split('-');
			var id = item[1];
			window.location = urlAdmin +  modulo + '/' + id;
		});
	});
	$$('div.rightmenu a.edit').each(function(element) {
		Event.observe(element, 'click', function(e){
			var item = element.id.split('-');
			var id = item[1];
			window.location = urlAdmin + modulo + '/' + id;
		});
	});
	
	//eliminar
	$$('div.rightmenu a.delete').each(function(element) {
		Event.observe(element, 'click', function(e){
			var item = element.id.split('-');
			var id = item[1];
			if (confirm(gcMsg_confirmdelete + ' '+ modulo + " " + id + '?' )){
				eliminar(modulo, id);
				mostrar($('msg'));
			}
		});
	});
	
	//imprimir
	$$('div.rightmenu a.print').each(function(element) {
		Event.observe(element, 'click', function(e){
			var item = element.id.split('-');
			var id = item[1];
			window.open(urlAdmin + modulo + "/imprimir/"+id);
		});
	});
	
	//alta baja
	$$('div.rightmenu a.visible').each(function(element) {
		Event.observe(element, 'click', function(e){
			var item = element.id.split('-');
			var id = item[1];
			ajax = nuevoAjax();
			ajax.open("POST", urlAdmin + modulo+"/view",true);
			ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					$('msg').innerHTML = feedback(ajax.responseText);
				}
			}
			ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			ajax.send("id="+ id + "&accion=N");
			mostrar($('msg'));
			setTimeout("window.location='" + urlAdmin + modulo+"'", 2000);
		});
	});
	$$('div.rightmenu a.no-visible').each(function(element) {
		Event.observe(element, 'click', function(e){
			var item = element.id.split('-');
			var id = item[1];
			ajax = nuevoAjax();
			ajax.open("POST", urlAdmin + modulo+"/view",true);
			ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					$('msg').innerHTML = feedback(ajax.responseText);
				}
			}
			ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			ajax.send("id="+ id + "&accion=S");
			mostrar($('msg'));
			setTimeout("window.location='" + urlAdmin + modulo + "'", 2000);
		});
	});
	
	
	/**
	 *  carga de mapas y puntos geograficos
	 **/
	if ($('map')){
	    var map = null;
	    var geocoder = null;
	
	    if (GBrowserIsCompatible()) {
	        map = new GMap2($('map'));
	        map.setCenter(new GLatLng(parseFloat($('id_longitud').value), parseFloat($('id_latitud').value)), 16);
	        geocoder = new GClientGeocoder();
	        if ($('espacio').value!=''){
		        var punto = new GLatLng($('id_latitud').value, $('id_longitud').value);
		        geocoder.getLatLng(punto, function(point) {
		            if (!point) {
		            	alert(punto + " not found");
		            } else {
			            map.setCenter(point, 16);
			            var marker = new GMarker(point);
			            map.addOverlay(marker);
			            $('id_longitud').value=point.x
			            $('id_latitud').value=point.y
		            }
		        });
		    }
	    }
	    
	    if ($('direccion')) {
	    	Event.observe('direccion', 'blur', function(e){
	    		var address = $('direccion').value + ', ' + $('id_ciudad').innerHTML;
	    		$('id_ciudad').innerHTML = $('direccion').value + ', ' + $('id_ciudad').innerHTML;
	    		geocoder.getLatLng(address, function(point) {
		            if (!point) {
		            	alert(address + " not found");
		            } else {
			            map.setCenter(point, 16);
			            var marker = new GMarker(point);
			            map.addOverlay(marker);
			            $('id_longitud').value=point.x
			            $('id_latitud').value=point.y
		            }
		        });
	    	});
	    }
	}
}
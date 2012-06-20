Event.observe(window, 'load', _onLoad, false);

function _onLoad(){

	$$('div#idiomas a').each(function(element) {
		Event.observe(element, 'click', function(e){
			var lang = element.id.split('-');
			$('lang').value = lang[1];
			$('formLang').submit();
		});
	});
	
	Event.observe('header', 'click', function(e){
		$('formLang').submit();
	});
	
}
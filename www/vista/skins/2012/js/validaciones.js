/*	+	validarEmail(pcTexto)
		funcion de validacion para campos de tipo email	*/
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

function format(x) {
 nStr = x.value;
 var rgx = /\./;
 while (rgx.test(nStr)) {
 nStr = nStr.replace(rgx, '');
 }
 var rgx = /\,/;
 while (rgx.test(nStr)) {
 nStr = nStr.replace(rgx, '.');
 }
 var dpos = nStr.indexOf('.');
 var nStrEnd = '';
 if (dpos != -1) {
 nStrEnd = ',' + nStr.substring(dpos + 1, nStr.length);
 nStr = nStr.substring(0, dpos);
 }
 var rgx = /(\d+)(\d{3})/;
 while (rgx.test(nStr)) {
 nStr = nStr.replace(rgx, '$1' + '.' + '$2');
 }
 x.value = nStr;
}
function unFormat(x) {
 nStr = x.value;
 var rgx = /\./;
 while (rgx.test(nStr)) {
 nStr = nStr.replace(rgx, '');
 }
 var rgx = /,/;
 while (rgx.test(nStr)) {
 nStr = nStr.replace(rgx, '.');
 }
 x.value = nStr;
} 
 
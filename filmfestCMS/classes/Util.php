<?
	class Util {    
	
		public static function substring($string, $length){	  
		    $stringDisplay = substr(strip_tags(html_entity_decode($string)), 0, $length);
		    if (strlen(strip_tags($string)) > $length){
		        $stringDisplay .= ' ...';
		    }
		    return $stringDisplay;
		}
		
		public static function stripAccents($string){
	
			// Tranformamos todo a minusculas
			$string = strtolower($string);
			
			// se cambia espacio por guiones
			$find = array(' ', '&', '\r\n', '\n', '+');
			$string = str_replace ($find, '-', $string);
			
			// Eliminamos y Reemplazamos demas caracteres especiales
			$find = array('/[^a-z0-9\-<>]/', '/[\-]+/', '/<[^>]*>/');
			$repl = array('', '-', '');
	
			return preg_replace ($find, $repl, $string);
		}
		
		public static function formatBytes($bytes){
	    	$units = array('B', 'KB', 'MB', 'GB');
	    	for($i=0; $bytes > 1024; $i++){ 
	    		$bytes = $bytes/1024;
	    	}
	    	return number_format($bytes,1)." ".$units[$i];
		}

		public static function recortaFicha($ficha){
	    	$pos = strpos($ficha, "</p>");
	    	if ($pos>200){
	    		$ficha = self::substring($ficha, 100);	  
	    	} else {
		    	$ficha = strip_tags(substr($ficha, 0, $pos));
		    	//Log::add($pos);
	    	}
	    	return $ficha;
		}
		
		public static function getUrlVideo($video){
			if (!empty($video)){
				$pos_vimeo = strpos($video, "www.vimeo.com/");
				$pos_youtube = strpos($video, "youtube.com/watch?v=");
				$pos_megavideo = strpos($video, "megavideo.com/?v=");
				
				if ($pos_youtube){ 
					$parte = explode("?v=", $video);
					$video = 'http://www.youtube.com/v/'.$parte[1];
				}
				if($pos_vimeo){
					$parte = explode("www.vimeo.com/", $video);
					$video = 'http://vimeo.com/'.$parte[1];
				}
				if($pos_megavideo){
					$parte = explode("?v=", $video);
					$video = 'http://megavideo.com/v/'.$parte[1];
				}
			}	
			return $video;
		}
	
		public static function getColorTemplate($anyo){
			$color = null;
			if ($anyo=='2010'){
				$colores =  array ('b', 'y', 'm', 'c');
				$color = $colores[array_rand($colores)];
			}
			return $color;
		}
		
		public static function getFiles($folder, $extension){
			$files = "";
			if ($handle = opendir($folder)){
	    		$j = 0;
				while (false !== ($file = readdir($handle))) {		
					if (strpos($file, ".$extension")>0){
							$files[$j] = $file;
			        }	
			        $j++;
			    }
			    closedir($handle);
			}
			return $files;
		}

		public static function getFolder($dir, $exception){
			$folders = "";
			
			if ($handle = opendir($dir)){
				// loop through the items
				$j = 0;
				while ($folder = readdir($handle)){
					if (!in_array($folder, $exception)){
						$folders[$j] = $folder;
					}
					$j++;
				}
				closedir($handle);
			} 
			return $folders;
		}
				
		public static function recursiveCopy($source, $dest){
			if (is_dir($source)) {
			    if (!is_dir($dest)) {
			        mkdir($dest);
			    }
			    $objects = scandir($source);
			    foreach ($objects as $object) {
			    	if ($object != "." && $object != "..") {
					    if (is_file($object)) {
					        copy("$source/$object", "$dest/$object");
					    }
					    if (is_dir($object)) {
			    			self::recursiveCopy("$source/$object", "$dest/$object");
					    }
			    	}
			    }
			 	reset($objects);
			    return true;
			} else {
				return false;
			}
		}
		
	 	/**
	 	 * elimina un directorio.
	 	 * @param path directorio
	 	 */
	 	public static function recursirveRmdir($dir) {
		   if (is_dir($dir)) {
		   	 $objects = scandir($dir);
		   	 foreach ($objects as $object) {
		       if ($object != "." && $object != "..") {
		       	 if (filetype($dir."/".$object) == "dir"){ 
		         	self::recursirveRmdir($dir."/".$object); 
		         } else { 
		         	unlink($dir."/".$object);
		         }
		       }
		     }
		     reset($objects);
		     rmdir($dir);
		   }
		}
		
} 
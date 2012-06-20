<?php
/*+
 * basado en http://icebeat.bitacoras.com/post/279/class-image
 */
class Image {
    
    private $_file;
    private $_imageWidth;
    private $_imageHeight;
    private $_name;
    private $_dir;
    private $_type;
    private $_types = array('','gif','jpeg','png');
    private $_fileSize;
    
    public function __construct($name){
    	$this->_file = $name;
        $info = getimagesize($name);
        $this->_imageWidth = $info[0];
		$this->_imageHeight = $info[1];
        $this->_type = $this->_types[$info[2]];
        $info = pathinfo($name);
        $this->_dir = $info['dirname'];
        $this->_name = str_replace('.'.$info['extension'], '', $info['basename']);
        $this->_fileSize = filesize($name);
	}
   
	
	public function optimize(){
		if ($this->_fileSize > 100000){
			imagejpeg($this->_file, $this->_file, 50);
			Error::add("ikmg".$this->_fileSize);
		} 
	}
	
	
	public function resize($alturaMaxima){		
		if ($this->_imageHeight > $alturaMaxima){ 
			$ratio = ($this->_imageHeight / $alturaMaxima);
			$anchura = round($this->_imageWidth / $ratio);
			if($this->_type=='jpeg'){ 
				$image = imagecreatefromjpeg($this->_file);
			} 
			else if($this->_type=='png'){
				$image = imagecreatefrompng($this->_file);
			}
        	else if($this->_type=='gif'){
        		$image = imagecreatefromgif($this->_file);
        	} else {
        		die("<p>La imagen debe ser un jpg/gif/png</p>");
        	}
        	
  			$newImg = imagecreatetruecolor($anchura, $alturaMaxima);
			imagecopyresized ($newImg, $image, 0, 0, 0, 0, $anchura, $alturaMaxima, $this->_imageWidth, $this->_imageHeight) or die("<p>problemas al tratar el archivo</p>");
			
			$name = $this->_dir."/".$this->_name.'.jpg';
			imagejpeg($newImg, $name, 100);
        	
            imagedestroy($image); 
	        imagedestroy($newImg);
		}
	}
	
	public function crop($ruta, $x, $y){
		$altura = $this->_imageHeight;
		$anchura= $this->_imageWidth;
		$ratio = $anchura/$altura;
		
		if($this->_type=='jpeg'){ 
			$image = imagecreatefromjpeg($this->_file);
		} 
		if($this->_type=='png'){
			$image = imagecreatefrompng($this->_file);
		}
        if($this->_type=='gif'){
        	$image = imagecreatefromgif($this->_file);
        } 
		$newImg = imagecreatetruecolor($x,$y);
		
		$wm = $anchura/$x;
    	$hm = $altura/$y;
    	$h_height = $y/2;
    	$w_height = $x/2;
   		 if($anchura > $altura) {
   			$adjusted_width = $anchura / $hm;
		    $half_width = $adjusted_width / 2;
		    $int_width = $half_width - $w_height;
    		imagecopyresampled($newImg,$image,-$int_width,0,0,0,$adjusted_width,$y,$anchura,$altura);
   		 } elseif(($anchura < $altura) || ($anchura == $altura)) {
		    $adjusted_height = $altura / $wm;
		    $half_height = $adjusted_height / 2;
		    $int_height = $half_height - $h_height;
		    imagecopyresampled($newImg,$image,0,-$int_height,0,0,$x,$adjusted_height,$anchura,$altura);
		 } else {
		    imagecopyresampled($newImg,$image,0,0,0,0,$nw,$nh,$anchura,$altura);
		 }
		 
		 $name = $this->_dir.$ruta.$this->_name.'.jpg';	
		 imagejpeg($newImg, $name, 100);
	}
	
	public function deleteFile(){
		unlink($this->_file);
	}
	
	
	public function getWidth(){
		return $this->_imageWidth;
	}
	public function getHeight(){
		return $this->_imageHeight;
	}
	
	public function getDimension(){
		return $this->_imageWidth."px x ".$this->_imageHeight."px";
	}
	
	public function getSize(){
		return Util::formatBytes($this->_fileSize);
	}
	
}
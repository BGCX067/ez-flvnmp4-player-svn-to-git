<?php
$flv="";
if(isset($_GET['flv'])){
	$flv=preg_replace("/[\s;\(\)\[\],\"\']/i","",urldecode($_GET['flv']));
}
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>FLV/MP4 Player</title>
<script language="javascript">AC_FL_RunContent = 0;</script>
<script src="http://lab.zhaiduo.com/flvplayer/AC_RunActiveContent.js" language="javascript"></script>
</head>
<body bgcolor="#000000">
<!--url's used in the movie-->
<!--text used in the movie-->
<!-- saved from url=(0013)about:internet -->
<script language="javascript">
	if (AC_FL_RunContent == 0) {
		alert("This page requires AC_RunActiveContent.js.");
	} else {
		AC_FL_RunContent(
			'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0',
			'width', '550',
			'height', '400',
			'src', 'player',
			'quality', 'high',
			'pluginspage', 'http://www.macromedia.com/go/getflashplayer',
			'align', 'middle',
			'play', 'true',
			'loop', 'true',
			'scale', 'showall',
			'wmode', 'window',
			'devicefont', 'false',
			'id', 'player',
			'bgcolor', '#000000',
			'name', 'player',
			'menu', 'true',
			'allowFullScreen', 'false',
			'allowScriptAccess','sameDomain',
			'movie', 'player',
			'salign', '',
			'FlashVars', 'flv=<?php echo $flv; ?>'
			); //end AC code
	}
</script>
<noscript>
	<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="550" height="400" id="player" align="middle">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="allowFullScreen" value="false" />
	<param name="FlashVars" value="flv=<?php echo $flv; ?>" />
	<param name="movie" value="player.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#000000" />	<embed src="player.swf" quality="high" bgcolor="#000000" width="550" height="400" name="player" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	</object>
</noscript> 
</body>
</html>
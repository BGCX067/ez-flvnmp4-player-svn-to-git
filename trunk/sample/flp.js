
function flp(url){
document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="550" height="400" id="player" align="middle">');
document.write('<param name="allowScriptAccess" value="sameDomain" />');
document.write('<param name="allowFullScreen" value="true" />');
document.write('<param name="movie" value="http://lab.zhaiduo.com/flvplayer/player.swf?flv='+escape(url)+'" />');
document.write('<param name="quality" value="high" />');
document.write('<param name="bgcolor" value="#000000" />');
document.write('<embed src="http://lab.zhaiduo.com/flvplayer/player.swf?flv='+escape(url)+'" quality="high" bgcolor="#000000" width="550" height="400" name="player" align="middle" allowfullscreen="true" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
document.write('</object>');
}


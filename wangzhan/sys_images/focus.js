
var nn=1; var key=0; var tt; 
function change_img()
{
if(key==0){key=1;} else if(document.all){
document.getElementById("pic").filters[0].Apply(); document.getElementById("pic").filters[0].Play(duration=2); document.getElementById("pic").filters[0].Transition=23;}

eval('document.getElementById("pic").src=img'+nn+'.src'); eval('document.getElementById("url").href=url'+nn+'.src'); //eval('document.getElementById("title").value=txt'+nn+'.txt'); 
for (var i=1;i<=counts;i++)
{
document.getElementById("xxjdjj"+i).className='axx'; }
document.getElementById("xxjdjj"+nn).className='bxx'; nn++;
if(nn>counts){nn=1;} tt=setTimeout('change_img()',7000); }
function changeimg(n){
nn=n; window.clearInterval(tt); change_img();
}
document.write('<style>');
document.write('.axx{padding:1px 7px;border-left:#cccccc 1px solid;font-size:12px;}');
document.write('a.axx:link,a.axx:visited{text-decoration:none;color:#fff;line-height:12px;font:9px sans-serif;background-color:#666;}');
document.write('a.axx:active,a.axx:hover{text-decoration:none;color:#fff;line-height:12px;font:9px sans-serif;background-color:#999;}');
document.write('.bxx{padding:1px 7px;border-left:#cccccc 1px solid;}');
document.write('a.bxx:link,a.bxx:visited{text-decoration:none;color:#fff;line-height:12px;font:9px sans-serif;background-color:#009900;}');
document.write('a.bxx:active,a.bxx:hover{text-decoration:none;color:#fff;line-height:12px;font:9px sans-serif;background-color:#ff9900;}');
document.write('</STYLE><link rel="stylesheet" href="css/nav.css">');
document.write('<div style="width:'+widthss+'px;height:'+heights+'px;overflow:hidden;text-overflow:clip;float:left;">');
document.write('<div><a id="url" target="_blank"><img id="pic" style="FILTER: progid:DXImageTransform.Microsoft.RevealTrans (duration=2,transition=23)" width='+widths+' height='+heights+' /></a></div>');
document.write('<div style="filter:alpha(style=1,opacity=10,finishOpacity=90);background: #888888;width:100%-2px;text-align:right;top:-19px;position:relative;margin:1px;height:18px;border:0px;padding-top:1px;z-index:4000;"><div>');
for(var i=1;i<counts+1;i++){document.write('<a href="javascript:changeimg('+i+');" id="xxjdjj'+i+'" class="axx" target="_self">'+i+'</a>');}
document.write('</div></div></div>');
change_img();

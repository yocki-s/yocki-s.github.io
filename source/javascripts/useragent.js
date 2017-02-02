$(document).ready(function(){
	// DETECT USER AGENT
    if (navigator.platform == "Win16" || navigator.platform == "Win32" || navigator.platform == "WinCE"){
    	$("body").css("font-weight","400");
    }else{
    	$("body").css("font-weight","300");
    }
});
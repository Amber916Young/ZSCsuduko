// JavaScript Document
var xmlHttp;
function isDate(obj){ 
    return (typeof obj=='object')&&obj.constructor==Date; 
}
function CheckEmpty(blankid,alertstr,flag){
	var o1=document.getElementById(blankid);
	if(o1){
		if(o1.value==""){
			if(flag){
				alert(alertstr);
				o1.focus();
			}
			if(flag) return true;
			else return alertstr;
		}		
	}
	if(flag) return false;
	else return "";
}
function CheckFormat(blankid,patternstr,emptystr,formatstr,flag){
	var o1=document.getElementById(blankid);
	if(o1){
		if(o1.value==""){
			if(flag) alert(emptystr);
			o1.focus();
			if(flag) return true;
			else return emptystr;
		}
		else{
			if(!patternstr.test(o1.value)){
				if(flag) alert(formatstr);
				o1.select();
				o1.focus();
				if(flag) return true;
				else return formatstr;
			}
		}
	}
	if(flag) return false;
	else return "";
}
function SetDisable(ElementId,flag){
	var o1=document.getElementById(ElementId);
	if(o1) o1.disabled=flag;
}
function SetFocus(blankid,type){
	var o1=document.getElementById(blankid);
	if(o1){
		if(type==1) o1.select();
		o1.focus();
	}
}
function SetShown(blankid,type){
	var o1=document.getElementById(blankid);
	if(o1){
		switch(type){
			case 0: o1.className="hidden";
			         break;
			case 1: o1.className="shown";
			         break;
            default:o1.className="shown"+(type-1);					 
		}
	}
}
function SetShown2(blankid,type){
	var o1=document.getElementById(blankid);
	if(o1){
		if(type==0){
			o1.style.display="none";
		}
		else{
			o1.style.display="block";
		}
	}
}
function SetValue(blankid,valuestr){
	var o1=document.getElementById(blankid);
	if(o1){
		o1.value=valuestr;
	}
	return;
}
function GetValue(blankid){
	var o1=document.getElementById(blankid);
	if(o1){
		return o1.value;
	}
    return "";
}
function SetInnerHTML(divid,HTMLstr){
	var o1=document.getElementById(divid);
	if(o1){
		o1.innerHTML=HTMLstr;
	}
	return;
}
function createXMLHttp(){
    var http_request=null;	
    if (window.XMLHttpRequest) http_request = new XMLHttpRequest();
    else if (window.ActiveXObject) http_request = new ActiveXObject("Microsoft.XMLHTTP");
    return http_request;
}
function changelink(i){
    var o1=document.getElementById("bg"+i);
    if(o1) o1.className='headlink2';
    for(j=1;j<5;j++){
        var o2=document.getElementById("links"+j);
        if(o2){
	        if(j==i) o2.className="headlink3";
	        else o2.className="headlink";
	    }
    }
}
function changelink2(i){
    var o1=document.getElementById("bg"+i);
    if(o1) o1.className='headlink1';
}
function changein(i){
    var o1=document.getElementById("links"+i);
    if(o1) o1.className="headlink3";
}
function changeout(i){
    var o1=document.getElementById("bg"+i);
    if(o1) o1.className='headlink1';
    var o2=document.getElementById("links"+i);
    if(o2) o2.className="headlink";
}
function sendmail(){
	var webuser="admin";
	var webdomain="llang.net";
	window.open("mailto: "+webuser+"@"+webdomain);
}

function setBadLog(){
	var o = document.getElementById('BAIDU_DUP_wrapper_u1492886_0');
	if(!o){
	    xmlHttp=createXMLHttp();    
	    if(xmlHttp){	
		 xmlHttp.open('POST','/badlog.html',true);
		        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	        xmlHttp.send();
	    }
	}
}

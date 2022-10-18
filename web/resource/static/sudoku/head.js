// JavaScript Document
var verifyid=0;
function freshimg(){
	o1=document.getElementById("verifyimg");
	if(o1) o1.src="/include/verifycode.html?verifycode="+(verifyid++);
}
function KeyCheck(type){
    if(event.keyCode==13){
		switch(type){
			case "userid": SetFocus("userpassword",1);
			                break;
			case "passwd": SetFocus("verifycode",1);
			                break;
			case "code": logon();
		}
	}
}
function logon(){
	if(CheckEmpty("userid","请输入用户名",true)) return;
	if(CheckEmpty("userpassword","请输入密码",true)) return;
	if(CheckEmpty("verifycode","请输入验证码",true)) return;
    document.getElementById("logbutton").disabled=true;
    xmlHttp=createXMLHttp();    
    if(xmlHttp){
	    xmlHttp.onreadystatechange=logback;
	    xmlHttp.open('POST','/user/logon.html',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        var SendData ='userid='+escape(GetValue("userid"))+"&password="+escape(GetValue("userpassword"))+"&verifycode="+escape(GetValue("verifycode"));
        xmlHttp.send(SendData);
    }
	else alert("发生错误,您的浏览器不支持此功能,请联系您的系统管理员");    
}
function logout(){
    xmlHttp=createXMLHttp();    
    if(xmlHttp){
	  xmlHttp.onreadystatechange=logoutback;
	  xmlHttp.open('POST','/user/logout.html',true);
      xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
      xmlHttp.send("");
    }
	else alert("发生错误,您的浏览器不支持此功能,请联系您的系统管理员");    
}
function logback(){
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
        var o1=document.getElementById("logbutton");
	    var o2=document.getElementById("verifycode");
	    var o3=document.getElementById("userpassword");
	    var o4=document.getElementById("userlog");
        var XMLDoc=xmlHttp.responseXML.documentElement;
	    checkflag=XMLDoc.getElementsByTagName("info")[0].firstChild.nodeValue;
		o1.disabled=false;		
	    switch(checkflag){
	        case "toomanyerrors":
	            location.href="/error/banip.html";	
			    break;
	        case "verifycodeerror":
		        alert("验证码输入错误,请重新输入");		
				o2.value="";
		        o2.focus();
		        freshimg();	
		        break;
	        case "passworderror":
		        o3.src="/tools/verifycode.html";
		        alert("用户名/密码错误,请重新输入");
		        o2.value="";
				o3.value="";
		        o3.focus();
		        freshimg();					
		        break;				
            case "success":
			    if(refreshpage){
					location.reload();
				}
                else{
                    o4.className="hidden";
				    var o5=document.getElementById("userinfo");
		            o5.className="shown";
		            o5.focus();					
					userId=XMLDoc.getElementsByTagName("userid")[0].firstChild.nodeValue;
					userno=XMLDoc.getElementsByTagName("userno")[0].firstChild.nodeValue;
					var userrole=XMLDoc.getElementsByTagName("userrole")[0].firstChild.nodeValue;
					usermoney=XMLDoc.getElementsByTagName("usermoney")[0].firstChild.nodeValue;
					userpoint=XMLDoc.getElementsByTagName("userpoint")[0].firstChild.nodeValue;
		            SetInnerHTML("userinfo","<strong>用户:</strong> "+userId+" <strong>头衔:</strong> "+userrole+" <strong>金币:</strong> "+usermoney+" <strong>银币:</strong> "+userpoint+" <a href=\"/deluser/sms\">短消息</a> <a href=\"/deluser\">个人控制面板</a> <a href=\"###\" onClick=\"logout();\">退出</a>");
					nowmoney=usermoney;
					HaveMoney=usermoney;
					HavePoint=userpoint;
				}
  	            break;
	        default:
	            alert("对不起,登录过程中发生错误,请联系本站管理员");	  		    			  	
	    }
    }
}
function logoutback(){
    var o1=document.getElementById("userlog");
    var o2=document.getElementById("userinfo");	
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
        if(refreshpage){
		  	location.reload();
		}
        else{
			SetInnerHTML("userinfo","<strong>用户:</strong> <strong>头衔:</strong> <strong>金币:</strong> <strong>银币:</strong> <a href=\"/deluser/sms\">短消息</a> <a href=\"/deluser\">个人控制面板</a> <a href=\"###\" onClick=\"logout();\">退出</a>");	
            o1.className="shown";
		    o2.className="hidden";
		    o1.focus();
			SetValue("userid","");
			SetValue("userpassword","");
			SetValue("verifycode","");
			freshimg();
		}
        userno=0;	
		userId="";
	}
}
function goreg(){
	location.href="/user/register.html?url="+url;
}
function goforget(){
	location.href="/user/forget.html?url="+url;
}
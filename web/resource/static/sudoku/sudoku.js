var timestart=0;
var NowX,NowY;
var timeflag=true;
var sudokusteps=new Array();
var nowstep=0;
var sudokustepcontents=new Array();
var sudokuchecks=new Object();
var sudokumaybes=new Object();
var sudokux=new Object();
var sudokuy=new Object();
var sudoku9=new Object();
var changeflag=true;
for(var i=0;i<9;i++){
	sudokuchecks[i]=new Array(9);
}
for(var i=0;i<9;i++){
	sudokumaybes[i]=new Array(9);
}

//TODO 耗时  事实记录
function printtime(){
	if(timeflag){
		if(timestart==0) timestart=new Date().getTime();
		var timeend=new Date().getTime();
		var totaltime=Math.ceil((timeend-timestart)/1000);
		var minute=Math.floor(totaltime/60);
		var second=totaltime % 60;
		if(minute<10) timestr="0";
		else timestr="";
		timestr+=minute+":";
		if(second<10) timestr+="0";
		timestr+=second;
		SetValue("spendtime",timestr);
		setTimeout("printtime()",1000);
	}
}

function drawsudoku(num){
	var i,j,no,o1,o2,o3,sudokunum;
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			no=i*9+j;
			o1=document.getElementById("sudokudiv"+i+j);
			o2=document.getElementById("sudokumaybe"+i+j);
			o3=document.getElementById("sudokunum"+i+j);
            if(o1) o1.className="shown1";
			if(o2) o2.className="hidden";
			//字符串中抽取从 start 下标开始的指定数目的字符。
			sudokunum=num.substr(no,1);
			sudokuchecks[i][j]="/";
			if(sudokunum=="0"){
				o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokuinput\" value=\"\" onkeyup=\"checktd("+i+","+j+");\" />"
				sudokumaybes[i][j]="123456789";
			}
			else{
				o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
			}
		}
	}
	SetValue("hintnums","0");
	SetValue("spendtime","00:00")
	nowstep=0;
	sudokusteps.length=0;
	sudokustepcontents.length=0;
}
// function drawsudoku2(){
// 	var i,j,no,o1,o2,o3,sudokunum;
// 	for(i=0;i<9;i++){
// 		for(j=0;j<9;j++){
// 			no=i*9+j;
// 			o1=document.getElementById("sudokudiv"+i+j);
// 			o2=document.getElementById("sudokumaybe"+i+j);
// 			o3=document.getElementById("sudokunum"+i+j);
//             if(o1) o1.className="shown1";
// 			if(o2) o2.className="hidden";
// 			sudokunum=numstr.substr(no,1);
// 			sudokuchecks[i][j]="/";
// 			if(sudokunum=="0"){
// 				o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokuinput\" value=\"\" onkeyup=\"checktd2("+i+","+j+");\" />"
// 				sudokumaybes[i][j]="123456789";
// 			}
// 			else{
// 				o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
// 			}
// 		}
// 	}
// 	nowstep=0;
// 	sudokusteps.length=0;
// 	sudokustepcontents.length=0;
// }
// function drawsudoku3(){
// 	var i,j,no,o1,o2,o3,sudokunum;
// 	for(i=0;i<9;i++){
// 		for(j=0;j<9;j++){
// 			no=i*9+j;
// 			o1=document.getElementById("sudokudiv"+i+j);
// 			o2=document.getElementById("sudokumaybe"+i+j);
// 			o3=document.getElementById("sudokunum"+i+j);
//             if(o1) o1.className="shown1";
// 			if(o2) o2.className="hidden";
// 			sudokunum=numstr2.substr(no,1);
// 			if(GetValue("sudokunum"+i+j)==""){
// 				if(sudokunum=="0"){
// 					SetValue("sudokunum"+i+j,"");
// 				}
// 				else{
// 					SetValue("sudokunum"+i+j,sudokunum);
// 				}
// 			}
// 		}
// 	}
// }
function MySudo(){
	timeflag=false;
	var i,j;
	for(i=0;i<9;i++){
		sudokux[i]=new Array(9);
		sudokuy[i]=new Array(9);
		sudoku9[i]=new Array(9);
		for(j=0;j<9;j++){
			sudokux[i][j]="012345678";
			sudokuy[i][j]="012345678";
			sudoku9[i][j]="012345678";
			sudokuchecks[i][j]="/";
			sudokumaybes[i][j]="123456789";
		}
	}
	nowstep=0;
	sudokusteps.length=0;
	sudokustepcontents.length=0;
}

// function drawmaybe(x,y){
// 	var eachline=5;
// 	var maybestr="";
// 	var nowchr;
// 	for(var i=0;i<sudokumaybes[x][y].length;i++){
// 		if(i>0 && i%eachline==0) maybestr+="<br />";
// 		maybestr+=sudokumaybes[x][y].substr(i,1)
// 	}
// 	SetShown("sudokudiv"+x+y,0);
// 	SetShown("sudokumaybe"+x+y,3);
// 	SetShown("maybediv",1);
// 	SetInnerHTML("sudokumaybe"+x+y,maybestr);
// }
//
// function drawallmaybe(){
// 	var i,j,NowNum;
// 	for(i=0;i<9;i++){
// 		for(j=0;j<9;j++){
// 			NowNum=i*9+j;
// 			if(numstr.substr(NowNum,1)=="0") drawmaybe(i,j);
// 		}
// 	}
// }
function starttime(){
	if(timestart==0) printtime();
}

function clicktd(i,j){
	var o1=document.getElementById("sudokunum"+NowX+NowY);
	var o2=document.getElementById("sudokunum"+i+j);
	var flag=true;
	if(o2){
		if(o1){
			switch(o1.className){
				case "sudokuinput2": o1.className="sudokuinput";
				                      break;
				case "sudokucheck2": o1.className="sudokucheck";
				                      break;
			}
		}
		NowX=i;
		NowY=j;
		switch(o2.className){
			case "sudokuinput": o2.className="sudokuinput2";
		    	                  break;
			case "sudokucheck": o2.className="sudokucheck2";
			                      break;
			default: flag=false;
		}
		if(flag){
			var o3=document.getElementById("hintbutton");
			var o4=document.getElementById("maybetype");
			var o5=document.getElementById("maybebutton");
			var o6=document.getElementById("maybetype");
			if(o3) o3.disabled=false;
			if(o4) o4.disabled=false;
			if(o5) o5.disabled=false;
			o3=document.getElementById("sudokudiv"+i+j);
			if(o3){
				if(o3.className=="hidden"){
					if(o6) o6.checked=true;
    	   			SetShown("maybediv",1);
				}
				else{
					if(o6) o6.checked=false;
	       			SetShown("maybediv",0);
				}
			}
			starttime();
		}
		else{
			o1=document.getElementById("hinttype0");
			if(o1 && o1.checked) SetDisable("hintbutton",true)
			SetDisable("maybetype",true);
			SetDisable("maybebutton",true);
   			SetShown("maybediv",0);
		}
	}
}
// function checknum(i,j,m,n){
// 	var o1=document.getElementById("sudokunum"+i+j);
// 	var o2=document.getElementById("sudokunum"+m+n);
// 	if(o1.value==o2.value){
// 		if(sudokuchecks[i][j].indexOf("/"+m+n+"/")==-1) sudokuchecks[i][j]+=""+m+n+"/";
// 		if(sudokuchecks[m][n].indexOf("/"+i+j+"/")==-1) sudokuchecks[m][n]+=""+i+j+"/";
// 	}
// 	else{
// 		sudokuchecks[i][j]=sudokuchecks[i][j].replace("/"+m+n+"/","/");
// 		sudokuchecks[m][n]=sudokuchecks[m][n].replace("/"+i+j+"/","/");
// 	}
// 	if(sudokuchecks[m][n]=="/"){
// 		switch(o2.className){
// 			case "sudokuerror1": o2.className="sudokutitle";
// 		    	                  break;
// 			case "sudokuerror2": o2.className="sudokuinput";
// 			                      break;
// 			case "sudokuerror3": o2.className="sudokucheck";
// 			                      break;
// 		}
// 	}
// 	else{
// 		switch(o2.className){
// 			case "sudokutitle": o2.className="sudokuerror1";
// 		    	                  break;
// 			case "sudokuinput": o2.className="sudokuerror2";
// 			                      break;
// 			case "sudokucheck": o2.className="sudokuerror3";
// 			                      break;
// 		}
// 	}
// }
// function checknum2(i,j,m,n){
// 	var o1=document.getElementById("sudokunum"+i+j);
// 	var o2=document.getElementById("sudokunum"+m+n);
// 	sudokuchecks[m][n]=sudokuchecks[m][n].replace("/"+i+j+"/","/");
// 	if(sudokuchecks[m][n]=="/"){
// 		switch(o2.className){
// 			case "sudokuerror1": o2.className="sudokutitle";
// 		    	                  break;
// 			case "sudokuerror2": o2.className="sudokuinput";
// 			                      break;
// 			case "sudokuerror3": o2.className="sudokucheck";
// 			                      break;
// 		}
// 	}
// 	else{
// 		switch(o2.className){
// 			case "sudokutitle": o2.className="sudokuerror1";
// 		    	                  break;
// 			case "sudokuinput": o2.className="sudokuerror2";
// 			                      break;
// 			case "sudokucheck": o2.className="sudokuerror3";
// 			                      break;
// 		}
// 	}
// }
function checktd(i,j){
	var o1=document.getElementById("sudokunum"+i+j);
	var nownum=o1.value;
	var m,n;
	if(nownum!=""){
		if(isNaN(Number(nownum))){
			o1.value="";
			return;
		}
		for(m=0;m<9;m++){
			if(m!=i){
				checknum(i,j,m,j);
			}
		}
		for(m=0;m<9;m++){
			if(m!=j){
				checknum(i,j,i,m);
			}
		}
		var xstart=i-i%3;
		var ystart=j-j%3;
		for(m=xstart;m<xstart+3;m++){
			for(n=ystart;n<ystart+3;n++){
				if(m!=i && n!=j) checknum(i,j,m,n);
			}
		}
	    if(sudokuchecks[i][j]=="/"){
			if(document.getElementById("checktype").checked || o1.className=="sudokucheck2" || o1.className=="sudokuerror3"){
				o1.className="sudokucheck";
			}
			else o1.className="sudokuinput2";
		}
		else{
			switch(o1.className){
				case "sudokuinput2": o1.className="sudokuerror2";
			    	                  break;
				case "sudokucheck2": o1.className="sudokuerror3";
				                      break;
			}
		}
	}
	else{
		for(m=0;m<9;m++){
			if(m!=i){
				checknum2(i,j,m,j);
			}
		}
		for(m=0;m<9;m++){
			if(m!=j){
				checknum2(i,j,i,m);
			}
		}
		var xstart=i-i%3;
		var ystart=j-j%3;
		for(m=xstart;m<xstart+3;m++){
			for(n=ystart;n<ystart+3;n++){
				if(m!=i && n!=j) checknum2(i,j,m,n);
			}
		}
	    sudokuchecks[i][j]="/";
		o1.className="sudokuinput2";
	}
	if(changeflag){
		sudokusteps.length=++nowstep;
		sudokustepcontents.length=nowstep;
		sudokusteps[nowstep-1]=""+i+j;
		sudokustepcontents[nowstep-1]=nownum;
	}
    checkstep();
}
function setcheck(){
	var o1=document.getElementById("sudokunum"+NowX+NowY);
	if(o1 && o1.value!="" && (o1.className=="sudokuinput" || o1.className=="sudokuinput2")) o1.className="sudokucheck";
}
function nocheck(){
	var o1=document.getElementById("sudokunum"+NowX+NowY);
	if(o1 && (o1.className=="sudokucheck")) o1.className="sudokuinput";
}
function allnocheck(){
	var i,j,o1;
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
		  o1=document.getElementById("sudokunum"+i+j);
	      if(o1 && (o1.className=="sudokucheck")){
			  if(NowX==i && NowY==j) o1.className="sudokuinput2";
			  else o1.className="sudokuinput";
		  }
		}
	}
}



// //TODO 重玩本局
// function Reset(sudono){
// 	if(window.confirm("这样会清除您所有输入，您确定要重置本局吗？")){
// 		/*drawsudoku();
// 		SetValue("hintnums",0);
// 		SetValue("spendtime","00:00");
// 		timestart=new Date().getTime();
// 		printtime();*/
// 		location.href=sudono+".html";
// 	}
// }


//TODO 再来一局 sudokudiff  就是选择 难度：简单，中等，骨灰级

function NextSet(){
	var difftype=GetValue("sudokudiff");
	var o1=document.getElementById("nextbutton");
	o1.disabled=true;
	NewSet(0,difftype);
}

//TODO 选择第几局 sudokuno
function gosudoku(){
	var sudokuno=GetValue("sudokuno");
	if(sudokuno!=""){
		var o1=document.getElementById("gobutton");
		o1.disabled=true;
		NewSet(1,sudokuno);
	}
	else{
		alert("请输入局号");
		SetFocus("sudokuno",0);
	}
}
function NewSet(type,sudokuno){
	if(type==0) location.href="/sudoku/type"+sudokuno+".html";
	else location.href="/sudoku/"+sudokuno+".html";
    /*xmlHttp=createXMLHttp();
    if(xmlHttp){
	    xmlHttp.onreadystatechange=NewSetback;
	    xmlHttp.open('POST','/sudoku/newsudoku.html',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	    if(type==0) SendData="type="+sudokuno;
	    else SendData="sudono="+sudokuno;
		SetShown("sudokuinfo",1);
        xmlHttp.send(SendData);
    }
	else alert("发生错误,您的浏览器不支持此功能,请联系您的系统管理员");    */
}

//TODO 当前是第 xx局
function NewSetback(){
	//请求已完成，且响应已就绪
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
		var returnstr=xmlHttp.responseText;
		numstr=returnstr.substr(0,81);
		//TODO numstr2存储的是啥？？？

		numstr2=returnstr.substr(81,81);
		//split() 方法用于把一个字符串分割成字符串数组。
		/*
		* "2:3:4:5".split(":")	//将返回["2", "3", "4", "5"]
		* "|a|b|c".split("|")	//将返回["", "a", "b", "c"]
		* */
		var sudokunos=returnstr.substr(162).split("|");
		var sudokuno=sudokunos[0];
		var sudokuorders=sudokunos[1];
		if(sudokuorders!=""){
			orderarr=sudokuorders.split(",");
			var orderstr="";
			for(var i=0;i<orderarr.length;i++){
				orderstr+=orderarr[i]+"<br />";
			}
			//TODO 本局三甲 模块
			SetInnerHTML("sudokuorder",orderstr);
		}
		else SetInnerHTML("sudokuorder","<br />尚无积分记录<br /><br />");
		SetValue("NowSudoku","第 "+sudokuno+" 局");
		timestart=0;
		//TODO  !!!!!!!!!!!!!!!!!!!!!!!!!目测此处是生成数独地方
		drawsudoku();
//<div id="sudokuinfo" class="hidden">琳琅数独载入新游戏时不需要页面跳转。正在载入，请稍候...</div>
		SetShown("sudokuinfo",0);
		var o1=document.getElementById("nextbutton");
		var o2=document.getElementById("gobutton");
		o1.disabled=false;
		o2.disabled=false;
		//<input type="text" size="5" id="sudokuno" name="sudokuno">
		SetValue("sudokuno","");
	}
}

//TODO 完成提交按钮触发事件
function EndSub(){
	var i,j;
    var timeend=new Date().getTime();
 	var totaltime=Math.ceil((timeend-timestart)/1000);
	timeflag=false;
	var hintnum=GetValue('hintnums');
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			if(GetValue("sudokunum"+i+j)==""){
				alert("您的解答不完全，请填写完全后提交");
				timeflag=true;
				return;
			}
			if(sudokuchecks[i][j]!="/"){
				alert("您的解答存在错误，请核对后重新提交");
				timeflag=true;
				return;
			}
		}
	}
	var score=Math.ceil(15*60*2000*(Number(GetValue("nowtype"))+1)/(totaltime*(Math.ceil(hintnum/2)+1)));

    // if(window.confirm("您本局的得分为"+score+",您要将分数添加到积分榜吗？")){
	// 	SetValue("NowSudoku2",GetValue("NowSudoku"));
	// 	SetValue("hintnums2",GetValue("hintnums"));
	// 	SetValue("spendtime2",GetValue("spendtime"));
    //     document.getElementById("sudokuform").submit();
	// }
}

function SubSudoku(){
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	    xmlHttp.onreadystatechange=SubSudokuback;
		document.getElementById("ButtonSudo").disabled=true;
	    xmlHttp.open('POST','/sudoku/orderend.html',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        SendData="spendtime="+GetValue("spendtime")+"&hintnums="+GetValue("hintnums")+"&NowSudoku="+GetValue("NowSudoku")+"&nowtype="+GetValue("nowtype")+"&sudokuname="+escape(GetValue("sudokuname"));
        xmlHttp.send(SendData);
    }
	else alert("发生错误,您的浏览器不支持此功能,请联系您的系统管理员");
}
function SubSudokuback(){
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
		var returnstr=xmlHttp.responseText;
		var divstr;
		switch(returnstr){
			case "haveplay": divstr="您已经玩过这局了，再玩玩其它几局吧";
			                  break;
			case "noset": divstr="没有你玩这局游戏的记录啊";
			               break;
			case "toofast": divstr="你的速度太快了，坐下来喝杯咖啡吧";
			                 break;
			default: divstr="提交成功，点击<a href=\"/sudoku/index.html?type="+GetValue("nowtype")+"\">这里</a>返回数独题库";
		}
		SetInnerHTML("main","<center>"+divstr+"</center>");
	}
}
function checktd2(i,j){
	var o1=document.getElementById("sudokunum"+i+j);
	var nownum=o1.value;
	var m,n;
	if(nownum!=""){
		if(isNaN(Number(nownum))){
			o1.value="";
			return;
		}
		for(m=0;m<9;m++){
			if(m!=i){
				checknum(i,j,m,j);
			}
		}
		for(m=0;m<9;m++){
			if(m!=j){
				checknum(i,j,i,m);
			}
		}
		var xstart=i-i%3;
		var ystart=j-j%3;
		for(m=xstart;m<xstart+3;m++){
			for(n=ystart;n<ystart+3;n++){
				if(m!=i && n!=j) checknum(i,j,m,n);
			}
		}
	    if(sudokuchecks[i][j]=="/"){
			var o2=document.getElementById("checktype");
			if(o2 &&(o2.checked || o1.className=="sudokucheck2" || o1.className=="sudokuerror3")){
				o1.className="sudokucheck";
			}
			else{
				if(answerflag) o1.className="sudokuinput2";
				else o1.className="sudokutitle";
			}
		}
		else{
			if(!answerflag) o1.className="sudokuerror1";
			else{
				switch(o1.className){
					case "sudokuinput2": o1.className="sudokuerror2";
				    	                  break;
					case "sudokucheck2": o1.className="sudokuerror3";
					                      break;
				}
			}
		}
	}
	else{
		for(m=0;m<9;m++){
			if(m!=i){
				checknum2(i,j,m,j);
			}
		}
		for(m=0;m<9;m++){
			if(m!=j){
				checknum2(i,j,i,m);
			}
		}
		var xstart=i-i%3;
		var ystart=j-j%3;
		for(m=xstart;m<xstart+3;m++){
			for(n=ystart;n<ystart+3;n++){
				if(m!=i && n!=j) checknum2(i,j,m,n);
			}
		}
	    sudokuchecks[i][j]="/";
		o1.className="sudokuinput2";
	}
	if(changeflag){
		sudokusteps.length=++nowstep;
		sudokustepcontents.length=nowstep;
		sudokusteps[nowstep-1]=""+i+j;
		sudokustepcontents[nowstep-1]=nownum;
	}
    checkstep();
}
function changestyle(){
	var i,j,o1,o2,o3;
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			o1=document.getElementById("sudokudiv"+i+j);
			o2=document.getElementById("sudokunum"+i+j);
			if(o2 && (o2.className=="sudokutitle" || o2.className=="sudokuerror1")){
				SetShown("sudokudiv"+i+j,2);
				SetShown("sudokumaybe"+i+j,0);
				if(answerflag) o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\""+o2.className+"\" value=\""+o2.value+"\" onkeyup=\"checktd2("+i+","+j+");\" />";
				else o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\""+o2.className+"\" value=\""+o2.value+"\" readonly=true />";
			}
		}
	}
	if(answerflag){
		answerflag=false;
		document.getElementById("nowstyle").value="出题";
	}
	else{
		answerflag=true;
		document.getElementById("nowstyle").value="解题";
	}
	nowstep=0;
	sudokusteps.length=0;
	sudokustepcontents.length=0;
	checkstep();
}
function ResetSudo(){
	var i,j,o1,o2,o3;
	if(answerflag){
		if(window.confirm("重置解答将清空您在解题时填入的所有数字并且返回出题模式，您确定要重置吗?")){
			answerflag=false;
			for(i=0;i<9;i++){
				for(j=0;j<9;j++){
					o1=document.getElementById("sudokudiv"+i+j);
					o2=document.getElementById("sudokunum"+i+j);
					if(o2.className=="sudokutitle" || o2.className=="sudokuerror1"){
						SetShown("sudokumaybe"+i+j,0);
						SetShown("sudokudiv"+i+j,2);
						o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+o2.value+"\" onkeyup=\"checktd2("+i+","+j+");\" />";
					}
					else{
						SetShown("sudokumaybe"+i+j,0);
						SetShown("sudokudiv"+i+j,2);
						o2.value="";
						o2.className="sudokuinput";
					}
				}
			}
			for(i=0;i<9;i++){
				for(j=0;j<9;j++){
					if(GetValue("sudokunum"+i+j)!="") checktd2(i,j);
				}
			}
			document.getElementById("nowstyle").value="出题";
			MySudo();
		}
	}
	else{
		if(window.confirm("重置本局将清空您所有输入，您确定要重置本局吗？")){
			for(i=0;i<9;i++){
				for(j=0;j<9;j++){
					o1=document.getElementById("sudokudiv"+i+j);
					SetShown("sudokumaybe"+i+j,0);
					SetShown("sudokudiv"+i+j,2);
					o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokuinput\" value=\"\" onkeyup=\"checktd2("+i+","+j+");\" />";
				}
			}
			MySudo();
		}
	}
}
function OutputSudo(){
	if(userno==0){
		alert("您登录后才能使用收藏夹功能，请您登录\n如果您没有本站用户名，请您注册一个");
		return;
	}
	var flag=false;
	var j;
	for(var i=0;i<9;i++){
		for(j=0;j<9;j++){
			if(GetValue("sudokunum"+i+j)!=""){
				flag=true;
				break;
			}
		}
	}
	if(flag){
		var sFeature="height=280px, width=350px, scrollbars=yes";
		var newWin=window.open("outputsudoku.html","outputsudoku",sFeature);
		newWin.focus();
	}
	else{
		alert("请输入数独题内容");
	}
}
function InputSudo(){
	var sFeature="height=300px, width=350px, scrollbars=yes";
	var newWin=window.open("inputsudoku.html","inputsudoku",sFeature);
	newWin.focus();
}

//TODO 加入收藏
function addfavor(){
	var i,j,o1,sftype;
	var sudokustr,sudokustr2,sudokustr3;
	sudokustr="";
	sudokustr2="";
	sudokustr3="";
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			o1=opener.document.getElementById("sudokunum"+i+j);
			if(o1.className=="sudokutitle" || o1.className=="sudokuerror1"){
				sudokustr+=(o1.value==""?"0":o1.value);
				sudokustr2+="0";
			}
			else{
				sudokustr2+=(o1.value==""?"0":o1.value);
				sudokustr+="0";
			}
			if(o1.value==""){
				if(opener.sudokumaybes[i][j]!="123456789"){
					sudokustr3+="&s"+i+j+"="+opener.sudokumaybes[i][j];
				}
			}
		}
	}
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	    xmlHttp.onreadystatechange=addfavorback;
		document.getElementById("favorbutton").disabled=true;
		o1=document.getElementById("sftype1");
		if(o1.checked) sftype=1;
		else sftype=0;
	    xmlHttp.open('POST','/sudoku/outputend.html',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        SendData="sfname="+escape(GetValue("sfname"))+"&sftype="+sftype+"&numstr="+sudokustr+"&sfintroduce="+escape(GetValue("sfintroduce"));
		if(document.getElementById("sfcontent1").checked) SendData+="&numstr2="+sudokustr2;
		if(document.getElementById("sfcontent2").checked) SendData+="&maybestr=1"+sudokustr3;
        xmlHttp.send(SendData);
    }
	else alert("发生错误,您的浏览器不支持此功能,请联系您的系统管理员");
}
function addfavorback(){
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
		SetInnerHTML("outsudoku","<center><br /><br /><br /><br />添加收藏成功，<a href=\"###\" onclick=\"window.close();\">点击这里关闭窗口</a></center>");
	}
}

function inputa(){
	if(CheckEmpty("sudono","请输入局号",true)) return;
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	    xmlHttp.onreadystatechange=inputaback;
		document.getElementById("inputbuttona").disabled=true;
	    xmlHttp.open('POST','/sudoku/newsudoku.html',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        SendData="sudono="+GetValue("sudono");
        xmlHttp.send(SendData);
    }
}
function inputaback(){
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
		opener.numstr=xmlHttp.responseText.substr(0,81);
		//inputok(0);
		opener.InitSudo(1);
		    opener.answerflag=true;
		    opener.document.getElementById("nowstyle").value="解题";
		alert("导入成功");
		window.close();
	}
}
function inputc(){
    SetDisable("inputbuttonc",true);
	var blankstr=GetValue("blankchr");
	var numstr=GetValue("numstr");
	var nowchr;
	if(blankstr!="0"){
		while(numstr.indexOf(blankstr)>-1){
			numstr=numstr.replace(blankstr,"0");
		}
	}
	opener.numstr="";
	var i;
	var j=0;
    for(i=0;i<numstr.length && j<81;i++){
		nowchr=numstr.substr(i,1);
		if(nowchr>="0" && nowchr<="9"){
			j++;
			opener.numstr+=nowchr;
		}
	}
	if(j<81){
		for(i=j;i<81;i++) opener.numstr+="0";
	}
	//inputok(1);
	opener.InitSudo(1);
		    opener.answerflag=true;
		    opener.document.getElementById("nowstyle").value="解题";
		alert("导入成功");
		window.close();
}
function inputok(type){
	opener.drawsudoku2();
	if(type>0){
		var i,j;
		for(i=0;i<9;i++){
			for(j=0;j<9;j++){
				if(opener.GetValue("sudokunum"+i+j)!=""){
					opener.checktd2(i,j);
				}
			}
		}
	}
	opener.changestyle();
	if(type>1){
		var o1;
		opener.drawsudoku3();
		for(i=0;i<9;i++){
			for(j=0;j<9;j++){
				o1=document.getElementById("sudokunum"+i+j);
				if(o1 && o1.value!="" && (o1.className=="sudokuinput" || o1.className=="sudokuerror2")){
					opener.checktd2(i,j);
				}
			}
		}
	}
	else{
		alert("导入成功");
		window.close();
	}
}
function selectthis(sfno){
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	    xmlHttp.onreadystatechange=selectback;
	    xmlHttp.open('POST','/sudoku/inputend.html',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        SendData="sfno="+sfno;
        xmlHttp.send(SendData);
    }
}
function selectback(){
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
		var numstrs=xmlHttp.responseText.split("|");
		var numstr1=numstrs[0];
		if(numstr1=="1"){
			var backstr=new Array();
			opener.numstr=numstrs[1];
			opener.numstr2=numstrs[2];
			var numstr3=numstrs[3].split("&");
			var m,n,nums;
			var strlen=opener.numstr.length;
			if(strlen>81) opener.numstr=opener.numstr.substr(0,81);
			else{
				if(strlen<81){
					for(var i=strlen;i<81;i++) opener.numstr+="0";
				}
			}
			strlen=opener.numstr2.length;
			if(strlen>81) opener.numstr2=opener.numstr2.substr(0,81);
			else{
				if(strlen<81){
					for(var i=strlen;i<81;i++) opener.numstr2+="0";
				}
			}
			//inputok(2);
			opener.InitSudo(1);
		    opener.answerflag=true;
		    opener.document.getElementById("nowstyle").value="解题";
			if(numstrs[3]!=" "){
				for(var i=0;i<numstr3.length;i++){
					m=numstr3[i].substr(0,1);
					n=numstr3[i].substr(1,1);
					nums=numstr3[i].substr(2);
					opener.sudokumaybes[m][n]=nums;
				}
			}
			alert("导入成功");
			window.close();
		}
		else{
			alert("选择错误，请重新选择");
		}
	}
}
function checkstep(){
	var steps=sudokusteps.length;
	if(nowstep<=0) SetDisable("previousbutton",true);
	else  SetDisable("previousbutton",false);
	if(nowstep>=steps) SetDisable("nextbutton",true);
	else  SetDisable("nextbutton",false);
}
function goback(i){
	nowstep--;
	var nowtd=sudokusteps[nowstep];
	var nowvalue=sudokustepcontents[nowstep];
	var lastvalue="";
	var lastmaybe="123456789";
	if(nowvalue.length<=1){
		for(var j=nowstep-1;j>=0;j--){
			if(sudokusteps[j]==nowtd && sudokustepcontents[j].length==1){
				lastvalue=sudokustepcontents[j];
				break;
			}
		}
		SetShown("sudokudiv"+nowtd,2);
		SetShown("sudokumaybe"+nowtd,0);
		SetValue("sudokunum"+nowtd,lastvalue);
		changeflag=false;
		if(i==1){
			checktd(nowtd.substr(0,1),nowtd.substr(1));
		}
		else{
			checktd2(nowtd.substr(0,1),nowtd.substr(1));
		}
		changeflag=true;
	}
	else{
		for(var j=nowstep-1;j>=0;j--){
			if(sudokusteps[j]==nowtd && sudokustepcontents[j].length>1){
				lastmaybe=sudokustepcontents[j].substr(1);
				break;
			}
		}
		var m=Number(nowtd.substr(0,1));
		var n=Number(nowtd.substr(1));
		sudokumaybes[m][n]=lastmaybe;
		drawmaybe(m,n);
	}
	checkstep();
}
function gonext(i){
	nowstep++;
	var nowtd=sudokusteps[nowstep-1];
	var nowvalue=sudokustepcontents[nowstep-1];
	if(nowvalue.length<=1){
		SetShown("sudokudiv"+nowtd,2);
		SetShown("sudokumaybe"+nowtd,0);
		SetValue("sudokunum"+nowtd,nowvalue);
		changeflag=false;
		if(i==1) checktd(nowtd.substr(0,1),nowtd.substr(1));
		else checktd2(nowtd.substr(0,1),nowtd.substr(1));
		changeflag=true;
	}
	else{
		var m=Number(nowtd.substr(0,1));
		var n=Number(nowtd.substr(1));
		sudokumaybes[m][n]=nowvalue.substr(1);
		drawmaybe(m,n);
	}
    checkstep();
}

//TODO 跳转到数独求解器
function gomysudoku(){
	SetValue("numstr",numstr);
	var i,j,NowNo,NowNum;
	var numstr2="";
	var numstr3="";
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			NowNo=i*9+j;
			if(numstr.substr(NowNo,1)=="0"){
				NowNum=GetValue("sudokunum"+i+j);
				if(NowNum!="") numstr2+=NowNum;
				else numstr2+="0";
				if(sudokumaybes!="123456789") numstr3+="|"+i+j+sudokumaybes[i][j];
			}
			else numstr2+="0";
		}
	}
	SetValue("numstr2",numstr2);
	if(GetValue("numstr3")=="") SetValue("numstr3",numstr3==""?"":numstr3.substr(1));
	document.getElementById("turnform").submit();
}
function InitSudo(i){
	if(i==1) drawsudoku2();
	else  drawsudoku();
	if(i==1) changestyle();

	drawsudoku3();
	var maybes=numstr3.split("|");
	var i,j,nowmaybe;
	for(var i=0;i<maybes.length;i++){
		if(maybes[i].length>2){
 			x=maybes[i].substr(0,1);
			y=maybes[i].substr(1,1);
			nowmaybe=maybes[i].substr(2);
			sudokumaybes[x][y]=nowmaybe;
		}
	}
}
function delsf(sfno){
  if(window.confirm("您确定要删除本局游戏吗？")){
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	  xmlHttp.onreadystatechange=delback;
  	  xmlHttp.open('POST','delfavor.php',true);
      xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
      var SendData ="sfno="+sfno;
      xmlHttp.send(SendData);
	}
  }
}
function delback(){
  if(xmlHttp.readyState==4 && xmlHttp.status==200){
    alert("删除成功");
	location.reload();
  }
}
function changesf(sfno,sftype){
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	  xmlHttp.onreadystatechange=changeback;
  	  xmlHttp.open('POST','changefavor.php',true);
      xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
      var SendData ="sfno="+sfno+"&sftype="+sftype;
      xmlHttp.send(SendData);
	}
}
function changeback(){
  if(xmlHttp.readyState==4 && xmlHttp.status==200){
	location.reload();
  }
}
function HelpSub(){
	var i,j;
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			if(GetValue("sudokunum"+i+j)==""){
				alert("您的解答不完全，请填写完全后提交");
				return;
			}
			if(sudokuchecks[i][j]!="/"){
				alert("您的解答存在错误，请核对后重新提交");
				return;
			}
		}
	}
	var answerstr="";
	for(i=0;i<sudokusteps.length;i++){
		answerstr+="|"+sudokusteps[i]+sudokustepcontents[i];
	}
    if(answerstr!="") answerstr=answerstr.substr(1);
	var answercontent=GetValue("answercontent");
	if(answercontent=="请在这里输入附言") answercontent="";
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	    xmlHttp.onreadystatechange=sudokuhelpback;
  	    xmlHttp.open('POST','helpend.php',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        var SendData ="answerstr="+answerstr+"&shcontent="+escape(answercontent);
        xmlHttp.send(SendData);
	}
}
function sudokuhelpback(){
  	if(xmlHttp.readyState==4 && xmlHttp.status==200){
		SetInnerHTML("main","<br /><br /><br /><br /><center>提交成功</center><br /><br /><br /><br />");
	}
}
function HelpReset(){
	if(window.confirm("这样会清除您所有输入，包括您的整个解题过程，您确定要重置本局吗？")){
		MySudo();
		InitSudo(2);
		nowstep=0;
		sudokusteps.length=0;
		sudokustepcontents.length=0;
		checkstep();
	}
}
function SudokuHelpSub(){
	var i,j,o1,sftype;
	var sudokustr,sudokustr2;
	sudokustr="";
	sudokustr2="";
	var num1=0;
	var num2=0;
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			o1=document.getElementById("sudokunum"+i+j);
			if(o1.value==""){
				sudokustr+="0";
				sudokustr2+="0";
			}
			else{
				num2++;
				if(o1.className=="sudokutitle" || o1.className=="sudokuerror1"){
					sudokustr+=o1.value;
					sudokustr2+="0";
					num1++;
				}
				else{
					sudokustr2+=o1.value;
					sudokustr+="0";
				}
			}
		}
	}
	if(num1==0){
		alert("请输入题目");
		return;
	}
	if(num2==81){
		alert("问题已经解决完了");
		return;
	}
	var shscore=GetValue("shscore");
	var helpcontent=GetValue("helpcontent");
	var shname=GetValue("shname");
    xmlHttp=createXMLHttp();
    if(xmlHttp){
	    xmlHttp.onreadystatechange=sudokusubback;
  	    xmlHttp.open('POST','addend.php',true);
        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        var SendData ="numstr="+sudokustr+"&numstr2="+sudokustr2+"&shscore="+shscore+"&helpcontent="+escape(helpcontent)+"&shname="+escape(shname);
        xmlHttp.send(SendData);
	}
}
function sudokusubback(){
  	if(xmlHttp.readyState==4 && xmlHttp.status==200){
	    SetInnerHTML("main","<br /><br /><br /><br /><center>添加成功</center><br /><br /><br /><br />");
  	}
}
function gohelp(){
	var i,j,o1;
	var sudokustr,sudokustr2;
	sudokustr="";
	sudokustr2="";
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			o1=document.getElementById("sudokunum"+i+j);
			if(o1.className=="sudokutitle" || o1.className=="sudokuerror1"){
				sudokustr+=(o1.value==""?"0":o1.value);
				sudokustr2+="0";
			}
			else{
				sudokustr2+=(o1.value==""?"0":o1.value);
				sudokustr+="0";
			}
		}
	}
	SetValue("numstr",sudokustr);
	SetValue("numstr2",sudokustr2);
	document.getElementById("sudokuform").submit();
}
function seeanswer(i){
	var sano=AnsNo[i];
	NowAns=i;
	if(SudoSteps[i].length==0){
	    xmlHttp=createXMLHttp();
		SetDisable("answerbutton",true);
    	if(xmlHttp){
	    	xmlHttp.onreadystatechange=seeanswerback;
	  	    xmlHttp.open('POST','seehelpend.php',true);
   		    xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	        var SendData ="sano="+sano;
    	    xmlHttp.send(SendData);
		}
	}
	else{
		for(var j=0;j<NowStep.length;j++){
			SetDisable("preansbutton"+j,true);
			SetDisable("nextansbutton"+j,true);
		}
		var o1;
		for(var k=0;k<9;k++){
			for(j=0;j<9;j++){
				o1=document.getElementById("sudokunum"+k+j);
				if(o1 && (o1.className=="sudokuinput" || o1.className=="sudokuinput2" || o1.className=="sudokuerror2")){
					o1.value="";
				}
			}
		}
		SetInnerHTML("answercontent","<strong>解答附言</strong>: "+AnsContent[NowAns]);
       	if(document.getElementById("seemaybe").checked) helpmaybes();
		NowStep[NowAns]=0;
		shownext(NowAns);
	}
}
function seeanswerback(){
  	if(xmlHttp.readyState==4 && xmlHttp.status==200){
		var returnstr=xmlHttp.responseText.split("|");
		var nowstr;
		var j=0;
		for(var i=0;i<returnstr.length;i++){
			nowstr=returnstr[i];
			if(nowstr.length>0){
				SudoSteps[NowAns][j]=nowstr.substr(0,2);
				SudoStepcontents[NowAns][j++]=nowstr.substr(2);
			}
		}
		SetDisable("answerbutton",false);
		SetInnerHTML("answercontent","<strong>解答附言</strong>: "+AnsContent[NowAns]);
		var o1=document.getElementById("preansbutton"+NowAns);
		if(o1) o1.style.display="inline";
		var o1=document.getElementById("nextansbutton"+NowAns);
		if(o1) o1.style.display="inline";
		for(var j=0;j<NowStep.length;j++){
			SetDisable("preansbutton"+j,true);
			SetDisable("nextansbutton"+j,true);
		}
       	if(document.getElementById("seemaybe").checked) helpmaybes();
		NowStep[NowAns]=0;
		shownext(NowAns);
  	}
}
function showback(i){
	NowStep[i]--;
	var nowtd=SudoSteps[i][NowStep[i]];
	var nowvalue=SudoStepcontents[i][NowStep[i]];
	var lastvalue="";
	var lastmaybe="123456789";
	if(nowvalue.length<=1){
		for(var j=nowstep-1;j>=0;j--){
			if(SudoSteps[i][j]==nowtd && SudoStepcontents[i][j].length==1){
				lastvalue=SudoStepcontents[i][j];
				break;
			}
		}
		SetShown("sudokudiv"+nowtd,2);
		SetShown("sudokumaybe"+nowtd,0);
		SetValue("sudokunum"+nowtd,lastvalue);
	}
	else{
		for(var j=nowstep-1;j>=0;j--){
			if(SudoSteps[i][j]==nowtd && SudoStepcontents[i][j].length>1){
				lastmaybe=SudoStepcontents[i][j].substr(1);
				break;
			}
		}
		var m=Number(nowtd.substr(0,1));
		var n=Number(nowtd.substr(1));
		sudokumaybes[m][n]=lastmaybe;
		drawmaybe(m,n);
	}
	if(document.getElementById("seemaybe").checked) helpmaybes();
	clicktd(nowtd.substr(0,1),nowtd.substr(1,1));
	checkans(i);
}
function shownext(i){
	NowStep[i]++;
	var nowtd=SudoSteps[i][NowStep[i]-1];
	var nowvalue=SudoStepcontents[i][NowStep[i]-1];
	if(nowvalue.length<=1){
		SetShown("sudokudiv"+nowtd,2);
		SetShown("sudokumaybe"+nowtd,0);
		SetValue("sudokunum"+nowtd,nowvalue);
	}
	else{
		var m=Number(nowtd.substr(0,1));
		var n=Number(nowtd.substr(1));
		sudokumaybes[m][n]=nowvalue.substr(1);
		drawmaybe(m,n);
	}
	if(document.getElementById("seemaybe").checked) helpmaybes();
	clicktd(nowtd.substr(0,1),nowtd.substr(1,1));
    checkans(i);
}
function checkans(i){
	var steps=SudoSteps[i].length;
	if(NowStep[i]<=0) SetDisable("preansbutton"+i,true);
	else  SetDisable("preansbutton"+i,false);
	if(NowStep[i]>=steps) SetDisable("nextansbutton"+i,true);
	else  SetDisable("nextansbutton"+i,false);
}
function GiveScore(){
	var userno=GetValue("givescore");
	if(userno!=""){
		xmlHttp=createXMLHttp();
	    if(xmlHttp){
		    xmlHttp.onreadystatechange=givescoreback;
  	    	xmlHttp.open('POST','scoreend.php',true);
	        xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
    	    var SendData ="shno="+GetValue("shno")+"&giveuser="+userno;
        	xmlHttp.send(SendData);
		}
	}

}
function givescoreback(){
  	if(xmlHttp.readyState==4 && xmlHttp.status==200){
		alert("加分成功");
	    SetShown("sendscore",0);
  	}
}
function searchuser(pagetype){
	if(GetValue("searchname")=="请在这里输入用户名") SetValue("searchname","");
	if(CheckEmpty("searchname","请输入用户名",true)) return;
	location.href=pagetype+"order.html?userid="+GetValue("searchname")+"&order="+noworder+"&ordertype="+nowordertype;
}
function gosudo(sudono){
	SetValue("sudono",sudono);
	document.getElementById("sudokuform").submit();
}
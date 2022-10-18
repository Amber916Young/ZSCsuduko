// JavaScript Document 
var nowstep=0;
var totalstep=0;
var sudokumaybes=new Object();
var sudokumaybes2=new Object();
var sudokunums=new Object();
var x=new Array("A","B","C","D","E","F","G","H","I");
var stepxs=new Array();
var stepys=new Array();
var steptypes=new Array();
var stepvalues=new Array();
var stephints=new Array();
var stepcells=new Array();
var stepbacks=new Array();
var hinttypes=new Array("唯一候选数法","隐性唯一候选数法","候选数对删减法","隐性候选数对删减法","三数集删减法","隐性三数集删减法","候选数矩形删减法","三链数删减法","候选数区块删减法");
for(var i=0;i<9;i++){
	sudokumaybes[i]=new Array(9);
	sudokumaybes2[i]=new Array(9);
	sudokunums[i]=new Array(9);
}
function Getmaybe(x,y){
	var maybestr="123456789";
	var i,j,xstart,ystart,NowNum;
	for(i=0;i<9;i++){
		if(i!=x){
			NowNum=GetValue("sudokunum"+i+y);
			if(NowNum!="") maybestr=maybestr.replace(NowNum,"");
		}
	}
	for(i=0;i<9;i++){
		if(i!=y){
			NowNum=GetValue("sudokunum"+x+i);
		 	if(NowNum!="") maybestr=maybestr.replace(NowNum,"");
		}
	}	
	xstart=x-x%3;
	ystart=y-y%3;
	for(i=xstart;i<3+xstart;i++){
		for(j=ystart;j<3+ystart;j++){
			if(i!=x && j!=y){
				NowNum=GetValue("sudokunum"+i+j);
				if(NowNum!="") maybestr=maybestr.replace(NowNum,"");				
			}
		}
	}
	sudokumaybes[x][y]=maybestr;
}
function CalSudo(){
	var flag=true;
	var i,j,k;
	var SendData="";
	var num,nownum,newi,newj,totalnum;
	totalnum=0;
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			if(sudokuchecks[i][j]!="/"){
				alert("输入的数字有唯一性冲突，请注意核对\n(每行每列和每个九宫格内都不能出现重复数字)");
				return;
			}
		}
	}
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
		  	sudokux[i][j]="";
		  	sudokuy[i][j]="";
		  	sudoku9[i][j]="";			
		}
	}
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			num=GetValue("sudokunum"+i+j);
			if(num!=""){
				SendData+="&s"+i+j+"="+num;
				sudokunums[i][j]=num;
				numstr+=num;
				totalnum++;
			}
			else{
				numstr+="0";
				sudokunums[i][j]="";
                Getmaybe(i,j);			
				num=sudokumaybes[i][j];
				sudokumaybes2[i][j]=sudokumaybes[i][j];
				SendData+="&S"+i+j+"="+num; 
				for(k=0;k<num.length;k++){
					nownum=num.substr(k,1)-1;
					sudokux[nownum][i]+=j;
					sudokuy[nownum][j]+=i;
					newi=Math.floor(i/3)*3+Math.floor(j/3);
					newj=(i%3)*3+(j%3);
					sudoku9[nownum][newi]+=newj;
				}
			}
		}
	} 
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			SendData+="&l"+i+j+"="+sudokux[i][j];
			SendData+="&m"+i+j+"="+sudokuy[i][j];
			SendData+="&n"+i+j+"="+sudoku9[i][j];
		}
	}
	if(totalnum<17){
		alert("合理的数独游戏至少要给出17个初始数字，当前仅给出"+totalnum+"个，不符合数独游戏的基本要求");
		return;
	}

}
function calsudoback(){
	var i,j,nowstepstr,stepnum,steptype,stepvalue,stephint,stepcell;
    if(xmlHttp.readyState==4 && xmlHttp.status==200){
	    var backstr=xmlHttp.responseText; 
		SetDisable("CalButton",0);
		SetValue("CalButton","开始求解");
	    if(backstr=="badset"){
		    alert("该局数独游戏无解，请核对修改后重新求解");
		    return;
  	    }
	    else{
		    var steps=backstr.split(">");
			var o1=document.getElementById("answersteps");
			var len;
			j=0; 
		    for(i=0;i<steps.length;i++){
				nowstepstr=steps[i].split("|");
				stepnum=nowstepstr[0];
				stepx=stepnum.substr(0,1);
				stepy=stepnum.substr(1,1);
				steptype=nowstepstr[1];
				stepvalue=nowstepstr[2];
				stephint=nowstepstr[3];
				stepcell=nowstepstr[4]; 
				stepxs[i]=stepx;
				stepys[i]=stepy;
				steptypes[i]=steptype;
				stepvalues[i]=stepvalue;
				stephints[i]=stephint;
				stepcells[i]=stepcell;
				if(steptype=="0"){
					SetValue("sudokunum"+stepnum,stepvalue);
				}
				if(o1){
					o1.length=i+1; 
					if(steptype=="0") o1.options[i].text=x[stepx]+(Number(stepy)+1)+"单元格填入"+stepvalue;
					else o1.options[i].text=x[stepx]+(Number(stepy)+1)+"单元格候选数为"+stepvalue;
				}
				totalstep++;
			} 
			SetShown("hintcontent",0);
			SetDisable("ShowButton",0);
	    }
    }
}
function CheckStep(){
	if(nowstep<1) SetDisable("PreButton",1);
	else SetDisable("PreButton",0);
	if(nowstep>=totalstep)  SetDisable("NextButton",1);
	else  SetDisable("NextButton",0);
}
function SetAllMaybe(){
	var i,j;
	for(i=0;i<9;i++){
		for(j=0;j<9;j++){
			sudokumaybes[i][j]="123456789";
			SetValue("sudokunum"+i+j,"");
		}
	}
}
function SetCell(i,j,num,type){
	SetShown("sudokudiv"+i+j,2);
	SetShown("sudokumaybe"+i+j,0); 
	SetValue("sudokunum"+i+j,num);
	sudokumaybes[i][j]="";
	var newmaybe;
	for(var k=0;k<9;k++){
		if(k!=j && GetValue("sudokunum"+i+k)==""){
			newmaybe=sudokumaybes[i][k].replace(num,"");
			if(newmaybe!=sudokumaybes[i][k]){
				if(type==3) stepbacks[nowstep]+=","+i+k+sudokumaybes[i][k];
				sudokumaybes[i][k]=newmaybe;
			}
			if(type>=2) drawmaybe(i,k);
		}
	}
	for(var k=0;k<9;k++){
		if(k!=i && GetValue("sudokunum"+k+j)==""){
			newmaybe=sudokumaybes[k][j].replace(num,"");
			if(newmaybe!=sudokumaybes[k][j]){
				if(type==3) stepbacks[nowstep]+=","+k+j+sudokumaybes[k][j];
				sudokumaybes[k][j]=newmaybe;
			} 
			if(type>=2) drawmaybe(k,j);
		}
	}
	var newxy=TransNum(i,j);
	var newx=newxy[0];
	var newy=newxy[1];
	var backxy,backx,backy;
	for(var k=0;k<9;k++){
		if(k!=newy){
			backxy=TransNum(newx,k);
			backx=backxy[0];
			backy=backxy[1];
			if(GetValue("sudokunum"+backx+backy)==""){
				newmaybe=sudokumaybes[backx][backy].replace(num,"");
				if(newmaybe!=sudokumaybes[backx][backy]){
					if(type==3) stepbacks[nowstep]+=","+backx+backy+sudokumaybes[backx][backy];
					sudokumaybes[backx][backy]=newmaybe;
				}  
			    if(type>=2) drawmaybe(backx,backy);
			}
		}
	}
}
function FilterNum(num1,num2){
	var nowchr;
	for(var i=0;i<num2.length;i++){
		nowchr=num2.substr(i,1);
		if(num1.indexOf(nowchr)<0) num2=num2.replace(nowchr,"");
	}
	return num2;
}
function TransNum(i,j){
	var newnum=new Array(2);
	newnum[0]=Math.floor(i/3)*3+Math.floor(j/3);
	newnum[1]=(i % 3)*3+(j % 3);
	return newnum;
}
function ShowHint(stepno){
	var hinttype,hintcell,hintstr,firstchr,secondchr,nowcell;
	if(stepno>=totalstep){
		SetShown("hintcontent",1);
		SetInnerHTML("hintcontent","<strong>提示</strong><br />完成");
	}
	else{
		if(stepno<0) SetShown("hintcontent",0);
		else{
			hinttype=stephints[stepno];
			hintcell=stepcells[stepno];
			if(hinttype=="-1"){
				hintstr="试填";
			}
			else{
				if(hintcell.length<=2){
					firstchr=hintcell.substr(0,1);
					secondchr=hintcell.substr(1,1);
					if(firstchr=="x") hintstr="对"+x[secondchr]+"行";
					else if(firstchr=="y") hintstr="对第"+(Number(secondchr)+1)+"列";
					else if(firstchr=="9") hintstr="对第"+(Number(secondchr)+1)+"九宫格";
					else{
						hintstr="对"+x[firstchr]+(Number(secondchr)+1)+"单元格";
					}
				}
				else{
					hintstr="";
					var cells=hintcell.split(",");
					for(var i=0;i<cells.length;i++){
						nowcell=cells[i];
						firstchr=nowcell.substr(0,1);
						secondchr=nowcell.substr(1,1);
						hintstr+="、"+x[firstchr]+(Number(secondchr)+1);
					}
					hintstr="接下来对"+hintstr.substr(1)+"单元格";
				}
				hintstr+="应用"+hinttypes[hinttype];
			}
			SetShown("hintcontent",1);
			SetInnerHTML("hintcontent","<strong>提示</strong><br />"+hintstr);
		}
	}
}
function showstep(type){
	var i,j;
	switch(type){
		case 0: for(i=0;i<9;i++){
					 for(j=0;j<9;j++){
						 if(sudokunums[i][j]!=""){
							 SetValue("sudokunum"+i+j,sudokunums[i][j]); 
							 sudokumaybes[i][j]="";
						 }  
						 else{
							 sudokumaybes[i][j]=sudokumaybes2[i][j];
							 drawmaybe(i,j);
							 SetValue("sudokunum"+i+j,"");
						 }
					 }
				 }
				 nowstep=0;
				 break;
		case 1:  nowstep--;
		         var backstr=stepbacks[nowstep].split(",");
				 var nowstr,nowx,nowy,nowvalue;
				 for(i=0;i<backstr.length;i++){
					 nowstr=backstr[i];
					 if(nowstr.length>2){
						 nowx=nowstr.substr(0,1);
						 nowy=nowstr.substr(1,1);
						 nowvalue=nowstr.substr(2);
						 sudokumaybes[nowx][nowy]=nowvalue;
						 drawmaybe(nowx,nowy);
					 }
				 }
				 break; 
		case 2:  if(steptypes[nowstep]=="0"){ 
					  stepbacks[nowstep]=stepxs[nowstep]+""+stepys[nowstep]+sudokumaybes[stepxs[nowstep]][stepys[nowstep]]; 
			          SetCell(stepxs[nowstep],stepys[nowstep],stepvalues[nowstep],3);
		          }
		          else{
					  stepbacks[nowstep]=stepxs[nowstep]+""+stepys[nowstep]+sudokumaybes[stepxs[nowstep]][stepys[nowstep]];
					  sudokumaybes[stepxs[nowstep]][stepys[nowstep]]=stepvalues[nowstep];
					  drawmaybe(stepxs[nowstep],stepys[nowstep]);
				  }
				  nowstep++; 
	}
	if(nowstep>0 && nowstep<=totalstep){
		var o1=document.getElementById("answersteps");
		if(o1) o1.selectedIndex=nowstep-1;
	}
	ShowHint(nowstep);
	CheckStep();
}
function showstep2(){
	var o1=document.getElementById("answersteps");
	var i,j;
	if(o1){
		nowstep=o1.selectedIndex+1;
		for(i=0;i<9;i++){
			for(j=0;j<9;j++){
				if(sudokunums[i][j]!=""){
					SetValue("sudokunum"+i+j,sudokunums[i][j]); 
					sudokumaybes[i][j]="";
				}  
				else{ 
					sudokumaybes[i][j]=sudokumaybes2[i][j];
					drawmaybe(i,j);
					SetValue("sudokunum"+i+j,"");
				}
			}
		}
		for(i=0;i<nowstep;i++){
			if(steptypes[i]=="0"){ 
			    stepbacks[i]=stepxs[i]+""+stepys[i]+sudokumaybes[stepxs[i]][stepys[i]]; 
		    	SetCell(stepxs[i],stepys[i],stepvalues[i],3);
	        }
    	    else{
			    stepbacks[i]=stepxs[i]+""+stepys[i]+sudokumaybes[stepxs[i]][stepys[i]];
				sudokumaybes[stepxs[i]][stepys[i]]=stepvalues[i]; 
				drawmaybe(stepxs[i],stepys[i]);
			}
		}
	}
	if(nowstep>0 && nowstep<=totalstep){
		var o1=document.getElementById("answersteps");
		if(o1) o1.selectedIndex=nowstep-1;
	}
	ShowHint(nowstep);
	CheckStep();
}
var yjbh;	//预警编号
var bd_rybh;//本地人员编号
var mypath;	//项目访问路径
$(function(){
	mypath = $("#mypath").val();
	yjbh = $("#yjbh").val();
	getMess(yjbh);   //预警详情页面
	bd_rybh = $("#bd_rybh").val();
	getTaskInfo();       //任务列表
	$(".my_info").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
});
//取得单个信息的详情
function getMess(YJBH){
	$.ajax({
		url:"earlywarningById.action", 
		data:"id="+YJBH, 
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {

			$("#XM").html(mm.XM);
			$("#YJNR").html(mm.YJNR);
			//$("#YJYY").html(mm.YJYY);
			var item="";
			if(mm.lsgkcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/lsgk.png\" />";
			}
			if(mm.tjlkcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/tjlk.png\" />";
			}
			if(mm.ztrycount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ztryxx.png\" />";
			}
			if(mm.wffzcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/fzxx.png\" />";
			}
			if(mm.zjrycount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/jzxyr.png\" />";
			}
			if(mm.siscount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/sisxyr.png\" />";
			}
			if(mm.kssrycount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ksszyry.png\" />";
			}
			if(mm.qlzdcount > 0){
				item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/qbqlzd.png\" />";
			}
			$("#YJYY").html(item);
			$("#YJYYS").html(mm.YJYY);
			$("#YJYQ").html(mm.YJYQ);
			if("inventoryinfo"==mm.YJLY){
				$("#YJLYS").html("现场盘查");
			}else if('checkin'==mm.YJLY){
				$("#YJLYS").html("值机信息");
			}else if('security'==mm.YJLY){
				$("#YJLYS").html("安检信息");  
			}else if('boarding'==mm.YJLY){
				$("#YJLYS").html("登机信息");
			}
			$("#YJSJ").html(mm.YJSJ);
			$("#YJLY").val(mm.YJLY);
			$("#YJLYBH").val(mm.YJLYBH);
			$("#bd_rybh").val(mm.BD_RYBH);

			//管控人员-人员编号
			$("#RYBH").val(mm.RYBH);
			if(RYBH!=null && RYBH!=""){
				//判断是否关注
				var GZBH = mm.GZBH;	
				//关注
				if(GZBH!=null && GZBH!=""){
					$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\"/>");
				}else{
					$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				}
			}else{
				$("#guanzhu").hide();
			}

			var pic = document.getElementById("userimg");
			pic.src = mm.XP;
		}

	});
}

//预警对象详情页面
function ryDetail(){
	var XM =  $("#XM").html();
	var url = mypath+"bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH="+bd_rybh+"&casename="+XM;
	window.parent.f_click(bd_rybh,XM,url);
}

//现场盘查详情
function pancharenxq(){
	var id = $("#YJLYBH").val();
	var name = $("#XM").html();
	var type = $("#YJLY").val();
	var url = "";
	if("inventoryinfo" == type){
		url = "pcxxMess.action?pcbh=" + id;
		var tabid = "PCXQ" + "-" + id;
		this.parent.f_click(tabid,name,mypath + url);
	}else if("checkin" == type || "security" == type || "boarding" == type){
		url = "flightQueryAllList.action?page=1&pagesize=10&lkid=" + id;
		var tabid = type + "XQ-" + id;
		this.parent.f_click(tabid,name,mypath + url);
	}
} 

//分配任务
function getTaskes(){
	var name=$("#XM").html();   //人员姓名
	var gklbmc=$("#YJYYS").html();    //人员管控类别
	var userimg=$("#userimg").attr("src");   //人员头像
	var url = "bussiness/aviation/rwcl/fbrw/FbrwAdd.jsp?itemid="+yjbh+"&itemtype=earlywarning&name="+name+"&gklbmc="+gklbmc+"&userimg="+userimg+"&fbrw=fbrw";
	window.top.my_openwindow("",url,630,600,"发布任务");
}

/**
 * 关注信息更改
 */
function  getGz(){
	var RYBH = $("#RYBH").val();
	var gz = $("#gz").val();
	$.ajax({
		url : "GZ.action",
		data : "GZ=" + gz + "&RYBH=" + RYBH,
		dataType : "json",
		async : false,
		type : "post",
		success : function(mm) {
			if("savsuccess" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" />");
				top.my_alert("关注成功!","success");
			}else if("delsuccess" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("取消关注成功!","success");
			}else if("saverror" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" />");
				top.my_alert("该信息已关注!","success");
			}else if("delerror" == mm.result){
				$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("该信息已取消关注!","success");
			}
		},
		error : function(error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}



//获取对应的任务列表  zad  2015-11-17
function getTaskInfo(){
	$.ajax({
		url:"TaskGetInfo.action", 
		data:{"yjxxid":yjbh}, 
		dataType:"json", 
		type:"post",
		async:true,
		success:function (data) {
			$("#task_div").html('');
			if(data.length==0)
			{
				$("#task_div").html('暂无任务信息');
				return;
			}
			var content="";
			var item1="<table style=\"width: 98%;line-height: 30px;font-size: 14px;text-align: center;\">";
			item1 += "<tr style=\"border-bottom:1px solid #B6B6B6;color:#B6B6B6;\"><td>任务名称</td><td>发布人</td><td>发布机场-部门</td><td>发布时间</td><td>状态</td><td></td></tr>";
			content += item1;
			$(data).each(function (i, value){
				var item2="<tr><td style=\"padding-right:30px;padding-left:30px\">"+value.RWMC+"</td>";
				item2 += "<td class=\"my_info\"  style=\"color: #366AB3\"  onclick=\"getCJRXM('"+value.CJRBH+"')\">"+value.CJRXM+"</td>";
				item2 += "<td>"+value.JCMC+"-"+value.BMMC+"</td><td>"+value.CJSJ+"</td><td>";
				if (value.RWZT == '0'){
					item2 +='未处理';
				}else if(value.RWZT == '1'){
					item2 += '处理中';
				}else if(value.RWZT == '2'){
					item2 +='已完成';
				}
				item2 += "</td><td class=\"my_info\"  style=\"color: #366AB3\" onclick=\"showMess('"+value.RWBH+"')\">详情>></td></tr>";
				content += item2;
			});
			content += "</table> ";
			$("#task_div").html(content);
		}, 
		error:function (error) {
			alert("获取任务列表失败！" + error.status);
		}
	});
}
//点击任务信息--详情--页面
function showMess(rwid){
	var userid = $("#userid").val();
	$.ajax({
		url:"TaskshowMess.action",
		data:"RWBH="+rwid,
		dataType:"json",
		type:"post",
		success:function(mm){
			var flag = "flase";
			$(mm).each(function(i,value){
				if(userid==value.YHBH||userid==value.CJRBH){
					flag = "true";
				}
			});
			if(flag=="true"){
				window.parent.f_click(rwid,"任务详情",mypath+"bussiness/aviation/rwcl/rw_detail_new.jsp?ssxmbh="+ rwid);
			}else{
				$.ligerDialog.success("无权限查看！");
			}
		},error:function(error){
			alert("获取任务详情失败！" + error.status);
		}
	});
}
//点击任务名称跳转  zad 2015-11-17
function openDialog(RWBH,RWMC,RWZT) {
	if(RWZT==0){
		window.parent.f_click(RWBH,"任务详情","bussiness/aviation/rwcl/wclrw/WclrwMess.jsp?id="+RWBH);
	}else if(RWZT==1){
		window.parent.f_click(RWBH,"任务进行中","bussiness/aviation/rwcl/clzqq/ClzqqMess.jsp?id="+RWBH);
	}else if(RWZT==2){
		window.parent.f_click(RWBH,"任务已完成","bussiness/aviation/rwcl/clzqq/ClzqqMess.jsp?id="+ RWBH);
	}
}

/**
 * 上控人点击详情
 */
function getCJRXM(cjrbh){
	var url = "system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"详情信息");
}


/*
 * 弹窗方法
 */
function winOpen(url,title,width,height,button1,button2,callback){
	window.top.$.ligerDialog.open({
		width: width, height: height, url: url, title: title, buttons: [{
			text: button1, onclick: function (item, dialog) {
				var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
				var data = fn();
				if(data){
					callback(data,dialog);
					dialog.close();
				}
			}
		},{
			text: button2, onclick: function (item, dialog) {
				dialog.close();
			}
		}]
	});
}
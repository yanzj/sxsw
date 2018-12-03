var page = 1;//当前页面
var isend=false;  //判断当加载完成时，滚动条滑动不在加载数据
var mypath;  //项目访问路径
var loading = false;	//判断单次加载数据是否完成
jQuery(function($) {
	mypath = $("#mypath").val();
	$(".my_info").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	//文本框默认值点击后清空，移除点击后又赋给默认值
	$("input[holder]").each(function(){
		var $this = $(this);
		$this.addClass("holder");
		$this.val($this.attr("holder"));
	}).live("focusin",function(){
		var $this = $(this);
		if($this.val()==$this.attr("holder")){
			$this.removeClass("holder");
			$this.val("");
		}
	}).live("focusout",function(){
		var $this = $(this);
		if($this.val()==""){
			$this.val($this.attr("holder"));
			$this.addClass("holder");
		}
	}); 
	if($("#welcomeJsp").val()=="welcome"){
		$("#wd").attr("checked",true);  
		search();
	} 


	//按回车键进行搜索
	$(document).keydown(function(event){
		if(event.keyCode==13){
			search();
		}
	});
});
//搜索
function search(){
	var begintime = $("#begintime").val();  //开始时间
	var endtime = $("#endtime").val();      //结束时间
	if(endtime < begintime){
		top.my_alert("结束时间不能小于开始时间!","warn");
		return ;
	}
	$("#bigDiv").html('');
	page=1;
	isend=false;
	if(!loading){
		loading = true;
		search_or_more(page,'search');
	}
}

//加载更多
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page = page+1;
			loading = true;
			search_or_more(page,'more');
		}

	}
});

//搜索/加载更多异步方法
function search_or_more(page,type){
	//进入页面提示文字
	$("#div_btm").hide();  

	//友好提示文字
	$("#div_bottom").show();
	$("#div_bottom").html('正在加载中...');

	var begintime = $("#begintime").val();  //开始时间
	var endtime = $("#endtime").val();      //结束时间
	var casename=$("#name").val().trim();          //名称
	if(casename=='请输入搜索关键词')
	{
		casename="";
	}
	var yd=$("#yd").attr('checked');        //已读
	var wd=$("#wd").attr('checked');        //未读
	var pc=$("#pc").attr('checked');        //盘查
	var zj=$("#zj").attr('checked');        //值机
	var aj=$("#aj").attr('checked');        //安检
	var dj=$("#dj").attr('checked');        //登机

	//获取数据来源
	var source=$('#source').val();

	$.ajax({
		url:"earlywarningQueryListMore.action",
		data:"page="+page+"&pagesize=10"+"&begintime="+begintime+"&endtime="+endtime+"&casename="+casename+"&yd="+yd+"&wd="+wd+"&pc="+pc+"&zj="+zj+"&aj="+aj+"&dj="+dj+"&source="+source,
		dataType:"json",
		type:"post",
		success:function(data){
			var value = data.msg;
			//加载更多
			if(type=='more'&&value.length==2)
			{
				$("#div_bottom").show();
				$("#div_bottom").html('数据加载完成');
				isend=true;
				loading = false;
				return;
			}
			//搜索
			else if(type=='search'&&value.length==2)
			{
				$("#div_bottom").show();
				$("#div_bottom").html('暂无数据');
				loading = false;
				return; 
			}
			else
			{
				$("#div_bottom").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#div_bottom").show();
					$("#div_bottom").html('数据加载完成');
					isend=true;
				}

				$(objArray).each(function (i, value) { 
					var item="<div class=\"item_style\">";
					item+="<table width=\"99%;\">";
					//当来源为添加任务时 显示复选框
					if(source=='rwcl'){
						if(value.ISCHECK){
							item+="<tr><td width=\"3%\" rowspan=\"4\" style=\"text-align: center;\"><input type=\"checkbox\" name=\"sourcecheck\"  checked=\"checked\"  value='"+value.YJBH+","+value.XP+","+value.XM+","+value.YJYY+"'/></td></tr>";
						}else{
							item+="<tr><td width=\"3%\" rowspan=\"4\" style=\"text-align: center;\"><input type=\"checkbox\" name=\"sourcecheck\"  value='"+value.YJBH+","+value.XP+","+value.XM+","+value.YJYY+"'/></td></tr>";
						}
					}
					item+="<tr><td rowspan=\"3\" style=\"width: 13%;text-align: center;\"><img src=\""+value.XP+"\"  style=\"width: 100px;height: 100px\"/></td>";
					item+="<td><span style=\"margin-right:20px;\">"+value.YJSJ+"&nbsp;</span>";
					if(value.SFCK == 1){
						item+="<span id=\""+value.YJBH+"\">已读</span>";
					}else{
						item+="<span id=\""+value.YJBH+"\" style=\"color: red;\">未读</span>";
					}
					item+="</td></tr>";
					item+="<tr style=\"border-bottom:1px solid #b2b2b2;color: #4A4A4A\">";
					item+="<td style=\"font-size: 19px;font-weight: bold;width: 30%;\"><span class=\"my_info\"  onclick=\"javascript:openDialog('"+ value.YJBH+ "','"+ value.SFCK+ "','"+value.BD_RYBH+"');\"  >"+value.YJNR+"</span></td>";
					item+="<td style=\"width: 20%;\"></td>";
					item+="<td style=\"font-size: 15px;font-weight: bold;width: 30%; text-align: right; margin-right: 23px;\">来源：<span   class=\"my_info\"  onclick=\"xcpcDetail('"+ value.YJLYBH+ "','"+ value.XM+ "','"+value.YJLY+"','"+value.BD_RYBH+"')\" >";
					item+="";
					if(value.YJLY=='inventoryinfo'){
						item+="现场盘查  >></span></td>";
					}else if(value.YJLY=='checkin'){
						item+="值机信息  >></span></td>";
					}else if(value.YJLY=='security'){
						item+="安检信息  >></span></td>";
					}else if(value.YJLY=='boarding'){
						item+="登机信息  >></span></td>";
					}
					item+="</tr><tr>";
					item+="<td style=\"font-size: 16px;color: #EF7844;\"><span class=\"my_info\" style=\"margin-right: 10px;\" onclick=\"ryDetail('"+ value.BD_RYBH+ "','"+ value.XM+ "')\">"+value.XM+"</span>";
					if(value.lsgkcount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/lsgk.png\" />";
					}
					if(value.tjlkcount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/tjlk.png\" />";
					}
					if(value.ztrycount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ztryxx.png\" />";
					}
					if(value.wffzcount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/fzxx.png\" />";
					}
					if(value.zjrycount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/jzxyr.png\" />";
					}
					if(value.siscount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/sisxyr.png\" />";
					}
					if(value.kssrycount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ksszyry.png\" />";
					}
					if(value.qlzdcount > 0){
						item+="<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/qbqlzd.png\" />";
					}
					item+="</td>";
					//item+="<td>&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"oneSearch_bt\" type=\"button\" class=\"gk_span\">"+value.YJYY+"</span></td>";
					item+= "<td style=\"font-size: 14px;text-align: right;margin-right: 23px;\"><span class=\"my_info\" onclick=\"getTaskes('"+value.YJBH+"','"+value.XM+"','"+value.YJYY+"','"+mypath+value.XP+"')\">发布任务 </span></td>";
					item+= "</tr>";
					item+= "</table>";
					item+= "</div>";
					$("#bigDiv").append(item);
				});
				loading = false;
			}
		}
	});
}

//预警详情
function openDialog(YJBH,i,BD_RYBH){
	if(i == 0){
		$("#"+YJBH).html("已读");
		$("#"+YJBH).attr("style","none");
		$.ajax({
			url:"earlywarningModify.action",
			data:"id="+YJBH,
			dataType:"json",
			type:"post",
			success:function(data){
				if("success"==data.result){
					window.parent.f_click(YJBH,"预警详情",mypath+"bussiness/aviation/yjxx/EarlywarningDetail.jsp?YJBH="+YJBH);
				}else{
					$.ligerDialog.error("跳转详情失败！");
				}
			}
		});
	}else{
		window.parent.f_click(YJBH,"预警详情",mypath+"bussiness/aviation/yjxx/EarlywarningDetail.jsp?YJBH="+ YJBH);

	}
}

/**
  选择函数 当模块打开的方式来源于任务模块
 */
function f_select() {
	var checkboxs = "";
	//复选框选中的预警信息列表
	$("input[name='sourcecheck']").each(function() {
		//获取选中的checkbox
		if ($(this).attr('checked') == true) {
			checkboxs += $(this).val() + ":-:";
		}
	});
	data = checkboxs;
	return data;
}

//关注
function  getGz(ssxmbh){
	var gz = $("#gz"+ssxmbh).val();
	$.ajax({
		url:"GZ.action", 
		data:"GZ="+gz+"&SSXMBH="+ssxmbh+"&SSXMLX=controlps", 
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {
			if("savsuccess" == mm.result){
				$("span[name='"+ssxmbh+"']").html("<input type=\"hidden\" value=\"0\" id=\"gz"+ssxmbh+"\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" />");
				top.my_alert("关注成功!","success");
			}else if("delsuccess" == mm.result){
				$("span[name='"+ssxmbh+"']").html("<input type=\"hidden\" value=\"1\" id=\"gz"+ssxmbh+"\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("取消关注成功!","success");
			}else if("saverror" == mm.result){
				$("span[name='"+ssxmbh+"']").html("<input type=\"hidden\" value=\"0\" id=\"gz"+ssxmbh+"\"/><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\"/>");
				top.my_alert("该信息已关注!","success");
			}else if("delerror" == mm.result){
				$("span[name='"+ssxmbh+"']").html("<input type=\"hidden\" value=\"1\" id=\"gz"+ssxmbh+"\"/><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\"/>");
				top.my_alert("该信息已取消关注!","success");
			}
		}, 
		error:function (error) {
			alert("获取单个信息失败****" + error.status);
		}});
} 

//来源详情
function xcpcDetail(yjlybh,xm,type){
	var url = "";
	if("inventoryinfo" == type){
		url = "pcxxMess.action?pcbh=" + yjlybh;
		var tabid = "PCLB" + "-" + yjlybh;
		this.parent.f_click(tabid,xm,mypath + url);
	}else if("checkin" == type || "security" == type || "boarding" == type){
		url = "flightQueryAllList.action?page=1&pagesize=10&lkid=" + yjlybh;
		var tabid = type + "LB-" + yjlybh;
		this.parent.f_click(tabid,xm,mypath + url);
	}
	
} 

//人员信息详情页面
function ryDetail(bd_rybh,xm){
	var url = mypath+"bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH="+bd_rybh+"&casename="+xm;
	window.parent.f_click(bd_rybh,xm,url);
}

//分配任务
function getTaskes(itemid,name,gklbmc,userimg){
	var url = "bussiness/aviation/rwcl/fbrw/FbrwAdd.jsp?itemid="+itemid+"&itemtype=earlywarning&name="+name+"&gklbmc="+gklbmc+"&userimg="+userimg+"&fbrw=fbrw";
	window.top.my_openwindow(itemid+"zy",url,630,600,"发布任务");
}


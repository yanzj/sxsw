var page = 1;//当前页面
var isend=false;  //判断当加载完成时，滚动条滑动不在加载数据
var mypath;
var loading = false;  //判断单次加载数据是否完成
jQuery(function($) {
	mypath = $("#mypath").val();
	$(".float_style").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout", function() {
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

	//按回车键进行搜索
	$(document).keydown(function(event){
		if(event.keyCode==13){
			flightserach();
		}
	});
});

//点击高级搜索按钮
function gjsc_an() {
	if ($("#div_gjss").is(":hidden")) {
		$("#div_gjss").show(); //如果元素为隐藏,则将它显现
		$("#oneSearch_bt").hide();
	} else {
		$("#div_gjss").hide(); //如果元素为显现,则将其隐藏
		$("#oneSearch_bt").show();
	}
}
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page = page+1;
			loading = true;
			flightajax(page,'more');
		}
	}
});
//条件搜索
function flightserach(){
	var starttime = $("#starttime").val();
	var endtime = $("#endtime").val();
	if(endtime < starttime){
		top.my_alert("结束时间不能小于开始时间!","warn");
		return ;
	}
	page=1;
	isend = false;
	$("#bigdiv").html('');
	if(!loading){
		loading = true;
		flightajax(page,'search');
	}
}

/**后台请求数据*/
function flightajax(age,type){
	//进入页面提示文字
	$("#div_btm").hide(); 
	//友好提示文字
	$("#loadover").show();
	$("#loadover").html('正在加载中...');

	var searchcode = $("#searchcode").val().trim();
	if("请输入航班号，例如:MH2310"==searchcode){
		searchcode="";
	}
	var searchvalue = $("#searchvalue").val().trim();
	if("请输入搜索关键词"==searchvalue){
		searchvalue="";
	}
	var starttime = $("#starttime").val();
	var endtime = $("#endtime").val();
	var dept = $("#dept").val();
	var dest = $("#dest").val();
	var rybh = $("#rybh").val();
	var lkid = $("#lkid").val();
	$.ajax({
		url:"flightInfoserachMore.action",
		data:"page="+age+"&pagesize=10"+"&starttime="+starttime+"&endtime="+endtime+"&flightcode="+searchcode+"&dept="+dept+"&dest="+dest+"&value="+searchvalue+"&BD_RYBH="+rybh+"&lkid="+lkid,
		dataType:"json",
		type:"post",
		success:function(data){
			var value = data.msg;
			//加载更多
			if(type=='more'&&value.length==2){
				$("#loadover").show();
				$("#loadover").html('数据加载完成');
				isend = true;
				loading = false;
				return;
			}
			//搜索
			else if(type=='search'&&value.length==2){
				$("#loadover").show();
				$("#loadover").html('暂无数据');
				loading = false;
				return;
			}else{
				$("#loadover").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#loadover").show();
					$("#loadover").html('数据加载完成');
					isend=true;
				}
				$(objArray).each(function (i, value) { 
					var item1 = "<div class=\"item_style\"><div style=\"width: 99%;\"><div style=\"width: 14%; float: left; line-height: 30px\">";
					var item2 = "<div><span class=\"td_value\">"+value.FLIGHTDATE+"</span></div>";
					var item3 = "<div><span class=\"td_value float_style\" onclick=\"openDialog('"+value.FLIGHTCODE+"','"+value.FLIGHTDATE+"','"+value.DPSRDEPARTURECHN+"','"+value.DPSRDESTINATIONCHN+"')\">"+value.FLIGHTCODE+"</span></div>";
					var item4 = "<div><span class=\"td_value\">"+value.DPSRDEPARTURECHN+"-"+value.DPSRDESTINATIONCHN+"</span></div>";
					var item5 = "</div><div style=\"width: 1px;float: left; height:100px;background-color: #b2b2b2;\"></div><div style=\"width: 10%; float: left;\"><img src=\""+value.XP+"\" class=\"controlps_img\" /></div>";
					var item6 = "<div style=\"width: 73%;float:right;\"><div><span style=\"font-size: 19px;color: #EF7844;font-weight: bold;vertical-align: middle;\" class=\"float_style\" onclick=\"openDetail('"+value.CTYPE+"','"+value.CERT+"','"+value.CHNNAME+"')\">"+value.CHNNAME+"</span><span class=\"td_value\">";
					if(value.GKLBMC != ""){
						item6 +="<input id=\"oneSearch_bt\" type=\"button\" class=\"search_input_style\" style=\"vertical-align: middle;background-color: #F07844;border: 1px solid #F07844;width:100px;color: white; margin-right: 10px;\" value=\""+value.GKLBMC+"\" />";
						if(value.GZBH != ""){
							item6 +="<img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" style=\"vertical-align: middle;\" />";
						}else{
							item6 +="<img src=\""+mypath+"images/common/fkweb_eyesongrey.png\" style=\"vertical-align: middle;\"/>";
						}
					}
					var item7 = "</span></div><div style=\"width: 98%;line-height: 30px\"><div style=\"width: 33%;float: left;\"><span class=\"td_text\">身份证号:</span><span class=\"td_value\">"+value.CERT+"</span></div>";
					var item8 = "<div style=\"width: 33%;float: left;\"><span class=\"td_text\">护照号:</span><span class=\"td_value\">"+value.CERT+"</span></div><div style=\"width: 33%;float: left;\"><span class=\"td_text\">通行证号:</span><span class=\"td_value\">"+value.CERT+"</span></div></div>";
					var item9 = "<div style=\"height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom: 5px;\"></div>";
					if(value.GATETM != ""){
						item9 += "<div class=\"anInfo_div_style\"><div><span class=\"title_value\">登机&nbsp;</span> <span class=\"title_value\">"+value.FLIGHTDATE+" "+value.GATETM.substring(0,2)+":"+value.GATETM.substring(2,4)+"</span></div>";
						item9 += "<div><div style=\"width: 24%;float: left;\"><span class=\"td_text\">登机口</span>&nbsp;&nbsp;<span class=\"info_value\">"+value.SGATES+"</span></div>";
						item9 += "<div style=\"width: 24%;float: left;\"><span class=\"td_text\">序号</span>&nbsp;&nbsp;<span class=\"info_value\">"+value.BRDNO+"</span></div><div style=\"clear: both;\"></div></div></div>";
					}
					if(value.CHECKTIME != ""){
						item9 += "<div class=\"anInfo_div_style\"><div><span class=\"title_value\">安检&nbsp;</span> <span class=\"title_value\">"+value.FLIGHTDATE+" "+value.CHECKTIME.substring(0,2)+":"+value.CHECKTIME.substring(2,4)+"</span></div>";
						item9 += "<div style=\"width: 98%;\"><div style=\"width: 48%;float: left;\"><span class=\"td_text\">安检通道</span> <span class=\"info_value\">"+value.CHECKCHANNEL+"</span></div>";
						item9 += "<div style=\"width: 48%;float: left;\"><span class=\"td_text\">安检人员</span> <span class=\"info_value\">"+value.CHECKER+"</span></div></div><div style=\"width: 98%;clear: both;\">";
						item9 += "<div style=\"width: 48%;float: left;\"><span class=\"td_text\">安检证件</span> <span class=\"info_value\">身份证</span></div><div style=\"width: 48%;float: left;\"><span class=\"td_text\">证件号码</span> <span class=\"info_value\">"+value.CNUMBER+"</span></div>";
						item9 += "</div><div style=\"width: 98%;clear: both;\"><div style=\"width: 48%;float: left;\"><span class=\"td_text\">有效期限</span> <span class=\"info_value\">"+value.CVALIDATE+"</span></div>";
						item9 += "<div style=\"width: 48%;float: left;\"><span class=\"td_text\">发放单位</span> <span class=\"info_value\">"+value.CDEP+"</span></div></div><div style=\"width: 98%;clear: both;\">";
						item9 += "<div style=\"width: 48%;float: left;\"><div class=\"td_text\" style=\"float: left;\">证件照片</div><div><img src=\""+value.PHOTO+"\" class=\"controlps_img\" /></div></div>";
						item9 += "<div style=\"width: 48%;float: left;\"><div class=\"td_text\" style=\"float: left;\">过检照片</div><div><img src=\""+value.PICPATH+"\" class=\"controlps_img\" /></div></div></div><div style=\"width: 98%;clear: both;\"></div></div>";
					}
					var item10 = "<div class=\"anInfo_div_style\" style=\"clear: both;\"><div><span class=\"title_value\">值机&nbsp;</span> <span class=\"title_value\">"+value.FLIGHTDATE+" "+value.CKITM.substring(0,2)+":"+value.CKITM.substring(2,4)+"</span></div><div>";
					var item11 = "<div style=\"width: 24%;float: left;\"><span class=\"td_text\">座位</span><span class=\"info_value\">"+value.SEAT+"</span></div><div style=\"width: 24%;float: left;\"><span class=\"td_text\">仓位</span><span class=\"info_value\">无法提供</span></div>";
					var item12 = "<div style=\"width: 24%;float: left;\"><span class=\"td_text\">登机口</span><span class=\"info_value\">"+value.GATES+"</span></div><div style=\"width: 24%;float: left;\"><span class=\"td_text\">序号</span><span class=\"info_value\">"+value.BRDNO+"</span></div>";
					var item13 = "<div style=\"clear: both;\"></div></div></div></div><div style=\"width: 1%;clear: both;\"></div></div></div>";
					$("#bigdiv").append(item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11+item12+item13);
				});
				loading = false;
			}
		},
		error : function(error) {
			top.$.ligerDialog.error("数据加载失败！" + error.status,"错误");
		}
	});
}
//同航班下所有旅客
function openDialog(flightcode,flightdate,dept,dest){
	window.parent.f_click(flightcode,flightcode,mypath+"flightUserQueryList.action?flightcode="+flightcode+"&flightdate="+flightdate+"&dept="+dept+"&dest="+dest+"&page=1&pagesize=10");
}
//点击名字进入详情
function openDetail(ctype,cert,casename) {
	$.ajax({
		url:"flightDetailQuery.action",
		data:"ctype="+ctype+"&cert="+cert,
		dataType:"json",
		type:"post",
		success:function(data){
			var BD_RYBH = data.BD_RYBH;
			if(BD_RYBH!=null && BD_RYBH!=""){
				var url = mypath+"bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH=" + BD_RYBH+"&casename="+casename;
				var tabid = "GDPJ" + "-" + BD_RYBH;
				window.parent.f_click(tabid,casename,url);
			}else{
				top.my_alert("暂无此人的碰撞信息!");
			}
		}
	});
}

var flightcode; 
var flightdate;
var mypath;
var page=1;
var cage=1;
var issj=0;
var iscs=0;
var number = 0;
var order_type="";  //排序
var loading = false;  //判断单次加载数据是否完成
jQuery(function($){
	$(".float_style").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	flightcode = $("#flightcodes").val();
	flightdate = $("#flightdates").val();
	mypath = $("#mypath").val();
});
/*人员详细信息*/
function openDialog(rybh,casename) {
	if(rybh != ""){
		var tabid = "FLIGHT" + "-" + rybh;
		this.parent.f_click(tabid,casename,mypath + "flightQueryAllList.action?page=1&pagesize=10&BD_RYBH=" + rybh);
	}else{
		top.my_alert("暂无此人的碰撞信息!");
	}
}
//tab点击事件
function tab_onclick(item) {
	$("#" + item).css("background-color", "#FC9B71");
	if(item == "cfry"){
		$("#aj").css("background-color", "#B3B3B3");
		$("#case").hide();
		$("#screenpeople").show();
	} else {
		$("#cfry").css("background-color", "#B3B3B3");
		$("#screenpeople").hide();
		$("#case").show();
		if( number == 0 && !loading){
			loading = true;
			caselist(cage);
		}
	}
}
//加载案件
function caselist(age){
	//进入页面提示文字
    $("#div_btm").hide(); 
    //友好提示文字
    $("#cloadover").show();
	$("#cloadover").html('正在加载中...');
	
	$.ajax({
		url:"flightScreenAllCase.action",
		data:"page="+age+"&pagesize=10&flightcode="+flightcode+"&flightdate="+flightdate,
		dataType:"json",
		type:"post",
		success:function(data){
			var value = data.msg;
			if(value.length==2){
				$("#cloadover").show();
				$("#cloadover").html('数据加载完成');
				iscs=1;
				return;
			} 
			var objArray = JSON.parse(value);
			if(objArray.length<10){
			    $("#cloadover").show();
			    $("#cloadover").html('数据加载完成');
			    iscs=1;
			}
			$(objArray).each(function (i, value) { 
				var item1 = "<div class=\"item_style\"><table style=\"height: 100px;margin-left: 10px;width: 98% \">";
				var item2 = "<tr><td style=\"font-size: 20px;color: #EF7844;font-weight: bold;\"><span  style=\"padding: 0px 10px ;color: white;background-color: #EF7844;border-radius:2px;margin-right: 12px;\">"+value.AJLBMC+"</span><span>"+value.MC+"</span></td></tr>";
				var item3 = "<tr><td style=\"width: 28%\"><span class=\"td_text\">报&nbsp;&nbsp;案&nbsp;&nbsp;人</span><span class=\"td_value\">"+value.BARXM+"</span></td>";
				var item4 = "<td style=\"width:2%;\" rowspan=\"3\"><div style=\"width: 1px;float: left; height:70px;background-color: #b2b2b2;\"></div></td>";
				var item5 = "<td style=\"width: 28%\"  class=\"td_text\">报案时间<span class=\"td_value\">"+value.AFSJ+"</span></td><td style=\"width:2%;\" rowspan=\"3\">";
				var item6 = "<div style=\"width: 1px;float: left; height:70px;background-color: #b2b2b2;\"></div></td><td style=\width: 30%\"  class=\"td_text\">案件详情</td></tr>";
				var item7 = "<tr><td  class=\"td_text\">身份证号<span class=\"td_value\">"+value.BARSFZHM+"</span></td><td  class=\"td_text\">报案地点<span class=\"td_value\">"+value.AFDD+"</span></td><td class=\"td_value\" rowspan=\"2\" style=\"text-align: left;\">"+value.ZYAQ+"</td></tr>";
				var item8 = "<tr><td  class=\"td_text\">联系电话<span class=\"td_value\">"+value.BARLXDH+"</span></td><td  class=\"td_text\">案发航班<span class=\"td_value\">"+value.HBH+"</span></td></tr></table></div>";
				$("#casediv").append(item1+item2+item3+item4+item5+item6+item7+item8);
			});
			number = 1;
			loading = false;
		},
		error : function(error) {
			top.$.ligerDialog.error("滚动加载失败！" + error.status,"错误");
		}
	});
} 
//航班重复人员
function screenlist(age,type){
	//进入页面提示文字
    $("#div_btm").hide(); 
    //友好提示文字
    $("#sloadover").show();
	$("#sloadover").html('正在加载中...'); 
	
	$.ajax({
		url:"flightScreenUserMore.action",
		data:"page="+age+"&pagesize=10&flightcode="+flightcode+"&flightdate="+flightdate+"&ordertype="+type,
		dataType:"json",
		type:"post",
		success:function(data){
			var value = data.msg;
			if(value.length==2){
				$("#sloadover").show();
				$("#sloadover").html('数据加载完成');
				issj=1;
				return;
			} 
			var objArray = JSON.parse(value);
			if(objArray.length<10){
			    $("#sloadover").show();
			    $("#sloadover").html('数据加载完成');
			    issj=1;
			}
			$(objArray).each(function (i, value) { 
				var item = "<div class=\"item_style\">";
				item += "<table style=\"height: 100px;margin-left: 10px;width: 98% \">";
				item += "<tr><td rowspan=\"5\" style=\"width: 13%;text-align: center;\"><img src=\""+value.XP+"\" class=\"controlps_img\" /></td></tr>";
				item += "<tr><td style=\"font-size: 19px;color: #EF7844;font-weight: bold;\"><span class=\"float_style\" onclick=\"openDialog('"+value.BD_RYBH+"','"+value.CHNNAME+"')\">"+value.CHNNAME+"</span></td>";
				item += "<td style=\"width:2%;\" rowspan=\"5\"><div style=\"width: 1px;float: left; height:80px;background-color: #b2b2b2;\"></div></td>";
				item += "<td style=\"font-size: 19px;font-weight: bold;\" colspan=\"3\">关联<span style=\"color: #376CB0;margin:0px 5px;\">"+value.count+"</span>航班</td></tr>";
				item += "<tr><td style=\"width: 25%\"><span>身份证号</span><span class=\"td_value\">";
				if(value.CTYPE=='NI'){
					item += value.CERT;
				}else{
					item += "无";
				}
				item += "</span></td>";
				item += "<td style=\"font-size: 13px;font-weight: bold;\" rowspan=\"2\">案件航班<span style=\"color: #376CB0;padding-left: 30px;\">"+value.FLIGHTCODE+"</span></td></tr>";
				item += "<tr><td>护&nbsp; 照&nbsp; 号<span class=\"td_value\">";
				if(value.CTYPE=='PP'){
					item += value.CERT;
				}else{
					item += "无";
				}
				item += "</span></td></tr>";
				item += "<tr><td>通行证号<span class=\"td_value\">无</span></td></tr></table></div>";			
				$("#screendiv").append(item);
			});
			loading = false;
		},
		error : function(error) {
			top.$.ligerDialog.error("滚动加载失败！" + error.status,"错误");
		}
	});
} 
//滚动加载
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(issj==1 && $("#screenpeople").is(':visible')){
			return;
		}else if(iscs==1 && $("#case").is(':visible')){
			return;
		}
		//加载案件
		if($("#case").is(':visible') && !loading){
			loading = true;
			cage=cage+1;
			caselist(cage);
		}
		//加载重复人员
		if($("#screenpeople").is(':visible') && !loading){
			loading = true;
			page=page+1;
			screenlist(page,order_type);
		}
	}
});
//排序

//function order_onclick(item_type,item_value){
//   
//	$("#div_sort div").css("color", "#386CB5");
//	$("#div_sort #jt").remove();
//	
//	//重新赋值
//	$("#"+item_type).css("color", "#FC9B71");
//	$("#"+item_type).html(item_value);
//	$("#"+item_type).append("<span id=\"jt\">↓</span>");
//	page=1;
//	issj=0;
//	order_type=item_type;
//	//重复人员
//	if($("#screenpeople").is(':visible')){
//		$("#sloadover").hide();
//		$("#screendiv").html('');
//		if(!loading){
//			loading = true;
//			screenlist(page,order_type);
//		}
//	}
//}
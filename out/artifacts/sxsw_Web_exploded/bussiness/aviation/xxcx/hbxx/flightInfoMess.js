var page=1;
var cage=1;
var issj=false;
var iscs=false;
var number = 0;
var order_type = "";
var mypath;
var loading = false;  //判断单次加载数据是否完成
jQuery(function($){
	$(".float_style").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	mypath = $("#mypath").val();
});

/*人员详细信息*/
function openDialog(lkid,casename) {
	var url =  mypath + "flightQueryAllList.action?page=1&pagesize=10&lkid=" + lkid;
	var tabid = "GDPJ" + "-" + lkid;
	this.parent.f_click(tabid,casename,url);
}
//tab点击事件
function tab_onclick(item) {
	$("#" + item).css("background-color", "#FC9B71");
	//关联人员
	if (item == "glry") {
		$("#aj").css("background-color", "#B3B3B3");
		$("#relationpeople").show();
		$("#case").hide();
	}
	//案件
	else {
		$("#glry").css("background-color", "#B3B3B3");
		$("#relationpeople").hide();
		$("#case").show();
		if(number == 0 && !loading){
			loading = true;
			caselist(cage);
		}

	}
}
//排序
function order_onclick(item_type,item_value){

	$("#div_sort div").css("color", "#386CB5");
	$("#div_sort #jt").remove();

	//重新赋值
	$("#"+item_type).css("color", "#FC9B71");
	$("#"+item_type).html(item_value);
	$("#"+item_type).append("<span id=\"jt\">↓</span>");
	page=1;
	issj=false;
	order_type=item_type;
	$("#bigdiv").html('');
	$("#loadover").hide();
	if(!loading){
		loading = true;
		userlist(page,order_type);
	}
}
//加载人员
function userlist(age,order_type){
	//进入页面提示文字
    $("#div_btm").hide(); 
    //友好提示文字
    $("#loadover").show();
	$("#loadover").html('正在加载中...');
	
	$.ajax({
		url:"flightUserQueryListMore.action?page="+age+"&pagesize=10&ordertype="+order_type,
		dataType:"json",
		type:"post",
		success:function(data){
			var value=data.msg;
			if(value.length==2){
				$("#loadover").show();
			    $("#loadover").html('暂无数据');
			    issj=true;
			} 
			var objArray = JSON.parse(value);
			if(objArray.length<10){
			    $("#loadover").show();
			    $("#loadover").html('数据加载完成');
			    issj=true;
			}
			$(objArray).each(function (i, value) { 
				var item1 = "<div class=\"item_style\">";
				var item2="<table>";
				var item3="<tr><td rowspan=\"5\"><img src=\""+value.XP+"\"   class=\"controlps_img\" /></td></tr>";
				var item4="<tr><td style=\"font-size: 19px;color: #EF7844;font-weight: bold;\"><span  class=\"float_style\" onclick=\"openDialog('"+ value.LKID+ "','"+value.CHNNAME+"');\">"+value.CHNNAME+"</span></td></tr>";
				var item5="<tr><td style=\"width: 25%\"><span>身份证号</span><span class=\"td_value\">"+value.CERT+"</span></td><td style=\"width: 40%\">值机时间<span class=\"td_value\">"+value.CKITM+"</span></td><td style=\"width: 25%\">舱位<span class=\"td_value\"></span></td></tr>";
				var item6="<tr><td>护&nbsp; 照&nbsp; 号<span class=\"td_value\">无</span></td><td>安检时间<span class=\"td_value\">"+value.CHECKTIME+"</span></td><td>座位<span class=\"td_value\">"+value.SEAT+"</span></td></tr>";
				var item7="<tr><td>通行证号<span class=\"td_value\">无</span></td><td>登机时间<span class=\"td_value\">"+value.GATETM+"</span></td><td>序号<span class=\"td_value\">"+value.BRDNO+"</span></td></tr>";	
				var item8=" </table>";
				var item9="</div>";				
				$("#bigdiv").append(item1 +item2+item3+item4+item5+item6+item7+item8+item9);
			});
			loading = false;
		}
	});
}

//加载案件
function caselist(age){
	//进入页面提示文字
    $("#div_btm").hide(); 
    //友好提示文字
    $("#cloadover").show();
	$("#cloadover").html('正在加载中...');
	
	var flightcode = $("#flightcodes").val();
	var flightdate = $("#flightdates").val();
	$.ajax({
		url : "flightQueryAllCase.action",
		data : "page=" + age + "&pagesize=10&flightcode="+ flightcode + "&flightdate=" + flightdate,
		dataType : "json",
		type : "post",
		success : function(data) {
			var value = data.msg;
			if(value.length==2){
				$("#cloadover").show();
				$("#cloadover").html('暂无数据');
				iscs=true;
			} 
			var objArray = JSON.parse(value);
			if(objArray.length<10){
			    $("#cloadover").show();
			    $("#cloadover").html('数据加载完成');
			    iscs=true;
			}
			$(objArray).each(function(i, value) {
				var item1 = "<div class=\"item_style\"><table style=\"height: 100px;margin-left: 10px;width: 98% \">";
				var item2 = "<tr><td style=\"font-size: 20px;color: #EF7844;font-weight: bold;\"><span  style=\"padding: 0px 10px ;color: white;background-color: #EF7844;border-radius:2px;margin-right: 12px;\">"+ value.AJLBMC+ "</span><span>"+ value.MC+ "</span></td></tr>";
				var item3 = "<tr><td style=\"width: 28%\"><span class=\"td_text\">报&nbsp;&nbsp;案&nbsp;&nbsp;人</span><span class=\"td_value\">"+ value.BARXM+ "</span></td>";
				var item4 = "<td style=\"width:2%;\" rowspan=\"3\"><div style=\"width: 1px;float: left; height:70px;background-color: #b2b2b2;\"></div></td>";
				var item5 = "<td style=\"width: 28%\"  class=\"td_text\">报案时间<span class=\"td_value\">"+ value.AFSJ+ "</span></td><td style=\"width:2%;\" rowspan=\"3\">";
				var item6 = "<div style=\"width: 1px;float: left; height:70px;background-color: #b2b2b2;\"></div></td><td style=\"width: 30%\"  class=\"td_text\">案件详情</td></tr>";
				var item7 = "<tr><td  class=\"td_text\">身份证号<span class=\"td_value\">"+ value.BARSFZHM+ "</span></td><td  class=\"td_text\">报案地点<span class=\"td_value\">"+ value.AFDD+ "</span></td><td class=\"td_value\" rowspan=\"2\" style=\"text-align: left;\">"+ value.ZYAQ + "</td></tr>";
				var item8 = "<tr><td  class=\"td_text\">联系电话<span class=\"td_value\">"+ value.BARLXDH+ "</span></td></tr></table></div>";
				$("#casediv").append(item1 + item2 + item3+ item4 + item5+ item6 + item7+ item8);
			});
			number = 1;
			loading = false;
		},
		error : function(error) {
			top.$.ligerDialog.error("滚动加载失败！" + error.status, "错误");
		}
	});
}
//滚动加载
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(issj && $("#relationpeople").is(':visible')){
			return;
		}else if(iscs && $("#case").is(':visible')){
			return;
		}
		//加载案件
		if($("#case").is(':visible') && !loading){
			loading = true;
			cage=cage+1;
			caselist(cage);
		}
		//加载人员
		if($("#relationpeople").is(':visible') && !loading){
			loading = true;
			page=page+1;
			userlist(page,order_type);
		}
	}
});


//添加案件
function addAj(flightcode,flightdate){
	var url = mypath+"bussiness/aviation/xxcx/asj/ajAdd.jsp?flightcode="+flightcode+"&flightdate="+flightdate;
	window.top.my_openwindow("", url, 550, 540, "添加案件");
}
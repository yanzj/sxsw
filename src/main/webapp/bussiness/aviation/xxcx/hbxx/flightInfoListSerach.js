var page = 1;//当前页面
var isend = false; //判断当加载完成时，滚动条滑动不在加载数据
var mypath;
var loading = false;  //判断单次加载数据是否完成
var order_type = ""; 
jQuery(function($){
	ajlxQueryList();
	$(".float_style").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	mypath = $("#mypath").val();
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

//添加案件
function addAj(flightcode,flightdate,dept,dest){
	var url = mypath+"bussiness/aviation/xxcx/asj/ajAdd.jsp?flightcode="+flightcode+"&flightdate="+flightdate+"&dept="+dept+"&dest="+dest;
	window.top.my_openwindow("", url, 550, 540, "添加案件");
}

//点击高级搜索按钮
function gjsc_an() {
	if ($("#div_gjss").is(":hidden")) {
		$("#div_gjss").show(); //如果元素为隐藏,则将它显现
		$("#oneSearch_bt").hide();
		$("#twoSearch_bt").show();

	} else {
		$("#div_gjss").hide(); //如果元素为显现,则将其隐藏
		$("#oneSearch_bt").show();
		$("#twoSearch_bt").hide();
	}
}
//同航班下所有旅客
function openDialog(flightcode,flightdate,dept,dest){
	window.parent.f_click(flightcode,flightcode,mypath+"flightUserQueryList.action?flightcode="+flightcode+"&flightdate="+flightdate+"&dept="+dept+"&dest="+dest+"&page=1&pagesize=10");
}
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page = page+1;
			loading = true;
			flightajax(page,'more',order_type);
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
	$("#dadiv").html('');
	if(!loading){
		loading = true;
		flightajax(page,'search',order_type);
	}
}

/**后台请求数据*/
function flightajax(age,type,order_type){
	//进入页面提示文字
	$("#div_btm").hide(); 
	//友好提示文字
	$("#loadover").show();
	$("#loadover").html('正在加载中...');

	var starttime = $("#starttime").val();
	var endtime = $("#endtime").val();
	var dept = $("#dept").val();
	var dest = $("#dest").val();
	var searchcode = $("#searchcode").val().trim();
	if("请输入航班号，例如:MH2310"==searchcode){
		searchcode="";
	}
	var searchvalue = $("#searchvalue").val().trim();
	if("请输入搜索关键词"==searchvalue){
		searchvalue="";
	}
	var lx = $("#lx").val();
	$.ajax({
		url:"flightserachMore.action",
		data:"page="+age+"&pagesize=10"+"&starttime="+starttime+"&endtime="+endtime+"&flightcode="+searchcode+"&dept="+dept+"&dest="+dest+"&value="+searchvalue+"&lx="+lx+"&ordertype="+order_type,
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
					var item1 = "<div class=\"item_style\" style=\"height: 100%\">";
					var item2 = "<table style=\"text-align:center;margin-top: 10px;margin-bottom: 10px;width: 98% \">";
					var item3 = "<tr><td width=\"4%\" rowspan=\"2\"> <input type=\"checkbox\" id=\"flightcheck\" value=\""+value.FLIGHTCODE+","+value.FLIGHTDATE+"\" /></td>";
					var item4 ="<td width=\"10%\" rowspan=\"2\"><span id=\"flightdate\">"+value.FLIGHTDATE+"</span></td>";
					var item5 = "<td width=\"10%\">中国南航</td>";
					var item6 = "<td width=\"2%\" rowspan=\"2\"><img src=\""+mypath+"images/splitline.png\" /></td>";
					var item7 = "<td width=\"10%\" rowspan=\"2\">"+value.DPSRDEPARTURECHN+"</td><td width=\"5%\" rowspan=\"2\">---></td>";
					var item8 = "<td width=\"10%\" rowspan=\"2\">"+value.DPSRDESTINATIONCHN+"</td><td width=\"20%\" colspan=\"2\">起始登机时间</td>";
					var item9 = "<td width=\"20%\" class=\"float_style\" style=\"color: #386CB5;text-align: center;\" onclick=\"addAj('"+value.FLIGHTCODE+"','"+value.FLIGHTDATE+"','"+value.DPSRDEPARTURECHN+"','"+value.DPSRDESTINATIONCHN+"')\">添加案事件</td></tr>";
					var item10 = "<tr><td><span id=\"flightcode\" class=\"float_style\" onclick=\"openDialog('"+value.FLIGHTCODE+"','"+value.FLIGHTDATE+"','"+value.DPSRDEPARTURECHN+"','"+value.DPSRDESTINATIONCHN+"');\">"+value.FLIGHTCODE+"</span></td>";
					var item11 = "<td colspan=\"2\">";
					if(value.GATETM!=""){
						item11 += value.GATETM.substring(0,2)+":"+value.GATETM.substring(2,4);
					}
					item11 += "</td><td style=\"text-align:center;\">";
					var item12 ="" ;
					var events = value.eventsList;
					$(events).each(function(i,event){
						if(i<3){
							item12 +="<span  class=\"float_style\" style=\"color: white;background-color: red;padding-left: 7px;padding-right: 7px;padding-top:3px;padding-bottom:3px;border-radius: 2px;\">"+event.AJLBBH+"</span>&nbsp;";
						}else if(i==3){
							item12+="<span  class=\"float_style\" style=\"color: white;background-color: red;padding-left: 7px;padding-right: 7px;padding-top:3px;padding-bottom:3px;border-radius: 2px;\">...</span>";
						}else{
							item12 +="";
						}

					}); 
					var item13 = "</td></tr></table></div>";
					$("#dadiv").append(item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11+item12+item13);
				});
				loading = false;
			}
		},
		error : function(error) {
			top.$.ligerDialog.error("滚动加载失败！" + error.status,"错误");
		}
	});
}
//筛选重复人员
function screenuser(){
	var flightcode = "";
	var flightdate = "";
	var str=new Array();
	var countcheck = 0;
	$("input[id='flightcheck']").each(function() {
		if ($(this).attr('checked') ==true) {
			countcheck ++;
			str = $(this).val().split(",");
			flightcode += "'"+str[0]+"',";
			flightdate += str[1]+",";
		}   
	});
	if(countcheck <=1 ){
		alert("航班不能少于2个，请重新选择!");
		return;
	}
	window.parent.f_click(flightcode,"重复人员分析",mypath+"flightScreener.action?flightcode="+flightcode+"&flightdate="+flightdate+"&page=1&pagesize=3");
}
//全部选中和取消事件
function checkall(){
	if($("input[id='checkBtn']").attr('checked')==true){
		$("input[id='flightcheck']").each(function() {
			$(this).attr('checked', true);
		});
	}else{
		$("input[id='flightcheck']").each(function() {
			$(this).attr('checked', false);
		});
	}
}

//获取民族下拉框值
function ajlxQueryList() {
	$.ajax({
		url:"loadTsdict.action",
		data : "sszdlx=AJLB",
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#lx").append("<option  selected='selected' value='"+-1+"'>"+ "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#lx").empty();
			var text = " <option selected=\"selected\" value=''>--请选择案件类型--</option>";
			$.each(data, function(n, value) {
				text += "<option value='"+value.id+"'>" + value.text + "</option>";
			});
			$("#lx").append(text);
		}
	});
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
	isend = false;
	order_type=item_type;
	$("#dadiv").html('');
	$("#loadover").hide();
	if(!loading){
		loading = true;
		flightajax(page,"",order_type);
	}
}

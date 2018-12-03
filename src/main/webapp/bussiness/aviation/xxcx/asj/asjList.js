var page = 1;//当前页面
var isend = false; //判断当加载完成时，滚动条滑动不在加载数据
var mypath;
var loading = false;  //判断单次加载数据是否完成
var order_type="";  //排序
jQuery(function($){
	ajlxQueryList();
	$(".float_style").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	mypath = $("#mypath").val();
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
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page = page+1;
			loading = true;
			caselist(page,'more',order_type);
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
		caselist(page,'search',order_type);
	}
}
/**后台请求数据*/
function caselist(age,type,itemtype){
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
	//获取数据来源
	var source=$('#source').val();
	$.ajax({
		url:"eventslistMore.action",
		data:"page="+age+"&pagesize=10"+"&starttime="+starttime+"&endtime="+endtime+"&flightcode="+searchcode+"&dept="+dept+"&dest="+dest+"&value="+searchvalue+"&lb="+lx+"&order_type="+itemtype+"&source="+source,
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
			    $("#loadover").html('无数据');
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
				var source = $("#source").val();
				$(objArray).each(function (i, value) { 
					var item1 = "<div class=\"item_style\" style=\"height: 100%\">";
					var item2 = "<table style=\"text-align:center;margin-top: 10px;margin-bottom: 10px;width:98%; line-height: 30px;\">";
					var item3 = "";
					if(source != 'rwcl'){
						item3 = "<tr><td width=\"5%\" rowspan=\"5\"> <input type=\"checkbox\" id=\"evrntscheck\" /></td>";
					}
					//当来源为添加任务时显示复选框 
					if(source == 'rwcl'){
						if(value.ISCHECK){
							item3 = "<td width=\"5%\" rowspan=\"5\"><input type=\"checkbox\" id=\"evrntscheck\" checked=\"checked\" value='"+value.ASJBH+","+value.DEPT+","+value.DEST+","+value.HBSJ+","+value.HBH+","+value.AJLBMC+","+value.JCMC+"' /></td>";
						}else{
							item3 = "<td width=\"5%\" rowspan=\"5\"><input type=\"checkbox\" id=\"evrntscheck\" value='"+value.ASJBH+","+value.DEPT+","+value.DEST+","+value.HBSJ+","+value.HBH+","+value.AJLBMC+","+value.JCMC+"' /></td>";
						}
					}
					var item4 = "<td style=\"text-align:left;\" colspan=\"5\"><span  style=\"color: #EF7844;font-size: 18px;padding: 0px 10px ;color: white;background-color: #EF7844;border-radius:2px;margin-right: 12px;\">"+value.AJLBMC+"</span>";
					var item5 = "<span style=\"font-size: 18px;\">"+value.MC+"</span></td></tr><tr style=\"font-size: 17px;border-bottom:1px solid  #b2b2b2;\">";
					var item6 =	"<td colspan=\"2\" style=\"text-align:left;\" ><span style=\"margin-right: 90px;\">"+value.HBSJ+"</span><span style=\"color: #386CB5;\">"+value.HBH+"</span></td>";
					var item7 = "<td  colspan=\"2\" style=\"text-align:center;\"><span style=\"margin:0px 20px;\">"+value.DEPT+"</span><span class=\"td_text\">---></span><span style=\"margin:0px 20px;\">"+value.DEST+"</span></td>";
					var item8 =	"<td style=\"text-align:right;\"	><span style=\"margin-right: 10px;color: #386CB5;\" class=\"float_style\" onclick=\"addAj('"+value.HBH+"','"+value.HBSJ+"','"+value.DEPT+"','"+value.DEST+"')\">添加案事件</span></td></tr>";
					var item9 = "<tr style=\"text-align:left;line-height: 20px;\"><td style=\"width: 30%;\"><span class=\"td_text\">报&nbsp;&nbsp;案&nbsp;&nbsp;人</span><span class=\"td_value\">"+value.BARXM +"</span></td>";
					var item10 = "<td style=\"width:2%;\" rowspan=\"3\"><div style=\"width: 1px;float: left; height:50px;background-color: #b2b2b2;\"></div></td>";
					var item11 = "<td style=\"width: 30%;\"  class=\"td_text\">报案时间<span class=\"td_value\">"+value.AFSJ+"</span></td>";
					var item12 = "<td style=\"width:2%;\" rowspan=\"3\"><div style=\"width: 1px;float: left; height:50px;background-color: #b2b2b2;\"></div></td><td style=\"width: 30%;\" class=\"td_text\">案件详情</td></tr>";
					var item13 = "<tr style=\"text-align:left;line-height: 20px;\"><td  class=\"td_text\">身份证号<span class=\"td_value\">"+value.BARSFZHM+"</span></td><td  class=\"td_text\">报案地点<span class=\"td_value\">"+value.AFDD+"</span></td>";
					var item14 = "<td class=\"td_value\" rowspan=\"2\" style=\"text-align: left;\"><span>"+value.ZYAQ +"</span></td></tr>";
					var item15 = "<tr style=\"text-align:left;line-height: 20px;\"><td  class=\"td_text\">联系电话<span class=\"td_value\">"+value.BARLXDH+"</span></td></tr></table></div>";
					$("#dadiv").append(item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11+item12+item13+item14+item15);
				});
				loading = false;
			}
	},
	error : function(error) {
		top.$.ligerDialog.error("滚动加载失败！" + error.status,"错误");
	}
});
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
			$("#lx").append(
					"<option  selected='selected' value='"+-1+"'>"
							+ "正在加载中,请稍候..." + "</option>");
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
	if(!loading){
		caselist(page,'',order_type);
	}
}
/**
选择函数 当模块打开的方式来源于任务模块
*/
function f_select() {
	var checkboxs = "";
	//复选框选中的案事件信息列表
	$("input[id='evrntscheck']").each(function() {
		//获取选中的checkbox
		if($(this).attr('checked') == true) {
			checkboxs += $(this).val() + ":-:";
		}
	});
	data = checkboxs;
	return data;
}


//全部选中和取消事件
function checkall(){
	if($("input[id='checkBtn']").attr('checked')==true){
		$("input[id='evrntscheck']").each(function() {
			$(this).attr('checked', true);
		});
	}else{
		$("input[id='evrntscheck']").each(function() {
			$(this).attr('checked', false);
		});
	}
}


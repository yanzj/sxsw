var bpage = 1;//当前页面
var isend=false;  //判断当加载完成时，滚动条滑动不在加载数据
var loading = false;//判断单次加载数据是否完成
jQuery(function($){		
	//指针手型样式
	$(".my_info").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	
	//获取任务类别，判断是否显示类别
	var lb = $("#type").val();
	$("#lb").hide();
	if(lb=='wfclb' || lb=='wjslb'){
		$("#lb").show();
	}
	//限制字符个数
	$(".dian").each(function(){
	var maxwidth=15;
	if($(this).text().length>maxwidth){
		$(this).text($(this).text().substring(0,maxwidth));
		$(this).html($(this).html()+'···');
	}
	});

})
//回车搜索
$(document).keydown(function (event){
	if(event.keyCode==13){
		search();
	}
}
);

//搜索功能
function search(){
	//获取单选框值
	var radio = $('input:radio[name="radio"]:checked').val();
	//获取开始结束时间
	var begintime="";
	var endtime="";
	if(radio=='time'){
		begintime = $("#begintime").val();  //开始时间
		endtime = $("#endtime").val();      //结束时间
		if(endtime < begintime){
			top.my_alert("结束时间不能小于开始时间!","warn");
			return ;
		}
	}
	$("#dadiv").html('');
	bpage=1;
	isend=false;
	if(!loading){
		loading = true;
		search_or_more(bpage,'search');
	}
}
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			bpage = bpage+1;
			loading = true;
			search_or_more(bpage,'more');
		}

	}
});
//搜索/加载更多共公方法
function search_or_more(page,type){   
	//进入页面提示文字
    $("#div_btm").hide(); 
	
    //友好提示文字
	$("#div_bottom").show();
	$("#div_bottom").html('正在加载中...');
	var basePath = $("#mypath").val();
	var rwtype = $("#rwtype").val();        //获取任务类型
	var rwzt = $("#rwzt").val();            //获取任务状态 
	var casename=$("#name").val().trim();   //名称
	if(casename=='请输入任务名称关键字'){
		casename="";
	}
	//获取多选框的值
	var checkbox="";
	$("input:checkbox[name='checkbox']:checked").each(function() {
		checkbox += $(this).val() + ",";
	});
	//获取单选框值
	var radio = $('input:radio[name="radio"]:checked').val();
	//获取开始结束时间
	var begintime="";
	var endtime="";
	if(radio=='time'){
		begintime = $("#begintime").val();  //开始时间
		endtime = $("#endtime").val();      //结束时间
	}
	$.ajax({
		url:"rwlbQueryListMore.action",
		data:"bpage="+bpage+"&apage=10"+"&RWMC="+casename+"&rwzt="+rwzt+"&rwtype="+rwtype+"&checkbox="+checkbox+"&begintime="+begintime+"&endtime="+endtime+"&radio="+radio,
		dataType:"json",
		type:"post",
		success:function(data){

			var value = data.msg;
			//加载更多
			if(type=='more' && value.length==2){
				$("#div_bottom").show();
				$("#div_bottom").html('数据加载完成');
				isend=true;
				loading = false;
				return;
			}
			//搜索
			else if(type=='search' && value.length==2){
				$("#div_bottom").show();
				$("#div_bottom").html('暂无数据');
				loading = false;
				return;
			}else{
				$("#div_bottom").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#div_bottom").show();
					$("#div_bottom").html('数据加载完成');
					isend=true;
				}
				$(objArray).each(function (i, value) { 
					var desc = "<table style=\"text-align: center; width: 100%;font-size: 14px;\" >";
					var itemdps = "<tr>";
					var item2 = "<td width=\"20%\"><span class=\"my_info dian\" onclick=\"getRwess('"+value.RWBH+"','"+value.RWMC+"','"+value.RWCJR+"')\">"+value.RWMC+"</span></td>";
					var itemround="";
					if(value.WDSL <= 0){
						itemround = "<td width=\"3%\"></td>";
					}else if(value.WDSL > 99){
						itemround = "<td width=\"3%\"><div id=\"rwjlround_l\" style=\"background:url("+basePath+"images/fk_webunreadbg_l.png) no-repeat;height:16px;width:24px;float:left;margin-top:0px;font-size:12px;text-align:center;line-height:16px;display:block;\"><span style=\"color:#fff\">99+</span></div></td>";
					}else{
						itemround = "<td width=\"3%\"><div id=\"rwjlround_s\" style=\"background:url("+basePath+"images/fk_webunreadbg_s.png) no-repeat;height:16px;width:16px;float:left;margin-top:0px;font-size:10px;text-align:center;line-height:16px;display:block;\"><span style=\"color:#fff\" id=\"rwjlwdCount\">"+value.WDSL+"</span></div></td>"
					}
					var itemdpe = "<td width=\"10%\"><span >"+value.CJRBH+"</span></td>";
					var itemdys = "<td width=\"15%\"><span>"+value.CJSJ+"</span></td>";
					var item3="";
					if(value.RWWCSJ=='1970-01-01'){
						item3 = "<td width=\"15%\"><span >无期限</span></td>";
					}else{
						item3 = "<td width=\"15%\"><span >"+value.RWWCSJ+"</span></td>";
					}
					var itemdye = "";
					if(value.RWZT==0){
						itemdye = "<td width=\"10%\"><span style=\"color:red\">未处理</span></td>";
					}
					if(value.RWZT==1){
						itemdye = "<td width=\"10%\"><span style=\"font-size: 15px;\">进行中</span></td>";
					}
					if(value.RWZT==2){
						var RWTJSJ=parseInt(value.RWTJSJ);
						var GDWCSJ=parseInt(value.GDWCSJ);
						if(RWTJSJ > GDWCSJ&&value.RWWCSJ!='1970-01-01'){
							var itemdye = "<td width=\"10%\"><span style=\"font-size: 15px;\">超期完成</span></td>";
						}else if(value.RWWCSJ=='1970-01-01'){
							var itemdye = "<td width=\"10%\"><span style=\"font-size: 15px;\">已完成</span></td>";
						}else if(RWTJSJ<=GDWCSJ){
							var itemdye = "<td width=\"10%\"><span style=\"font-size: 15px;\">已完成</span></td>";
						}
					}
					var  pltb = "<td width=\"10%\"><span style=\"color:#1C86EE;\" class=\"my_info\" onclick=\"getRwess('"+value.RWBH+"','"+value.RWMC+"','"+value.RWCJR+"')\">查看任务详情>></span></td>";
					var plshowds ="</tr>";
					var plnor = "</table>";
					$("#dadiv").append(desc+ itemdps+item2+itemround+itemdpe+itemdys+item3+itemdye+pltb+plshowds + plnor);
				});
				//限制字符个数
				$(".dian").each(function(){
					var maxwidth=15;
					if($(this).text().length>maxwidth){
						$(this).text($(this).text().substring(0,maxwidth));
						$(this).html($(this).html()+'···');
					}
				});
				loading = false;
			}
		}
	});

}
//点击进入任务详情
function getRwess(id,casename,rwcjr){
	var basePath = $("#mypath").val();
	var url = basePath+"bussiness/aviation/rwcl/rw_detail_new.jsp?ssxmbh="+id+"&rwcjr="+rwcjr;
	var tabid = "GDPJ" + "-" + id;
	if(casename.length>15){
		casename=casename.substring(0,15)+"···";
	}
	this.parent.f_click(tabid,casename,url);		
}  
//点击搜索关键词文本框
function onfocuss() {
	document.getElementById("name").focus();
	var value = $("#name").val().trim();
	if (value == "请输入任务名称关键字") {
		$("#name").val("");
	}
}
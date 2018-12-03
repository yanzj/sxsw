var mypath;
var page = 1;// 当前页面
var isend = false; // 判断当加载完成时，滚动条滑动不在加载数据
var loading = false; //判断单次加载数据是否完成
jQuery(function($) {
	mypath = $("#mypath").val();
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});

	$("input[holder]").each(function() {
		var $this = $(this);
		$this.addClass("holder");
		$this.val($this.attr("holder"));
	}).live("focusin", function() {
		var $this = $(this);
		if ($this.val() == $this.attr("holder")) {
			$this.removeClass("holder");
			$this.val("");
		}
	}).live("focusout", function() {
		var $this = $(this);
		if ($this.val() == "") {
			$this.val($this.attr("holder"));
			$this.addClass("holder");
		}
	});

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
	$("#dadiv").html('');
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
		if(!isend && loading == false)
		{
			page = page+1;
			loading = true;
			search_or_more(page,'more');
		}
	}
});

//搜索/加载更多
function search_or_more(page,type)
{
	//进入页面提示文字
	$("#div_btm").hide();  

	//友好提示文字
	$("#div_bottom").show();
	$("#div_bottom").html('正在加载中...');

	var cjrxm = $("#cjrxm").val().trim();   //申请人
	if(cjrxm=='请输入申请人姓名关键字'){
		cjrxm="";
	}
	//获取多选框的值
	var checkbox="";
	$("input:checkbox[name='checkbox']:checked").each(function() {
		checkbox += $(this).val() + ",";
	});
	//获取单选框值
	var radio = $('input:radio[name="radio"]:checked').val();
	//选择时间段
	var begintime = $("#begintime").val();  //开始时间
	var endtime = $("#endtime").val();      //结束时间
	$.ajax({
		url:"gdjzApprovalsconditionList.action",
		data:"page="+page+"&pagesize=10"+"&cjrmc="+cjrxm+"&checkbox="+checkbox+"&radio="+radio+"&begintime="+begintime+"&endtime="+endtime,
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
				var item1 = " <table style=\"width:100%;border-collapse:collapse;line-height: 30px; text-align: center;\" >";

				$(objArray).each(function (i, value) { 
					item1 += "<tr><td  width=\"25%\" class=\"my_info\" style=\"color:#007EE2;\"  onclick=\"openDialog('"+value.SPBH+"')\">";
					item1 += "<div class = \"info\">";

					if(value.MZ!=""){
						item1 += value.MZMC+"&nbsp;&nbsp";
					}
					if(value.XM!=""){
						item1 += value.XM+"&nbsp;&nbsp;";
					}
					if(value.XB!=""){
						if(value.XB == "1"){
							item1 +=  "男";
						}else if(value.XB == "2"){
							item1 +=  "女";
						}
						item1 += "&nbsp;&nbsp;";
					}
					if(value.JG!=""){
						item1 += value.JG+"&nbsp;&nbsp;";
					}
					if(value.ZZ!=""){
						item1 += value.ZZ+"&nbsp;&nbsp;";
					}
					if(value.SFZH!=""){
						item1 += value.SFZH+"&nbsp;&nbsp;";
					}
					if(value.QT!=""){
						item1 += value.QT+"&nbsp;&nbsp;";
					} 
					item1 += "</div></td><td width=\"20%\" style=\"color:#ef7844\">"+value.LKYXSJ+"</td>";
					item1 += "<td width=\"8%\">";
					if(value.SPZT=='0'){
						item1 += "<span>未审批</span>";
					}else if(value.SPZT=='1'){
						item1 += "<span>审批中</span>";                      
					}else if(value.SPZT=='2'){
						item1 += "<span>已拒绝</span>";
					}else if(value.SPZT=='3'){
						item1 += "<span>已批准</span>"; 
					}else if(value.SPZT=='4'){
						item1 += "<span>打回修改</span>";
					}
					item1 += "</td><td width=\"8%\" style=\"color:#007EE2;\"  class = \"my_info\" onclick = \"getCJRXM('"+value.CJRBH+"')\">"+value.CJRXM+"</td>";
					item1 += "<td width=\"15%\">"+value.CJSJ+"</td>"; 
					item1 += "<td width=\"20%\">";
					if(value.CZZT>=1){
						item1 += "<span style=\"color:red;\">未操作</span>";
					}else{
						item1 += "<span style=\"color:gray;\">已操作</span>";
					}
					item1 += "</td></tr></table>";
					$("#dadiv").append(item1);
				});
				loading = false;
			}
		}
	});
}	

/*
 * 详情
 */
function openDialog(spbh) {
	window.parent.f_click(spbh,"详情",mypath+"bussiness/aviation/lkgl/tjxlkSP/ApprovalsconditionEditfcc.jsp?itemid="+spbh+"&type=wjs");
}
//上控人基本信息
function getCJRXM(cjrbh){
	if(cjrbh==null){
		cjrbh=$("#CJRBH").val();
	}
	var url = mypath+"system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"上控人详情信息");
}
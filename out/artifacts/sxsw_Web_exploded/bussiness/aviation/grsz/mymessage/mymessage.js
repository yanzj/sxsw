var page = 1;// 当前页面
var isend = false; // 判断当加载完成时，滚动条滑动不在加载数据
var loading = false;//判断单次加载数据是否完成
jQuery(function($){
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});
	//文本框默认值点击后清空，移除点击后又赋给默认值
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
	if($("#welcomeJsp").val()=="welcome"){
		$("#taskes").attr("checked",true);
		$("#wd").attr("checked",true);
		search();
	}else if($("#welcomeJsp").val()=="index"){
		$("#wd").attr("checked",true);
		search();
	}

	//内容超过15个字变成...
	$(".dian").each(function(){
		var maxwidth=17;
		if($(this).text().length>maxwidth){
			$(this).text($(this).text().substring(0,maxwidth));
			$(this).html($(this).html()+"....");
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
function search() {
	$("#dadiv").html('');
	page = 1;
	isend = false;
	if(!loading){
		loading = true;
		search_or_more(page, 'search');
	}
}

//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop()>0){
		if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
			if(!isend&&!loading){
				loading = true;
				page = page+1;
				search_or_more(page,'more');
			}
		}
	}
});

//搜索/加载更多
function search_or_more(page, type) {
	// 进入页面提示文字
	$("#div_btm").hide();  
	// 友好提示文字
	$("#div_bottom").show();
	$("#div_bottom").html('正在加载中...');
	// 获取多选框的值
	var box="";
	var checkbox = "";
	$("input:checkbox[name='box']:checked").each(function() {
		box += $(this).val() + ",";
	});
	$("input:checkbox[name='checkbox']:checked").each(function() {
		checkbox += $(this).val() + ",";
	});
	//消息内容
	var xxnr = $("#XXNR").val();
	if(xxnr=="请输入消息内容搜索关键字"){
		xxnr = "";
	}
	$.ajax({
		url : "gdcxMessageQueryList.action",
		dataType : "json",
		type : "post",
		data : "page="+page+"&pagesize=10&checkbox="+checkbox+"&box="+box+"&xxnr="+xxnr,
		success : function(data) {
			var value = data.msg;
			// 加载更多
			if (type == 'more' && value.length == 2) {
				$("#div_bottom").show();
				$("#div_bottom").html('数据加载完成');
				isend = true;
				loading = false;
				return;
			}
			// 搜索
			else if (type == 'search' && value.length == 2) {
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
				$(objArray).each(function(i, value) {
					var item1 = "<tr>";
					var item2 = "<td width=\"35%\"><span style=\"color:#007EE2;\"  class = \"my_info dian\" onclick=\"openDialog('"+value.XXBH+"','"+value.SSXMBH+"','"+value.SSXMLX+"','"+value.SFCK+"','"+value.SSZXMLX+"')\">"+value.YHXM+value.XXNR+"</span></td>";
					var item3 = "<td width=\"19%\" style=\"text-align:center\">";
					if(value.SSXMLX=="taskes"){
						item3+="<span>任务</span>";
					}else if(value.SSXMLX=="inventorys"){
						item3+="<span>盘查</span>";
					}else{
						item3+="<span>审批</span>";
					}
					item3 +="</td>";
					var item4 = "<td width=\"10%\" style=\"text-align:center\">";
					if(value.SFCK=="0"){
						item4 +="<span id=\""+value.XXBH+"\" style=\"color:red\">未读</span>";
					}else if(value.SFCK=="1"){
						item4 +="<span id=\""+value.XXBH+"\">已读</span>";
					}
					var item5 ="<td width=\"20%\" style=\"text-align:center\">"+value.CJSJ+"</td>";
					var item6 ="<td width=\"15%\" style=\"text-align:center\"><span class=\"my_info\"  style=\"color:#007EE2\" onclick=\"openDialog('"+value.XXBH+"','"+value.SSXMBH+"','"+value.SSXMLX+"','"+value.SFCK+"','"+value.SSZXMLX+"')\">查看</span></td>";
					$("#dadiv").append(item1 + item2 + item3 + item4 + item5 + item6);

					/*$(".dian").each(function(){
						var maxwidth=50;
						if($(this).text().length>maxwidth){
							$(this).text($(this).text().substring(0,maxwidth));
							$(this).html($(this).html()+"....");
						}
					});*/
				});
				loading = false;
			}
		},
		error : function(error) {
			top.$.ligerDialog.error("数据加载失败！" + error.status,"错误");
		}
	});
}

function winOpen(url,title,width,height,button1,button2,callback){
	window.top.$.ligerDialog.open({
		width: width, height: height, url: url, title: title, buttons: [{
			text: button1, onclick: function (item, dialog) {
				var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
				var data = fn();
				if(data){
					callback(data);
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
//function openDialog(id,itemid,itemtype,i,lb,sfcz,spzt,cjr) {
/** 点击内容进入详情 */
//id-消息编号      itemid-所属项目编号     itemtype-所属项目类别   SFCK-是否查看 
function openDialog(id,itemid,itemtype,sfck,SSZXMLX) {
	if(sfck==0){
		$.ajax({
			url:"mymessageModify.action",
			data:"id="+id,
			dataType:"json",
			success:function(data){
				if("success"==data.result)
				{
					detail(itemid,itemtype,SSZXMLX);
				}else{
					$.ligerDialog.error("跳转详情失败！");
				}
			}

		});
	}
	else
	{
		detail(itemid,itemtype,SSZXMLX);
	}
	$("#"+id).html("已读");
	$("#"+id).attr("style","none");
}

function detail(itemid,itemtype,SSZXMLX)
{
	var mypath = $("#mypath").val();
	//任务
	if("taskes"==itemtype){
		isTRUEbyID(itemid);
	}else if("approvalsobject"==itemtype){
		if(SSZXMLX=='apl_creat_restart')
		{
			window.parent.f_click(itemid,"审批详情",mypath+ "bussiness/aviation/grsz/approvalsObject/ApprovalsEditfcdh.jsp?spdxbh="+ itemid);
		}
		else{
			window.parent.f_click(itemid,"审批详情",mypath + "bussiness/aviation/grsz/approvalsObject/ApprovalsEdit.jsp?spdxbh=" + itemid);
		}
	}
	//条件信息
	else if("approvalsconditions"==itemtype){
		window.parent.f_click(itemid,"审批详情",mypath+"bussiness/aviation/lkgl/tjxlkSP/ApprovalsconditionEditfcc.jsp?itemid="+ itemid);
		/*if(userid==cjr){
				window.parent.f_click(itemid,"审批详情",mypath+"bussiness/aviation/lkgl/tjxlkSP/ApprovalsconditionEditfcc.jsp?itemid="+itemid+"&type=wjs");
			}else{
				window.parent.f_click(itemid,"审批详情",mypath+"bussiness/aviation/lkgl/tjxlkSP/ApprovalsconditionEditfcc.jsp?itemid="+ itemid+"&type=wfc");
			}*/
	}
	//盘查信息
	else if("inventoryinfo"==itemtype){
		var url = mypath+"pcxxMess.action?pcbh=" + itemid;
		var tabid = "PCLB" + "-" + itemid;
		window.parent.f_click(tabid,"盘查消息",url);
	}

}


/**
 * 点击查看，判断登录人是否有查看任务的权限
 * zad
 * 2016-02-22
 */
function isTRUEbyID(itemid){
	var mypath = $("#mypath").val();
	var userid = $("#userid").val();
	$.ajax({
		url:"isTRUEbyID.action",
		data:"id="+itemid,
		dataType:"json",
		async : true,
		type : "post",
		success : function(data) {
			var mm = data.model;
			var yhbh = mm.YHBH;
			var cjrbh = mm.CJRBH;
			yhbh +=","+cjrbh;
			if(yhbh.indexOf(userid) > -1){
				window.parent.f_click(itemid,"任务详情",mypath+"bussiness/aviation/rwcl/rw_detail_new.jsp?ssxmbh="+itemid);
			}else{
				top.$.ligerDialog.warn('你已被移除该任务，无权查看！');
			}
		},
		error : function(error) {
			alert("获取信息失败****" + error.status);
		}
	});
}

function islkdxDetail()
{
	$.ajax({
		url:"isTRUEbyID.action",
		data:"id="+itemid,
		dataType:"json",
		async : true,
		type : "post",
		success : function(data) {
			var mm = data.model;
			var yhbh = mm.YHBH;
			var cjrbh = mm.CJRBH;
			yhbh +=","+cjrbh;
			if(yhbh.indexOf(userid) > -1){
				window.parent.f_click(itemid,"任务详情",mypath+"bussiness/aviation/rwcl/rw_detail_new.jsp?ssxmbh="+itemid);
			}else{
				top.$.ligerDialog.warn('你已被移除该任务，无权查看！');
			}
		},
		error : function(error) {
			alert("获取信息失败****" + error.status);
		}
	});

}

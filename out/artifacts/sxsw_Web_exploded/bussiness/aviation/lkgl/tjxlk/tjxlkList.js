var mypath;
var page = 1;// 当前页面
var isend = false; // 判断当加载完成时，滚动条滑动不在加载数据
var order_type = 'order_shxsj'; // 排序类别
var loading = false; //判断单次加载是否完成
jQuery(function($) {
	mypath = $("#mypath").val();
	mzQueryList(); // 获取民族下拉框值
	GKLBBHQueryList(); // 获取人员类别下拉框值
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});

	//按回车键进行搜索
	$(document).keydown(function(event){
		if(event.keyCode==13){
			search();
		}
	});
	//做判断，判断是不是从系统门户页面跳进来
	if($("#welcomeJsp").val()=="welcome"){
		search();
	}
});

//搜索
function search() {
	$("#dadiv").html('');
	$("#div1").show();
	page = 1;
	isend = false;
	if(!loading){
		loading = true;
		search_or_more(page, 'search', order_type);
	}
}

//按不同方式排序搜索
function searchByType(item_type, item_value) {
	$("#dadiv").html('');
	$("#div_sort span").css("color", "#386CB5");
	$("#div_sort #jt").remove();

	// 重新赋值
	$("#" + item_type).css("color", "#FC9B71");
	$("#" + item_type).html(item_value);
	$("#" + item_type).append("<span id=\"jt\">↓</span>");
	page = 1;
	isend = false;
	order_type = item_type;
	if(!loading){
		loading = true;
		search_or_more(page, 'more', order_type);
	}
}

//滚动加载更多数据
$(window).scroll(function() {
	if($(document).scrollTop()>0){
		if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
			if (!isend && !loading) {
				page = page + 1;
				loading = true;
				search_or_more(page, 'more', order_type);
			}
		}
	}
});

//搜索/加载更多
function search_or_more(page, type, order_type) {
	//进入页面提示文字
	$("#div_btm").hide();  

	//友好提示文字
	$("#div_bottom").show();
	$("#div_bottom").html('正在加载中...');

	var data = "page=" + page + "&pagesize=10";
	var GKLBMC = $("#GKLBBH").val(); // 人员类别
	var MZMC = $("#MZ").val(); // 民族
	var RYXM = $("#RYXM").val().trim(); // 姓名
	var RYXB = $("#RYXB").val().trim(); // 姓别
	var welcomeJsp = $("#welcomeJsp").val();
	var Dqtx="";
	if(welcomeJsp=="welcome"){
		Dqtx = "welcome";
	}
	var GMSFZHM = $("#GMSFZHM").val().trim(); // 身份证号
	var ZZXZ = $("#ZZXZ").val().trim(); // 住址
	var province = $("#province").val();//省份
	var city = $("#city").val();	//地区
	var county = $("#county").val();//县市
	data += "&province="+province+"&city="+city+"&county="+county;
	var QT = $("#QT").val().trim(); // 其他
	var qb = $("#qb").attr('checked'); // 全部
	var lkz = $("#lkz").attr('checked');// 列控中
	var ycx = $("#ycx").attr('checked');// 已撤销
	data +=  "&RYXB=" + RYXB+"&MZMC=" + MZMC+"&GKLBMC=" + GKLBMC+"&RYXM=" + RYXM + "&GMSFZHM=" + GMSFZHM + "&ZZXZ=" + ZZXZ + "&QT=" + QT + "&qb=" + qb + "&lkz=" + lkz + "&ycx=" + ycx + "&order_type=" + order_type+"&Dqtx="+Dqtx,

	$.ajax({   
		url : "gdjzConditioncontrols.action",
		dataType : "json",
		type : "post",
		data : data,
		success : function(data) {
			if(type!="more"){
				var item0 = "搜索到<span style=\"color:#ef7844;font-weight:bold;\">&nbsp;"
					+ data.total
					+ "&nbsp;</span>条记录&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color:#ef7844;font-weight:bold;\">&nbsp;"
					+ data.totallkz
					+ "&nbsp;</span>个条件正生效中&nbsp;&nbsp;&nbsp;&nbsp;<span>"
					+ data.totalycx
					+ "</span>个条件已失效&nbsp;&nbsp;&nbsp;&nbsp";
				$("#div1").html(item0);
			}
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
			}else {
				$("#div_bottom").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#div_bottom").show();
					$("#div_bottom").html('数据加载完成');
					isend=true;
				}
				$(objArray).each(function(i, value) {
					var item3 = "<table style=\"width:100%;line-height: 30px;\"><tr>";//<td width=\"10%\"><input type=\"checkbox\" name=\"box\" value=\"全选\" /></td>
					var item4 = "<td width=\"15%\" class=\"my_info\" class = \"info\" style=\"color:#007EE2;\" onclick=\"openDialog('"+ value.TJXLKBH+ "')\">";
					var item5 = "<div class = \"info\" style=\"text-align:center;\">";
					if (value.MZ != "") {
						item5 += value.MZMC+ "&nbsp;&nbsp";
					}
					if (value.XM != "") {
						item5 += value.XM + "&nbsp;&nbsp;";
					}
					if (value.XB != "") {
						if(value.XB==1){
							item5 +="男"	+ "&nbsp;&nbsp;";
						}
						else if(value.XB==2){
							item5 +="女"	+ "&nbsp;&nbsp;";
						}
					}
					if (value.JG != "") {
						item5 += value.JG+ "&nbsp;&nbsp;";
					}
					if (value.ZZ != "") {
						item5 += value.ZZ+ "&nbsp;&nbsp;";
					}
					if (value.SFZH != "") {
						item5 += value.SFZH+ "&nbsp;&nbsp;";
					}
					if (value.QT != "") {
						item5 += value.QT+ "&nbsp;&nbsp;";
					}
					item5 += "</div></td><td width=\"18%\" style=\"color:#ef7844\">"+value.CJSJ+"</td>";
					item5 += "<td width=\"13%\" style=\"color:#ef7844\">"+ value.LKYXSJ_Date+ "</td>";
					var item6 = "<td width=\"15%\">";
					if (value.ZT == 0) {
						item6 += "列控";
					}else if(value.ZT == 1){
						item6 += "禁用";
					}else if(value.ZT == 2){
						item6 += "申请启用中";
					}else if(value.ZT == 3){
						item6 += "申请禁用中";
					}else if(value.ZT == 4){
						item6 += "申请编辑中";
					}

					var item7 = "</td><td width=\"10%\" style=\"color:#007EE2;\" class = \"my_info\" onclick=\"getCJRXM('"+ value.CJRBH+ "')\">"+ value.CJRXM + "</td>";
					var item8 = "<td width=\"19%\" style=\"text-align:center;\">";
					if (value.ZT = 0) {
						item8 += "<span class = \"my_info\" style=\"padding:13px;color:#b2b2b2\">修改</span><span class = \"my_info\" style=\"padding:13px;color:#007EE2\">生效</span><span style=\"padding:13px;color:#b2b2b2\">失效</span></td>";
					} else if(value.ZT = 1){
						item8 += "<span class = \"my_info\" style=\"padding:13px;color:#b2b2b2\">修改</span><span style=\"padding:13px;color:#007EE2\">生效</span><span class = \"my_info\" style=\"padding:13px;color:#b2b2b2\">失效</span></td>";
					}else{
						item8 += "<span class = \"my_info\" style=\"padding:13px;color:#b2b2b2\">修改</span><span style=\"padding:13px;color:#b2b2b2\">生效</span><span class = \"my_info\" style=\"padding:13px;color:#b2b2b2\">失效</span></td>";
					}
					var item9 = "</tr>";
					$("#dadiv").append(item3 + item4+ item5+ item6+ item7+ item8+ item9);
				});
				loading = false;
			}
		}
	});
}
//添加条件性列控
function itemclick(){
	isPass(); //判断是否有审批权限
	var pass=$("#pass").val();

	var url = mypath + "bussiness/aviation/lkgl/tjxlk/tjxlkAdd.jsp?LB=0&pass="+pass;
	//有审批权限
	if(pass == "okpass"){
		window.top.$.ligerDialog.confirm("您所提交的列控条件申请即时生效，    确定添加吗？", "提示",function(ok) {
			if (ok){
				winOpen(url, "", 750, 600, '提交', '取消', function(data, dialog) {
					$.ajax({
						url : "addApprovalsTJXLKOKPass.action",
						data : data,
						dataType : "json",
						type : "post",
						success : function(data) {
							if ("success" == data.result) {
								top.$.ligerDialog.success("列控成功！");
								$("#dadiv").html("");
								isend = false;
								search_or_more("1","more","order_shxsj");
							} else {
								top.$.ligerDialog.error("列控失败！");
							}
						},
						error : function(error) {
							top.$.ligerDialog.error("列控失败！" + error.status,
							"错误");
						}
					});
				});
			}
		});
	}else{
		winOpen(url, "", 750, 600, '提交', '取消', function(data, dialog) {
			$.ajax({
				url : "addApprovalsTJXLK.action",
				data : data,
				async : true,
				dataType : "json",
				type : "post",
				success : function(data) {
					if ("success" == data.result) {
						top.$.ligerDialog.success("提交成功！");
						window.top.my_closewindow();
					} else {
						top.$.ligerDialog.error("提交失败！");
					}
				},
				error : function(error) {
					top.$.ligerDialog.error("列控失败！" + error.status, "错误");
				}
			});
		}); 
	}
}
//判断用户是否有最终审批权限
function isPass() {
	$.ajax({
		url : "new_approvalsModify.action",
		dataType : "json",
		async : false,
		type:"post",
		success : function(data) {
			if ("okpass" == data.result) {
				$("#pass").val("okpass");
				//$("#spry").hide();
			} else {
				$("#pass").val("nopass");
			}
		}
	});
}




//打开详情界面
function openDialog(id) {
	var tabid = "GDPJ" + "-" + id;
	var url = mypath + "bussiness/aviation/lkgl/tjxlk/ljxlkMess.jsp?id="+ id;
	this.parent.f_click(tabid, "详情", url);
}

/**
 * 点击上控人详情
 */
function getCJRXM(cjrbh) {
	if (cjrbh == null) {
		cjrbh = $("#CJRBH").val();
	}
	var url = mypath + "system/user/UserMess.jsp?id="+ cjrbh;
	window.top.my_openwindow("", url, 700,450, "上控人详情信息");
}

//获取民族下拉框值
function mzQueryList() {
	$.ajax({
		url : "loadTsdict.action?sszdlx=" + encodeURI("GA_MZ"),
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#MZ").append(
					"<option  selected='selected' value='" + -1 + "'>" + "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#MZ").empty();
			var text = "";
			text += " <option selected=\"selected\" value=\"\">--请选择民族--</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>" + value.text + "</option>";
			});
			$("#MZ").append(text);
		}
	});
}
//获取人员类别下拉框值
function GKLBBHQueryList() {
	$.ajax({
		url : "loadTsdict.action?sszdlx=" + encodeURI("GKLB"),
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#GKLBBH").append(
					"<option  selected='selected' value='" + -1 + "'>"
					+ "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#GKLBBH").empty();
			var text = "";
			text += " <option selected=\"selected\" value=\"\">--请选择人员类别--</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>" + value.text + "</option>";
			});
			$("#GKLBBH").append(text);
		}
	});
}


//撤销条件性列控 //sfzh,GKLBBH,YJYQ,DQSJ
function repealLK(TJXLKBH,TJXXBH){
	//将条件性列控表 状态改为4（禁用中）
	//审批条件性表添加数据
	//审批操作人表，审批意见表，审批可见人表 添加数据

	//条件列控主键，条件信息编号
	var url = mypath + "bussiness/aviation/lkgl/tjxlk/tjlkRepeal.jsp?TJXLKBH="+TJXLKBH+"&TJXXBH="+TJXXBH;
	window.top.my_openwindow("", url, 670, 500, "撤销列控");
}


/**控制打开界面*/
function winOpen(url, title, width, height, button1, button2, callback) {
	window.top.$.ligerDialog.open({width : width,height : height,url : url,title : title,
		buttons : [{text : button1,onclick : function(item, dialog) {
			var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
			var data = fn();
			if (data) {
				callback(data);
				dialog.close();
			}
		}
		},{text : button2,onclick : function(item, dialog) {
			dialog.close();
		}
		}]
	});
}

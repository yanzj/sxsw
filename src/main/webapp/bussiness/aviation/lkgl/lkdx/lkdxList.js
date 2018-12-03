var mypath;
var page = 1;//当前页面
var isend=false;  //判断当加载完成时，滚动条滑动不在加载数据
var loading = false; //判断单次加载数据是否完成
var order_type='order_shxsj'; //排序类别

jQuery(function($) {
	mypath = $("#mypath").val();
	mzQueryList();     //获取民族下拉框值
	GKLBBHQueryList(); //获取人员类别下拉框值
	$(".my_info").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});
	var welcomeJsp = $("#welcomeJsp").val();
	if(welcomeJsp=="welcome"){
		search();
	}

	//限制字符个数
	$(".dian").each(function(){
		var maxwidth=20;
		if($(this).text().length>maxwidth){
			$(this).text($(this).text().substring(0,maxwidth));
			$(this).html($(this).html()+'···');
		}
	});

	//按回车键进行搜索
	$(document).keydown(function(event){
		if(event.keyCode==13){
			search();
		}
	});
	//复选框--勾选了其他的，‘全部’的勾选就取消
	$("input:checkbox[name='box']").live("click",function(){
		if($(this).val()!="全部"){
			$("#qb").attr("checked",false);
		}else{
			$("#lk").attr("checked",false);
			$("#jy").attr("checked",false);
			$("#sqqyz").attr("checked",false);
			$("#sqjyz").attr("checked",false);
			$("#sqbjz").attr("checked",false);
		}
	});
});

//按不同方式排序搜索
function searchByType(item_type,item_value){
	$("#dadiv").html('');
	$("#div_sort span").css("color", "#386CB5");
	$("#div_sort #jt").remove();

	//重新赋值
	$("#"+item_type).css("color", "#FC9B71");
	$("#"+item_type).html(item_value);
	$("#"+item_type).append("<span id=\"jt\">↓</span>");
	page=1;
	isend=false;
	order_type=item_type;
	if(!loading){
		loading  = true;
		search_or_more(page,'search',order_type);
	}
}
//搜索
function search(){
	$("#dadiv").html('');
	$("#div1").show();
	page=1;
	isend=false;
	//默认的复选框‘全部’勾选
	var checkbox="";
	$("input:checkbox[name='box']:checked").each(function(){
		checkbox += $(this).val()+",";
	});
	if(checkbox==""){
		$("#qb").attr("checked",true);
	}
	if(!loading){
		loading  = true;
		search_or_more(page,'search',order_type);
	}
}
//滚动加载更多数据
$(window).scroll(function() {
	if ($(document).scrollTop()>0){
		if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
			if(!isend && !loading){
				page = page+1;
				loading  = true;
				search_or_more(page,'more',order_type);
			}
		}
	}
});

//搜索/加载更多
function search_or_more(page,type,order_type){ 
	//进入页面提示文字
	$("#div_btm").hide();  

	//友好提示文字
	$("#div_bottom").show();
	$("#div_bottom").html('正在加载中...');

	var welcomeJsp = $("#welcomeJsp").val();
	var Dqtx="";
	if(welcomeJsp=="welcome"){
		Dqtx = "welcome";
	}
	var data = "page="+page+"&pagesize=10";
	var GKLBMC = $("#LKLB").val();//人员类别
	var MZMC = $("#MZ").val();         //民族
	var RYXM=$("#XM").val().trim();  //姓名
	var RYXB=$("#XB").val().trim();  //姓别
	if (RYXB != "请选择性别") {
		data += "&RYXB=" + RYXB;
	}
	var GMSFZHM=$("#SFZH").val().trim();  //身份证号
	var ZZXZ=$("#ZZXZ").val().trim();  //住址
	var province = $("#province").val();//省份
	var city = $("#city").val();	//地区
	var county = $("#county").val();//县市
	var checkbox="";
	$("input:checkbox[name='box']:checked").each(function(){
		checkbox += $(this).val()+",";
	});
	data+="&GKLBMC="+GKLBMC+"&MZMC="+MZMC+"&RYXM="+RYXM+"&GMSFZHM="+GMSFZHM+"&ZZXZ="+ZZXZ+"&order_type="+order_type+"&checkbox="+checkbox+"&Dqtx="+Dqtx+"&province="+province+"&city="+city+"&county="+county,
	$.ajax({
		url:"controlsplistMore.action",
		dataType:"json",
		type:"post",
		data:data,
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
				$("#div1").html("");
				var item0 = "搜索到<span style=\"color:#ef7844;font-weight:bold;\">&nbsp;"+data.total+"&nbsp;</span>条记录&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color:#ef7844;font-weight:bold;\">&nbsp;"+data.totallkz+"&nbsp;</span>条列控中&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color:#ef7844;font-weight:bold;\">"+data.totalycx+"</span>&nbsp条已失效&nbsp;&nbsp;&nbsp;&nbsp<span style=\"color:#ef7844;font-weight:bold;\">"+data.totalqyz+"</span>&nbsp条启用中&nbsp;&nbsp;&nbsp;&nbsp<span style=\"color:#ef7844;font-weight:bold;\">"+data.totalcxz+"</span>&nbsp条撤销中&nbsp;&nbsp;&nbsp;&nbsp<span style=\"color:#ef7844;font-weight:bold;\">"+data.bjzcount+"</span>&nbsp条编辑中&nbsp;&nbsp;&nbsp;&nbsp";
				$("#div1").append(item0);
				loading = false;
				return;
			}else{
				$("#div_bottom").hide();
				$("#div1").html("");
				var item0 = "搜索到<span style=\"color:#ef7844;font-weight:bold;\">&nbsp;"+data.total+"&nbsp;</span>条记录&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color:#ef7844;font-weight:bold;\">&nbsp;"+data.totallkz+"&nbsp;</span>条列控中&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color:#ef7844;font-weight:bold;\">"+data.totalycx+"</span>&nbsp条已失效&nbsp;&nbsp;&nbsp;&nbsp<span style=\"color:#ef7844;font-weight:bold;\">"+data.totalqyz+"</span>&nbsp条启用中&nbsp;&nbsp;&nbsp;&nbsp<span style=\"color:#ef7844;font-weight:bold;\">"+data.totalcxz+"</span>&nbsp条撤销中&nbsp;&nbsp;&nbsp;&nbsp<span style=\"color:#ef7844;font-weight:bold;\">"+data.bjzcount+"</span>&nbsp条编辑中&nbsp;&nbsp;&nbsp;&nbsp";
				$("#div1").append(item0);
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#div_bottom").show();
					$("#div_bottom").html('数据加载完成');
					isend=true;
				}
				$(objArray).each(function (i, value) { 
					var item1 = "<div class=\"item_style\">";
					var item2="<table style=\"width:100%;\">";
					var item3="<tr><td rowspan=\"5\" style=\"width:10%;\"><img class=\"controlps_img\" src=\""+value.XP+"\"  class=\"controlps_img\" /></td></tr>";
					var item4="<tr><td style=\"font-size: 19px;color: #EF7844;font-weight: bold;width:25%;border:1px silid blue;\"><span  class=\"my_info\" onclick=\"openDialog('"+ value.BD_RYBH+ "','"+value.XM+"');\">"+value.XM+"</span></td>";
					if(value.GZBH != ""){
						item4+="<td  style=\"width:10%\"><img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" /></td>";
					}else{
						item4+="<td style=\"width:10%\"><img src=\""+mypath+"images/common/fkweb_eyesongrey.png\" /></td>";
					}
					item4+="<td style=\"width:35%\"><span id=\"oneSearch_bt\" class=\"gk_span\">"+value.GKLBMC+"</span>"+value.CJSJ+"&nbsp;&nbsp;&nbsp; <span style = \"color:#007EE2;\" class = \"my_info\" onclick=\"getCJRXM('"+value.CJRBH+"')\">"+value.CJRXM+"</span></td><td colspan=\"2\" style=\"width:20%;color:#ef7844;font-weight:bold;text-align:center\">";
					if(value.ZT == '0'){
						item4+="列控";
					}
					if(value.ZT == '1'){
						item4+="禁用";
					}
					if(value.ZT == '2'){
						item4+="申请启用中";
					}
					if(value.ZT == '3'){
						item4+="申请禁用中";
					}
					if(value.ZT == '4'){
						item4+="申请编辑中";
					}
					item4+="</td></tr>";
					var item5="<tr><td colspan=\"2\"><span>身份证号：</span><span class=\"td_value\">"+value.SFZH+"</span></td><td style=\"colspan:2;\">出生日期：<span class=\"td_value\">"+value.CSRQ+"</span></td><td style=\"text-align:center;color:#007EE2;\" class = \"my_info\" onclick=\"javascript:openDialog('"+ value.BD_RYBH+ "','"+value.XM+"');\" >查看列控信息</td></tr><tr><td colspan=\"2\"><span>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：</span><span class=\"td_value\">"+value.MZMC+"</span></td><td>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：<span class=\"td_value\">"+value.NL+"</span></td><td style=\"text-align:center;color:#007EE2\">";

					item5 += "</td></tr>";
					var item6="<tr><td  colspan=\"2\">户口地址：<span class=\"dian td_value\">"+value.HKSZD+"</span></td><td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：";
					if(value.XB==1){
						item6+="<span class=\"td_value\">男</span></td><td style=\"text-align:center;color:#007EE2\">";
					}
					if(value.XB==2){
						item6+="<span class=\"td_value\">女</span></td><td style=\"text-align:center;color:#007EE2\">";
					}
					if(value.XB==9){
						item6+="<span class=\"td_value\">未知</span></td><td style=\"text-align:center;color:#007EE2\">";
					}
					"</td></tr>";
					var item7=" </table>";			
					var item8="</div>";	
					//限制字符个数
					$(".dian").each(function(){
						var maxwidth=20;
						if($(this).text().length>maxwidth){
							$(this).text($(this).text().substring(0,maxwidth));
							$(this).html($(this).html()+'···');
						}
					});
					$("#dadiv").append(item1 +item2+item3+item4+item5+item6+item7+item8);
				});
				loading = false;
			}
		}
	});
}

//点击名字进入详情
function openDialog(id,casename) {
	var ids = "";
	var url = "bussiness/aviation/lkgl/lkdx/lkdxMess.jsp?BD_RYBH=" + id+"&casename="+casename+"&ids="+ids;
	var tabid = "GDPJ" + "-" + id+"-"+ids;
	this.parent.f_click(tabid,casename,mypath + url);
}

//批量导入用户
function itemimport() {
	var url = "bussiness/callcenter/util/ExcelUpload.jsp?servicetype=02";
	window.top.$.ligerDialog.open({
		name : "importExcel",
		url : url,
		width : 400,
		height : 300,
		modal : true,
		isResize : false,
		title : "导入管控对象Excel",
		allowClose : true,
		isHidden : false,
		buttons : [
		           { text : '上传',
		        	   onclick : function(item, dialog) {
		        		   var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
		        		   var data = fn(function(data) {
		        			   g.loadData(true);
		        			   dialog.close();
		        		   });
		        	   }
		           }, {
		        	   text : '取消',
		        	   onclick : function(item, dialog) {
		        		   dialog.close();
		        	   }
		           } ]
	});
}
//导出管控对象
function itemexport() {
	var starttime = $("#starttime").val();
	var endtime = $("#endtime").val();
	var itemtype = $("#lb").val();
	serchform.action = "exportControlpsExcel.action?starttime=" + starttime
	+ "&endtime=" + endtime + "&itemtype=" + itemtype;
	serchform.submit();
}



//获取民族下拉框
function mzQueryList() {
	$.ajax({
		url : "loadTsdict.action?sszdlx=" + encodeURI("GA_MZ"),
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#MZ").append(
					"<option  selected='selected' value='" + -1 + "'>"
					+ "正在加载中,请稍候..." + "</option>");
		},

		success : function(data) {
			$("#MZ").empty();
			var text = "";
			text += " <option selected=\"selected\"  style = \"color:#b2b2b2;\" value=\"\">请选择民族</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>"
				+ value.text + "</option>";
			});
			$("#MZ").append(text);
		}
	});
}
//获取管控类别下拉框
function GKLBBHQueryList() {
	$
	.ajax({
		url : "loadTsdict.action?sszdlx=" + encodeURI("GKLB"),
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#LKLB").append("<option  selected='selected' value='" + -1 + "'>" + "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#LKLB").empty();
			var text = "";
			text += " <option selected=\"selected\"  style = \"color:#b2b2b2;\" value=\"\">请选择列控类别</option>";
			$.each(data, function(n, value) {
				text += "<option value='" + value.id + "'>" + value.text + "</option>";
			});
			$("#LKLB").append(text);
		}
	});
}
//上控人基本信息
function getCJRXM(cjrbh){
	var url = mypath+"system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"上控人详情信息");
}
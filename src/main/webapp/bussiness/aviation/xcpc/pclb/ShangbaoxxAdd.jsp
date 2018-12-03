<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String id = CommUtil.getID();//id
	String itemid = request.getParameter("itemid");
	String content = request.getParameter("content");
	String itemtype = request.getParameter("itemtype");
	String fbrw = request.getParameter("fbrw");
	String pcbh = request.getParameter("pcbh");//盘查编号
	String ryxm = request.getParameter("ryxm");//人员姓名
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>发布任务信息添加</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/jquery.metadata.js"
	type="text/javascript"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js"
	type="text/javascript"></script>
<script src="<%=basePath%>js/UploadFailUtil.js" type="text/javascript"></script>
<script type="text/javascript">
	var cacheDept;
	var cacheYJ;
	var cacheRY;
	var cacheDataSet;
	var form;
	var pcbh = "<%=pcbh%>";
	var ryxm = "<%=ryxm%>";
	var basePath = "<%=basePath%>";
	var fbrw = "<%=fbrw%>";
	var itemtype = "<%=itemtype%>";
	var content = "<%=content%>";
	var itemid = "<%=itemid%>";
    $(function (){
     cacheDataSet=$(window.parent.document).find("#cacheDataSet");
        getMess(pcbh);
    	form = $("#form2").ligerForm();
        liger.get("form2").setData({
				id : "<%=id%>"
		});
		$("#selectuser").click(function() {
			f_selectContact();
		});
		$("#clearuser").click(function() {
			cacheDataSet.children("#cacheRY").text("");
			$("#sdesc").html("");
		});
	});
    /** 
     	  获取上报信息
    */
    function getMess(pcbh){
    	$.ajax({
    		url:"pcxxgetMess.action",
    		data:"pcbh="+pcbh,
    		dataType:"json",
    		type:"post",
    		success:function(mm){
    			$("#xm").html(mm.iimodel.XM);
    			$("#cjsj").html(mm.iimodel.CJSJ);
    			$("#jcmc").html(mm.iimodel.JCMC);
    			$("#cjrxm").html(mm.iimodel.CJRXM);
    		},error:function(error){
    			top.my_alert("获取信息失败!" + error.status,"error");
    		}
    	});
    }
	/**提交验证*/
	function f_validate() {
		if (checkData()) {
			$.ligerDialog.waitting('正在保存中,请稍候...');
			return addPost();
		}
		return null;
	}
	function checkData() {
		var SBYY = $("#SBYY").val();
		var RWJSR = $("#sdesc").html();
		if (SBYY == null || SBYY == "" || RWJSR == null || RWJSR == "") {
			top.my_alert("上报原因或上报对象不能为空！");
			return false;
		}
		return true;
	}
	function addPost() {      //组装发送到后台的数据
	    cacheDataSet.children("#cacheRY").text("");
		var RWJSR = "";
		var SBYY = $("#SBYY").val();
		for (var i = 0; i < cacheRY.length; i++){
			RWJSR += cacheRY[i].id + ",";
		}
		var dataPost = {
			"sbyy" : SBYY,
			"pcbh" : pcbh,
			"jsrids" : RWJSR,
		};
		return dataPost;
	};
	$(".nav_href").live("mouseover", function() {
		$(this).addClass("my_info_mess");
	});
	$(".nav_href").live("mouseout", function() {
		$(this).removeClass("my_info_mess");
	});
	//移除审批人员
	function removeUser(id, name) {
		var data = cacheRY;
		var idx = -1;
		for (var i = 0; i < data.length; i++) {
			if (id == data[i].id) {
				idx = i;
				break;
			}
		}
		if (idx != -1) {
			try {
				data.splice(idx, 1);
			} catch (e) {
				var temp = [];
				for (var i = 0; i < data.length; i++) {
					if (id != data[i].id) {
						temp.push(data[i]);
					}
				}
				cacheRY = data = temp;
			}

			cacheDataSet.children("#cacheRY").text(JSON.stringify(data));
			//移除标签
			$("#" + id + "ry").remove();
		}
	}
	function f_selectContact() {
		cacheDataSet.children("#cacheRY").addClass("selected");
		cacheDataSet.children("#cacheYJ").removeClass("selected");
		window.top.$.ligerDialog.open({
			title : '选择执行人',
			name : 'winselector',
			width : 900,
			height : 500,
			url : 'bussiness/aviation/util/UserListMultiSelect.jsp',
			buttons : [ {
				text : '确定',
				onclick : f_selectContactOK
			}, {
				text : '取消',
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
		});
		return false;
	}
	function f_selectContactOK(item, dialog) {
		var fn = dialog.frame.f_select || dialog.frame.window.f_select;
		var data = fn();
		if (!data) {
			alert('请选择人员');
			return;
		}
		cacheRY = data;
		//把前一次的缓存清空，并重新赋值
		cacheDataSet.children("#cacheRY").text("");
		cacheDataSet.children("#cacheRY").text(JSON.stringify(cacheRY));
		var users = "";
		for (var i = 0; i < data.length; i++) {
			var s = "<span style='font-size:14px;margin-right:10px' id='"+data[i].id+"ry'>"
					+ data[i].name
					+ " <img src='"
					+ basePath
					+ "images/delete.png' onclick=\"removeUser('"
					+ data[i].id
					+ "','"
					+ data[i].name
					+ "')\" style=\"cursor:pointer\" /></span>";
			users += s;
		}
		$("#sdesc").html(users);
		dialog.close();
	}
</script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	font-size: 14px;
}
.button_style{
	background-color: #C7D7EE;
	border: 1px solid #C7D7EE;
	height:27px;
	width: 120px;
	margin-right: 5px;"
}
.div1 {
	width: 100%;
	height: 30px;
	line-height: 30px;
	clear: both;
	background-color: #C7D9EF;
	font-size: 15px;
	font-famliy:微软雅黑;
	font-weight: bold;
	margin-top: 20px;
	margin-bottom: 20px;
	text-align: center;
	color: #ef7844;
	clear: both;
}
.input3 {
	border-radius: 3px;
	min-height: 25px;
	overflow: auto;
	width: 390px;
	background: #F2F2F2;
	border: 1px solid #D1D1D1;
} 
.font_style{
    font-size:12px;
    color:grey; 
}
.font_style1{
 	font-size:12px;
    color:black; 
}
</style>
</head>
<body style="padding-bottom: 20px;">
	<div class="div1">信息上报</div>
	<div style="margin-top: 5px;padding-left:30px;">
		<table class="table_info_box" border="0">
			<tr>
				<td align="left" class="font_style">被盘查人:</td>
				<td class="font_style1" id="xm"></td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="left" class="font_style">盘查时间:</td>
				<td style="color: #ef7844;font-size:12px;" id="cjsj"></td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="left" class="font_style">盘查地点:</td>
				<td class="font_style1" id="jcmc"></td>
				<td align="left"></td>
			</tr>
			<tr>
				<td align="left" class="font_style">盘查人:</td>
				<td  class="font_style1" id="cjrxm"></td>
				<td align="left"></td>
			</tr>
			<tr><td><br/><br/></td></tr>
			
			<tr>
				<td width="80px" class="font_style">上报对象:</td>
				<td width="390px" ><div style="margin-bottom:3px;" class="input3" id="sdesc"></div></td>
				<td id="selectuser"><img class = "my_info"
					style="width:20px;height:20px;margin-left: 10px"
					src="<%=basePath%>images/common/fkweb_personicon.png"  onclick="f_selectContact()"/></td>
			</tr>
			<tr>
				<td align="left" class="font_style">上报原因:</td>
				<td ><textarea
						style="height:70px" class="input3" id="SBYY"  onfocus="this.value=''; this.onfocus=null;" >&nbsp;&nbsp;&nbsp;请输入上报原因</textarea></td>
				<td align="left" ></td>
			</tr>
			
		</table>
	</div>
	<input id="mypath" type="hidden" value="<%=path%>" />
	<input id="basepath" type="hidden" value="<%=basePath%>" />
</body>
</html>

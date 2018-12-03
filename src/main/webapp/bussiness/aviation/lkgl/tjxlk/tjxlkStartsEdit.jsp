<%@page import="com.dhcc.common.util.CommUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
    String LB = request.getParameter("LB"); //来源  LB=0 列控  LB=1 启用
	String TJXLKBH=request.getParameter("TJXLKBH");  //条件性列控编号
    String userid = session.getAttribute("userid").toString();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>启用列控对象页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/lkgl/tjxlk/tjxlkStartsEdit.js"></script> 
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/util/UserListMultiSelect.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<style>
.txt_title {
	width: 90px;
	color: #868686;
	font-size: 14px;
}

.div1 {
	width: 100%;
	height: 30px;
	line-height: 30px;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: bold;
	margin-top: 20px;
	margin-bottom: 20px;
	text-align: center;
	color: #ef7844;
	clear: both;
}

.holder {
	color: gray;
}
.xing {
	color: red;
	font-weight: bold;
	vertical-align: middle;
}

.input3 {
	border-radius: 3px;
	min-height: 30px;
	overflow: auto;
	width: 450px;
	background: #F2F2F2;
	border: 1px solid #D1D1D1;
}
</style>
</head>
<body style="padding-bottom: 20px;">
	<div class="div1">列控申请</div>
	<div style="margin-top: 5px;padding-left:30px;">
		<table>
		     <tr>
		        <td class = "txt_title">到期时间<span class="xing">&nbsp;*</span></td>
				<td>
					<input id="LKYXSJ" class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" /> <input
					type="checkbox" checked="checked" style="margin-left:50px;" /><font>到期提前一天提醒</font>
				</td>
			</tr>
			<tr>
				<td class = "txt_title">管控类型<span class="xing">&nbsp;*</span></td>
				<td colspan="2"><select class="input3" style="height:34px;" id="GKLBBH">
				</select></td>
			</tr>
			<tr>
				<td class = "txt_title">列控原因<span class="xing">&nbsp;*</span></td>
				<td colspan="2"><input class="input3" type="text" id="YY"  holder="此项是必填项，请填写"  required></input></td>
			</tr>
			<tr>
				<td class = "txt_title">预警对象<span class="xing">&nbsp;*</span></td>
				<td><div class="input3" id="sdescyj"></div></td>
				<td id="selectuseryj"><img class = "my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png" /></td>
			</tr>
			<tr>
				<td class = "txt_title">预警值班账号</td>
				<td><div class="input3" id="sdescyjzbzh"></div></td>
				<td id="selectyjzbzh"><img class = "my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png" /></td>
			</tr>
			<tr>
				<td class = "txt_title">预警要求<span class="xing">&nbsp;*</span></td>
				<td colspan="2"><input holder="此项是必填项，请填写" class="input3 holder" type="text"  id="YJYQ" required></input></td>
			</tr>
			<tr id="spry">
				<td class = "txt_title">审批人&nbsp;&nbsp;&nbsp;<span class="xing">&nbsp;*</span></td>
				<td><div id="sdesc" class="input3"></div></td>
				<td id="selectuser"><img class = "my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png"></img></td>
			</tr>
			<tr>
				<td class = "txt_title" style="vertical-align:middle;">备注说明：</td>
				<td colspan="2"><textarea style="height:70px" class="input3" id="BZXX"></textarea></td>
			</tr>

		</table>
		</div>
	<input type="hidden" id="mypath" value="<%=basePath%>" />
	<input type="hidden" id="userid" value="<%=userid%>" />
	<input type="hidden" id="pass" /> 
	<input id="LB" type="hidden" value="<%=LB%>" />
	<input id="TJXLKBH" type="hidden" value="<%=TJXLKBH%>"/>
		<input type="hidden" id="GKLBMC" />
</body>
</html>
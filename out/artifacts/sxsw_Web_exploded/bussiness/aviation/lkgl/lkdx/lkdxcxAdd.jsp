<%@page import="com.dhcc.common.util.CommUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String id = request.getParameter("id");
	String spdxbh = CommUtil.getID();
	String BD_RYBH = request.getParameter("BD_RYBH");
	String BD_RYXM = request.getParameter("BD_RYXM");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>禁用列控对象页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/lkgl/lkdx/lkdxcxAdd.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/util/UserListMultiSelect.js"></script>
	
	
<style>
.txt_title {
	width: 90px;
	color: #868686;
	font-size: 14px;
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
	width: 400px;
	background: #F2F2F2;
	border: 1px solid #D1D1D1;
}
</style>
</head>
<body class="body_style">
	<table style="padding-left:30px;width: 95%;clear:both;">
		<tr>
			<td class="txt_title">禁用原因<span class="xing">&nbsp;*</span></td>
			<td colspan="2"><input class="input3" type="text" id="YY"
				holder="此项是必填项，请填写" required></input></td>
		</tr>
		<tr id="spry">
			<td class="txt_title">审批人&nbsp;&nbsp;&nbsp;<span class="xing">&nbsp;*</span></td>
			<td><div id="sdesc" class="input3"></div></td>
			<td id="selectuser"><img class="my_info" style="width:20px;height:20px" src="<%=basePath%>images/common/fkweb_personicon.png"></img></td>
		</tr>
		<tr>
			<td class="txt_title" style="vertical-align:middle;">备注说明：</td>
			<td colspan="2"><textarea style="height:100px" class="input3" id="BZXX"></textarea></td>
		</tr>
	</table>
	<input type="hidden" id="mypath" value="<%=basePath%>" />
	<input type="hidden" id="userid" value="<%=id%>" />
	<input type="hidden" id="pass" />
	<input type="hidden" id="spdxbh" value="<%=spdxbh%>" />
	<input type="hidden" id="BD_RYBH" value="<%=BD_RYBH%>"/>
	<input type="hidden" id="BD_RYXM" value="<%=BD_RYXM%>"/>
	<input type="hidden" id="GKLBBH"/>
	<input type="hidden" id="YJYQ"/>
	<input type="hidden" id="DQSJ"/>
	<input type="hidden" id = "type" value="禁用"/>
</body>
</html>
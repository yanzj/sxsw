<%@page import="com.dhcc.common.util.CommUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userid = (String) request.getSession()
			.getAttribute("userid");//用户id

	String TJXLKBH = request.getParameter("TJXLKBH");
	String TJXXBH = request.getParameter("TJXXBH");
	String TJSPBH=request.getParameter("TJSPBH");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>列控对象详细信息页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bussiness/aviation/lkgl/tjxlk/tjlkRepeal.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/util/UserListMultiSelect.js"></script>
<style>
.txt_title {
	width: 110px;
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
.holder {
	color: gray;
}
</style>
</head>
<body style="padding-bottom: 20px;">
	<div class="div1">禁用列控</div>
	<table style="padding-left:30px;width: 95%;clear:both;">
		<tr>
			<td class="txt_title">禁用原因<span class="xing">&nbsp;*</span>
			</td>
			<td colspan="2"><input class="input3" type="text" id="CXYY"
				holder="此项是必填项，请填写" required></input>
			</td>
		</tr>
		<tr id="spry">
			<td class="txt_title">审批人&nbsp;&nbsp;&nbsp;<span class="xing">&nbsp;*</span>
			</td>
			<td><div id="sdesc" class="input3"></div>
			</td>
			<td id="selectuser"><img class="my_info"
				style="width:20px;height:20px"
				src="<%=basePath%>images/common/fkweb_personicon.png"></img>
			</td>
		</tr>
		<tr>
			<td class="txt_title" style="vertical-align:middle;">备注说明：</td>
			<td colspan="2"><textarea style="height:70px" class="input3"
					id="BZXX"></textarea>
			</td>
		</tr>
	</table>
	<input type="hidden" id="mypath" value="<%=basePath%>" />
	<input type="hidden" id="userid" value="<%=userid%>" />
	<input type="hidden" id="TJXLKBH" value="<%=TJXLKBH%>" />
	<input type="hidden" id="TJXXBH" value="<%=TJXXBH%>" />
	<input type="hidden" id="TJSPBH" value="<%=TJSPBH%>" />
	<input type="hidden" id="pass"/>

</body>
</html>
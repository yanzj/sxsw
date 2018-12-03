<%@page import="com.dhcc.common.util.CommUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String userid = (String) request.getSession().getAttribute("userid");;
	String pcbh = request.getParameter("pcbh");
	String id = CommUtil.getID();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>盘查视频添加页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/lkgl/lkdx/lkdxcxAdd.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath  %>js/UploadFailUtil.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath  %>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js"></script>
<script type="text/javascript" src="./spzlAdd.js" ></script>
<style>
.txt_title {
	width: 60px;
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
	font-size: 14px;
	border-radius: 3px;
	min-height: 30px;
	overflow: auto;
	width: 350px;
	background-color: #F2F2F2;
	border: 1px solid #D1D1D1;
}
</style>
</head>
<body style="padding-bottom: 20px;">
	<div class="div1">视频资料</div>
	<div style="margin-top: 5px;padding-left:30px;">
		<table>
			<tr>
				<td class = "txt_title">视频名称</td>
				<td><input class="input3" type="text" id="spmc"/></td>
			</tr>
			<tr>
				<td class = "txt_title">视频描述</td>
				<td><textarea style="height:70px" class="input3" id="spms"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input id="upload" type="button" class="search_input_style"
					style="background-color: #C7D7EE;border: 1px solid #C7D7EE;height:27px;width: 120px; margin-right: 5px;"
					value="视频上传"  onclick="upload()"/></td>
			</tr>
			<tr>
				<td colspan="2" class="input2" style="height: 80PX;">
					<div style="width:350px;border: 0px solid grey" id="mvoice"></div>
				</td>
			</tr>
		</table>
	</div>
	<!-- <div style="text-align: center;">
		<input type="button" value="提交" class="search_input_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;margin-top:20px;margin-bottom:20px;"
			id="subbutton"/>
	</div> -->
	<input type="hidden" id="pcbh" value="<%=pcbh%>"/>
	<input type="hidden" id="userid" value="<%=userid%>"/>
	<input type="hidden" id="id" value="<%=id%>"/>
	<input type="hidden" id="mypath" value="<%=basePath%>"/>
</body>
</html>
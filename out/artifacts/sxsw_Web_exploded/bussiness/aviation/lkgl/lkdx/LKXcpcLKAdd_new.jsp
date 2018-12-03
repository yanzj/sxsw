<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String SPDXBH = CommUtil.getID();
	String BD_RYBH =request.getParameter("BD_RYBH");
	String BD_RYXM =request.getParameter("BD_RYXM");
	String userid = session.getAttribute("userid").toString();
%>
<!-- 现场盘查列控 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>js/birthdaypicker.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript"
	src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bussiness/aviation/lkgl/lkdx/LKXcpcLKAdd.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bussiness/aviation/util/UserListMultiSelect.js"></script>
<style type="text/css">
.bg {width:100%;height:100%;top:0px;left:0px;position:absolute;filter: Alpha(opacity=50);opacity:0.5; background:#D4D4D4;}
.div1 {
	height: 25px;
	vertical-align: middle;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: bold;
	margin-top: 20px;
	padding-left: 20px;
	text-align: center;
	color: #ef7844;
}
td{
   font-size:14px;
}
tr {
	line-height: 35px; /*设置行高*/
}

.input1 {
    border-radius: 3px;
    border: 1px solid #D1D1D1;
	width: 434px;
	height: 20px;
	background: #F2F2F2;
}

.input3 {
    border-radius: 3px;
	min-height: 30px; 
	overflow:auto;
	width: 580px;
	background: #F2F2F2;
    border: 1px solid #D1D1D1;
}

.input2 {
    border-radius: 3px;
	width: 168px;
	height: 20px;
	background: #F2F2F2;
	border: 1px solid #D1D1D1;
}
.search_input_style1 {
    border-radius: 3px;
	border: 1px solid #D1D1D1;
	height: 22px;
	margin-right:10px;
	width: 170px;
}
.xing{
    color:red;font-weight:bold;vertical-align: middle;
}
label.error{
    color: red;
	font-style: italic;
	margin-left:50px;
}
.holder{
  color:gray;
}
</style>
</head>

<body id = "bg">
	<div class="div1" style="display: none;">被列控人信息</div>
	<div style="margin-top: 5px;padding-left:30px;">
		<table>
		     <tr>
		        <td style="width:67px;">到期时间<!-- <span style="color:red;vertical-align: middle;">&nbsp;*</span> --></td>
				<td>
					<input id="DQSJ"  class="Wdate" style="width:200px;height:24px;background-color: #F2F2F2;border: 1px solid #D1D1D1;" 
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"   onchange="Single()"/> <input
					type="checkbox" checked="checked" style="margin-left:50px;" /><font>到期提前一天提醒</font>
				</td>
			</tr>
			<tr>
				<td>管控类型<span class="xing">&nbsp;*</span></td>
				<td colspan="2"><select class="input3" style="width:584px;height:34px;" id="LKLB">
				 <option value="01">临时管控</option>
				</select></td>
			</tr>
			<tr>
				<td>列控原因<span class="xing">&nbsp;*</span></td>
				<td colspan="2"><input class="input3" type="text" id="YY"  holder="此项是必填项，请填写"  required></input></td>
			</tr>
			<tr>
				<td>预警对象</td>
				<td><div class="input3" id="sdescyj"></div></td>
				<td id="selectuseryj"><img class = "my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png" /></td>
			</tr>
			<tr>
				<td>预警值班账号</td>
				<td><div class="input3" id="sdescyjzbzh"></div></td>
				<td id="selectyjzbzh"><img class = "my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png" /></td>
			</tr>
			<tr>
				<td>预警要求<span class="xing">&nbsp;*</span></td>
				<td colspan="2"><input holder="此项是必填项，请填写" class="input3 holder" type="text"  id="YJYQ" required></input></td>
			</tr>
			<tr id="spry">
				<td>审批人&nbsp;&nbsp;&nbsp;<span class="xing">&nbsp;*</span></td>
				<td><div id="sdesc" class="input3"></div></td>
				<td id="selectuser"><img class = "my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png"></img></td>
			</tr>
			<tr>
				<td style="vertical-align:middle;">备注说明</td>
				<td colspan="2"><textarea style="height:70px" class="input3" id="BZXX"></textarea></td>
			</tr>

		</table>
		<input type="hidden" id="pass" />
		<input type="hidden" id="mypath" value="<%=basePath%>" />
		<input type="hidden" id="SPDXBH" value="<%=SPDXBH%>" />
		<input type="hidden" id="BD_RYBH" value="<%=BD_RYBH%>" />
		<input type="hidden" id="BD_RYXM" value="<%=BD_RYXM%>" />
		<div style="text-align: center;"><input type="button" value="提交" class = "search_input_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;margin-top:20px;margin-bottom:30px;"
			id="subbutton" /></div>
			
	</div>
</body>
</html>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userid = session.getAttribute("userid").toString();
	String pass = request.getParameter("pass");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script src="<%=basePath%>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script src="<%=basePath%>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
<script src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/lkgl/tjxlk/tjxlkAdd.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/util/UserListMultiSelect.js"></script>
<script type="text/javascript" src="<%=basePath%>js/city/city.js"></script>
<style type="text/css">
.bg {
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	position: absolute;
	filter: Alpha(opacity = 50);
	opacity: 0.5;
	background: #D4D4D4;
}

body {
	margin: 0;
	padding: 0;
}

.div1 {
	width: 100%;
	height: 25px;
	vertical-align: middle;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: bold;
	margin-top: 20px;
	margin-bottom: 20px;
	text-align: center;
	color: #ef7844;
}

tr {
	line-height: 30px; /*设置行高*/
}

.input1 {
	border-radius: 3px;
	width: 567px;
	height: 27px;
	background: #F2F2F2;
	border: 1px solid #D1D1D1;
}

.input3 {
	border-radius: 3px;
	min-height: 30px; overflow：auto;
	width: 567px;
	minheight: 30px;
	background: #F2F2F2;
	border: 1px solid #D1D1D1;
}

td {
	font-size: 12px;
}

.holder {
	color: gray;
}

.xing {
	color: red;
	font-weight: bold;
	vertical-align: middle;
}
</style>
<script>
$(function() {  
	var areaPicker = new AreaPicker({provId:"province",cityId:"city",townId:"county",url:"commList.action"});  
	areaPicker.pick();   
}); 
</script>
</head>
<body id="bg">
	<div class="div1">选择列控条件关键字</div>
	<div style="width: 95%;margin-top: 5px;padding-left:35px;">
		<table style="width:100%;">
			<tr>
				<td>民族：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td id="mz1"><select id="MZ" class="input1"
					style="width:571px;height:31px;"></select>
				</td>
			</tr>
			<tr>
				<td>姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><input type="text" id="XM" class="input1" />
				</td>
			</tr>
			<tr>
				<td>性别：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><select id="XB" class="input1"
					style="width:571px;height:31px;">
						<option style="color:#b2b2b2;" value="">请选择性别</option>
					    <option value="1">男</option>
						<option value="2">女</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>住址：</td>
				<td><input class="input1" type="text" id="ZZ"></input>
				</td>
			</tr>
			<tr>
				<td>籍贯：</td>
				<td>
					<font style="margin-right: 5px">省</font>
					<select class="input1" id="province" style="width:145px;height:23px;"></select>
					<font style="margin: 0px 5px 0px 30px">市</font>
					<select class="input1" id="city" style="width:145px;height:23px;"></select>
					<font style="margin: 0px 5px 0px 30px">县</font>
					<select class="input1" id="county" style="width:145px;height:23px;"></select> 
				</td>
			</tr>
			<tr>
				<td>身份证号：</td>
				<td><input class="input1" type="text" id="SFZH"></input>
				</td>
			</tr>
			<tr>
				<td>其他：</td>
				<td><input class="input1" type="text" id="QT"></input>
				</td>
			</tr>
		</table>
	</div>
	<div class="div1">列控申请</div>
	<div style="width: 95%;margin-top: 5px;padding-left:35px;">
		<table style="width:100%;">
			<tr>
				<td style="width:67px;">生效期限<span
					style="color:red;vertical-align: middle;">&nbsp;*</span>
				</td>
				<td><input id="LKYXSJ" class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" /> <input
					type="checkbox" checked="checked" style="margin-left:50px;" /><font>到期提前一天提醒</font>
				</td>
			</tr>
			<tr>
				<td>列控类别<span style="color:red;vertical-align: middle;">&nbsp;*</span>
				</td>
				<td><select class="input1" id="LKLB"
					style="width:571px;height:31px;">
				</select>
				</td>
			</tr>
			<tr>
				<td>列控原因<span class="xing">&nbsp;*</span>
				</td>
				<td><input class="input1" type="text" id="LKYY"
					holder="此项是必填项，请填写" required></input>
				</td>
			</tr>
			<tr>
				<td>预警对象<span class="xing">&nbsp;*</span>
				</td>
				<td><div class="input3" id="sdescyj"></div>
				</td>
				<td id="selectuseryj">&nbsp;&nbsp;<img class="my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png" />
				</td>
			</tr>
			<tr>
				<td>预警值班账号</td>
				<td><div class="input3" id="sdescyjzbzh"></div>
				</td>
				<td id="selectyjzbzh">&nbsp;&nbsp;<img class="my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png" />
				</td>
			</tr>
			<tr>
				<td>预警要求<span class="xing">&nbsp;*</span>
				</td>
				<td><input class="input1" type="text" id="YJYQ"
					holder="此项是必填项，请填写" required></input>
				</td>
			</tr>
			<tr id="spry">
				<td>审批人&nbsp;&nbsp;&nbsp;<span class="xing">&nbsp;*</span>
				</td>
				<td><div id="sdesc" class="input3"></div>
				</td>
				<td id="selectuser">&nbsp;&nbsp;<img class="my_info"
					style="width:20px;height:20px"
					src="<%=basePath%>images/common/fkweb_personicon.png" />
				</td>
			</tr>
			<tr>
				<td style="vertical-align:middle;">备注说明:</td>
				<td><textarea style="height:70px;width:565px;" class="input1"
						id="BZXX"></textarea>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="pass" value="<%=pass%>" />
	<input type="hidden" id="userid" value="<%=userid%>" />
	<input type="hidden" id="RYTXLJ" />
	<input type="hidden" id="mypath" value="<%=basePath%>" />
</body>
</html>
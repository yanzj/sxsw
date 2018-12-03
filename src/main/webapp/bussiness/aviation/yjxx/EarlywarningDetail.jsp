<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort() + path + "/";
	String YJBH = request.getParameter("YJBH");//预警编号
	//String BD_RYBH = request.getParameter("BD_RYBH"); //本地人员编号
	String userid = (String)request.getSession().getAttribute("userid");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>
<title>预警信息详情页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./earlywarningDetail.js"></script>
</head>
<body style="padding-top:20px; ">
	<div
		style="height:40px;line-height:40px;background-color: #F07844; padding-left: 30px;padding-right: 30px">
		<div id="YJNR" class="my_info"
			style="float: left;font-size:19px; font-weight: bold;color: #4A4A4A;padding-left: 20px; "
			onclick="pancharenxq()"></div>
		<div style="float: right;width: 180px;text-align: center;">
			&nbsp;&nbsp;<span id="YJSJ"></span>
		</div>
	</div>
	<div style="margin-top: 20px;">
		<div style="width: 13%;float: left;text-align: center;">
			<img id="userimg" src="" style="width: 100px;height: 100px" />
		</div>
		<table style="width: 85%;line-height:30px;">
			<tr style="border-bottom:1px solid #b2b2b2;">
				<td><span class="my_info" id="XM" onclick="ryDetail()"
					style="color:  #F07844;font-size: 16px;font-weight: bold;margin-right: 30px;vertical-align: middle;"></span>
					<span id="YJYY"></span>
					<!-- <span id="YJYY" class="gk_span" style="margin-left:60px;"></span> -->
				</td>
				<!-- <td style="text-align: right;">
				   <span id="GKLBMC" class="gk_span"></span>
				</td> -->
				<td width="60%;">
					<span id="guanzhu" onclick="getGz()" style="cursor: pointer;"></span> &nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td><span class="td_text">预警原因&nbsp;&nbsp;</span><span
					class="td_value" id="YJYYS"></span></td>
			</tr>
			<tr>
				<td><span class="td_text">预警来源&nbsp;&nbsp;</span><span
					class="my_info td_value" id="YJLYS" onclick="pancharenxq()"
					style="color: #366AB3"></span></td>
			</tr>
			<tr>
				<td><span class="td_text">预警要求&nbsp;&nbsp;</span><span
					class="td_value" id="YJYQ"></span></td>
			</tr>
			<tr style="height: 15px;"></tr>
			<tr>
				<td><input type="button" class="gk_span my_info"
					style="width:130px;margin-right: 10px; height: 30px;font-size: 15px;"
					onclick="getTaskes()" value="发布任务" /></td>
			</tr>
		</table>
	</div>
	<div style="width:100%;height:30px;line-height:30px;background-color:#C7D7EE; margin-top: 30px;">
		<div style="font-size:17px; font-weight: bold;color: #4A4A4A;padding-left: 20px; ">任务信息</div>
	</div>
	<div id="task_div" style="margin-top: 20px;width:98%;margin: auto;margin-top: 20px; margin-bottom: 30px;text-align: center;"></div>
	<input type="hidden" id="mypath" value="<%=basePath%>" />
	<input type="hidden" id="yjbh" value="<%=YJBH%>" />
	<input type="hidden" id="bd_rybh"/>
	<input type="hidden" id="RYBH" />
	<input type="hidden" id="YJLY" />
	<input type="hidden" id="YJLYBH" />
	<input type="hidden" id="userid" value="<%=userid%>"/>
</body>
</html>

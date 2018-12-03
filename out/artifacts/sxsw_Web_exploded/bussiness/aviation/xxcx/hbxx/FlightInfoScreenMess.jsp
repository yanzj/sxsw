<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String flightcode = (String) request.getSession().getAttribute("flightcode");//航班号
	String flightdate = (String) request.getSession().getAttribute("flightdate");//航班时间
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>航班重复人员列表</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./flightInfoScreenMess.js"></script>
<style>
.top_style {
	width: 95%;
	border: 1px solid #D1D1D1;
	border-radius: 5px;
	margin-bottom: 20px;
	margin-top: 10px;
	margin-left: 10px;
	padding: 6px;
	padding-top: 20px;
	padding-bottom: 20px;
}

.tab_style {
	width: 150px;
	height: 100%;
	float: left;
	color: white;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	font-size: 15px;
}




</style>
</head>
<body class="body_style">
	<div style="height: 45px;text-align: center;line-height: 50px;">
		<div id="cfry" onclick="tab_onclick('cfry')" class="tab_style float_style"
			style="background-color:  #FC9B71;margin-right: 5px;">
			重复人员<span style="color: #376CB0"> ${record } </span>件
		</div>
		<div id="aj" onclick="tab_onclick('aj')" class="tab_style float_style"
			style="background-color: #B3B3B3">
			案件<span style="color: #376CB0"> ${casecount} </span>件
		</div>
	</div>
	<div id="screenpeople"
		style="width: 95%;border: 1px solid #D1D1D1;padding: 6px; margin-bottom: 10px">
		<!-- <div id="div_sort" style="width: 100%; height:30px;margin-left: 10px">
			<div  id='order_sfz' class="sort_style float_style" style="color: #FC9B71" onclick="order_onclick('order_sfz','按身份证号排序')">按身份证号排序
				<span id="jt">↓</span>
			</div>
			<div class="sort_style float_style">按管控对象排序</div>
			<div class="sort_style float_style">按人员类型排序</div>
			<div  id='order_djsj' class="sort_style float_style" onclick="order_onclick('order_djsj','按登机时间排序')">按登机时间排序</div>
		</div> -->

		<div id="screendiv" style="clear: both;">
			<c:forEach var="item" items="${screenerlist}">
				<!-- 基本信息 -->
				<div class="item_style">
					<table style="height: 100px;margin-left: 10px;width: 98% ">
						<tr>
							<td rowspan="5" style="width: 13%;text-align: center;"><img
								src="${item.XP}"
								class="controlps_img" />
							</td>
						</tr>
						<tr>
							<td style="font-size: 19px;color: #EF7844;font-weight: bold;">
								<span class="float_style"
								onclick="openDialog('${item.BD_RYBH}','${item.CHNNAME}')">${item.CHNNAME}</span>
							</td>
							<td style="width:2%;" rowspan="5"><div style="width: 1px;float: left; height:80px;background-color: #b2b2b2;"></div></td>
							<td style="font-size: 19px;font-weight: bold;" colspan="3">关联<span style="color: #376CB0;margin:0px 5px;">${item.count}</span>航班</td>
						</tr>
						<tr>
							<td style="width: 25%"><span>身份证号</span><span
								class="td_value"> <c:choose>
										<c:when test="${item.CTYPE=='NI'}">${item.CERT}</c:when>
										<c:otherwise>无</c:otherwise>
									</c:choose> </span>
							</td>
							<td style="font-size: 13px;font-weight: bold;" rowspan="2">案件航班
								<span style="color: #376CB0;padding-left: 30px;">${item.FLIGHTCODE}</span>
							</td>
						</tr>
						<tr>
							<td>护&nbsp; 照&nbsp; 号<span class="td_value"> <c:choose>
										<c:when test="${item.CTYPE=='PP'}">${item.CERT}</c:when>
										<c:otherwise>无</c:otherwise>
									</c:choose> </span>
							</td>
						</tr>
						<tr>
							<td>通行证号<span class="td_value">无</span></td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</div>
		<c:if test="${fn:length(screenerlist)<10}">
			<div id="div_btm" class="div_bottom"  style="display: block;">
				<c:choose>
					<c:when test="${fn:length(screenerlist)==0}">暂无数据</c:when>
					<c:otherwise>数据加载完成</c:otherwise>
				</c:choose>
			</div>
		</c:if>
		<div id="sloadover" class="div_bottom"></div>
	</div>
	<div id="case"
		style="width: 95%;border: 1px solid #D1D1D1;margin-left: 10px;padding: 6px;display: none;margin-bottom: 10px">
		<div id="casediv" style="clear: both; margin-top: 10px"></div>
		<div id="cloadover" class="div_bottom"></div>
	</div>
	<input type="hidden" id="flightcodes" value="<%=flightcode %>" />
	<input type="hidden" id="flightdates" value="<%=flightdate %>" />
	<input type="hidden" id="mypath" value="<%=basePath %>" />
</body>
</html>

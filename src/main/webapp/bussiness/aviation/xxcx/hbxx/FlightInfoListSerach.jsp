<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>航班信息列表</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />

<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript"
	src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./flightInfoListSerach.js"></script>
</head>
<body style="padding-left: 15px; padding-top: 15px;">
	<div style="height: 22px;line-height: 22px;clear: both;width: 98%;">
		<div style="float: left; width: 46%">
			航班日期&nbsp;&nbsp; <input id="starttime" class="Wdate search_input_style"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
			&nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		</div>
		<div style="float: right; width: 53%;text-align: right;">
			<div style="float: right;">
				<input type="text" class="search_input_style" id="searchvalue"
					style="width: 230px;color: gray;height:25px;padding-right: 4px;"
					holder=" 请输入搜索关键词" /> &nbsp;&nbsp; <input id="oneSearch_bt"
					type="button" class="search_input_style"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
					value="搜索" onclick="flightserach()" /> <span onclick="gjsc_an()"
					style="color: #F07844; width: 90px;height: 20px;margin-left: 10px;margin-right: 5px;font-size: 13px;">
					<span class="float_style">高级搜索&nbsp;</span><img
					src="<%=basePath%>images/common/fkweb_drawbackicon.png"
					style="margin-right: 10px;" /> </span>
			</div>
		</div>
	</div>
	<div id="div_gjss"
		style="height: 22px;line-height: 22px;margin-top: 15px;display: none;clear: both;width: 98%; ">
		<div>
			<div style="width:55%;float: left;">
				发生案件类型&nbsp;&nbsp;<select id="lx" class="search_input_style"
					style="color: gray;padding-right: 4px;width: 180px;"></select>
				&nbsp;&nbsp; 航班号码&nbsp;&nbsp;<input type="text" id="searchcode"
					class="search_input_style"
					style="color: gray;padding-right: 4px;width: 180px;"
					holder="请输入航班号，例如:MH2310" />
			</div>
			<div style="width:40%;float: right;">
				出发地&nbsp;&nbsp;<input type="text" id="dept" class="search_input_style"
					style="color: gray;padding-right: 4px;" />&nbsp;&nbsp;-&nbsp;&nbsp;
				目的地&nbsp;&nbsp;<input type="text" id="dest" class="search_input_style"
					style="color: gray;padding-right: 4px;" />
			</div>
		</div>
	</div>
	<div id="twoSearch_bt"
		style="width: 98%;height: 22px;line-height: 22px;margin-top: 15px; display: none; text-align: right;clear: both;">
		<input type="button" class="search_input_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;"
			value="搜索" onclick="flightserach()"/>
	</div>
	<div style="width:98%; height:40px;clear: both;padding-top:15px;">
		<div id='' class="sort_style float_style" style="width: 80px;">
			<input type="checkbox" id="checkBtn" value="全选" onclick="checkall()"/>&nbsp;&nbsp;全选
		</div>
		<div id="div_sort" style="width: 100%; ">
			<div id='order_hbsj' class="sort_style float_style" style="color: #FC9B71" onclick="order_onclick('order_hbsj','按航班时间排序')">
				按航班时间排序<span id="jt">↓</span>
			</div>
			<div id="order_adss" class="sort_style float_style" onclick="order_onclick('order_adss','按目标地点排序')">按目标地点排序</div>
		</div>
		<div class="sort_style" style="float: right;">
			<input type="button" class="search_input_style"
				style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;"
				value="筛选重复人员" onclick="screenuser()"/>
		</div>
	</div>
	<!-- 航班列表 -->
	<div id="dadiv">
		<c:forEach var="item" items="${flightQueryList }">
			 
			<div class="item_style" style="height: 100%">
				<table
					style="text-align:center;margin-top: 10px;margin-bottom: 10px;width: 98% ">
					<tr>
					    <td width="4%" rowspan="2"> <input type="checkbox" id="flightcheck" value="${item.FLIGHTCODE},${item.FLIGHTDATE}" /></td>
						<td width="10%"  rowspan="2"><span id="flightdate">${item.FLIGHTDATE}</span></td>
						<td width="10%">中国南航</td>
						<td width="2%" rowspan="2"><img
							src="<%=basePath%>images/splitline.png" />
						</td>
						<td width="10%" rowspan="2">${item.DPSRDEPARTURECHN}</td>
						<td width="5%"  rowspan="2">---></td>
						<td width="10%" rowspan="2">${item.DPSRDESTINATIONCHN}</td>
						<td width="20%" colspan="2">起始登机时间</td>
						<td width="20%" class="float_style"
							style="color: #386CB5;text-align: center;" onclick="addAj('${item.FLIGHTCODE}','${item.FLIGHTDATE}','${item.DPSRDEPARTURECHN}','${item.DPSRDESTINATIONCHN}')">添加案事件</td>
					</tr>
					<tr>
						<td><span id="flightcode" class="float_style" onclick="openDialog('${item.FLIGHTCODE}','${item.FLIGHTDATE}','${item.DPSRDEPARTURECHN}','${item.DPSRDESTINATIONCHN}')">${item.FLIGHTCODE}</span></td>
						<td colspan="2"><c:if test="${item.GATETM != null }">${fn:substring(item.GATETM,0,2)}:${fn:substring(item.GATETM,2,4)}</c:if></td>
						<td style="text-align:center;">
						<c:forEach items="${item.eventsList}" var="events" varStatus="s">
							 <c:if test="${s.index<3}">
								<span  class="float_style" style="color: white;background-color: red;padding-left: 7px;padding-right: 7px;padding-top:3px;padding-bottom:3px;border-radius: 2px;">${events.AJLBBH}</span>
							 </c:if>
							 <c:if test="${s.index==3}">
								<span  class="float_style" style="color: white;background-color: red;padding-left: 7px;padding-right: 7px;padding-top:3px;padding-bottom:3px;border-radius: 2px;">...</span>
							 </c:if>
							 <c:if test="${s.index>3}">
							 </c:if>
						</c:forEach>
						</td>
					</tr>
				</table>
			</div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(flightQueryList)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(flightQueryList)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="loadover" class="div_bottom"></div>
	<input type="hidden" id="mypath" value="<%=basePath %>" />
</body>
</html>

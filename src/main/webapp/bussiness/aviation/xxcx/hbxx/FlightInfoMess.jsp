<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String flightcode = (String) request.getSession().getAttribute(
			"flightcode");//航班号
	String flightdate = (String) request.getSession().getAttribute(
			"flightdate");//航班时间
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>航班人员列表</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./flightInfoMess.js"></script>
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

.controlps_img {
	width: 100px;
	height: 100px;
	margin-right: 20px;
}
</style>
</head>
<body style="padding: 0px;">
	<div class="top_style" style="height: 100%">
		<table style="text-align:center;width: 98% ">
			<tr>
				<td width="8%" rowspan="2"><span id="flightdate">${flightdate}</span></td>
				<td width="15%"><span id="flightcode">${flightcode}</span></td>
				<td width="2%" rowspan="2"><img
					src="<%=basePath%>images/splitline.png" /></td>
				<td width="10%" rowspan="2"><span id="dept">${dept}</span></td>
				<td width="5%" rowspan="2">---></td>
				<td width="10%" rowspan="2"><span id="dest">${dest}</span></td>
				<td width="10%" rowspan="2"></td>
				<td width="10%">起始登机时间</td>
				<td width="10%" class="float_style" rowspan="2"
							style="color: #386CB5;text-align: center;" onclick="addAj('${flightcode}','${flightdate}')">添加案事件</td>
			</tr>
			<tr>
				<td>
					<c:forEach items="${eventsList}" var="events" varStatus="s">
						 <c:if test="${s.index<3}">
							<span  class="float_style" style="color: white;background-color: red;padding-left: 7px;padding-right: 7px;padding-top:2px;padding-bottom:2px;border-radius: 2px;">${events.AJLBBH}</span>
						 </c:if>
						 <c:if test="${s.index==3}">
							<span  class="float_style" style="color: white;background-color: red;padding-left: 7px;padding-right: 7px;padding-top:2px;padding-bottom:2px;border-radius: 2px;">...</span>
						 </c:if>
						 <c:if test="${s.index>3}">
						 </c:if>
					</c:forEach>
				</td>
				<td width="10%"><c:if test="${mingatetm != null }">${fn:substring(mingatetm,0,2)}:${fn:substring(mingatetm,2,4)}</c:if></td>
			</tr>
		</table>
	</div>
	<div style="height: 45px;text-align: center;line-height: 50px;">
		<div id="glry" onclick="tab_onclick('glry')"
			class="tab_style float_style"
			style="margin-left: 10px; background-color: #FC9B71;margin-right: 5px;">
			关联人员<span style="color: #376CB0"> ${record } </span>件
		</div>
		<div id="aj" onclick="tab_onclick('aj')" class="tab_style float_style"
			style="background-color: #B3B3B3">
			案件<span style="color: #376CB0"> ${casecount} </span>件
		</div>
	</div>
	<div id="relationpeople"
		style="width: 95%;border: 1px solid #D1D1D1;margin-left: 10px;padding: 6px; margin-bottom: 10px">
		<div id="div_sort" style="width: 100%; height:30px;margin-left: 10px">
			<div id='order_sfz' class="sort_style float_style" style="color: #FC9B71" onclick="order_onclick('order_sfz','按身份证号排序')">按身份证号排序 
				<span id="jt">↓</span>
			</div>
			<div id='order_djsj' class="sort_style float_style" onclick="order_onclick('order_djsj','按登机时间排序')">按登机时间排序</div>
		</div>
		<div id="bigdiv" style="clear: both;">
			<c:forEach var="item" items="${flightUserlist}">
				<!-- 基本信息 -->
				<div class="item_style">
					<table>
						<tr>
							<td rowspan="5"><img
								src="${item.XP }"
								class="controlps_img" /></td>
						</tr>
						<tr>
							<td style="font-size: 19px;color: #EF7844;font-weight: bold;">
								<span class="float_style"
								onclick="openDialog('${item.LKID}','${item.CHNNAME}')">${item.CHNNAME}</span>
							</td>
						</tr>
						<tr>
							<td style="width: 25%"><span>身份证号</span><span
								class="td_value"> <c:choose>
										<c:when test="${item.CTYPE=='NI'}">${item.CERT}</c:when>
										<c:otherwise>无</c:otherwise>
									</c:choose>
							</span></td>
							<td style="width: 40%">值机时间<span class="td_value">${fn:substring(item.CKITM,0,2)}:${fn:substring(item.CKITM,2,4)}</span>
							</td>
							<td style="width: 25%">舱位<span class="td_value"></span></td>
						</tr>
						<tr>
							<td>护&nbsp; 照&nbsp; 号<span class="td_value"> <c:choose>
										<c:when test="${item.CTYPE=='PP'}">${item.CERT}</c:when>
										<c:otherwise>无</c:otherwise>
									</c:choose>
							</span>
							</td>
							<td>安检时间<span class="td_value">${fn:substring(item.CHECKTIME,0,2)}:${fn:substring(item.CHECKTIME,2,4)}</span></td>
							<td>座位<span class="td_value">${item.SEAT}</span></td>
						</tr>
						<tr>
							<td>通行证号<span class="td_value">无</span></td>
							<td>登机时间<span class="td_value">${fn:substring(item.GATETM,0,2)}:${fn:substring(item.GATETM,2,4)}</span>
							</td>
							<td>序号<span class="td_value">${item.BRDNO}</span>
							</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</div>
		<c:if test="${fn:length(flightUserlist)<10}">
			<div id="div_btm" class="div_bottom" style="display: block;">
				<c:choose>
					<c:when test="${fn:length(flightUserlist)==0}">暂无数据</c:when>
					<c:otherwise>数据加载完成 </c:otherwise>
				</c:choose>
			</div>
		</c:if>
		<div id="loadover" class="div_bottom"></div>
	</div>


	<div id="case"
		style="width: 95%;border: 1px solid #D1D1D1;margin-left: 10px;padding: 6px; margin-bottom: 10px; display: none;">
		<div id="casediv" style="clear: both; margin-top: 10px"></div>
		<div id="cloadover" class="div_bottom"></div>
	</div>
	<input type="hidden" id="flightcodes" value="<%=flightcode %>" />
	<input type="hidden" id="flightdates" value="<%=flightdate %>" />
	<input type="hidden" id="mypath" value="<%=basePath %>" />
</body>
</html>

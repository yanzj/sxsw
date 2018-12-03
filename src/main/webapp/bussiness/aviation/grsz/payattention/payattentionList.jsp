<%@ page language="java" pageEncoding="UTF-8"%>
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
<title>我的关注页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath  %>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath  %>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath  %>include/LigerUI/js/ligerui.all.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./payattention.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>js/btnQuery.js"></script>
<style>
.style_disable{
    background-color: #FAFAFA;
    border: 1px solid #FAFAFA;
}

</style>
</head>
<body class="body_style">
	<input id="source" type="hidden" value="${sessionScope.source}" />
	<!-- 搜索条件 start -->
	<div style="height: 22px;line-height: 22px;clear: both;width: 98%;">
		<div style="float: left; width: 33%;">
			姓名&nbsp;&nbsp; <input type="text" class="search_input_style" id="name"
				style="width: 180px;color: gray;height:25px;padding-right: 4px;"
				holder=" 请输入关注人姓名关键词" />
		</div>
		<div style="float: left; width: 33%;">
			管控类别&nbsp;&nbsp; <select class="search_input_style" id="lb"
				style="width: 160px;color: gray;height:25px;padding-right: 4px;"></select>
		</div>
		<div style="float: left; width: 33%;text-align: right;">
			民族&nbsp;&nbsp; <select class="search_input_style" id="mz"
				style="width: 150px;color: gray;height:25px;padding-right: 4px;" ></select>
		</div>
	</div>
	<div
		style="height: 22px;line-height: 22px;clear: both;width: 98%;margin-top: 20px;">
		时间&nbsp;&nbsp; <input name="radio" type="radio" value="week" onclick="undisable('week')"/>&nbsp;一个周内&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp; <input name="radio" type="radio" value="month" onclick="undisable('month')"/>&nbsp;一个月内&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp; <input name="radio" type="radio" value="threeMonth" onclick="undisable('threeMonth')"/>&nbsp;三个月内&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp; <input name="radio" type="radio" value="time" id="time" style="margin-left: 30px;" onclick="undisable('time')"/>&nbsp;&nbsp;选择时间段
		&nbsp;&nbsp; <input id="starttime" class="Wdate search_input_style style_disable" disabled="disabled"
			onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		&nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style style_disable" disabled="disabled"
			onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
	</div>
	<div
		style="height: 22px;line-height: 22px;clear: both;width: 98%;margin-top: 20px;margin-bottom: 20px">
		<div id="div_sort" style="float: left; width: 46%">
			<div id='order_gzsj' class="sort_style float_style" style="color: #FC9B71" onclick="order_onclick('order_gzsj','按关注时间排序')">按关注时间排序<span id="jt">↓</span></div>
			<div id="order_gklx" class="sort_style float_style" onclick="order_onclick('order_gklx','按管控类型排序')">按管控类型排序</div>
		</div>
		<div style="float: right; width: 53%;text-align: right;">
			<div style="float: right;">
				<input type="text" class="search_input_style" id="search_value"
					style="width: 230px;color: gray;height:25px;padding-right: 4px;"
					holder=" 请输入搜索关键词" /> &nbsp;&nbsp; <input id="oneSearch_bt"
					type="button" class="search_input_style"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
					value="搜索" onclick="search()" />
			</div>
		</div>
	</div>
	<!-- 搜索条件 end -->
	<div id="dadiv" style="clear: both;">
		<c:forEach items="${payattentionList}" var="item">
			<!-- 基本信息 -->
			<div class="item_style">
				<table style="width: 98%">
				   		<!-- 当来源为添加任务时 显示复选框 -->
					<c:if test="${source=='rwcl'}">
						<tr>
							<td width="3%" rowspan="6" style="text-align: center;"><c:choose>
									<c:when test="${item.ISCHECK}">
										<input type="checkbox" name="sourcecheck" checked="checked"
											value='${item.RYBH},${item.XP},${item.XM},${item.GKLBMC}' />
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="sourcecheck"
											value='${item.RYBH},${item.XP},${item.XM},${item.GKLBMC}' />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>
					<tr>
						<td rowspan="5" style="width: 13%;text-align: center;"><img src="${item.XP}"
							class="controlps_img" />
						</td>
					</tr>
					<tr>
						<td style="font-size: 19px;color: #EF7844;font-weight: bold;">
							<span class="float_style"
							onclick="openDialog('${item.BD_RYBH}','${item.XM}')">${item.XM}</span>
							<span class="td_value" style="margin-left: 30px;font-size: 14px;">
							<c:choose>
								<c:when test="${item.GZBH!=mull}">
									<img src="<%=basePath%>images/common/fkweb_focusonforaimat.png" />
								</c:when>
								<c:otherwise>
									<img src="<%=basePath%>images/common/fkweb_eyesongrey.png"  />
								</c:otherwise>
							</c:choose></span>
						</td>
						<td>
							<span id="oneSearch_bt" class="gk_span">${item.GKLBMC }</span>
							<span style="margin-left:10px;"> ${item.CJSJ}&nbsp;&nbsp;&nbsp;${item.CJRXM}</span>
						</td>
						<td>
						  <c:if test="${item.ZT==0}">
						    <span style="color:#F07844;font-weight:bold;">列控</span>
						  </c:if>
						  <c:if test="${item.ZT==1}">
						    <span style="color:#F07844;font-weight:bold;">禁用</span>
						  </c:if>
						  <c:if test="${item.ZT==2}">
						    <span style="color:#F07844;font-weight:bold;">申请启用中</span>
						  </c:if>
						  <c:if test="${item.ZT==3}">
						    <span style="color:#F07844;font-weight:bold;">申请禁用中</span>
						  </c:if>
						  <c:if test="${item.ZT==4}">
						    <span style="color:#F07844;font-weight:bold;">申请编辑中</span>
						  </c:if>
						</td>
					</tr>
					<tr>
						<td style="width: 25%"><span>身份证号：</span><span
							class="td_value">${item.SFZH}</span>
						</td>
						<td style="width: 30%">户口地址：<span class="td_value dian">${item.HKSZDMC}</span>
						</td>
						<td style="width: 20%">出生日期：<span class="td_value">${item.CSRQ}</span>
						</td>
					</tr>
					<tr>
						<td>护 照 号：<span class="td_value">暂未开放</span></td>
						<td>民 族：<span class="td_value">${item.MZMC}</span></td>
						<td>年 龄：<span class="td_value">${item.NL}</span></td>
					</tr>
					<tr>
						<td>通行证号：<span class="td_value">暂未开放</span></td>
						<td>性 别：<span class="td_value">
							<c:choose>
								<c:when test="${item.XB==1}">男</c:when>
								<c:when test="${item.XB==2}">女</c:when>
								<c:when test="${item.XB==9}">未知性别</c:when>
							</c:choose>
						</span></td>
					</tr>
				</table>
			</div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(payattentionList)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(payattentionList)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="loadover" class="div_bottom"></div>
	<input type="hidden" id="mypath" value="<%=basePath%>"/>
</body>
</html>

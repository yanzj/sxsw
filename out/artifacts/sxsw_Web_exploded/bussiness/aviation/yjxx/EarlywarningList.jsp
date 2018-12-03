<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String welcomeJsp = request.getParameter("welcomeJsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>预警信息列表</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/jquery-validation/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./earlywarningList.js"></script>
<style type="text/css">
.my_info_mess {
	text-decoration: underline;
	cursor: pointer;
	color: #00f;
}

.item_style {
	width: 95%;
	border: 1px solid #D1D1D1;
	border-radius: 5px;
	margin-bottom: 10px;
	margin-left: 10px;
	padding: 6px;
}
</style>
</head>
<body style="padding-left: 15px; padding-top: 15px;">
	<input id="source" type="hidden" value="${sessionScope.source}" />
	<!-- 搜索条件 start -->
	<table style="width: 60%">
		<tr>
			<td>类别</td>
			<td><input type="checkbox" id="pc" />&nbsp;盘查</td>
			<td><input type="checkbox" id="zj" />&nbsp;值机</td>
			<td><input type="checkbox" id="aj" />&nbsp;安检</td>
			<td><input type="checkbox" id="dj" />&nbsp;登机</td>
		</tr>
		<tr style="height: 10px"></tr>
		<tr>
			<td>状态</td>
			<td><input type="checkbox" id="wd" />&nbsp;未读</td>
			<td><input type="checkbox" id="yd" />&nbsp;已读</td>
			<td></td>
		</tr>
	</table>

	<div
		style="height: 22px;line-height: 22px;width: 98%;clear: both;margin-bottom: 20px; margin-top: 15px">
		<div style="float: left; width: 46%">
			预警日期&nbsp;&nbsp; <input id="begintime"
				class="Wdate search_input_style"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
			&nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		</div>
		<div style="float: right; width: 53%;text-align: right;">
			<div style="float: right;">
				<input id="name" type="text" class="search_input_style"
					style="width: 230px;color: gray;height:25px;padding-right: 4px;"
					holder=" 请输入搜索关键词" onfocus="onfocuss()" /> &nbsp;&nbsp; <input
					id="oneSearch_bt" type="button" class="search_input_style"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
					value="搜索" onclick="search()" />
			</div>
		</div>
	</div>
	<!-- 搜索条件 end -->
	<div id="bigDiv" style="clear: both;">
		<c:forEach var="item" items="${earlywarningQueryList}"
			varStatus="status">
			<!-- 基本信息 -->
			<div class="item_style">
				<table width="99%;">
					<!-- 当来源为添加任务时 显示复选框 -->
					<c:if test="${source=='rwcl'}">
						<tr>
							<td width="3%" rowspan="4" style="text-align: center;"><c:choose>
									<c:when test="${item.ISCHECK}">
										<input type="checkbox" name="sourcecheck" checked="checked"
											value='${item.YJBH},${item.XP},${item.XM},${item.YJYY}' />
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="sourcecheck"
											value='${item.YJBH},${item.XP},${item.XM},${item.YJYY}' />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>
					<tr>
						<td rowspan="3" style="width: 13%;text-align: center;"><img
							src="${item.XP}"
							style="width: 100px;height: 100px" /></td>
						<td><span style="margin-right:20px;">${item.YJSJ}&nbsp;</span> <c:choose>
								<c:when test="${item.SFCK == 1}">
									<span id="${item.YJBH}">已读</span>
								</c:when>
								<c:otherwise>
									<span id="${item.YJBH}" style="color: red;">未读</span>
								</c:otherwise>
							</c:choose></td>
					</tr>

					<tr style="border-bottom:1px solid #b2b2b2;color: #4A4A4A">
						<td style="font-size: 19px;font-weight: bold;width: 30%;">
							<span class="my_info" onclick="openDialog('${item.YJBH}','${item.SFCK}','${item.BD_RYBH}')">${item.YJNR}</span>
						</td>
						<td style="width: 20%;"></td>
						<td
							style="font-size: 15px;font-weight: bold;width: 30%; text-align: right; margin-right: 23px;">来源：
							<span class="my_info" onclick="xcpcDetail('${item.YJLYBH}','${item.XM}','${item.YJLY }')">
								<c:if test="${item.YJLY=='inventoryinfo'}">现场盘查 >></c:if>
								<c:if test="${item.YJLY=='checkin'}">值机信息  >></c:if>
								<c:if test="${item.YJLY=='security'}">安检信息  >></c:if>
								<c:if test="${item.YJLY=='boarding'}">登机信息 >></c:if>
								</span></td>
					</tr>
					<tr>
						<td style="font-size: 16px;color: #EF7844;" colspan="2">
							<span class="my_info" style="margin-right: 10px;" onclick="ryDetail('${item.BD_RYBH}','${item.XM}')">${item.XM}</span>
							<span>
								<c:if test="${item.lsgkcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/lsgk.png" />
								</c:if>
								<c:if test="${item.tjlkcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/tjlk.png" />
								</c:if>
								<c:if test="${item.ztrycount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/ztryxx.png" />
								</c:if>
								<c:if test="${item.wffzcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/fzxx.png" />
								</c:if>
								<c:if test="${item.zjrycount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/jzxyr.png" />
								</c:if>
								<c:if test="${item.siscount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/sisxyr.png" />
								</c:if>
								<c:if test="${item.kssrycount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/ksszyry.png" />
								</c:if>
								<c:if test="${item.qlzdcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/qbqlzd.png" />
								</c:if>
							</span>
						</td>
						<%--<td> <span id="${item.YJBH}"  name="${item.RYBH}" onclick="getGz('${item.RYBH}')"> 
							<c:choose>
								<c:when test="${item.GZBH == '1'}">
									<input type="hidden" value="0" id="gz${item.RYBH}"/>
									<img src="<%=basePath%>images/common/fkweb_focusonforaimat.png" />
								</c:when>
								<c:otherwise>
									<input type="hidden" value="1" id="gz${item.RYBH}"/>
									<img src="<%=basePath%>images/common/fkweb_eyesongrey.png"  />
								</c:otherwise>
							</c:choose>
							</span> &nbsp;&nbsp;&nbsp;&nbsp;
							<span id="oneSearch_bt" class="gk_span">${item.YJYY}</span>
						</td> --%>
						<td style="font-size: 14px;text-align: right;margin-right: 23px;"><span class="my_info"  onclick="getTaskes('${item.YJBH}','${item.XM}','${item.YJYY}','${item.XP}')">发布任务</span></td>
					</tr>
				</table>
			</div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(earlywarningQueryList)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(earlywarningQueryList)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="div_bottom" class="div_bottom"></div>
    <input type="hidden" id="welcomeJsp" value="<%=welcomeJsp%>"/>
    <input type="hidden" id="mypath" value="<%=basePath%>"/>
</body>
</html>

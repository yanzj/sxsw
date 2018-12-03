<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>联系信息列表页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="./contactinfoList.js"></script>
<style>
.div_table_over{
	background-color: #f9f9f9;
}
.div_table_out{
	background-color: #ffffff;
}
</style>
</head>
<body>
	<div style="height: 44px;padding-left:20px;line-height: 44px;background-color: #ebebeb;">
		<div style="width:70%;font-size: 18px;color: #333333;font-weight: bold;float: left;">联系方式</div>
		<div style="float: right;font-size: 16px;margin-right: 40px;" onclick="conactionAdd()">
			<img src="<%=basePath%>images/xxcx/fk_addmore.png" style="vertical-align: middle;"/>
			<span style="vertical-align: middle;" class="my_info">手动添加</span>
		</div>
	</div>
	<div id="lx_div">
		<c:forEach var="item" items="${contactionList}" varStatus="idx">
			<div style="padding-left:20px;padding-top:13px;height: 60px;" onmouseover="this.className='div_table_over'" onmouseout="this.className='div_table_out'">
				<table style="font-size:14px;">
					<tr style="height: 20px;line-height: 20px;">
						<td rowspan="3" style="width: 28px;color:#ef7844;font-weight: bold;"><span><c:out value="${idx.count }"></c:out></span></td>
						<td style="width: 106px;">${item.CJSJ }</td>
						<td style="width: 138px;">
						<c:if test="${item.SSXMLX == 'sdAdd'}">手动添加</c:if>
						</td>
						<td style="width: 24px;"><img src="<%=basePath %>images/xxcx/fk_phoneicon.png" style="height: 14px;width: 15px;" /></td>
						<td style="width: 180px;">${item.LXDH}</td>
						<td style="width: 24px;"><img src="<%=basePath %>images/xxcx/fk_qqicon.png" style="height: 14px;width: 15px;" /></td>
						<td style="width: 350px;">${item.QQ }</td>
						<td style="width: 126px;"></td>
					</tr>
					<tr style="height: 5px;">
						<td colspan="8"></td>
					</tr>
					<tr style="height: 22px;line-height: 22px;">
						<td>${item.DWMC}</td>
						<td style="color: #366AB3;" class="my_info" onclick="getCJRXM('${item.CJRBH}')">${item.CJRXM}</td>
						<td><img src="<%=basePath %>images/xxcx/fk_address.png" /></td>
						<td colspan="3">${item.JZDZ}</td>
						<td></td>
					</tr>
				</table>
			</div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(contactionList)<10}">
		<div id="div_btm" class="div_bottom" style="display: block;">
			<c:choose>
				<c:when test="${fn:length(contactionList)==0}">无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="loadover" class="div_bottom"></div>
	<input type="hidden" id="rybh" value="${sessionScope.contactionList[0].BD_RYBH }"/>
	<input type="hidden" id="mypath" value="<%=basePath%>"/>
</body>
</html>
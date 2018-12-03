<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String userid = (String) request.getSession()
			.getAttribute("userid");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>我的审批页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bussiness/aviation/lkgl/tjxlkSP/ApprovalsconditionList.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<style>
.holder {
	color: gray;
}

.td_value {
	color: black;
}

td {
	font-size: 13px;
}

.input1 {
	border: 1px solid #D1D1D1;
	border-radius: 7px;
	width: 175px;
	height: 20px;
	color: gray;
}

font {
	font-size: 13px;
}

.info {
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	width:100%;
}
</style>
</head>
<body class="body_style">
	<div>
		<table style="width: 100%;">
			<tr>
				<td width="4%" style="color:black">类别：</td>
				<td width="13%"><input type="checkbox" name="checkbox"
					value="2" />拒绝</td>
				<td width="13%"><input type="checkbox" name="checkbox"
					value="0" />未审批</td>
				<td width="13%"><input type="checkbox" name="checkbox"
					value="1" />审批中</td>
				<td width="13%"><input type="checkbox" name="checkbox"
					value="4" />打回修改</td>
				<td width="20%"><input type="checkbox" name="checkbox"
					value="3" />已批准</td>
			</tr>
			<tr>
				<td style="color:black">时间：</td>
				<td><input type="radio" name="radio" value="week" /><font>一周内</font>
				</td>
				<td><input type="radio" name="radio" value="month" /><font>一个月内</font>
				</td>
				<td><input type="radio" name="radio" value="threeMonth" /><font>三个月内</font>
				</td>
				<td colspan="2"><input type="radio" name="radio" value="time" /><font
					style="margin-right:5px;">选择时间段：</font> <input id="begintime"
					class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
					&nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
				</td>
			</tr>
		</table>
		<div>
			<span style="font-size:12px;">申请人：</span> <span><input
				id="cjrxm" class="input1" type="text" holder="请输入申请人姓名关键字" />
			</span>
			<div style="margin:12px 1px">
				<input type="button" onclick="search()" value="搜索"
					class="search_input_style"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;" />
			</div>
		</div>
	</div>
	<div style="width:100%">
		<table
			style="width:100%;border-collapse:collapse;line-height: 30px;text-align: center;">
			<tr style="border-bottom:1px solid #b2b2b2; ">
				<td width="25%">列控条件</td>
				<td width="20%">到期时间</td>
				<td width="8%">状态</td>
				<td width="8%">申请人</td>
				<td width="15%">申请时间</td>
				<td width="20%" style="text-align:center">操作</td>
			</tr>
		</table>
		<div id="dadiv" style="width:100%">
		<table style="width:100%;border-collapse:collapse;line-height: 30px; text-align: center;">
			<c:forEach var="item" items="${listmodel }">
				<tr>
					<td width="25%" class="my_info" style="color:#007EE2;" onclick="openDialog('${item.SPBH}')">
						<div class="info"">
							<c:if test="${item.MZ!=null}">${item.MZMC}&nbsp;&nbsp;</c:if>
							<c:if test="${item.XM!=null}">${item.XM}&nbsp;&nbsp;</c:if>
							<c:if test="${item.XB!=null}">
								<c:if test="${item.XB=='1'}">男</c:if>
								<c:if test="${item.XB=='2'}">女</c:if>&nbsp;&nbsp;
					  		</c:if>
							<c:if test="${item.JG!=null}">${item.JG}&nbsp;&nbsp;</c:if>
							<c:if test="${item.ZZ!=null}">${item.ZZ}&nbsp;&nbsp;</c:if>
							<c:if test="${item.SFZH!=null}">${item.SFZH}&nbsp;&nbsp;</c:if>
							<c:if test="${item.QT!=null}">${item.QT}&nbsp;&nbsp;</c:if>
						</div>
					</td>
					<td width="20%" style="color:#ef7844">${item.LKYXSJ}</td>
					<td width="8%"><c:if test="${item.SPZT==0}">
							<span>未审批</span>
						</c:if> <c:if test="${item.SPZT==1}">
							<span>审批中</span>
						</c:if> <c:if test="${item.SPZT==2}">
							<span>已拒绝</span>
						</c:if> <c:if test="${item.SPZT==3}">
							<span>已批准</span>
						</c:if> <c:if test="${item.SPZT==4}">
							<span>打回修改</span>
						</c:if></td>
					<td width="8%" style="color:#007EE2;" class="my_info" onclick="getCJRXM('${item.CJRBH}')">${item.CJRXM}</td>
					<td width="15%">${item.CJSJ}</td>
					<td width="20%" style="text-align:center;">
						<c:if test="${item.CZZT>=1}">
							<span style="color:red;">未操作</span>
						</c:if> <c:if test="${item.CZZT==0}">
							<span style="color:gray;">已操作</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		</div>
	</div>
	<input type="hidden" id="mypath" value="<%=basePath%>" />
	<c:if test="${fn:length(listmodel)<10}">
		<div id="div_btm" class="div_bottom" style="display: block;">
			<c:choose>
				<c:when test="${fn:length(listmodel)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="div_bottom" class="div_bottom"></div>
</body>
</html>

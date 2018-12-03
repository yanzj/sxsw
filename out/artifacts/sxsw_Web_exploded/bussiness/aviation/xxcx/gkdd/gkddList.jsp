<%@page import="com.dhcc.bussiness.aviation.xxcc.entity.ControlpEntity"%>

<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="com.opensymphony.xwork2.Action"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String RYXM = request.getParameter("RYXM");
	String GMSFZHM = request.getParameter("GMSFZHM");
	String welcomeJsp = request.getParameter("welcomeJsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人员列表展示</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/btnQuery.js"></script>
<script src="<%=basePath%>js/UploadFailUtil.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./gkddList.js"></script>
<style>
td {
	font-size: 12px;
	color: gray;
}
.input1 {
	border: 1px solid #D1D1D1;
	margin-right: 25px;
	border-radius: 7px;
	width: 175px;
	height: 20px;
}
font {
	font-size: 12px;
}
.div1{
   margin-bottom:17px;
   clear: both;
}
</style>
</head>
<body class="body_style">
   <input id="source" type="hidden" value="${sessionScope.source}" />
	<!-- 查询条件 -->
	    <div id="div_gjss">
		<div class="div1" >
			<font>人员类别</font><select id="GKLBBH" class="input1"
				style="width:177px;height:23px;"></select> <font>民族</font><select
				class="input1" id="MZ" style="width:177px;height:23px;"></select> <font>姓名</font><input
				type="text" id="XM" class="input1" /> <font>性别</font><select
				class="input1" id="XB" style="width:177px;height:23px;"><option
					selected="selected" value="">--请选择性别--</option>
				<option value="1">男</option>
				<option value="2">女</option></select>
		</div>
		<div class="div1">
			<font>身份证号</font><input type="text" id="SFZH" class="input1" /> 
			<font>住址</font><input type="text" id="ZZXZ" class="input1" />
			<font>出生日期</font>
			<input id="starttime"  class="Wdate search_input_style" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		    &nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		</div>
		<div class="div1">
			<input type="checkbox" name="box" value="全部" id="qb"/><font style="margin-right:40px;">全部</font> 
			<input type="checkbox" name="box" value="0" id="lk"></input><font  style="margin-right:40px;">列控</font>
			<input type="checkbox" name="box" value="1" id="jy"></input><font style="margin-right:40px;">禁用</font>
			<input type="checkbox" name="box" value="2" id="sqqyz"></input><font style="margin-right:40px;">申请启用中</font>
			<input type="checkbox" name="box" value="3" id="sqjyz"></input><font style="margin-right:40px;">申请禁用中</font>
			<input type="checkbox" name="box" value="4" id="sqbjz"></input><font style="margin-right:40px;">申请编辑中</font><br />
			<br /> <input type="button" onclick="shousuo()" value="搜索"
				class="search_input_style"
				style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;" /><br />
		</div>
	</div>
	<div id="dadiv" style="clear: both;">
		<c:forEach var="item" items="${gkddlist}" varStatus="idx">
			<!-- 基本信息 -->
			<div class="item_style">
				<table style="width: 98%;">
					<!--当来源为添加任务时显示复选框  -->
					<c:if test="${source=='rwcl'}">
						<tr>
							<td width="3%" rowspan="6" style="text-align: center;">
										<c:choose>
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
						<td rowspan="5" style="width: 13%;text-align: center;">
							<img src="${item.XP}"class="controlps_img" />
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
							<span>
						  		<span id="oneSearch_bt" class="gk_span">${item.GKLBMC }</span>
						  		${item.CJSJ}&nbsp;&nbsp;&nbsp;${item.CJRXM}
						  	</span>
						</td>
						<td>
						  <c:if test="${item.ZT==0}">
						    <span style="color:#F07844;font-weight:bold;">列控</span>
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
						 <c:if test="${item.XB==1}">男</c:if>
						 <c:if test="${item.XB==2}">女</c:if>
						 <c:if test="${item.XB==9}">未知性别</c:if>
						</span></td>
					</tr>
				</table>
			</div>
		</c:forEach>
		<input type="hidden" id="checkuser" value="" />
	</div>
	<c:if test="${fn:length(gkddlist)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(gkddlist)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="loadover" class="div_bottom"></div>
	<input type="hidden" id="mypath" value="<%=basePath %>"/>
	<input type="hidden" id="welcomeJsp" value="<%=welcomeJsp%>"/>
	<input type="hidden" id="RYXM" value="<%=RYXM%>"/>
	<input type="hidden" id="GMSFZHM" value="<%=GMSFZHM%>"/>
</body>
</html>
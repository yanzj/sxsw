<%@page import="java.util.Date"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Date date = new Date();
	long newTime = date.getTime(); 
	pageContext.setAttribute("newTime",  date.getTime());
	String welcomeJsp = request.getParameter("welcomeJsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>条件性列控列表页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/lkgl/tjxlk/tjxlkList.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>js/city/city.js"></script>
<style>
.item_style {
	width: 95%;
	border: 1px solid #D1D1D1;
	border-radius: 5px;
	margin-bottom: 10px;
	margin-left: 10px;
	padding: 6px;
}

.controlps_img {
	width: 100px;
	height: 100px;
	margin-right: 20px;
}

td {
	font-size: 13px;
	text-align: center;
}

.td_value {
	color: black;
}

.gklbmc {
	border-radius: 8px;
	height: 30px;
	background-color: #ef7844;
	text-align: center;
	line-height: 25px;
	font-size: 18px;
	color: #ffffff;
	font-weight: bold;
}

.input1 {
	border: 1px solid #D1D1D1;
	margin-right: 25px;
	border-radius: 7px;
	width: 175px;
	height: 20px;
}

.div1 {
	clear: both;
	padding: 8px;
}

font {
	font-size: 13px;
}

.div2 {
	color: #007EE2;
	font-weight: bold;
	margin-right: 50px;
	float: left;
}

.div3 {
	vertical-align: middle;
	width: 130px;
	height: 26px;
	font-weight: bold;
	text-align: center;
	border-radius: 9px 9px 0px 0px;
	background-color: #ef7844;
	border: 1px solid #ef7844;
	color: white;
	margin-right: 50px;
	float: left;
}

.info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	width: 150px;
	text-align: center;
}
</style>
<script>
$(function() {  
	var areaPicker = new AreaPicker({provId:"province",cityId:"city",townId:"county",url:"commList.action"});  
	areaPicker.pick();   
}); 
</script>
</head>
<body>
	<div>
		<!--页面最上层  -->
		<div class="div1">
			<div class="div3 my_info" style="display: none;">
				<img style="vertical-align:middle;"
					src="<%=basePath%>/images/common/fkweb_listforaimat.png"></img>&nbsp;查看列表
			</div>
			<div class="div2 my_info" onclick="itemclick()">
				<img style="vertical-align:middle;"
					src="<%=basePath%>/images/common/fkweb_addpersonforaimat.png"></img>&nbsp;添加条件
			</div>
			<div style="clear:both;height:1px;background-color: gray;"></div>
		</div>
		<!--  查询条件-->
		<div class="div1">
			<font>人员类别</font>
			<select id="GKLBBH" class="input1" style="width:174px;height:23px;"></select> 
			<font>民族</font><select class="input1" id="MZ" style="width:174px;height:23px;"></select> 
			<font>姓名</font><input type="text" id="RYXM" class="input1" /> 
			<font>姓别</font>
			<select class="input1" id="RYXB" style="width:174px;height:23px;">
				<option selected="selected" value="">--请选择性别--</option>
				<option value="1">男</option>
				<option value="2">女</option>
			</select>
		</div>
		<div class="div1">
			<font>身份证号</font><input type="text" id="GMSFZHM" class="input1" /> 
			<font>住址</font><input type="text" id="ZZXZ" class="input1" /> 
			<font>其他</font><input type="text" id="QT" class="input1" />
		</div>
		<form class="div1">
			<font>选择省份</font>
			<select class="input1" id="province" style="width:174px;height:23px;"></select>
			<font>选择地区</font>
			<select class="input1" id="city" style="width:174px;height:23px;"></select>
			<font>选择市县</font>
			<select class="input1" id="county" style="width:174px;height:23px;"></select> 
		</form>
		<div class="div1">
			<input type="checkbox" id="qb" name="box" value="全部" /><font
				style="margin-right:40px;">全部</font> <input type="checkbox" id="lkz"
				name="box" value="列控中"></input><font style="margin-right:40px;">列控中</font>
			<input type="checkbox" id="ycx" name="box" value="已撤销"></input><font
				style="margin-right:40px;">已撤销</font><br /> <br /> <input
				type="button" onclick="search()" value="搜索"
				class="search_input_style"
				style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;" /><br />
		</div>
		<div class="div1" id="div1" style="display: none;"></div>
		<div class="div1" id="div_sort">
			<span id="order_shxsj" class="my_info"
				style="color:#ef7844;font-size:14px;margin-right:10px;"
				onclick="searchByType('order_shxsj','按生效时间排序')">按生效时间排序&nbsp;<span
				id="jt">↓</span></span> <span id="order_sxsj" class="my_info"
				style="font-size:14px;margin-right:10px;display: none;"
				onclick="searchByType('order_sxsj','按失效时间排序')">按失效时间排序</span> <span
				id="order_sqr" class="my_info"
				style="font-size:14px;margin-right:10px;"
				onclick="searchByType('order_sqr','按申请人排序')">按申请人排序</span>
		</div>
	</div>
	<!-- 列表内容 -->
	<div style="clear: both;">
		<!-- 收到的审批列表 -->
		<div>
			<table style="width:100%;line-height: 30px;">
				<tr>
					<!-- <td width="10%"><input type="checkbox" name="box" value="全选" /><font
						style="margin-right:40px;">全选</font></td> -->
					<td width="15%">列控条件</td>
					<td width="18%">创建时间</td>
					<td width="13%">到期时间</td>
					<td width="15%">状态</td>
					<td width="10%">申请人</td>
					<td width="19%" style="text-align:center;">操作</td>
				</tr>
				<tr>
					<td colspan="7"><div
							style="height: 1px;background-color: #b2b2b2;"></div></td>
				</tr>
			</table>
		</div>
		<div id="dadiv">
			<table style="width:100%;line-height: 30px;">
				<c:forEach var="item" items="${ConditioncontrolsModel}">
					<tr>
						<!-- <td width="10%"><input type="checkbox" name="box" value="全选" /></td> -->
						<td width="15%" class="my_info" style="color:#007EE2;"
							onclick="openDialog('${item.TJXLKBH}')">
							<div class="info">
								<c:if test="${item.MZ!=null}">${item.MZMC}&nbsp;&nbsp;</c:if>
								<c:if test="${item.XM!=null}">${item.XM}&nbsp;&nbsp;</c:if>
								<c:if test="${item.XB!=null}">
									<c:if test="${item.XB=='1'}">男&nbsp;&nbsp;</c:if>
									<c:if test="${item.XB=='2'}">女&nbsp;&nbsp;</c:if>
								</c:if>
								<c:if test="${item.JG!=null}">${item.JG}&nbsp;&nbsp;</c:if>
								<c:if test="${item.ZZ!=null}">${item.ZZ}&nbsp;&nbsp;</c:if>
								<c:if test="${item.SFZH!=null}">${item.SFZH}&nbsp;&nbsp;</c:if>
								<c:if test="${item.QT!=null}">${item.QT}&nbsp;&nbsp;</c:if>
							</div>
						</td>
						<td width="18%" style="color:#ef7844">${item.CJSJ}</td>
						<td width="13%" style="color:#ef7844">${item.LKYXSJ_Date}</td>
						<td width="15%"><c:if test="${item.ZT==0}">列控</c:if> <c:if
								test="${item.ZT==1}">禁用</c:if> <c:if test="${item.ZT==2}">申请启用中</c:if>
							<c:if test="${item.ZT==3}">申请禁用中  <!-- <span style="color: red">(正在审批)</span> -->
							</c:if> <c:if test="${item.ZT==4}">申请编辑中  <!-- <span style="color: red">(正在审批)</span> -->
							</c:if> <%-- <c:if test="${item.LKYXSJ <= pageScope.newTime}">
				                <span style="color: red">(已过期)</span>
				           </c:if> --%></td>
						<td width="10%" style="color:#007EE2;" class="my_info"
							onclick="getCJRXM('${item.CJRBH}')">${item.CJRXM}</td>

						<td width="19%" style="text-align:center;"><c:if
								test="${item.ZT==0}">
								<span class="my_info" style="padding:13px;color:#007EE2">修改</span>
								<span style="padding:13px;color:#b2b2b2">生效</span>
								<span class="my_info" style="padding:13px;color:#007EE2"
									onclick="repealLK('${item.TJXLKBH}','${item.TJXXBH}')">失效</span>
							</c:if> <c:if test="${item.ZT==1}">
								<span class="my_info" style="padding:13px;color:#b2b2b2">修改</span>
								<span style="padding:13px;color:#007EE2;">生效</span>
								<span class="my_info" style="padding:13px;color:#b2b2b2">失效</span>
							</c:if></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<c:if test="${fn:length(ConditioncontrolsModel)<10}">
		<div id="div_btm" class="div_bottom" style="display: block;">
			<c:choose>
				<c:when test="${fn:length(ConditioncontrolsModel)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="div_bottom" class="div_bottom"></div>
	<input type="hidden" id="pass" />
	<input type="hidden" id="welcomeJsp" value="<%=welcomeJsp%>" />
	<input type="hidden" id="time" value="<%=newTime%>" />
	<input type="hidden" id="mypath" value="<%=basePath%>" />
</body>
</html>

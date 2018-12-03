<%@page import="com.dhcc.common.util.CommUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	HttpSession sessiHttpSession = request.getSession(true);
	String id = request.getParameter("id");
	String BD_RYBH = CommUtil.getID();
	String welcomeJsp = request.getParameter("welcomeJsp");
	String idtwo = "";
	//进合成侦查页传null值是合成侦查，传id是转发进来的
	if(id == null){
	 	idtwo = "";
	}else{
	 	session.setAttribute("id", id);
	 	idtwo =  session.getAttribute("id").toString();
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>管控对象列表页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./lkdxList.js"></script>
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
	font-size: 12px;
	color: gray;
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
	padding: 7px;
}

font {
	font-size: 13px;
}

.div2 {
	vertical-align: middle;
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
.search_input_style1 {
	border: 1px solid #D1D1D1;
	border-radius: 5px;
	height: 22px;
	margin-right:10px;
}
.info{
  text-overflow:ellipsis;-o-text-overflow: ellipsis;overflow: hidden;white-space: nowrap;width:320px;
}
font{
 	margin-right: 4px;
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
		<div class="div1" style="display: none;">
			<div class="div3 my_info">
				<img style="vertical-align:middle;"
					src="<%=basePath%>/images/common/fkweb_listforaimat.png"></img>&nbsp;查看列表
			</div>
			<div class="div2 my_info">
				<img style="vertical-align:middle;"
					src="<%=basePath%>/images/common/fkweb_addpersonforaimat.png"></img>&nbsp;添加对象
			</div>
			<div class="div2 my_info" onclick="itemimport()">
				<img style="vertical-align:middle;"
					src="<%=basePath%>/images/common/fkweb_addexcelforaimat.png"></img>导入Excel
			</div>
			<div class="div2 my_info" onclick="itemexport()">
				<img style="vertical-align:middle;"
					src="<%=basePath%>/images/common/fkweb_outexcelforaimat.png"></img>导出Excel
			</div>
			<div style="clear:both;height:1px;background-color: gray;"></div>
		</div>
		<!-- 查询条件 -->
		<div class="div1" style="margin-top:10px;">
			 <table width="99%" >
			  <tr style="height: 30px;">
			     <td width="33%"><font>人员类别</font><select id="LKLB" class="input1" style="width:174px;height:23px;"></select> </td>
			     <td width="33%"><font>民族</font><select class="input1" id="MZ" style="width:174px;height:23px;"></select></td>
			     <td width="33%"><font>姓名</font><input type="text" id="XM" class="input1" /></td>
			  </tr>
			   <tr  style="height: 30px;">
			     <td width="33%"><font>身份证号</font><input type="text" id="SFZH" class="input1" />  </td>
			     <td width="33%"><font>住址</font><input type="text" id="ZZXZ" class="input1" /> </td>
			     <td width="33%"><font>性别</font><select
				class="input1" id="XB" style="width:174px;height:23px;"><option
					selected="selected">请选择性别</option>
				<option value="1">男</option>
				<option value="2">女</option>
				<option value="9">未知</option></select></td>
			  </tr>
			  <tr  style="height: 30px;">
			     <td width="33%"><font>选择省份</font>
			<select class="input1" id="province" style="width:174px;height:23px;"></select> </td>
			     <td width="33%"><font>选择地区</font>
			<select class="input1" id="city" style="width:174px;height:23px;"></select></td>
			     <td width="33%"><font>选择县市</font>
			<select class="input1" id="county" style="width:174px;height:23px;"></select></td>
			  </tr>
			 </table>
		</div>
		<div class="div1">
			<input type="checkbox" name="box" value="全部" id="qb" /><font
				style="margin-right:40px;">全部</font> <input type="checkbox"
				name="box" value="0" id="lk"></input><font
				style="margin-right:40px;">列控</font> <input type="checkbox"
				name="box" value="1" id="jy"></input><font
				style="margin-right:40px;">禁用</font> <input type="checkbox"
				name="box" value="2" id="sqqyz"></input><font
				style="margin-right:40px;">申请启用中</font> <input type="checkbox"
				name="box" value="3" id="sqjyz"></input><font
				style="margin-right:40px;">申请禁用中</font> <input type="checkbox"
				name="box" value="4" id="sqbjz"></input><font
				style="margin-right:40px;">申请编辑中</font><br /> <br /> <input
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
				style="font-size:14px;margin-right:10px;"
				onclick="searchByType('order_sxsj','按失效时间排序')">按失效时间排序</span> <span
				id="order_sqr" class="my_info"
				style="font-size:14px;margin-right:10px;"
				onclick="searchByType('order_sqr','按申请人排序')">按申请人排序</span>
		</div>
	</div>
	<!-- 收到的审批列表 -->
	<div id="dadiv" style="clear: both;">
		<div>
			<c:forEach var="item" items="${controlsplists }">
				<div class="item_style">
					<table style="width:100%;">
						<tr>
							<td rowspan="5" style="width:10%;">
							<img src="${item.XP}" class="controlps_img" /></td>
						</tr>
						<tr>
							<td
								style="font-size: 19px;color: #EF7844;font-weight: bold;width:25%">
								<span class="my_info"
								onclick="openDialog('${item.BD_RYBH}','${item.XM}')">${item.XM}</span>
							</td>
							<td style="width:10%"><c:choose>
									<c:when test="${item.GZBH!=null}">
										<img
											src="<%=basePath%>images/common/fkweb_focusonforaimat.png" />
									</c:when>
									<c:otherwise>
										<img src="<%=basePath%>images/common/fkweb_eyesongrey.png" />
									</c:otherwise>
								</c:choose></td>
							<td style="width:35%;"><span id="oneSearch_bt"
								class="gk_span">${item.GKLBMC}</span>${item.CJSJ}&nbsp;&nbsp;&nbsp;<span
								class="my_info" style="color:#007EE2;"
								onclick="getCJRXM('${item.CJRBH}')">${item.CJRXM}</span></td>
							<td colspan="2"
								style="width:20%;color:#ef7844;font-weight:bold;text-align:center">
								<c:if test="${item.ZT=='0'}">列控</c:if> <c:if
									test="${item.ZT=='1'}">禁用</c:if> <c:if test="${item.ZT=='2'}">申请启用中</c:if>
								<c:if test="${item.ZT=='3'}">申请禁用中</c:if> <c:if
									test="${item.ZT=='4'}">申请编辑中</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2"><span>身份证号：</span><span class="td_value">${item.SFZH}</span></td>
							<td>出生日期：<span class="td_value">${item.CSRQ}</span></td>
							<td class="my_info" style="text-align:center;color:#007EE2;"
								onclick="openDialog('${item.BD_RYBH}','${item.XM}')">查看列控信息</td>
						</tr>
						<tr>
							<td colspan="2">民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：<span
								class="td_value">${item.MZMC}</span></td>
							<td>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：<span
								class="td_value">${item.NL}</span></td>
							<td style="text-align:center;">
								
							</td>
						</tr>
						<tr>
							<td colspan="2">户口地址：<span class="td_value dian">${item.HKSZD
									}</span></td>
							<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别： <c:if
									test="${item.XB=='1'}">
									<span class="td_value">男</span>
								</c:if> <c:if test="${item.XB=='2'}">
									<span class="td_value">女</span>
								</c:if> <c:if test="${item.XB=='9'}">
									<span class="td_value">未知</span>
								</c:if>
							</td>
							<td style="text-align:center;color:#007EE2">
								</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</div>
	</div>
	<input type="hidden" id="welcomeJsp" value="<%=welcomeJsp%>" />
	<input type="hidden" id="BD_RYBH" value="<%=BD_RYBH%>" />
	<input type="hidden" id="mypath" value="<%=basePath%>" />
	<c:if test="${fn:length(controlsplists)<10}">
		<div id="div_btm" class="div_bottom" style="display: block;">
			<c:choose>
				<c:when test="${fn:length(controlsplists)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="div_bottom" class="div_bottom"></div>
</body>
</html>

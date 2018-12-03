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
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/grsz/approvalsObject/ApprovalsListFC.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>js/city/city.js"></script>
<style>
.holder{
  color:gray;
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
	width: 130px;
	background-color: #ef7844;
	text-align: center;
	line-height: 25px;
	font-size: 18px;
	color: #ffffff;
	font-weight: bold;
}

.input1 {
	border: 1px solid #D1D1D1;
	border-radius: 7px;
	width: 174px;
	height: 20px;
	margin-right: 15px;
}
.search_input_style1 {
	border: 1px solid #D1D1D1;
	border-radius: 5px;
	height: 22px;
	margin-right:10px;
}
.div1 {
	clear: both;
	padding: 7px;
	font-size: 12px;
}
.style_disable{
    background-color: #FAFAFA;
    border: 1px solid #FAFAFA;
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
<body class="body_style">
<!-- 查询条件 -->
	<!-- 查询条件 -->
	<div class="div1">
		<font>人员类别</font><select id="LKLB" class="input1" style="width:174px;height:23px;"></select>
		<font>身份证号</font><input type="text" id="SFZH" class="input1" /> 
		<font>姓名</font><input type="text" id="XM" class="input1" /> 
		<font>性&nbsp;&nbsp;&nbsp;&nbsp;别</font>
		<select class="input1" id="XB" style="width:174px;height:23px;">
			<option selected="selected" value="">--请选择性别--</option>
			<option value="1">男</option>
			<option value="2">女</option>
			<option value="9">未知</option>
		</select>
	</div>
	<div class="div1">
		<font>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</font>
		<select class="input1" id="MZ" style="width:174px;height:23px;"></select> 
		<font>住&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</font>
		<input type="text" id="ZZXZ" class="input1" /> 
		<font>申请人</font><input type="text" id="cjrxm" class="input1" />
	</div>
	<form class="div1">
		<font>选择省份</font>
		<select class="input1" id="province" style="width:174px;height:23px;"></select>
		<font>选择地区</font>
		<select class="input1" id="city" style="width:174px;height:23px;"></select>
		<font>选择县市</font>
		<select class="input1" id="county" style="width:174px;height:23px;"></select> 
	</form>
	<div>
		<table style="width: 100%;">
         <tr>
           <td width="5%" style="color:black">&nbsp;类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
           <td width="9%" ><input type="checkbox" name="checkbox" value="3"/>已批准</td>
           <td width="9%"><input  type="checkbox" name="checkbox" value="2"/>拒绝</td>
           <td width="12%"><input type="checkbox" name="checkbox" value="0"/>未审批</td>
           <td width="12%"><input  type="checkbox" name="checkbox" value="1"/>审批中</td>
           <td><input type="checkbox" name="checkbox" value="4"/>打回修改</td>
         </tr>
           <tr>
           <td style="color:black">&nbsp;时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;间：</td>
           <td><input type="radio" name="radio" value="全部" onclick="undisable('全部')"/><font>全部</font></td>
           <td><input type="radio" name="radio" value="week" onclick="undisable('week')"/><font>一周内</font></td>
           <td><input type="radio" name="radio" value="month" onclick="undisable('month')"/><font>一个月内</font></td>
           <td><input type="radio" name="radio" value="threeMonth" onclick="undisable('threeMonth')"/><font>三个月内</font></td>
           <td><input type="radio" name="radio"  value="time" id="time" onclick="undisable('time')"/><font
					style="margin-right:5px;">选择时间段</font> <input id="begintime"
					class="Wdate search_input_style style_disable" disabled="disabled" 
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
					&nbsp;-&nbsp; <input  id="endtime" class="Wdate search_input_style style_disable" disabled="disabled"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" /></td>
          </tr>
        </table>
        <div>
           <div style="margin:12px 1px">
           <input type="button" onclick="search()" value="搜索"
				class="search_input_style"
				style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;" />
           </div>
        </div>
	</div>
	<div id="dadiv" style="clear: both;">
		<!-- 收到的审批列表 -->
		<div>
			<c:forEach var="item" items="${approvalsQueryListFC }">
				<div class="item_style">
					<table style="width:100%;">
						<tr>
							<td rowspan="5" style="width:10%;"><img
								src="${item.XP}" class="controlps_img" /></td>
						</tr>
						<tr>
							<td
								style="font-size: 19px;color: #EF7844;font-weight: bold;width:28%">
								<span class="my_info" 
								onclick="openDialog('${item.SPDXBH}','${item.XM}','${item.SPZT}','${item.LB}')">${item.XM}</span>
							</td>
							<td style="width:32%;"><span id="oneSearch_bt" class="gk_span">${item.GKLBMC}</span>${item.CJSJ}&nbsp;&nbsp;&nbsp;<span style = "color:#007EE2;" class = "my_info" onclick="getCJRXM('${item.CJRBH}')">${item.CJRXM}</span>&nbsp;&nbsp;&nbsp;申请</td>
							<td 
								style="width:20%;color:#ef7844;font-weight:bold;text-align:center">
								<c:if test="${item.SPZT eq 0}">
									<font style="font-weight:bold;">未审批</font>
								</c:if> <c:if test="${item.SPZT eq 1}">
									<font style="font-weight:bold;">审批中</font>
								</c:if> <c:if test="${item.SPZT eq 2}">
									<font style="font-weight:bold;">已拒绝</font>
								</c:if> <c:if test="${item.SPZT eq 3}">
									<font style="font-weight:bold;">已批准</font>
								</c:if> <c:if test="${item.SPZT eq 4}">
									<font style="font-weight:bold;">打回修改</font>
								</c:if>
							</td>
						</tr>
						<tr>
							<td><span>身份证号：</span><span class="td_value">${item.SFZH}</span></td>
							<td>出生日期：<span class="td_value">${item.CSRQ}</span></td>
							<td style="text-align:center;"><font class = "my_info" style="text-align:center;color:#007EE2">修改</font></td>
						</tr>
						<tr>
							<td>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：<span class="td_value">${item.MZMC}</span></td>
							<td>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：<span class="td_value">${item.NL}</span></td>
							<td style="text-align:center;"><font class = "my_info" style="text-align:center;color:#007EE2">提醒</font></td>
						</tr>
						<tr>
							<td>户口地址：<span class="td_value dian">${item.HKSZD}</span></td>
							<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：
								<c:if test="${item.XB=='1'}"><span class="td_value">男</span></c:if>
								<c:if test="${item.XB=='2'}"><span class="td_value">女</span></c:if>
							    <c:if test="${item.XB=='9'}"><span class="td_value">未知</span></c:if>
							</td>
							<td class = "my_info" style="text-align:center;color:#007EE2" onclick="openDialog('${item.SPDXBH}','${item.XM}','${item.SPZT}','${item.LB}')">查看</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</div>
	</div>
	<c:if test="${fn:length(approvalsQueryListFC)<10}">
		<div id="div_btm" class="div_bottom" style="display: block;">
			<c:choose>
				<c:when test="${fn:length(approvalsQueryListFC)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="div_bottom" class="div_bottom"></div>
	<input type="hidden" id="mypath" value="<%=basePath%>" />
</body>
</html>

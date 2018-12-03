<%@page import="com.dhcc.common.util.CommUtil"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String BD_RYBH = request.getParameter("BD_RYBH");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>列控对象详细信息页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="./lkdxMess.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<style>
.txt_title {
	width: 110px;
	color: #868686;
	font-size: 14px;
}

.txt_value {
	font-size: 14px;
	color: #000000;
}
.txt_value1 {
	font-size: 12px;
	color: #000000;
}

.tr_height {
	height: 28px;
}

.div1 {
	height: 30px;
	line-height: 30px;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: bold;
	margin-top: 20px;
	margin-bottom: 20px;
	text-align: center;
	color: #ef7844;
	clear: both;
}

</style>
</head>
<body style="padding-bottom: 20px;padding-top:20px;" id="bg">
    <div style="margin-bottom:20px;padding-left:40px;">
			<div id="TJLK"   class="my_info" style="float:left;display: none;"  onclick="tjlkdxClick()"><img style="vertical-align:middle;"
					src="<%=basePath%>/images/Icon/10.png"></img>&nbsp;&nbsp;启用列控</div>
			<div id="lineTj" style="float:left;display: none;margin-left:10px;line-height:20px;width:1px;height:20px;background-color: #9AC6FF;"></div>
			<div id="CXLK" class="my_info" style="float:left;display: none;margin-left: 20px;"  onclick="cxlkdxClick()"><img style="vertical-align:middle;"
					src="<%=basePath%>/images/Icon/12.png"></img>&nbsp;&nbsp;禁用列控</div>
			<div id="lineCX"  style="float:left;display: none;margin-left:10px;line-height:20px;width:1px;height:20px;background-color: #9AC6FF;"></div>
			<div id="BJLK" class="my_info" style="float:left;display: none;margin-left: 20px;"  onclick="bjlkdxClick()"><img style="vertical-align:middle;"
					src="<%=basePath%>/images/Icon/11.png"></img>&nbsp;&nbsp;编辑列控</div>		
		    <div style="clear: both;padding-top:20px;">
		        <span class="txt_title" style="margin-right: 5px">申请时间：</span><span class="txt_value" id="CJSJ" style="margin-right: 35px"></span> 
		        <span class="txt_title" style="margin-right: 5px">申请人：</span><span id="CJRXM" style="margin-right: 10px;color:#007EE2;" class="my_info txt_value" onclick="return getCJRXM()"></span>&nbsp;<span id="JCMC" class="txt_value" style="margin-right: 10px;"></span><span id="BMMC" class="txt_value" style="margin-right: 35px;"></span>
		        <span class="txt_title" style="margin-right: 5px" id = "LKYY" ></span><span class="txt_value" id="YY"></span>
		    </div>
	</div>
	<div class="div1">被列控人信息</div>
	<div
		style="margin-top: 20px;padding-left:40px;width: 95%;">
		<div style="float: left;width: 20%">
			<div>
				<img src="" class="head" id="userimg"
					style="width:160px; height:200px;" />
			</div>
			<div>
			<input type="button" id="GKLBMC" class="search_input_style"
					style="background-color: #F07844;text-align: center;border: 1px solid #F07844;width:80%;color: white; font-weight:bold;margin:20px 0px;font-size: 16px;" />
			</div>
		</div>
		<div style="float: left; width: 80%">
			<div style="height:40px;">
				<span id="XM" class="my_info"
					style="font-size: 24px;font-weight: bold;"
					onclick="return getRYXM();"> </span> 
                <span id="ZT" style="color:#F07844;font-weight: bold"></span>
                 <span id="guanzhu" onclick="getGz()"
					style="margin-left: 20px;cursor: pointer;"></span>
			</div>
			<div style="height: 28px; margin-bottom: 5px; line-height: 28px;clear: both;display: none;">
				<div style="width: 40px;float: left;">
					<img src="<%=basePath%>images/xxcx/fk_phoneicon.png" />
				</div>
				<div style="line-height: 28px;height: 28px;width:140px;float: left;">
					<span id="SJHM" style="font-size: 14px"></span>
				</div>
				<div style="width: 40px;float: left;">
					<img src="<%=basePath%>images/xxcx/fk_qqicon.png" />
				</div>
				<div style="line-height: 28px;height: 28px;float: left;">
					<span id="QQ" style="font-size: 14px"></span>
				</div>
			</div>
			<div style="height: 1px;margin-top:15px;background-color: #b2b2b2; width: 100%"></div>
			<table style="margin-top: 10px;width: 94%;">
				<tr class="tr_height">
					<td width="10%" class="txt_title">性别</td>
					<td width="40%" class="txt_value"><span id="XB"></span></td>
					<td width="10%" class="txt_title" style="width: 90px;">民族</td>
					<td width="40%" class="txt_value"><span id="MZMC"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">出生日期</td>
					<td class="mycla"><span id="CSRQ"></span></td>
					<td class="txt_title" style="width: 90px;">年龄</td>
					<td class="txt_value"><span id="NL"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">证件住址</td>
					<td class="txt_value" colspan="3"><span id="ZJZZ"></span></td>
				</tr>
				<tr style="height: 49px;border-bottom: 1px solid #b2b2b2;">
					<td class="txt_title">身份证号</td>
					<td class="txt_value" colspan="3"><span id="SFZH"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">暂住地址</td>
					<td class="txt_value" ><span id="ZZDZ"></span></td>
					<td class="txt_title" style="width: 90px;">到期时间</td>
					<td class="txt_value"><span id="DQSJ"></span></td>
				</tr>
				<!-- <tr class="tr_height">
					<td class="txt_title">职业</td>
					<td class="txt_value"><span id="ZY"></span></td>
					
				</tr> -->
			</table>

		</div>
	</div>
    <div class="div1">列控信息</div>
	<div
		style="margin-top: 5px;padding-left:40px;width: 95%;">
		<table>
			<tr class="tr_height">
				<td class="txt_title">管控类型：</td>
				<td class="txt_value"><span id="GKLBMC1"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title">预警对象：</td>
				<td class="txt_value"><span id="YJDXMC"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title">预警单位：</td>
				<td class="txt_value"><span id="YJBMMC"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title">预警要求：</td>
				<td class="txt_value"><span id="YJYQ"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title" style="vertical-align:middle;">备注说明：</td>
				<td class="txt_value"><span id="BZXX"></span></td>
			</tr>
		</table>
	</div>
	<div class="div1">列控记录</div>
	<div id = "divXQ" style="padding-left:40px;width: 90%;font-size:12px;"></div>
	
	<input type="hidden" id = "CJRBH"/>
	<input type="hidden" id="basepath" value="<%=basePath%>" />
	<input type="hidden" id="BD_RYBH" value="<%=BD_RYBH%>" />
	<input type="hidden" id="RYBH"/>
	<input type="hidden" id="GKLBBH"/>
	<input type="hidden" id="YJYQ"/>
	<input type="hidden" id="pass"/>
	<input type="hidden" id="spzt"/>
</body>
</html>
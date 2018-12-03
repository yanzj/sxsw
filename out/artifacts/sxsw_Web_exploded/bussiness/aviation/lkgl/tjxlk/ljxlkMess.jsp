<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String id = request.getParameter("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>条件性详细信息页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/lkgl/tjxlk/ljxlkMess.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<style>
.bg {width:100%;height:100%;top:0px;left:0px;position:absolute;filter: Alpha(opacity=50);opacity:0.5; background:#D4D4D4;}
.txt_title {
	color: #b2b2b2;
	font-size: 13px;
	margin-right: 20px;
}


.txt_value {
	font-size: 14px;
}

.tr_height {
	height: 28px;
}

table table {
	width: 200px;
}


.div1 {
	height: 30px;
	line-height: 30px;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: 600;
	margin-bottom: 10px;
	padding-left: 30px;
	color: #353336;
}

.div2 {
	width: 95%;
	margin-bottom: 20px;
	padding-left: 20px;
}
.location {
    margin: 5px 50px 20px 90px;
	float: left;
    font-weight: bold;
    font-size:24px;
	text-align: center;
	text-shadow: 0 1px rgba(0, 0, 0, 0.2);
	line-height: 100px;
	width: 100px;
	height: 100px;
	border: 1px solid #C9DEFB;
	border-radius: 50px;
	
}
.div3{
    color:#ef7844;font-weight:bold;font-size: 16px;
}
.xing{
    color:red;font-weight:bold;vertical-align: middle;
}
.lc_border-bottom {
	border-bottom: 1px solid #E6E6E6;
	color: #999999
}
.lc_zc_font {
	color: #FA4E4F
}
.style_over{
   width:80px;
   height:20px;
   line-height:20px;
   text-align:center;
}
</style>
</head>
<body id="bg">
	<div style="padding-left:30px; line-height: 30px;margin-top: 15px;margin-bottom: 15px;">
		<div style="margin-bottom:20px">
			<div id="bj" class="style_over" style="float:left;display: none"  onclick="edit()"><img style="vertical-align:middle;"
					src="<%=basePath%>/images/Icon/10.png"></img>&nbsp;&nbsp;编辑列控</div>
			<div  id = "firstLine" style="float:left;display: nonemargin-left:10px;line-height:20px;width:1px;height:20px;background-color: #9AC6FF;"></div>
			<div id="qy" class="style_over" style="float:left;display: none"  onclick="starts()"><img style="vertical-align:middle;"
					src="<%=basePath%>/images/Icon/10.png"></img>&nbsp;&nbsp;启用列控</div>
			<div  id = "secondLine" style="float:left;display: nonemargin-left:10px;line-height:20px;width:1px;height:20px;background-color: #9AC6FF;"></div>
			<div id="cxlk" class="style_over" style="float:left;display: nonemargin-left: 20px;"  onclick="repealLK()"><img style="vertical-align:middle;"
					src="<%=basePath%>/images/Icon/12.png"></img>&nbsp;&nbsp;禁用列控</div>
		  <div style="clear: both;"></div>
		</div>
		<div style="clear: both;">
			<span class="txt_title">申请时间</span><span id="CJSJ"
				style="margin-right: 30px"></span> <span class="txt_title">申请人</span><span
				id="CJRXM" class="my_info ry_font" onclick="return getCJRXM()"></span>&nbsp;<span
				id="JCMC"></span><span id="BMMC"></span>
		</div>
		<div></div>
	</div>

	<div class="div1">列控条件关键字<span id="zt" style="color: #F07844; margin-right: 30px;margin-left: 30px;"></span></div>
	<div id="Keyword" style="margin-top: 15px;margin-bottom: 15px;padding-left:30px;width: 95%;line-height: 30px">
	</div>
	
	<div class="div1">管控信息</div>
	<div
		style="margin-top: 15px;margin-bottom: 15px;padding-left:30px;width: 95%;line-height: 30px">
		<div>
			<span class="txt_title">到期时间</span><span class="txt_value" id="LKYXSJ"></span>
		</div>
		<div>
			<span class="txt_title">列控类别</span><span class="txt_value" id="LKLB1"></span>
		</div>
		<div>
			<span class="txt_title">列控原因</span><span class="txt_value" id="LKYY"></span>
		</div>
		<div>
			<span class="txt_title">预警对象</span><span class="txt_value"
				id="YJDXMC"></span>
		</div>
		<div>
			<span class="txt_title">预警值班账号</span><span class="txt_value"
				id="YJBMMC"></span>
		</div>
		<div>
			<span class="txt_title">预警要求</span><span class="txt_value" id="YJYQ"></span>
		</div>
		<div>
			<span class="txt_title">备注说明</span><span class="txt_value" id="BZXX"></span>
		</div>

	</div>
	
	
	
	<div class="div1">审批流信息</div>
	<div id="spjl_div" style="width:95%;padding-left:30px;margin-bottom: 40px;">
	</div>
	<input type="hidden" id="pass" /> 
	<input type="hidden" id="TJXLKBH" />
	<input type="hidden" id="TJXXBH" />
	<input type="hidden" id="basepath" value="<%=basePath%>" />
	<input id="mypath" type="hidden" value="<%=path%>" />
	<input id="userid" type="hidden" value="<%=id%>" />
	<input id="CJRBH" type="hidden" />
</body>
</html>
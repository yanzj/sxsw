<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String id = CommUtil.getID();
	String RWCLJGBH = request.getParameter("RWCLJGBH");
	String ssxmbh = request.getParameter("ssxmbh");
	String CLRBH = request.getParameter("CLRBH");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath %>" />
<title>结果汇报意见</title>
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
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/jquery.metadata.js"
	type="text/javascript"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js"
	type="text/javascript"></script>
<script src="<%=basePath%>js/UploadFailUtil.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/rwcl/jg_huibao.js"></script>
<script type="text/javascript" src="<%=basePath  %>bussiness/aviation/rwcl/fbrw/schedulingUtil.js"></script>
<script src="<%=basePath  %>js/UploadFailUtil.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	font-size: 14px;
}

.input2 {
	width: 350px;
	height: 25px;
	background: #F2F2F2;
	border: 0px solid #960;
}

.input3 {
	width: 350px;
	height: auto;
	background: #F2F2F2;
	border: 0px solid #960;
}

tr {
	line-height: 40px; /*设置行高*/
}

/*参考资料 start */
.ckzl_div
{
border-radius: 5px;width: 120px;height: 155px;margin:5px;float: left;
}

.ckzl_divtop
{
 height:25px; border-top-left-radius: 5px;border-top-right-radius: 5px;background-color: #A6A6A6;position:relative;line-height: 25px;text-align: center;color: white;font-size: 13px;
}

.ckzl_divtop_image
{
 
position:absolute;top:0;right:0;margin-top: 5px;margin-right:5px;width: 10px;height: 10px;
}

.ckzl_divbottom
{
height: 130px;background-color: #C7D7EE;text-align: center;
}

.clzl_divbottom_image
{
 width: 80px;height: 80px;padding-top: 7px;padding-bottom:5px
}
.ckzl_divbottom_text
{
  font-size: 12px;height:18px;line-height: 18px;
}
.ckzl_divbottom_texts
{
 font-size: 11px;height: 15px;line-height: 15px;color: #F07844
}
</style>
</head>
<body>
	<div
		style="width:100%;height: 30px;line-height:30px;background-color: #C7D7EE;margin-top: 20px;">
		<div style="width: 98%;font-size: 12px;font-weight: bold;color: #F07844;border:0px solid #F00;text-align:center;">
				结果汇报意见
		</div>
	</div>
	<div style="padding:30px; margin-left:92px">
		<table style="padding:40px" border="0">
		<tr>
			<td style="vertical-align:top"; ><span style="color:#C2C2C2;">意见内容&nbsp;&nbsp;</span>
			</td>
			<td><textarea style="width:360px;height:120px" id="infodesc" placeholder="请输入意见，意见将在任务交流中显示"
					class="input2"></textarea>
			</td>
			<td></td>
		</tr>
	</table>
	</div>	
	
	<input id="mypath" type="hidden" value="<%=path %>" />
	<input id="basePath" type="hidden" value="<%=basePath %>" />
	<input id="basepath" type="hidden" value="<%=basePath %>" />
	<input id="id" type="hidden" value="<%=id %>"/>
	<input id="RWCLJGBH" type="hidden" value="<%=RWCLJGBH %>"/>
	<input id="ssxmbh" type="hidden" value="<%=ssxmbh %>"/>
	<input id="CLRBH" type="hidden" value="<%=CLRBH %>"/>
</body>
</html>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String id = CommUtil.getID();
	String ssxmbh = request.getParameter("ssxmbh");
	String cjrbh = request.getParameter("cjrbh");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath %>" />
<title>任务交流添加</title>
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
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/rwcl/clzrw/rwjladd.js"></script>
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
				跟进任务
		</div>
	</div>
	<div style="padding:30px; margin-left:92px">
		<table style="padding:30px;">
		<tr>
			<td style="vertical-align:top"; ><span style="color:#C2C2C2;">跟进内容&nbsp;&nbsp;</span>
			</td>
			<td><textarea style="width:350px;height:100px" id="infodesc"
					class="input2"></textarea>
			</td>
			<td></td>
		</tr>
		<tr>
			<td><span style="color:#C2C2C2;">选择资料</span>
			</td>
			<td colspan="2"><select id="s" name="s"
				style="width:160px; border: 1px solid #C7D7EE">
					<option style="selected" value="">-请选择资料类型-</option>
					<option value="earlywarning">预警信息</option>
					<option value="payattention">关注人</option>
					<option value="inventoryinfo">盘查信息</option>
					<option value="controlledpeople">管控人员</option>
					<option value="events">案事件</option>
			</select>&nbsp; <input type="button" class="search_input_style"
				style="background-color: #C7D7EE;border: 1px solid #C7D7EE;height:27px;width: 80px; margin-right: 5px;"
				value="查找" onclick="selectzl()" />
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2" class="input3">
				<div id="zl" style="width:350px;border:0px solid #7FFF00;">
					<div id="zldiv"></div>
				</div> 
				<!-- 预警 -->
				<input id="zlidsyj" type="hidden" />
				<input id="zltypeyj" type="hidden" value="earlywarning" /> 
				<!-- 关注 -->
				<input id="zlidsgz" type="hidden" /> 
				<input id="zltypegz" type="hidden" value="payattention" />
				<!-- 盘查 --> 
				<input id="zlidspc" type="hidden" />
				<input id="zltypepc" type="hidden" value="inventoryinfo" />
				<!-- 管控人员 -->
				<input id="zlidsgk" type="hidden" />
				<!-- 案事件 -->
				<input id="zlidsasj" type="hidden" />
		</td>
		</tr>
		<tr>
			<td><span>&nbsp;</span>
			</td>
			<td colspan="2"><input id="upload" type="button"
				class="search_input_style"
				style="background-color: #C7D7EE;border:1px solid #C7D7EE;height:27px;width:120px; margin-right: 5px;"
				value="上传图片" onclick="uploadfj()" /></td>
		</tr>
		<tr>
			<td><span>&nbsp;</span>
			</td>
			<td colspan="2" class="input2" style="height: 80PX;">
			     <div style="width:350px;border: 0px solid grey" id="yjxx"></div>
			     <div style="width:350px;border: 0px solid grey" id="pcxx"></div>
			     <div style="width:350px;border: 0px solid grey" id="gzxx"></div>
			     <div style="width:350px;border: 0px solid grey" id="gkxx"></div>
			      <div style="width:350px;border: 0px solid grey" id="asjxx"></div>
				<div style="width:350px;border: 0px solid grey" id="voice"></div>
				<div style="width:350px;border: 0px solid grey" id="image"></div>
			</td>
		</tr>
	</table>
	</div>	
	
	<input id="mypath" type="hidden" value="<%=path %>" />
	<input id="basePath" type="hidden" value="<%=basePath %>" />
	<input id="id" type="hidden" value="<%=id %>"/>
	<input id="ssxmbh" type="hidden" value="<%=ssxmbh %>"/>
	<input id="cjrbh" type="hidden" value="<%=cjrbh %>"/>
</body>
</html>
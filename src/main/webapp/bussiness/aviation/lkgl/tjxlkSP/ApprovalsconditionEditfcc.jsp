<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String itemid = request.getParameter("itemid");
	String type = request.getParameter("type");
	String LB=request.getParameter("LB");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>我的审批详情页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bussiness/aviation/lkgl/tjxlkSP/ApprovalsconditionEditfcc.js"></script>
<style>
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
.bjxxspan{
  margin-left:40px;
  height: 28px;
  line-height:28px;
  color: #4c4c4c;
}
.txt_title {
	color: #b2b2b2;
	font-size: 13px;
	margin-right: 20px;
}

.tr_height {
	height: 28px;
}

.txt_value {
	font-size: 14px;
	color: #44c4c4c;
}

.xing {
	color: red;
	font-weight: bold;
	vertical-align: middle;
}

.button {
	border-radius: 8px;
	width: 130px;
	height: 30px;
	color: white;
}

.lc_border-bottom {
	border-bottom: 1px solid #E6E6E6;
	color: #999999
}

.lc_zc_font {
	color: #FA4E4F
}

.cl_cjsj {
	color: #FA4E4F;
}

.ry_font {
	color: #346DB2
}

.input {
	display: none;
	margin-right: 10px;
}
</style>
</head>
<body>
	<div
		style="padding-left:30px; line-height: 30px;margin-top: 15px;margin-bottom: 15px;">
		<div>
			<span class="txt_title">申请时间</span><span id="CJSJ"
				style="margin-right: 30px"></span> <span class="txt_title">申请人</span><span
				id="CJRXM" class="my_info ry_font" onclick="return getCJRXM()"></span>&nbsp;(<span
				id="JCMC"></span>-<span id="BMMC"></span>)
		</div>
		<div></div>
		<div>
		<span class="txt_title">类别</span>
		<input type="hidden" id="TJXLKBH"/>
		<span id="lbs" style="color: red; margin-right: 30px;"></span>
		<span class="txt_title">状态</span><span id="spzt"></span>
		</div>
	</div>
	<div id="div_cxyy">
	<div class="div1">撤销原因</div>
	<div 
		style="margin-top: 15px;margin-bottom: 15px;padding-left:30px;width: 95%;line-height: 30px">
		<div>
			<span class="txt_title">撤销原因</span><span class="txt_value" id="cxYY"></span>
		</div>
		<div>
			<span class="txt_title">备注说明</span><span class="txt_value" id="cxBZXX"></span>
		</div>
	</div>
    </div>
    
    <div id="div_xgjl">
	<div class="div1">修改记录</div>
	<div id="div_xgjls"
		style="margin-top: 15px;margin-bottom: 15px;padding-left:30px;width: 95%;line-height: 30px">
		<div>
			
		</div>
		
	</div>
    </div>
    
	<div class="div1">列控条件关键字</div>
	<div id="Keyword" style="margin-top: 15px;margin-bottom: 15px;padding-left:30px;width: 95%;line-height: 30px">
	</div>
	
	<div class="div1">管控信息</div>
	<div
		style="margin-top: 15px;margin-bottom: 15px;padding-left:30px;width: 95%;line-height: 30px">
		<div>
			<span class="txt_title">到期时间</span><span class="txt_value" id="LKYXSJ"></span>
		</div>
		<div>
			<span class="txt_title">列控类别</span><span class="txt_value" id="LKLB"></span>
		</div>
		<div>
			<span class="txt_title">列控原因</span><span class="txt_value" id="LKYY"></span>
		</div>
		<div>
			<span class="txt_title">预警对象</span><span class="txt_value"
				id="YJDXMC"></span>
		</div>
		<div>
			<span class="txt_title">预警单位</span><span class="txt_value"
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
	<div style="width: 100%;margin-top: 30px; margin-bottom: 30px;">
		<div style="margin-bottom: 10px;">
			<table style="margin: 0px auto;">
				<tr>
					<td><img src="<%=basePath%>images/lkgl/fk_websubmitorg.png"
						id="lc_tj_img" /></td>
					<td><img
						src="<%=basePath%>images/lkgl/fk_webdotlineorg_rey.png"
						id="lc_tj_zx" /></td>
					<td><img src="<%=basePath%>images/lkgl/fk_webapprovalgrey.png"
						id="lc_sp_img" /></td>
					<td><img src="<%=basePath%>images/lkgl/fk_webdotlinegrey.png"
						id="lc_sp_zx" /></td>
					<td><img src="<%=basePath%>images/lkgl/fk_webpassgrey.png"
						id="lc_pz_img" /></td>
				</tr>
			</table>
		</div>
		<div style=" width: 720px;margin:0px auto;">
			<table style="width:100%">
				<tr>
					<td style="width: 33%;text-align: left;"><img id="lc_tj_jt"
						style="display: none;"
						src="<%=basePath%>images/lkgl/fk_webtriggle.png" /></td>
					<td style="width: 33%;text-align: center;"><img id="lc_sp_jt"
						style="display: none;"
						src="<%=basePath%>images/lkgl/fk_webtriggle.png" /></td>
					<td style="width: 33%;text-align: right;"><img id="lc_pz_jt"
						style="display: none;"
						src="<%=basePath%>images/lkgl/fk_webtriggle.png" /></td>
				</tr>
			</table>
		</div>

		<div
			style="background-color: #F2F3F3; width: 900px;margin:0px auto; border-radius:7px;padding-top: 30px;padding-bottom: 30px;">
			<table id="lc_tab"
				style="width: 720px;margin-left: 80px; line-height: 32px;text-align: left;margin-bottom: 30px;">
			</table>
			<div id="div_spyj" style="display: none;">
				<textarea id="SPYJ"
					style="width:700px;margin-left: 80px;border:0;height:77px;overflow-x:visible;overflow-y:visible;background-color: #ffffff;font-size:14px;padding:10px;color: gray;"
					onfocus="yj_onfocus()" onblur="yj_onblur()">请填写审批意见</textarea>

				<div id="cz_but" align="center"
					style="width:720px;margin-left: 80px;margin-top: 20px">
					<input onclick="over()" type="button"
						style="background-color: #366CB4; border: 1px solid #366CB4"
						class="button" value="不批准" /> &nbsp; &nbsp; <input
						onclick="back()" id="dhxg" type="button"
						style="background-color: #366CB4;border: 1px solid #366CB4"
						class="button" value="打回修改" /> &nbsp;&nbsp; <input
						onclick="pass()" id="ok" type="button"
						style="background-color: #F07844;border: 1px solid #F07844"
						class="button" value="批准" /> <input onclick="sb()" id="sb"
						type="button"
						style="background-color: #F07844;border: 1px solid #F07844"
						class="button" value="上报" />
				</div>
				<div id="dhxg_but" align="center"
					style="width:720px;margin-left: 80px;margin-top: 20px">
				</div>
			</div>
		</div>
	</div>
	<div id="qrdh" style="float:left"></div>
	<div id="qxcz" style="float:left"></div>

	<input type="hidden" value="<%=basePath%>" id="basepath" />
	<input type="hidden" id="CJRBH" />
	<input type="hidden" id="YJDX" />
	<input type="hidden" id="YJBM" />
	<input type="hidden" id="YJYQ" />
	<input type="hidden" id="pass" />
	<input type="hidden" id="itemid" value="<%=itemid%>" />
	<input type="hidden" id="type" value="<%=type%>" />
	<input type="hidden" id="LB" value="<%=LB%>" />
	<input type="hidden" id="spyjbh" />
	<!-- 当页面来源我接收 -->
</body>
</html>
